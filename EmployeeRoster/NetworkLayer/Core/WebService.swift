//
//  WebService.swift
//  EmployeeRoster
//
//  Created by Nischal Hada on 7/3/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Alamofire
import CocoaLumberjack
import Foundation
import RxSwift

struct Resource {
    let url: URL
    let parameters: [String: Any]?
}

protocol WebServiceProtocol {
    func request(with resource: Resource) -> Observable<Data>
}

final class WebService: WebServiceProtocol {
    func request(with resource: Resource) -> Observable<Data> {
        print("url:", resource.url)
        print("parameters:", resource.parameters ?? "[:]")

        return Observable<Data>.create { observer in
            Alamofire.request(resource.url, method: .get, parameters: resource.parameters)
                .validate()
                .responseData(completionHandler: { response in
                    print("response:", response)
                    switch response.result {
                    case let .success(value):
                        let json = try? JSONSerialization.jsonObject(with: response.result.value!) as? [String: Any]
                        DDLogInfo("success response: \(json ?? [:])")

                        observer.on(.next(value))
                        observer.on(.completed)
                    case let .failure(error):
                        DDLogError("failure Error: \(error)")

                        observer.on(.error(error))
                    }
                })
            return Disposables.create()
        }
    }
}
