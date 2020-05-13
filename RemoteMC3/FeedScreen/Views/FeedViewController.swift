//
//  FeedViewController.swift
//  RemoteMC3
//
//  Created by Edgar Sgroi on 11/05/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation
import UIKit

class FeedViewController: UIViewController {
    
    var viewModel: FeedViewModel = FeedViewModel()
    
	@IBOutlet var categoryCollectionView: UICollectionView!

	@IBOutlet var projectCollectionView: UICollectionView!
	
	override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//	MARK: - Table View Data Source
extension FeedViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		return UITableViewCell()
	}
	
}

//	MARK: - Table View Delegate
extension FeedViewController: UITableViewDelegate {

}
