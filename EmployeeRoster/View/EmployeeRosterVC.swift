//
//  EmployeeRosterVC.swift
//  EmployeeRoster
//
//  Created by Nischal Hada on 7/3/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class EmployeeRosterVC: UIViewController {
    private let disposeBag = DisposeBag()
    var viewModel: EmployeeViewModelProtocol!
    private var employeeList: EmployeeModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = EmployeeViewModel()
        self.viewModelSetUp()
        self.viewModel.getRosterInfo()
    }
    
    func viewModelSetUp() {
        self.viewModel.employeeResult
            .subscribe(onNext: { result in
                self.employeeList = result
                
            }, onError: { (error) in
                print("error:\(error)")
            }).disposed(by: disposeBag)
        
        self.viewModel
            .errorResult
            .subscribe(onNext: { error in
                print("error:\(error)")
            })
            .disposed(by: disposeBag)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
