//
//  ProjectWiithMeCollectionCell.swift
//  RemoteMC3
//
//  Created by Cassia Aparecida Barbosa on 02/06/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation
import UIKit

class ProjectWiithMeCollectionCell: UICollectionViewCell {
	
	public let  nameProject: UILabel = {
		var nameProject = UILabel()
		nameProject.translatesAutoresizingMaskIntoConstraints = false
		nameProject.font = UIFont.systemFont(ofSize: 22, weight: .regular)
		nameProject.textColor = .black
		return nameProject
	}()
	
	public let  responsavelLabel: UILabel = {
		var responsavelLabel = UILabel()
		responsavelLabel.translatesAutoresizingMaskIntoConstraints = false
		responsavelLabel.text = "Responsável"
		responsavelLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
		responsavelLabel.textColor = #colorLiteral(red: 0.6241586804, green: 0.23033306, blue: 0.2308549583, alpha: 1)
		return responsavelLabel
	}()
	
	public let  responsableProject: UILabel = {
		var responsableProject = UILabel()
		responsableProject.translatesAutoresizingMaskIntoConstraints = false
		responsableProject.font = UIFont(name: "MuktaMahee-Regular", size: 14)
		responsableProject.textColor = #colorLiteral(red: 0.5097514391, green: 0.5098407865, blue: 0.509739697, alpha: 1)
		responsableProject.numberOfLines = 3
		return responsableProject
	}()
	
	public let  phaseLabel: UILabel = {
		var phaseLabel = UILabel()
		phaseLabel.translatesAutoresizingMaskIntoConstraints = false
		phaseLabel.text = "Etapa"
		phaseLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
		phaseLabel.textColor = #colorLiteral(red: 0.6241586804, green: 0.23033306, blue: 0.2308549583, alpha: 1)
		return phaseLabel
	}()
	
	public let  phaseProject: UILabel = {
		var phaseProject = UILabel()
		phaseProject.translatesAutoresizingMaskIntoConstraints = false
		phaseProject.font = UIFont(name: "MuktaMahee-Regular", size: 14)
		phaseProject.textColor = #colorLiteral(red: 0.5097514391, green: 0.5098407865, blue: 0.509739697, alpha: 1)
		phaseProject.numberOfLines = 3
		return phaseProject
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		addSubview(nameProject)
		addSubview(responsavelLabel)
        addSubview(responsableProject)
        addSubview(phaseProject)
		addSubview(phaseLabel)
        self.layer.masksToBounds = false
		self.backgroundColor = .white
		self.layer.cornerRadius = 20
		self.layer.shadowColor = UIColor.black.cgColor
		self.layer.shadowOffset = .zero
		self.layer.shadowRadius = 4
		self.layer.shadowOpacity = 0.3
        
        nameProject.topAnchor.constraint(equalTo: self.topAnchor, constant: 12).isActive = true
        nameProject.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 16).isActive = true
        nameProject.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
		nameProject.bottomAnchor.constraint(equalTo: self.topAnchor, constant: 40).isActive = true

		responsavelLabel.topAnchor.constraint(equalTo: self.nameProject.bottomAnchor, constant: 10).isActive = true
        responsavelLabel.bottomAnchor.constraint(equalTo: self.responsableProject.topAnchor).isActive = true
		responsavelLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        responsavelLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 50).isActive = true
		
		phaseLabel.bottomAnchor.constraint(equalTo: self.phaseProject.topAnchor).isActive = true
		phaseLabel.leadingAnchor.constraint(equalTo: self.responsableProject.trailingAnchor, constant: 50).isActive = true
        phaseLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 50).isActive = true
		phaseLabel.topAnchor.constraint(equalTo: self.nameProject.bottomAnchor, constant: 10).isActive = true
		
		responsableProject.topAnchor.constraint(equalTo: self.responsavelLabel.bottomAnchor).isActive = true
        responsableProject.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
		responsableProject.heightAnchor.constraint(equalToConstant: 50).isActive = true
		responsableProject.widthAnchor.constraint(equalToConstant: 80).isActive = true
		responsableProject.trailingAnchor.constraint(equalTo: self.phaseProject.leadingAnchor, constant: -51).isActive = true
		
		phaseProject.topAnchor.constraint(equalTo: self.responsavelLabel.bottomAnchor).isActive = true
		phaseProject.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
		phaseProject.heightAnchor.constraint(equalToConstant: 50).isActive = true
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
