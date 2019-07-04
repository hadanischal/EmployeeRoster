//
//  WebService.swift
//  EmployeeRoster
//
//  Created by Nischal Hada on 7/3/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

struct Resource {
    let url: URL
    let parameters: [String: Any]?
}

class WebService: WebServiceProtocol {
    init() {
    }
    func request(with resource: Resource) -> Single<Data> {
        print("url:", resource.url)
        print("response:", resource.parameters ?? "nil")

        return Single<Data>.create { single in
            Alamofire.request(resource.url, method: .get, parameters: resource.parameters)
                .validate()
                .responseData(completionHandler: { response in
                    print("response:", response)
                    switch response.result {
                    case .success(let value):
                        single(.success(value))
                    case .failure(let error):
                        single(.error(error))
                    }
                })
            return Disposables.create ()
        }
    }
}
