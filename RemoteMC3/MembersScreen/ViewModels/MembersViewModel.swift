//
//  MembersViewModel.swift
//  RemoteMC3
//
//  Created by Cassia Aparecida Barbosa on 19/05/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation
import UIKit

class MembersViewModel {
    var members: [Member] = []

    func getMembersRowsNumber() -> Int {
        return members.count
    }

    func getMemberName(index: Int) -> String{
		return members[index].name
    }
    
    func getMemberEmail(index: Int) -> String {
		return members[index].email
    }

    func getMemberImage(index: Int) -> String {
		return members[index].image
    }
	
	func setProjects() {
		members.append(Member(name: "Cassia Barbosa", email: "cassia.a.barbosa@gmail.com", image: "cas"))
	}
}
