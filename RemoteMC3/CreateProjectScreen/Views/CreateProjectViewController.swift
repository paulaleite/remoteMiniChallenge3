//
//  CreateProjectViewController.swift
//  RemoteMC3
//
//  Created by Cassia Aparecida Barbosa on 14/05/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation
import UIKit

class CreateProjectViewController: UIViewController {
	
	var viewModel = CreateProjectViewModel()
	var formatter = DateFormatter()
	var startDate = Date()
	var endDate = Date()
	
	private let projectDescription: VerticallyCenteredTextView = {
        let projectDescription = VerticallyCenteredTextView(frame: .zero)
        projectDescription.translatesAutoresizingMaskIntoConstraints = false
		projectDescription.text = "Descrição"
        projectDescription.font = UIFont.systemFont(ofSize: 17)
        projectDescription.textAlignment = .center
		projectDescription.textColor = .lightGray
        projectDescription.becomeFirstResponder()
        projectDescription.resignFirstResponder()
        projectDescription.inputView?.layoutIfNeeded()
		projectDescription.layer.cornerRadius = 7.5
		projectDescription.layer.borderColor =  #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
		projectDescription.layer.borderWidth = 0.5
        return projectDescription
    }()
	
	@IBOutlet var projectTitle: UITextField!
	@IBOutlet var projectInstitution: UITextField!
	@IBOutlet var projectStart: UITextField!
	@IBOutlet var projectEnd: UITextField!
	@IBOutlet var projectCategory: UITextField!
	@IBOutlet var descrição: UILabel!
	@IBOutlet var duração: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		projectStart.addTarget(self, action: #selector(self.showProjectStartPicker(sender:)), for: .touchDown)
		projectEnd.addTarget(self, action: #selector(self.showProjectEndPicker(sender:)), for: .touchDown)
		projectCategory.addTarget(self, action: #selector(self.showProjectCategoryPicker(sender:)), for: .touchDown)
				
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
		self.view.addGestureRecognizer(tapGesture)
		
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
		
		self.view.addSubview(projectDescription)
		projectDescription.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
		projectDescription.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
		projectDescription.topAnchor.constraint(equalTo: self.descrição.bottomAnchor, constant: 5).isActive = true
		projectDescription.bottomAnchor.constraint(equalTo: self.duração.topAnchor, constant: -5).isActive = true
		
	}
	
	@IBAction func createProjectAction(_ sender: Any) {
		viewModel.createProject(title: projectTitle.text ?? "", description: projectDescription.text ?? "", college: College(name: projectInstitution.text ?? ""),
								responsible: User(firstName: "Cassia", lastName: "Barbosa"), members: [User(firstName: "Cassia", lastName: "Barbosa")],
								duration: (startDate, endDate), category: projectCategory.text ?? "")
	}
	
	@objc func showProjectStartPicker(sender: UITextField) {
		let datePickerView: UIDatePicker = UIDatePicker()
		datePickerView.resignFirstResponder()
		datePickerView.datePickerMode = .date
		sender.inputView = datePickerView
		projectStart.text = startDate.convertToString(dateformat: .date)
		 datePickerView.addTarget(self, action: #selector(dateStartPickerValueChanged), for: .valueChanged)
			   projectStart = sender
	}
	
	 @objc func dateStartPickerValueChanged(_ sender: UIDatePicker) {
		projectStart.text = sender.date.convertToString(dateformat: .date)
		startDate = sender.date
		}
	
	@objc func showProjectEndPicker(sender: UITextField) {
		let datePickerView: UIDatePicker = UIDatePicker()
		datePickerView.datePickerMode = .date
				sender.inputView = datePickerView
		projectEnd.text = endDate.convertToString(dateformat: .date)
		 datePickerView.addTarget(self, action: #selector(dateEndPickerValueChanged), for: .valueChanged)
			   projectEnd = sender
	}
	
	@objc func dateEndPickerValueChanged(_ sender: UIDatePicker) {
		projectEnd.text = sender.date.convertToString(dateformat: .date)
		endDate = sender.date
		}
		
	@objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        projectTitle.resignFirstResponder()
		projectInstitution.resignFirstResponder()
		projectStart.resignFirstResponder()
		projectEnd.resignFirstResponder()
		projectDescription.resignFirstResponder()
		projectCategory.resignFirstResponder()
		
    }
		
	@objc func categoryPickerValueChanged(_ sender: UIDatePicker) {
		projectStart.text = sender.date.convertToString(dateformat: .date)
		endDate = sender.date
		}
	
	@objc func showProjectCategoryPicker(sender: UITextField) {
		let pickerView: UIPickerView = UIPickerView()
		pickerView.delegate = self
		pickerView.dataSource = self
		sender.inputView = pickerView
		projectCategory = sender
		projectCategory.text = "Social"
		
		
	}
		
	@objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}

//  This extension was extracted from a implementation made by Lyndsey Scott. Comments about the implementation are available at:
//https://stackoverflow.com/questions/27652227/how-can-i-add-placeholder-text-inside-of-a-uitextview-in-swift

extension CreateProjectViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        textView.inputView?.layoutIfNeeded()
        let currentText: String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
        
        if updatedText.isEmpty {
            textView.inputView?.layoutIfNeeded()
            textView.text = "Descrição"
            textView.textColor = UIColor.black
            
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        } else if textView.textColor == UIColor.lightGray && !text.isEmpty {
            textView.inputView?.layoutIfNeeded()
            textView.textColor = UIColor.white
            textView.text = text
        } else {
            textView.inputView?.layoutIfNeeded()
            return true
        }
        return false
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        textView.inputView?.layoutIfNeeded()
        if self.view.window != nil {
            if textView.textColor == UIColor.lightGray {
                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            }
        }
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        textView.inputView?.layoutIfNeeded()
        self.projectDescription.text = ""
        return true
    }
}

extension CreateProjectViewController: UIPickerViewDelegate {
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		
		switch row {
		case 1:
			projectCategory.text = "Cultural"
			
		case 2:
			projectCategory.text = "Pessoal"
	
		case 3:
			projectCategory.text = "Empresarial"
			
		case 4:
			projectCategory.text = "Pesquisa"
		default:
			projectCategory.text = "Social"
		}
	}
}

extension CreateProjectViewController: UIPickerViewDataSource {
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return viewModel.pickerViewDataSource.count
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String {
		
		return viewModel.pickerViewDataSource[row]
    }
	
}
