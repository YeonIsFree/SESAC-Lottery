//
//  ViewController.swift
//  SESAC-Lottery
//
//  Created by Seryun Chun on 2024/01/16.
//

import UIKit

class LotteryViewController: UIViewController {
    
    let lotteryManager = LotteryManager()
    let pickerView = UIPickerView()
    let latestDrawNumber = 1101

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var lotteryNumberLabels: [UILabel]!
    @IBOutlet var textField: UITextField!
    
     // MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTitleLabel()
        configurePickerView()
        getNumber(latestDrawNumber)
    }
    
     // MARK: - Configure Methods
    
    func getNumber(_ drawNumber: Int) {
        lotteryManager.callRequest(drawNumber: drawNumber) { winningNumbers in
            for index in 0...6 {
                self.lotteryNumberLabels[index].text = "\(winningNumbers[index])"
            }
        }
        
        titleLabel.text = "\(drawNumber) 회차 당첨결과"
        textField.text = "\(drawNumber) 회차"
    }
    
    func configureTitleLabel() {
        titleLabel.text = "\(latestDrawNumber)회차 당첨결과"
    }

}

 // MARK: - UIPickerView Delegate

extension LotteryViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return latestDrawNumber
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(latestDrawNumber - row) 회차"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        getNumber(latestDrawNumber - row)
    }
    
    func configurePickerView() {
        // Connect to textField
        textField.inputView = pickerView
        
        // PickerView Delegate
        pickerView.delegate = self
        pickerView.dataSource = self
        
        // PickerView done button
        let doneButton = UIBarButtonItem()
        doneButton.title = "done"
        doneButton.tintColor = .darkGray
        doneButton.target = self
        doneButton.action = #selector(pickerViewDismiss)
        
        let toolBar = UIToolbar()
        let leftSpace = UIBarButtonItem(systemItem: .flexibleSpace)
        toolBar.frame = CGRect(x: 0, y: 0, width: 0, height: 35)
        toolBar.setItems([leftSpace, doneButton], animated: true)
        
        textField.inputAccessoryView = toolBar
    }
    
    @objc
    func pickerViewDismiss() {
        view.endEditing(true)
    }
}

