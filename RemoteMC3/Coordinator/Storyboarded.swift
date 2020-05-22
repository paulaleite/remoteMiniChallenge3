//
//  Storyboarded.swift
//  RemoteMC3
//
//  Created by Paula Leite on 20/05/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

//import Foundation
//import UIKit
//
//protocol Storyboarded {
//    static func instantiate() -> Self
//}
//
//extension Storyboarded where Self: UIViewController {
//    static func instantiate() -> Self {
//        let id = String(describing: self)
//        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//        guard let safeReturn = storyboard.instantiateViewController(identifier: id) as? Self else {
//            return Self()
//        }
//        return safeReturn
//    }
//}
