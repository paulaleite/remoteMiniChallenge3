//
//  Coordinator.swift
//  RemoteMC3
//
//  Created by Paula Leite on 20/05/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    
    func start()
}
