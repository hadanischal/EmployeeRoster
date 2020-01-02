//
//  GetEmployeeInfoHandler.swift
//  EmployeeRoster
//
//  Created by Nischal Hada on 7/3/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation
import RxSwift

final class GetEmployeeInfoHandler: GetEmployeeInfoHandlerProtocol {
    private let webService: WebServiceProtocol
    private let disposeBag = DisposeBag()
    private let url = "http://support-moray-eel.herokuapp.com/roster"

    init(withWebService webService: WebServiceProtocol = WebService()) {
        self.webService = webService
    }

    func request() -> Observable<EmployeeModel> {
        let resource = Resource(url: URL(string: url)!, parameters: nil)
        return self.webService.request(with: resource)
            .map { data -> EmployeeModel in
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let result = try decoder.decode(EmployeeModel.self, from: data)
                return result
            }.asObservable()
    }
}
