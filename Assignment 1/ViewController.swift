//
//  ViewController.swift
//  Assignment 1
//
//  Created by Student on 2019-01-14.
//  Copyright © 2019 Liam Quinn. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    enum UIKeyboardType : Int {
        case namePhonePad = 6
    }
    
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
    var round: Int = 0
    var score: Int = 0
    var operatorInUse = "+"
    var correct: Bool = false
    var level: Int = 0
    var levels: [Int] = [3, 5, 10, 15]
    var difficulty = 10
    
    func checkOperator(){
        if operatorInUse == "*" {
            answer = firstNumber * secondNumber
        } else if operatorInUse == "/" {
            secondNumber = Double(Int(arc4random_uniform(10)))
            if (firstNumber == 0.0) || (firstNumber == 3.0) || (firstNumber == 5.0) || (firstNumber == 7.0) || (firstNumber == 9.0) || (firstNumber == 11.0) || (firstNumber == 13.0) || (firstNumber == 15.0) || (firstNumber == 17.0) || (firstNumber == 19.0) {
                firstNumber += 1
            }
            if (secondNumber == 0.0) || (secondNumber == 3.0) || (secondNumber == 5.0) || (secondNumber == 7.0) || (secondNumber == 9.0) || (secondNumber == 11.0) || (secondNumber == 13.0) || (secondNumber == 15.0) || (secondNumber == 17.0) || (secondNumber == 19.0){
                secondNumber += 1
            }
            self.firstLabel.text = String(Int(firstNumber)) + "!"
            self.secondLabel.text = String(Int(secondNumber)) + "!"
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
        self.levelLabel.text = String(level + 1)
        self.scoreLabel.text = String(score)
        self.inputField.text = ""
        self.operatorLabel.text = String(operatorInUse)
    }
    
    @IBAction func showAlert() {
        
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
            self.operatorInUse = operatorArray[Int(arc4random_uniform(3))]
            title = "Correct"
            message += "\n You are CORRECT!"
            firstNumber = Double(Int(arc4random_uniform(UInt32(difficulty))))
            secondNumber = Double(Int(arc4random_uniform(UInt32(difficulty))))
            checkOperator()
            assignLabels()
        } else {
            round = 0
            message += "\n That is incorrect"
            message += "\n Level progress has been reset"
            message += "\n Try again"
            title = "Incorrect"
        }
        
        if round == levels[level] {
            round = 0
            message += "\n You have completed level \(level + 1)"
            score += (level * 15)
            if level != 3 {
               level += 1
            }
            assignLabels()
            switch level {
            case 1:
                difficulty = 10
            case 2:
                difficulty = 15
            case 3:
                difficulty = 20
            case 4:
                difficulty = 20
            default:
                difficulty = 10
            }
        }
        
        let alert = UIAlertController(title: title,
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
    
    @IBOutlet weak var levelLabel: UILabel!

    @IBAction func startOverButton() {
        score = 0
        round = 0
        level = 0
        firstNumber = Double(Int(arc4random_uniform(UInt32(difficulty))))
        secondNumber = Double(Int(arc4random_uniform(UInt32(difficulty))))
        assignLabels()
    }
    @IBAction func infoButton() {
        let alert = UIAlertController(title: "New Question",
                                      message: "Old answer was \(String(answer))",
                                      preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK",
                                   style: .default,
                                   handler: nil)
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        firstNumber = Double(Int(arc4random_uniform(UInt32(difficulty))))
        secondNumber = Double(Int(arc4random_uniform(UInt32(difficulty))))
        self.operatorInUse = operatorArray[Int(arc4random_uniform(3))]
        checkOperator()
        assignLabels()
    }
}


