//
//  CloudKitService.swift
//  RemoteMC3
//
//  Created by Edgar Sgroi on 11/05/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//
//
//import Foundation
//import CloudKit
//
//class CloudKitService {
//
//    var container: CKContainer
//    var publicDB: CKDatabase
//    var privateDB: CKDatabase
//    var projects: [Any] = []
//    var records: [CKRecord]?
//
//    init() {
//        container = CKContainer.default()
//        publicDB = container.publicCloudDatabase
//        privateDB = container.privateCloudDatabase
//
//    }
//
//    func fetch(_ completion: @escaping (Result<Any, Error>) -> Void) {
//        let predicate = NSPredicate(value: true)
//        let query = CKQuery(recordType: "Tour", predicate: predicate)
//        publicDB.perform(query, inZoneWith: CKRecordZone.default().zoneID) {
//            [weak self] results, error in
//            guard let self = self else { return }
//            if let error = error as? CKError {
//                DispatchQueue.main.async {
//                    completion(<#Result<Any, Error>#>)
//                }
//                return
//            }
//            guard let results = results else { return }
//            self.records = results
//            DispatchQueue.main.async {
//                completion(CloudKitResponse(error: nil, records: results))
//            }
//        }
//    }
//
//}
//
//extension CloudKitService: FeedViewModelDelegate {
//    func fetchData(_ completion: @escaping (Result<Any, Error>) -> Void) {
//        bla
//    }
//
//
//}
