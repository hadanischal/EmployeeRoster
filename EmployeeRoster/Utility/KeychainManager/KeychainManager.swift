//
//  KeychainManager.swift
//  EmployeeRoster
//
//  Created by Nischal Hada on 11/10/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation
import RxSwift
import KeychainAccess

protocol KeychainManagerProtocol {
    func get(key: String) -> Single<String?>
    func getData(key: String) -> Single<Data?>
    func set(value: String, key: String) -> Single<String>
    func set(data: Data, key: String) -> Single<Data>
}

struct KeychainManager: KeychainManagerProtocol {
    private let keyChainServiceKey: String
    private let scheduler: SchedulerType

    init(withKeyChainServiceKey keyChainServiceKey: String,
         andScheduler backgroundScheduler: SchedulerType = ConcurrentDispatchQueueScheduler(qos: DispatchQoS.userInitiated)) {
        self.keyChainServiceKey = keyChainServiceKey
        self.scheduler = backgroundScheduler
    }

     func get(key: String) -> Single<String?> {
        return getKeychain().map { keychain in
            return try keychain.get(key)
        }
    }

    func getData(key: String) -> Single<Data?> {
        return getKeychain().map { keychain in
            return try keychain.getData(key)
        }
    }

     func set(value: String, key: String) -> Single<String> {
        return getKeychain().map { keychain in
            try keychain.set(value, key: key)
            return value
        }
    }

    func set(data: Data, key: String) -> Single<Data> {
        return getKeychain().map { keychain in
            try keychain.set(data, key: key)
            return data
        }
    }

    private func getKeychain() -> Single<Keychain> {
        return Single<Keychain>.create { single -> Disposable in
            single(.success(Keychain(service: self.keyChainServiceKey)))
            return Disposables.create()
            }.subscribeOn(scheduler)
    }
}
