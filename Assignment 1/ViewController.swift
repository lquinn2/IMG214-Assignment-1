//
//  ViewController.swift
//  Assignment 1
//
//  Created by Student on 2019-01-14.
//  Copyright © 2019 Liam Quinn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        assignLabels()
        self.operatorLabel.text = operatorInUse
        checkOperator()
    }
    
    var firstNumber: Double = Double(Int(arc4random_uniform(10)))
    var secondNumber: Double = Double(Int(arc4random_uniform(10)))
    var operatorArray = ["*", "/", "+", "-"]
    var answer: Double = 0
    var round: Int = 1
    var score: Int = 0
    var operatorInUse = "/"
    var correct: Bool = false
    
    func checkOperator(){
        if operatorInUse == "*" {
            answer = firstNumber * secondNumber
        } else if operatorInUse == "/" {
            if secondNumber == 0 {
                secondNumber += 1
                secondLabel.text = String(secondNumber)
            }
            answer = firstNumber / secondNumber
        } else if operatorInUse == "+" {
            answer = firstNumber + secondNumber
        } else if operatorInUse == "-" {
            answer = firstNumber - secondNumber
        } else {
            answer = 0
        }
    }
    
    func assignLabels(){
        self.firstLabel.text = String(Int(firstNumber))
        self.secondLabel.text = String(Int(secondNumber))
        self.roundLabel.text = String(round)
        self.scoreLabel.text = String(score)
        self.inputField.text = ""
    }
    
    @IBAction func showAlert() {
        
        checkOperator()
        
        var message = "Your answer was \(inputField.text!)"

        var ans : Double = 0
        if let unwrappedInput = inputField.text {
            ans = (unwrappedInput as NSString).doubleValue
        } else {
            ans = 0
        }
        
        if Double(answer) == Double(ans) {
            score += 5
            round += 1
            operatorInUse = operatorArray[Int(arc4random_uniform(3))]
            message += "\n You are CORRECT!"
            firstNumber = Double(Int(arc4random_uniform(10)))
            secondNumber = Double(Int(arc4random_uniform(10)))
            assignLabels()
            operatorInUse = operatorArray[Int(arc4random_uniform(3))]
            self.operatorLabel.text = String(operatorInUse)
        } else {
            message += "\n That is incorrect"
            message += "\n Try again"
        }
        
        let alert = UIAlertController(title: "Hello, World",
                                      message: message,
                                      preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK",
                                   style: .default,
                                   handler: nil)
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var inputField: UITextField!
    
    @IBOutlet weak var firstLabel: UILabel!
    
    @IBOutlet weak var secondLabel: UILabel!
    
    @IBOutlet weak var operatorLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var roundLabel: UILabel!

    @IBAction func startOverButton() {
        score = 0
        round = 1
        firstNumber = Double(Int(arc4random_uniform(10)))
        secondNumber = Double(Int(arc4random_uniform(10)))
        assignLabels()
    }
}


