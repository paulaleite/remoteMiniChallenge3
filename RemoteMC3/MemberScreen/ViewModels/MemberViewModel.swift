//
//  MembersViewModel.swift
//  RemoteMC3
//
//  Created by Cassia Aparecida Barbosa on 19/05/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation
import UIKit

class MemberViewModel {
		
	var notification: Notification?

    func getMemberName() -> String {
		return notification?.requisitor ?? "nil"
    }

    func getMemberEmail() -> String {
		return notification?.requisitorEmail ?? "nil"
	}

    func getMemberImage() -> String {
		return notification?.personImage ?? "personalColored"
    }
	
	func getProjectName() -> String {
		return notification?.projectRequired ?? "nil"
    }
	
	init(notification: Notification){
		self.notification = notification
	}
}
