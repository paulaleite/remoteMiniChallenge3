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
    let serverService: ServerService = ServerService()

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
	
	init(notification: Notification) {
		self.notification = notification
	}
    
    func answerRequisition(answer: Bool) {
        guard let notification = notification else { return }
        serverService.answerRequestParticipation(userID: notification.userRequisitorID, projectID: notification.projectID, answer: answer, {(response) in
            switch response {
            case .success(let res):
                print(res)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reload_notifications"), object: nil)
            case .failure(let error):
                print(error.localizedDescription)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reload_notifications"), object: nil)
            }
        })
    }
}
