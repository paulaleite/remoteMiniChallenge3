//
//  ConfigurationCollectionCell.swift
//  RemoteMC3
//
//  Created by Luiza Fattori on 15/05/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import UIKit

class ConfigurationCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var nameProject: UILabel!
    @IBOutlet weak var phaseProject: UILabel!
    @IBOutlet weak var responsableProject: UILabel!
    var index: Int?
}
