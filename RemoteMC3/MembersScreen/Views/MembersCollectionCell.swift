//
//  MembersCollectionCell.swift
//  RemoteMC3
//
//  Created by Cassia Aparecida Barbosa on 19/05/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation
import UIKit

class MembersCollectionCell: UICollectionViewCell {
	
	@IBOutlet var memberImage: UIImageView!
	@IBOutlet var memberName: UITextView!
	@IBOutlet var memberEmail: UITextView!
	
	@IBAction func aceptAction(_ sender: Any) {
	}
	@IBAction func denyAction(_ sender: Any) {
	}
}
