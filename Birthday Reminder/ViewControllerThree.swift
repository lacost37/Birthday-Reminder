//
//  ViewControllerThree.swift
//  Birthday Reminder
//
//  Created by Mac on 15.11.2022.
//

import UIKit

class ViewControllerThree: UIViewController, UITextFieldDelegate {

    weak var delegate: ViewControllerTwo?
    
    let picker = UIPickerView()
    let datePicker = UIDatePicker()
    let agePicker = UIPickerView()
    
   
    @IBOutlet var nameField: UITextField!
    @IBOutlet var dateField: UITextField!
    @IBOutlet var ageField: UITextField!
    @IBOutlet var gender: UITextField!
    @IBOutlet var instField: UITextField!
    
    let genders = ["Мужчина", "Женщина"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // inst
        instField.delegate = self
        
        // gender
        picker.contentMode = .bottom
        picker.dataSource = self
        picker.delegate = self
        gender.inputView = picker
        
        // age
        agePicker.contentMode = .bottom
        agePicker.dataSource = self
        agePicker.delegate = self
        ageField.inputView = agePicker
        
        // date field
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        dateField.inputView = datePicker
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        // переносим кнопку готово на другую сторону
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([flexSpace, doneButton], animated: true)
        
        dateField.inputAccessoryView = toolBar
        
        // создаем ограничение по дате
        let yearAgo = Calendar.current.date(byAdding: .year, value: -99, to: Date())
        let yearLate = Calendar.current.date(byAdding: .year, value: 99, to: Date())
        datePicker.minimumDate = yearAgo
        datePicker.maximumDate = yearLate
        
        
        // чтобы по тапу закрывалось окно пикера
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureAction))
        // добавляем жест к нашей вью
        self.view.addGestureRecognizer(tapGesture)
    }
    
// action
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func addButtonAction(_ sender: Any) {
        delegate?.update(name: nameField.text!, age: ageField.text!)
        delegate?.nameFromThree.isHidden = false
        delegate?.textFromThree.isHidden = false
        dismiss(animated: true)
        
       
    }
    
    
    // function
    
    // функция отвечает за реагирование на нажатие на текст филд
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let alertController = UIAlertController(title: "Ведите инстаграм:", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ок", style: .default) { (action) in
            let textField = alertController.textFields![0]
            self.instField.text = textField.text
        }
        let action2 = UIAlertAction(title: "Отмена", style: .cancel)
        alertController.addAction(action)
        alertController.addAction(action2)
        alertController.addTextField { (textField) in
            textField.placeholder = "Например: tralala2021"
        }
        
        self.present(alertController, animated: true)
        
        return false
    }
    
    @objc func doneAction() {
        getDateFromPicker()
        view.endEditing(true)
    }
    
    @objc func tapGestureAction() {
        view.endEditing(true)
    }
    
    
    // получаем дату
    func getDateFromPicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        dateField.text = formatter.string(from: datePicker.date)
    }
}



extension ViewControllerThree: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == picker { return 1 }
        if pickerView == agePicker { return 1 }
        
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == picker { return genders.count }
        if pickerView == agePicker { return 99 }
        
        return 1
    }
}

extension ViewControllerThree: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == picker { return genders[row] }
        if pickerView == agePicker { return String(row + 1)}
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == picker { gender.text = genders[row] }
        if pickerView == agePicker { ageField.text = String(row + 1)}
        
      //  gender.resignFirstResponder() - Выбор по нажатию
    }
}
