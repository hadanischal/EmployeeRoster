//
//  GetEmployeeInfoHandler.swift
//  EmployeeRoster
//
//  Created by Nischal Hada on 7/3/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation
import RxSwift

protocol EmployeeNetworkHandling: AnyObject {
    func request() -> Observable<EmployeeModel>
}

final class EmployeeNetworkHandler: EmployeeNetworkHandling {
    private let webService: WebServiceProtocol

    init(withWebService webService: WebServiceProtocol = WebService()) {
        self.webService = webService
    }

    func request() -> Observable<EmployeeModel> {
        let resource = Resource(url: URL.sourcesUrl, parameters: nil)

        return self.webService
            .request(with: resource)
            .map { data -> EmployeeModel in
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let result = try decoder.decode(EmployeeModel.self, from: data)
                return result
            }
            .asObservable()
            .retry(2)
    }
}
