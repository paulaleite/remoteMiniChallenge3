//
//  FeedViewController.swift
//  RemoteMC3
//
//  Created by Edgar Sgroi on 11/05/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation
import UIKit

class FeedViewController: UIViewController, UITableViewDelegate {
    
    var viewModel: FeedViewModel = FeedViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
    }
}

extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getRowsNumber()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "projectCell", for: indexPath) as? ProjectTableViewCell {
            cell.lblTitle.text = viewModel.getProjectTitle(forProjectAt: indexPath.row)
            cell.lblResponsible.text = viewModel.getProjectResponsible(forProjectAt: indexPath.row).firstName
            cell.lblPhase.text = viewModel.getProjectCurrentPhase(forProjectAt: indexPath.row).title
            return cell
        }
        //TODO: Tratar erro aqui
        return ProjectTableViewCell()
    }
}
