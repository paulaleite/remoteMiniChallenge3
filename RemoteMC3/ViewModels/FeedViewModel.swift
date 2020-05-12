//
//  FeedViewModel.swift
//  RemoteMC3
//
//  Created by Edgar Sgroi on 11/05/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation

protocol FeedViewModelDelegate: class {
    func fetchData(_ completion: @escaping (Result<Any, Error>) -> Void)
}

class FeedViewModel {
    var projects: [Project] = []
    
    func getRowsNumber() -> Int {
        return projects.count
    }
    
    func getProjectTitle(forProjectAt index: Int) -> String {
        return projects[index].title
    }
    
    func getProjectResponsible(forProjectAt index: Int) -> User {
        return projects[index].responsible
    }
    
    func getProjectPhases(forProjectAt index: Int) -> [Phase] {
        return projects[index].phases
    }
    
    func getProjectCurrentPhase(forProjectAt index: Int) -> Phase {
        return projects[index].currentPhase
    }
}
