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
	var phaseCount: Int = 0
	
	var activeTextField: UITextField?
	
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
		projectDescription.autocapitalizationType = .sentences
		return projectDescription
	}()
	
	@IBOutlet var projectTitle: UITextField!
	@IBOutlet var projectInstitution: UITextField!
	@IBOutlet var projectStart: UITextField!
	@IBOutlet var projectEnd: UITextField!
	@IBOutlet var projectCategory: UITextField!
	@IBOutlet var descrição: UILabel!
	@IBOutlet var duração: UILabel!
	@IBOutlet var phaseTableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		phaseTableView.dataSource = self
		phaseTableView.delegate = self
		projectDescription.delegate = self
		projectTitle.delegate = self
		projectInstitution.delegate = self
		projectCategory.delegate = self
		projectStart.delegate = self
		projectEnd.delegate = self
		
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
        //TODO: Fezer verificação se os campos estão vazios
        viewModel.title = projectTitle.text!
        viewModel.description = projectDescription.text!
        viewModel.organization = projectInstitution.text!
        viewModel.start = projectStart.text!
        viewModel.end = projectEnd.text!
        viewModel.category = projectCategory.text!
        viewModel.createProject()
//        viewModel.phases = project
//        responsible: User = User(name: "Teste", email: "Test", projects: nil)
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
		
		guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
			return
		}
		var shouldMoveViewUp = false
		
		if let activeTextField = activeTextField {
			let bottomOfTextField = activeTextField.convert(activeTextField.bounds, to: self.view).maxY
			let topOfKeyboard = self.view.frame.height - keyboardSize.height
			
			if bottomOfTextField > topOfKeyboard {
				shouldMoveViewUp = true
			}
		}
		
		if shouldMoveViewUp {
			self.view.frame.origin.y = 0 - keyboardSize.height
		}
	}
	
	@objc func keyboardWillHide(notification: NSNotification) {
		self.view.frame.origin.y = 0
	}
	
	@IBAction func addPhaseAction(_ sender: Any) {
		let alert = UIAlertController(title: "Nova Etapa", message: "Adicione o título da Etapa", preferredStyle: .alert)
		alert.addTextField(configurationHandler: { (phaseTitle) in
			phaseTitle.placeholder = "Título da Etapa"
			phaseTitle.autocapitalizationType = .sentences
			phaseTitle.textAlignment = .center
		})
		alert.addAction(UIAlertAction(title: "Cancelar", style: .destructive, handler: { _ in }))
		alert.addAction(UIAlertAction(title: "Criar", style: .default, handler: { (_) in
			if (alert.textFields?[0].text != "") {
				self.phaseCount+=1
				if (self.phaseCount == 1) {
					self.viewModel.phasesName.removeAll()
				}
				self.viewModel.phasesName.append((alert.textFields?[0].text)!)
				self.phaseTableView.reloadData()
				
			} else {
				let errorAlert = UIAlertController(title:
					"Erro", message: "Não foi possivel criar a Etapa. Por favor, clique novamente para criar uma Nova Etapa e preencha o campo Título.", preferredStyle: .alert)
				errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in }))
				self.present(errorAlert, animated: true, completion: nil)
			}
		}))
		self.present(alert, animated: true, completion: nil)
	}
}

extension CreateProjectViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.phasesName.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if let specificPhaseTableCell = tableView.dequeueReusableCell(withIdentifier: "specificPhaseTableCell", for: indexPath) as? SpecificPhaseTableCell {
			specificPhaseTableCell.phaseName.text = viewModel.phasesName[indexPath.row]
			return specificPhaseTableCell
		}
		return SpecificPhaseTableCell()
	}
}

extension CreateProjectViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		let deleteAction = UIContextualAction(style: .destructive, title: "Deletar", handler: { (action, view, success) in
			self.viewModel.phasesName.remove(at: indexPath.row)
			self.phaseCount-=1
            self.phaseTableView.reloadData()
            success(true)
        })
		return UISwipeActionsConfiguration(actions: [deleteAction])
	}
}

extension CreateProjectViewController: UIPickerViewDelegate {
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		
		switch row {
		case 1:
			self.projectCategory.text = "Cultural"
			
		case 2:
			self.projectCategory.text = "Pessoal"
	
		case 3:
			self.projectCategory.text = "Empresarial"
			
		case 4:
			self.projectCategory.text = "Pesquisa"

		default:
			self.projectCategory.text = "Social"
		}
	}
}

extension CreateProjectViewController: UIPickerViewDataSource {
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 2
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return viewModel.pickerViewDataSource.count
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String {
		
		return viewModel.pickerViewDataSource[row]
	}
	
}

extension CreateProjectViewController: UITextFieldDelegate {
	
	func textFieldDidBeginEditing(_ textField: UITextField) {
		self.activeTextField = textField
	}
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		self.activeTextField = nil
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
			textView.textColor = UIColor.lightGray
			
			textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
		} else if textView.textColor == UIColor.lightGray && !text.isEmpty {
			textView.inputView?.layoutIfNeeded()
			textView.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
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
		return true
	}
}
