//
//  VerticallyCenteredTextView.swift
//  RemoteMC3
//
//  Created by Cassia Aparecida Barbosa on 15/05/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//
//  This Class was extracted from a article made by Tai Le. Comments about the implementation are available at:
//https://geek-is-stupid.github.io/2017-05-15-how-to-center-text-vertically-in-a-uitextview/

import Foundation
import UIKit

class VerticalCenteredTextView: UITextView {
    
    override var contentSize: CGSize {
        didSet {
            var topCorrection = (bounds.size.height - contentSize.height * zoomScale) / 2.0
            topCorrection = max(0, topCorrection)
            contentInset = UIEdgeInsets(top: topCorrection, left: 0, bottom: 0, right: 0)
            self.inputView?.layoutIfNeeded()
        }
    }
    
    
}
