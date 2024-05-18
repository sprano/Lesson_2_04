//
//  ViewController.swift
//  Lesson_2_04
//
//  Created by Sofi Prano on 18.05.2024.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var mainLabel: UILabel!
    @IBOutlet var slider: UISlider!
    @IBOutlet var textField: UITextField!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControl.insertSegment(withTitle: "Third", at: 2, animated: false)
        setupSlider()
        setupLabel()
    }
    
    // MARK: - IB Actions
    @IBAction func segmentedControlAction() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            mainLabel.text = "The first segment is selected"
            mainLabel.textColor = .red
        case 1:
            mainLabel.text = "The second segment is selected"
            mainLabel.textColor = .green
        default:
            mainLabel.text = "The third segment is selected"
            mainLabel.textColor = .blue
        }
    }
    
    @IBAction func sliderAction() {
        mainLabel.text = slider.value.formatted()
        view.backgroundColor = view.backgroundColor?.withAlphaComponent(CGFloat(slider.value))
    }
    
    @IBAction func doneButtonDidTapped() {
        guard let inputText = textField.text, !inputText.isEmpty else {
            showAlert(withTitle: "Text field is empty", andMessage: "Please enter your name")
            return
        }
        
        let usernamePattern = "^[a-zA-Z]{3,20}$"
        let isUsernameValid = NSPredicate(format: "SELF MATCHES %@", usernamePattern)
            .evaluate(with: inputText)
        
        if !isUsernameValid {
            showAlert(withTitle: "Wrong format", andMessage: "please enter your name")
            return
        }
        
        mainLabel.text = textField.text
        textField.text = ""
    }
    
    // MARK: - Private Methods
    private func setupLabel() {
        mainLabel.text = slider.value.formatted()
        mainLabel.font = UIFont.systemFont(ofSize: 35)
        mainLabel.textAlignment = .center
        mainLabel.numberOfLines = 2
    }
    
    private func setupSlider(){
        slider.value = 1
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.minimumTrackTintColor = .green
        slider.maximumTrackTintColor = .red
        slider.thumbTintColor = .blue
    }
    
    private func showAlert(withTitle title: String, andMessage message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in self.textField.text = ""
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
