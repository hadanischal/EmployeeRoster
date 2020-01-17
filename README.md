# EmployeeRoster

## Goal:
* Create an iOS application exhibiting the MVVM + rxSwift + Unit test.
* It display simple employee roster with shift plan. 
* It display prototype of **Shift Planning & Employee Schedule Maker app**

## Instructions:
* Load and display information from server
* Display a person currently on duty at top
* The employee list is displayed in list.

## Design Patterns: MVVM + RxSwift
Model-View-ViewModel (MVVM) is a structural design pattern that separates objects into three distinct groups:
* Models hold application data. They’re usually structs or simple classes.
* Views display visual elements and controls on the screen. They’re typically subclasses of UIView.
* View models transform model information into values that can be displayed on a view. They’re usually classes, so they can be passed around as references.

![Alt text](/ScreenShots/mvvm.png?raw=true "MVVM iOS app architecture pattern")

## Why MVVM?
* Segregated Code: Making the code segregated. MVVM component based divides a particular view handling distributed across the View, Model and View Model, thereby providing us with a modularised code structure.
* Avoid Bulky Controllers: Devs using MVC know that when our app gets scalable and requirements keep on messing with our existing logic, our controller keeps on expanding until and unless we route the controller code to separate files. Via MVVM, we write down our business logic in the View Model and just only communicate the output to the view or the controller.
* Test Driven Development: The most important of all, MVVM really provides a good platform to perform TDD. We can write down Unit Test Cases for View Models and test the business logic driving the UI. Unit Test cases are really important while developing as they minimize our code-break chances to a great extent. Please follow the below link to explore more about TDD in iOS

#### App Demo

 ![](/ScreenShots/EmployeeRoster.gif "")

### Model
These hold the app data. These are the structs and classes that you have created to hold the data you receive from a REST API or from some other data source.
* EmployeeModel.swift
```swift
import Foundation

struct EmployeeModel: Codable {
    let tenant: String?
    let motd: String?
    let scheduledToday: ScheduleModel?
    let roster: [RosterModel]?
}

extension EmployeeModel {
    init(withRealmEmployee realmEmployee: RealmEmployee) {
        self.tenant = realmEmployee.tenant
        self.motd = realmEmployee.motd
        self.scheduledToday = ScheduleModel(withRealmSchedule: realmEmployee.scheduledToday)
        let realmRoster = realmEmployee.roster
        self.roster = realmRoster.map { RosterModel(withRealmRoster: $0)}
    }
}

extension EmployeeModel: Equatable {
    static func == (lhs: EmployeeModel, rhs: EmployeeModel) -> Bool {
        return lhs.tenant == rhs.tenant
            && lhs.motd == rhs.motd
    }
}

extension EmployeeModel {
    static var empty: EmployeeModel {
        return EmployeeModel(tenant: "", motd: "", scheduledToday: nil, roster: nil)
    }
}
```
* ScheduleModel.swift
```swift
import Foundation

struct ScheduleModel: Codable {
    let name: String?
    let fromDate: String?
    let toDate: String?
}

extension ScheduleModel {
    init?(withRealmSchedule realmSchedule: RealmSchedule?) {
        guard let realmSchedule = realmSchedule else { return nil }
        self.name = realmSchedule.name
        self.fromDate = realmSchedule.fromDate
        self.toDate = realmSchedule.toDate
    }
}
```
* RosterModel.swift 
```swift
import Foundation

struct RosterModel: Codable {
    let name: String?
    let fromDate: String?
    let toDate: String?
}

extension RosterModel {
    init(withRealmRoster realmRoster: RealmRoster) {
        self.name = realmRoster.name
        self.fromDate = realmRoster.fromDate
        self.toDate = realmRoster.toDate
    }
}

```

### ViewModel
To be able to bind values from our ViewModel to our View, we need element with an observable pattern. In iOS, we could use `KVO` pattern to add and remove observers, but I would prefer `RxSwift`. KVO observing, async operations and streams are all unified under abstraction of sequence. This is the reason why Rx is so simple, elegant and powerful.

* EmployeeViewModelProtocol.swift
```swift
import RxSwift

protocol EmployeeViewModelProtocol {
    var employeeResult: Observable<EmployeeModel> { get }
    var errorResult: Observable<Error> { get }
    func viewDidLoad()
    func addEventToCalendar(withRosterModel rosterModel: RosterModel) -> Observable<AddEventRoute>
}
```

* EmployeeViewModel.swift
```swift
import Foundation
import RxSwift
import CocoaLumberjack
import EventStoreHelperRx

enum AddEventRoute {
    case eventAdded(String, String)
    case openSettings(String, String)
    case errorResult(Error)
}

final class EmployeeViewModel: EmployeeViewModelProtocol {
    //input
    private let employeeListModel: EmployeeListModelDataSource
    private let eventsCalendarManager: EventsCalendarManagerDataSource

    //output
    var employeeResult: Observable<EmployeeModel>
    var errorResult: Observable<Error>

    private let employeeResultSubject = PublishSubject<EmployeeModel>()
    private let errorResultSubject = PublishSubject<Error>()

    private let disposeBag = DisposeBag()

    init(withEmployeeListModel employeeListModel: EmployeeListModelDataSource = EmployeeListModel(),
         withEventsCalendarManager eventsCalendarManager: EventsCalendarManagerDataSource = EventsCalendarManager()) {
        self.employeeListModel = employeeListModel
        self.eventsCalendarManager = eventsCalendarManager

        self.employeeResult = employeeResultSubject.asObserver()
        self.errorResult = errorResultSubject.asObserver()
        self.reloadTask()
    }

    private func reloadTask() {
        let scheduler = SerialDispatchQueueScheduler(qos: .default)
        Observable<Int>.interval(.seconds(500), scheduler: scheduler)
            .flatMap { [weak self] _ -> Observable<EmployeeModel> in
                return self?.getRosterInfo() ?? Observable.empty()
        }
        .subscribe(onNext: { [employeeResultSubject] result in
            employeeResultSubject.onNext(result)
            }, onError: { [errorResultSubject] (error) in
                errorResultSubject.on(.next(error))
        }).disposed(by: disposeBag)
    }

    func viewDidLoad() {
        self.updateRosterInfo()
    }

    // Get employee roster from server
    func updateRosterInfo() {
        self.getRosterInfo()
            .subscribe(onNext: { [employeeResultSubject] result in
                employeeResultSubject.onNext(result)
                }, onError: { [errorResultSubject] (error) in
                    errorResultSubject.on(.next(error))
            }).disposed(by: disposeBag)
    }

    // Get employee roster Info From model
    private func getRosterInfo() -> Observable<EmployeeModel> {
        return self.employeeListModel.getRosterInfo()
    }

    // Check Calendar permissions auth status
    // Try to add an event to the calendar if authorized
    func addEventToCalendar(withRosterModel rosterModel: RosterModel) -> Observable<AddEventRoute> {

        guard let event = EventsModel(withRosterModel: rosterModel) else { return Observable.empty() }

        return self.eventsCalendarManager
            .addEventToCalendar(event: event)
            //            .presentCalendarModalToAddEvent(event: event)
            .asObservable()
            .catchError({ (error) -> Observable<EventsCalendarStatus> in
                return Observable.just(EventsCalendarStatus.error(error as? EKEventError ?? EKEventError.eventNotAddedToCalendar))
            })
            .flatMap({ calendarStatus -> Observable<AddEventRoute> in
                switch calendarStatus {
                case .added:
                    let result = ("Event added to Calendar", "Event added to Calendar completed")
                    return Observable.just(AddEventRoute.eventAdded(result.0, result.1))

                case .denied:
                    let appName = Bundle.main.displayName ?? "This app"
                    let result = ("This feature requires calender access", "In iPhone settings, tap \(appName) and turn on calender access")
                    return Observable.just(AddEventRoute.openSettings(result.0, result.1))

                case .error(let error):
                    return Observable.just(AddEventRoute.errorResult(error))
                }
            })
    }

}
```
### EmployeeListModel

* EmployeeListModel.swift
```swift
import Foundation
import RxSwift

protocol EmployeeListModelDataSource {
    func getRosterInfo() -> Observable<EmployeeModel>
}

final class EmployeeListModel: EmployeeListModelDataSource {

    private let getEmployeeHandler: GetEmployeeInfoHandlerProtocol
    private let realmManager: RealmManagerDataSource
    private let disposeBag = DisposeBag()

    init(withGetWeather getEmployeeHandler: GetEmployeeInfoHandlerProtocol = GetEmployeeInfoHandler(),
         withRealmManager realmManager: RealmManagerDataSource = RealmManager()) {
        self.getEmployeeHandler = getEmployeeHandler
        self.realmManager = realmManager
    }

    func getRosterInfo() -> Observable<EmployeeModel> {
        let result = Observable.concat(getEmployeeInfoFromLocalDb(), getEmployeeInfoFromServer())
        return result
    }
    // Get employee roster from server
    func getEmployeeInfoFromServer() -> Observable<EmployeeModel> {
        self.getEmployeeHandler
            .request()
            .retry(3)
            .catchError { _ in Observable.empty()}
            .flatMap { [weak self] result -> Observable<EmployeeModel> in
                guard let self = self else { return Observable.empty() }
                return self.saveEmployeeInfo(withInfo: result)
                    .andThen(Observable.just(result))
        }
    }

    // Get employee roster from DB
    func getEmployeeInfoFromLocalDb() -> Observable<EmployeeModel> {
        realmManager.fetchEmployeeInfo().asObservable()
            .catchError { _ in Observable.empty() }
    }

    //save EmployeeInfo to DB
    private func saveEmployeeInfo(withInfo data: EmployeeModel) -> Completable {
        return self.realmManager.saveEmployeeInfo(withInfo: data)
            .catchError { _ in Completable.empty()}
    }

}
```

### View
let’s implement our View, which is EmployeeRosterVC. What’s need to be done there is to link a UITableView to its dataSource, but also to bind values to be able to automatically refresh the UI when new data is available

```swift
import UIKit
import RxSwift
import RxCocoa
import CocoaLumberjack
import EventStoreHelperRx

final class EmployeeRosterVC: UIViewController {
    @IBOutlet weak var tableView: UITableView?

    @IBOutlet weak var buttonRefresh: UIBarButtonItem!
    private var viewModel: EmployeeViewModelProtocol!
    private var employeeList: EmployeeModel?
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupTableView()
        self.viewModelSetUp()
    }

    private func setupUI() {
        self.navigationItem.title = "Roster"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.setCustomStyle()
        self.view.backgroundColor = UIColor.white
    }

    private func setupTableView() {
        self.tableView?.backgroundColor = UIColor.tableViewBackgroundColor
        self.view.backgroundColor = UIColor.tableViewBackgroundColor
        self.tableView?.tableFooterView = UIView(frame: CGRect.zero)
    }

    private func viewModelSetUp() {
        viewModel = EmployeeViewModel()

        self.createSpinnerView()
        viewModel.employeeResult
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                self?.removeSpinnerView()
                self?.employeeList = result
                self?.tableView?.reloadData()
                }, onError: { [weak self] error in
                    self?.removeSpinnerView()
                    DDLogError("onError: \(error)")
            }).disposed(by: disposeBag)

        viewModel
            .errorResult
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] error in
                self?.showAlertView(withTitle: error.localizedDescription, andMessage: error.localizedDescription)
            }).disposed(by: disposeBag)

        buttonRefresh.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.viewModel.viewDidLoad()
            }).disposed(by: disposeBag)

        viewModel.viewDidLoad()
    }

    private func addEventToCalendar(withRosterModel dataModel: RosterModel) {
        viewModel
            .addEventToCalendar(withRosterModel: dataModel)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] eventRoute in
                self?.eventAddedRoute(withRoute: eventRoute)
                }, onError: { error in
                    print("addEventToCalendar VC error", error)
            }).disposed(by: disposeBag)

    }

    func eventAddedRoute(withRoute eventRoute: AddEventRoute) {
        switch eventRoute {
        case .eventAdded(let title, let message):
            self.showAlertView(withTitle: title, andMessage: message)

        case .openSettings(let title, let message):
            self.alertCalenderAccessNeeded(title, message)

        case .errorResult(let error):
            self.showAlertView(withTitle: error.localizedDescription, andMessage: (error as? EKEventError)?.recoverySuggestion)
        }
    }

    private func openSettingsAppURL() {
        let settingsAppURL = URL(string: UIApplication.openSettingsURLString)!
        UIApplication.shared.open(settingsAppURL)
    }

    private func alertCalenderAccessNeeded(_ title: String, _ message: String) {

        let alert = UIAlertController(title: title,
                                      message: message,
            preferredStyle: UIAlertController.Style.alert)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { [weak self] (_: UIAlertAction) in
            self?.openSettingsAppURL()
        }

        alert.addAction(cancelAction)
        alert.addAction(settingsAction)
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - TableViewDelegate Setup
extension EmployeeRosterVC: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let employeeSection = EmployeeSectionModel(rawValue: indexPath.section)
        switch employeeSection {
        case .header:
            return 200
        default:
            return 150
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.employeeList != nil ? 2 : 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let employeeSection = EmployeeSectionModel(rawValue: section)

        switch employeeSection {
        case .header:
            return self.employeeList != nil ? 1 : 0

        default:
            return self.employeeList?.roster?.count ?? 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let employeeSection = EmployeeSectionModel(rawValue: indexPath.section)

        switch employeeSection {
        case .header:
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as RosterTableViewCell
            cell.configure(self.employeeList?.scheduledToday)
            return cell

        default:
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as EmployeeDetailCell
            cell.configure(self.employeeList?.roster?[indexPath.row])
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DDLogInfo("tapped")
        guard let roster = self.employeeList?.roster else {
            return
        }
        let dataValue = roster[indexPath.row]
        self.addEventToCalendar(withRosterModel: dataValue)
    }
}
```