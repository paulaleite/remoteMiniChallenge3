//
//  EditProjectViewController.swift
//  RemoteMC3
//
//  Created by Cassia Aparecida Barbosa on 01/06/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation
import UIKit

class EditProjectViewController: UIViewController {
	
	var viewModel: EditProjectViewModel?
	var formatter = DateFormatter()
	var startDate = Date()
	var endDate = Date()
	var project: Project?
	var activeTextField: UITextField?
	
	@IBOutlet var descricao: UILabel!
	@IBOutlet var duracao: UILabel!
	
	private let projectDescription: VerticallyCenteredTextView = {
			let projectDescription = VerticallyCenteredTextView(frame: .zero)
			projectDescription.translatesAutoresizingMaskIntoConstraints = false
			projectDescription.font = UIFont.systemFont(ofSize: 17)
			projectDescription.textAlignment = .center
            projectDescription.textColor = .black
	//		projectDescription.becomeFirstResponder()
			projectDescription.resignFirstResponder()
			projectDescription.inputView?.layoutIfNeeded()
			projectDescription.layer.cornerRadius = 7.5
			projectDescription.layer.borderColor =  #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
			projectDescription.layer.borderWidth = 0.5
			projectDescription.autocapitalizationType = .sentences
			return projectDescription
		}()
	
	@IBOutlet var projectName: UITextField!
	@IBOutlet var projectOrganization: UITextField!
	@IBOutlet var projectStart: UITextField!
	@IBOutlet var projectEnd: UITextField!
	@IBOutlet var projectCategory: UITextField!
	@IBOutlet var etapa: UITextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.viewModel = EditProjectViewModel(project: project!)
		self.setUpView()
		
		navigationItem.setRightBarButton(UIBarButtonItem(title: "Salvar", style: .done, target: self, action: #selector(self.saveProject)), animated: true)
		navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0, green: 0.0525861159, blue: 0.3849625885, alpha: 1)
		navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0, green: 0.0525861159, blue: 0.3849625885, alpha: 1)
		navigationController?.navigationBar.prefersLargeTitles = true
		
		viewModel!.delegate = self
		projectDescription.delegate = self
		projectName.delegate = self
		projectOrganization.delegate = self
		projectCategory.delegate = self
		projectStart.delegate = self
		projectEnd.delegate = self
		etapa.delegate = self
		
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
		projectDescription.topAnchor.constraint(equalTo: self.descricao.bottomAnchor, constant: 5).isActive = true
		projectDescription.bottomAnchor.constraint(equalTo: self.duracao.topAnchor, constant: -5).isActive = true
	}
	
	@IBAction func deleteProject(_ sender: Any) {
		//TODO: Deletar projeto
		let alert = UIAlertController(title: "Apagar Projeto", message: "Você tem certeza de que deseja apagar esse Projeto e todos seus dados?", preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Apagar", style: .destructive, handler: { (_) in
			self.viewModel?.deleteProject()
			self.navigationController?.popToRootViewController(animated: true)
		}))
		alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { (_) in }))
		self.present(alert, animated: true, completion: {})
	}
	
	func setUpView() {
		self.projectName.text = viewModel?.getProjectTitle()
		self.projectDescription.text = viewModel?.getProjectDescription()
		self.projectOrganization.text = viewModel?.getProjectOrganization()
		self.projectStart.text = viewModel?.getStart()
		self.projectEnd.text = viewModel?.getEnd()
		self.projectCategory.text = viewModel?.getProjectCategory()
		self.etapa.text = viewModel?.getPhase(index: 0)
	}
	
	@objc func saveProject() {
        viewModel!.title = projectName.text!
		viewModel!.description = projectDescription.text!
		viewModel!.organization = projectOrganization.text!
		viewModel!.start = projectStart.text!
		viewModel!.end = projectEnd.text!
		viewModel!.category = projectCategory.text!
        if etapa.text != viewModel?.phases.first {
            guard let phase = etapa.text else { return }
            viewModel?.phases.append(phase)
        }
        viewModel!.saveProject()
		self.navigationController?.popToRootViewController(animated: true)
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
		projectName.resignFirstResponder()
		projectOrganization.resignFirstResponder()
		projectStart.resignFirstResponder()
		projectEnd.resignFirstResponder()
		projectDescription.resignFirstResponder()
		projectCategory.resignFirstResponder()
		etapa.resignFirstResponder()
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
	
}

extension EditProjectViewController: UIPickerViewDelegate {
	
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

extension EditProjectViewController: UIPickerViewDataSource {
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return viewModel?.pickerViewDataSource.count ?? 0
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String {
		
		return viewModel?.pickerViewDataSource[row] ?? "Social"
	}
	
}

extension EditProjectViewController: UITextFieldDelegate {
	
	func textFieldDidBeginEditing(_ textField: UITextField) {
		self.activeTextField = textField
	}
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		self.activeTextField = nil
	}
}

//  This extension was extracted from a implementation made by Lyndsey Scott. Comments about the implementation are available at:
//https://stackoverflow.com/questions/27652227/how-can-i-add-placeholder-text-inside-of-a-uitextview-in-swift

extension EditProjectViewController: UITextViewDelegate {
	func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
		textView.inputView?.layoutIfNeeded()
		let currentText: String = textView.text
		let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
		
		if updatedText.isEmpty {
			textView.inputView?.layoutIfNeeded()
			textView.text = "*campo obrigatório"
			textView.textColor = UIColor.placeholderText
			
			textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
		} else if textView.textColor == UIColor.black && !text.isEmpty {
			textView.inputView?.layoutIfNeeded()
			textView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
			textView.text = text
		} else {
			textView.inputView?.layoutIfNeeded()
			return true
		}
		return false
	}
	
	func EditProjectViewController(_ textView: UITextView) {
		textView.inputView?.layoutIfNeeded()
		if self.view.window != nil {
			if textView.textColor == UIColor.lightGray {
				textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
			}
		}
	}
	
	func EditProjectViewController(_ textView: UITextView) -> Bool {
		textView.inputView?.layoutIfNeeded()
		return true
	}
}

extension EditProjectViewController: EditProjectViewModelDelegate {
	func addSucessAlert() {
		let alert = UIAlertController(title: "Projeto Editado", message: "Você editou o seu Projeto.", preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) in
			self.tabBarController?.selectedIndex = 2
            self.navigationController?.popToRootViewController(animated: false)
		}))
		self.present(alert, animated: true, completion: nil)
	}
	
	func addErrorAlert() {
		let alert = UIAlertController(title: "Erro ao editar seu Projeto", message: "Não foi possível editar seu Projeto nesse momento. Por favor, tente outra vez.", preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) in
			
		}))
		self.present(alert, animated: true, completion: {})
	}
}
