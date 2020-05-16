//
//  VerticallyCenteredTextView.swift
//  RemoteMC3
//
//  Created by Cassia Aparecida Barbosa on 16/05/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation
import UIKit

class VerticallyCenteredTextView: UITextView {
    
    override var contentSize: CGSize {
        didSet {
            var topCorrection = (bounds.size.height - contentSize.height * zoomScale) / 2.0
            topCorrection = max(0, topCorrection)
            contentInset = UIEdgeInsets(top: topCorrection, left: 0, bottom: 0, right: 0)
            self.inputView?.layoutIfNeeded()
        }
    }
    
    
}
