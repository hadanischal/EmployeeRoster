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

### Model
These hold the app data. These are the structs and classes that you have created to hold the data you receive from a REST API or from some other data source.
* EmployeeModel.swift
```swift
struct EmployeeModel: Codable {
    let tenant: String?
    let motd: String?
    let scheduledToday: ScheduleModel?
    let roster: [RosterModel]?
}
```
* ScheduleModel.swift
```swift
struct ScheduleModel: Codable {
    let name: String?
    let fromDate: String?
    let toDate: String?
}
```
* Player.swift 
```swift
struct RosterModel: Codable {
    let name: String?
    let fromDate: String?
    let toDate: String?
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
    func getRosterInfo()
}
```

* EmployeeViewModel.swift
```swift
import Foundation
import RxSwift
import CocoaLumberjack

class EmployeeViewModel: EmployeeViewModelProtocol {
    //input
    private let getEmployeeHandler: GetEmployeeInfoHandlerProtocol
    private let realmManager: RealmManagerDataSource

    //output
    var employeeResult: Observable<EmployeeModel>
    var errorResult: Observable<Error>

    private let employeeResultSubject = PublishSubject<EmployeeModel>()
    private let errorResultSubject = PublishSubject<Error>()
    private let disposeBag = DisposeBag()

    init(withGetWeather getEmployeeHandler: GetEmployeeInfoHandlerProtocol = GetEmployeeInfoHandler(),
         withRealmManager realmManager: RealmManagerDataSource = RealmManager()) {
        self.getEmployeeHandler = getEmployeeHandler
        self.realmManager = realmManager

        self.employeeResult = employeeResultSubject.asObserver()
        self.errorResult = errorResultSubject.asObserver()
        self.reloadTask()
    }

    private func reloadTask() {
        let scheduler = SerialDispatchQueueScheduler(qos: .default)
        Observable<Int>.interval(.seconds(500), scheduler: scheduler)
            .subscribe { [weak self] _ in
                self?.getRosterInfo()
            }.disposed(by: disposeBag)
    }

    // Get employee roster from server
    func getRosterInfo() {
        self.getEmployeeHandler
            .request()
            .retry(3)
            .map { [weak self] result -> EmployeeModel in
                self?.employeeResultSubject.on(.next(result))
                return result
            }
            .flatMap { result -> Completable in
                return self.realmManager.saveEmployeeInfo(withInfo: result)
            }.subscribe(onNext: { _ in
                DDLogInfo("onNext")
            }, onError: { [weak self] error in
                DDLogError("onError: \(error)")
                self?.errorResultSubject.on(.next(error))

                }, onCompleted: {
                    DDLogInfo("onCompleted")

            }).disposed(by: disposeBag)
    }

    // Get employee roster from DB
    func getRosterInfoFromDB() {
        realmManager
            .fetchEmployeeInfo()
            .subscribe(onSuccess: { [weak self] result in
                self?.employeeResultSubject.on(.next(result))
                }, onError: { error in
                    DDLogError("fetch from DB error : \(error)")
            }).disposed(by: disposeBag)
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

class EmployeeRosterVC: UIViewController {
    @IBOutlet weak var tableView: UITableView?
    var activityIndicator: ActivityIndicator? = ActivityIndicator()

    @IBOutlet weak var buttonRefresh: UIBarButtonItem!
    private let disposeBag = DisposeBag()
    var viewModel: EmployeeViewModelProtocol!
    private var employeeList: EmployeeModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupTableView()
        self.viewModelSetUp()
    }

    func setupUI() {
        self.navigationItem.title = "Roster"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.setCustomStyle()
        self.view.backgroundColor = UIColor.white
    }

    func setupTableView() {
        self.tableView?.backgroundColor = UIColor.tableViewBackgroundColor
        self.view.backgroundColor = UIColor.tableViewBackgroundColor
        self.tableView?.tableFooterView = UIView(frame: CGRect.zero)
    }

    func viewModelSetUp() {
        viewModel = EmployeeViewModel()
        viewModel.employeeResult
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { result in
                self.employeeList = result
                self.tableView?.reloadData()
            }, onError: { (error) in
                DDLogError("onError: \(error)")
            }).disposed(by: disposeBag)

        viewModel
            .errorResult
            .subscribe(onNext: { error in
                DDLogError("onError: \(error)")
            })
            .disposed(by: disposeBag)

        buttonRefresh.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.viewModel.getRosterInfo()
            }).disposed(by: disposeBag)

        viewModel.getRosterInfoFromDB()
        viewModel.getRosterInfo()

    }
}

```