//
//  FeedViewController.swift
//  RemoteMC3
//
//  Created by Edgar Sgroi on 11/05/20.
//  Copyright ©️ 2020 Paula Leite. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

class FeedViewController: UIViewController {
    
    var viewModel: FeedViewModel!
    
    @IBOutlet var categoryCollectionView: UICollectionView!

    @IBOutlet var projectCollectionView: UICollectionView!
    
    var firstCellState: Int = 0
    
    @IBOutlet var viewLabel: UILabel!
    
	var categorySelected: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
		categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        
        projectCollectionView.dataSource = self
        projectCollectionView.delegate = self
		
		NotificationCenter.default.addObserver(self, selector: #selector(reloadUI), name: .updateProjects, object: nil)
		
		SignInWithAppleManager.checkUserAuth { (authState) in
			switch authState {
				case .undefined:
					let controller = LoginViewController()
					controller.modalPresentationStyle = .fullScreen
					controller.delegate = self
					self.present(controller, animated: true, completion: nil)
				case .signedOut:
					let controller = LoginViewController()
					controller.modalPresentationStyle = .fullScreen
					controller.delegate = self
					self.present(controller, animated: true, completion: nil)
				case .signedIn:
					print("SignedIn")
			}
		}
	}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
			viewModel = FeedViewModel()
			viewModel.loadProjects()
    }

    @objc func reloadUI() {
        viewModel.addCategory()
        projectCollectionView.reloadData()
        categoryCollectionView.reloadData()
    }
}

extension FeedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
        case categoryCollectionView:
            return viewModel.getCategoryRowsNumber()
        default:
            self.viewLabel.isHidden = true
            if self.categorySelected == 0 && viewModel.socialCount != 0 {
                return viewModel.socialCount
            } else if categorySelected == 1 && viewModel.culturalCount != 0 {
                return viewModel.culturalCount
            } else if categorySelected == 2 && viewModel.personalCount != 0 {
                return viewModel.personalCount
            } else if categorySelected == 3 && viewModel.entrepreneurialCount != 0 {
                return viewModel.entrepreneurialCount
            } else if categorySelected == 4 && viewModel.researchCount != 0 {
                return viewModel.researchCount
            }
        }
        self.viewLabel.isHidden = false
        self.viewLabel.text = "Não há projetos cadastrados para essa categoria."
        if firstCellState == 0 {
            viewLabel.text = "Carregando..."
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        switch collectionView {
        case categoryCollectionView:
			if let feedCategoryCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedCategoryCollectionCell", for: indexPath) as? FeedCategoryCollectionCell {
				if categorySelected ==  indexPath.row {
					feedCategoryCollectionCell.categoryImage.image = UIImage(named: viewModel.categorys[categorySelected].imagem)
					feedCategoryCollectionCell.categoryName.text = viewModel.categorys[indexPath.row].name
					feedCategoryCollectionCell.categoryCount.text = String(viewModel.categorys[indexPath.row].count)
					feedCategoryCollectionCell.backgroundColor = .white
					feedCategoryCollectionCell.layer.masksToBounds = false
					feedCategoryCollectionCell.layer.cornerRadius = 37
					feedCategoryCollectionCell.layer.shadowColor = UIColor.black.cgColor
					feedCategoryCollectionCell.layer.shadowOffset = .zero
					feedCategoryCollectionCell.layer.shadowRadius = 4
					feedCategoryCollectionCell.layer.shadowOpacity = 0.3
					feedCategoryCollectionCell.categoryName.textColor = .black
					feedCategoryCollectionCell.categoryCount.layer.cornerRadius = 7
					feedCategoryCollectionCell.categoryCount.layer.borderWidth = 1
					feedCategoryCollectionCell.categoryCount.layer.borderColor = #colorLiteral(red: 0.6241586804, green: 0.23033306, blue: 0.2308549583, alpha: 1)
					return feedCategoryCollectionCell
				}
				feedCategoryCollectionCell.categoryImage.image = UIImage(named: viewModel.unselectedImages[indexPath.row])
				feedCategoryCollectionCell.categoryName.text = viewModel.categorys[indexPath.row].name
				feedCategoryCollectionCell.categoryCount.text = String(viewModel.categorys[indexPath.row].count)
				feedCategoryCollectionCell.backgroundColor = .white
				feedCategoryCollectionCell.layer.masksToBounds = false
				feedCategoryCollectionCell.layer.cornerRadius = 37
				feedCategoryCollectionCell.layer.shadowRadius = 0
				feedCategoryCollectionCell.layer.borderWidth = 1
				feedCategoryCollectionCell.layer.borderColor = #colorLiteral(red: 0.768627451, green: 0.768627451, blue: 0.768627451, alpha: 1)
				feedCategoryCollectionCell.categoryCount.layer.cornerRadius = 7
				feedCategoryCollectionCell.categoryCount.layer.borderWidth = 1
				feedCategoryCollectionCell.categoryCount.layer.borderColor = #colorLiteral(red: 0.768627451, green: 0.768627451, blue: 0.768627451, alpha: 1)
				return feedCategoryCollectionCell
			}
        case projectCollectionView:
            if let feedProjectCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedProjectCollectionCell", for: indexPath) as? FeedProjectCollectionCell {
                feedProjectCollectionCell.backgroundColor = .white
                feedProjectCollectionCell.layer.masksToBounds = false
                feedProjectCollectionCell.layer.cornerRadius = 20
                feedProjectCollectionCell.layer.shadowColor = UIColor.black.cgColor
                feedProjectCollectionCell.layer.shadowOffset = .zero
                feedProjectCollectionCell.layer.shadowRadius = 4
                feedProjectCollectionCell.layer.shadowOpacity = 0.3
				feedProjectCollectionCell.projectName.text = viewModel.getProjectTitle(forCategoryAt: categorySelected, forProjectAt: indexPath.row)
				feedProjectCollectionCell.projectResponsible.text = viewModel.getProjectResponsible(forCategoryAt: categorySelected, forProjectAt: indexPath.row)
				feedProjectCollectionCell.projectPhase.text = viewModel.getProjectCurrentPhase(forCategoryAt: categorySelected, forProjectAt: indexPath.row)
                return feedProjectCollectionCell
            }
		default:
			return UICollectionViewCell()
		}
	return UICollectionViewCell()
    }
}

extension FeedViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView {
        case categoryCollectionView:
            return CGSize(width: self.view.frame.size.width * 0.2, height: self.view.frame.size.height * 0.1)
        case projectCollectionView:
            return CGSize(width: self.view.frame.size.width * 0.9, height: 125)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case categoryCollectionView:
            
            firstCellState = 1

            switch indexPath.row {
            case 1:
                self.categorySelected = 1
				categoryCollectionView.reloadData()
                projectCollectionView.reloadData()

            case 2:
                self.categorySelected = 2
				categoryCollectionView.reloadData()
                projectCollectionView.reloadData()

            case 3:
                self.categorySelected = 3
				categoryCollectionView.reloadData()
                projectCollectionView.reloadData()

            case 4:
                self.categorySelected = 4
				categoryCollectionView.reloadData()
                projectCollectionView.reloadData()

            default:
                self.categorySelected = 0
				categoryCollectionView.reloadData()
                projectCollectionView.reloadData()
            }
        case projectCollectionView:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let specificVC = storyboard.instantiateViewController(withIdentifier: "SpecificProjectViewController") as? SpecificProjectViewController
			
			specificVC?.project = viewModel.getProject(forCategoryAt: categorySelected, forProjectAt: indexPath.row)
			
            self.show(specificVC ?? SpecificProjectViewController(), sender: nil)
        default:
            print("Tratar o erro")
        }
    }
}

extension FeedViewController: LoginViewControllerDelegate {
    func didFinishAuth() {
        guard let userIdentifierKey = UserDefaults.standard.string(forKey: SignInWithAppleManager.userIdentifierKey) else {
            return
        }
        print("User identifier: \(userIdentifierKey)")
    }
}
