//
//  ViewController.swift
//  Calculator
//
//  Created by Dzjem Gard on 2022-12-31.
//

/*
 T0D0:
 1) Fix so multiple numbers can go through. currently only two operands can be used
 In the future we should be able to do this multiple times.
 2) Make more functions
 */

import UIKit

class ViewController: UIViewController {
    
    // Default: no operator selected
    var currentOperation: Operator = Operator.nothing
    // Default: entering number mode
    var calcState: CalculationState = CalculationState.enteringNumber
    // Default: empty string
    var stackValue: String = ""
    
    // Label (calculator display)
    @IBOutlet weak var calculatorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func numberClicked(_ sender: UIButton){
        // Update display with tag attached to number once clicked
        updateDisplay (number: String(sender.tag))
    }
    
    func updateDisplay(number: String){
        // Check if new number is entered
        if (calcState == CalculationState.newNumStarted) {
            // check if calcLabelText exists and if assign it to current number
            if let currentNumber = calculatorLabel.text{
                // if not empty
                if(checkThatOperatorsAreNotIncluded(stack: currentNumber)){
                    // operate the current number to the stack
                    stackValue = currentNumber
                }
            }
            calcState = CalculationState.enteringNumber
            calculatorLabel.text = number
            
        } else if (calcState == CalculationState.enteringNumber){
            calculatorLabel.text = calculatorLabel.text! + number
        } else {
            print("ERR: not in either state")
            return
        }
    }
    
    func checkThatOperatorsAreNotIncluded(stack: String) -> Bool{
        // returns TRUE if a number
        // returns FALSE if empty or an operator
        if (stack != "" && stack != "+" && stack != "x" && stack != "/" && stack != "-"){
            return true
        } else {
            return false
        }
    }
    
 
    @IBAction func operationClicked(_ sender: UIButton){
        calcState = CalculationState.newNumStarted
        
        if let num = calculatorLabel.text {
            if (num != ""){
                stackValue = num
                calculatorLabel.text = ""
            }
        }
        
        switch(sender.tag){
        case 10:
            currentOperation = Operator.add
            calculatorLabel.text = "+"
        case 11:
            currentOperation = Operator.subtract
            calculatorLabel.text = "-"
        case 12:
            currentOperation = Operator.times
            calculatorLabel.text = "x"
        case 13:
            currentOperation = Operator.divide
            calculatorLabel.text = "/"
        default:
            return
        }
        
        print(String(stackValue) + "\t" + calculatorLabel.text!)
        
        /*T0D0: Make result allow things to add up
        if (!stackValue.isEmpty && checkThatOperatorsAreNotIncluded(stack: calculatorLabel.text!)){
            stackValue = calculateSum()
            print(stackValue)
        }
        */
            
    }
    
    
    
    @IBAction func equalsClicked(_ sender: UIButton){
        if (stackValue != ""){
            stackValue = calculateSum()
            calculatorLabel.text = stackValue
        }
        return
    }
    
    func calculateSum() -> String{
        if (stackValue.isEmpty){
            return ""
        }
        
        var result = ""
        
        if(checkThatOperatorsAreNotIncluded(stack: stackValue)){
            // fixes case where operator is the first button pressed
            if currentOperation == Operator.times{
                result = "\(Double(stackValue)! * Double(calculatorLabel.text!)!)"
            } else if currentOperation == Operator.divide{
                result = "\(Double(stackValue)! / Double(calculatorLabel.text!)!)"
            } else if currentOperation == Operator.add{
                result = "\(Double(stackValue)! + Double(calculatorLabel.text!)!)"
            } else if currentOperation == Operator.subtract{
                result = "\(Double(stackValue)! - Double(calculatorLabel.text!)!)"
            } else {
                return "ERR"
            }
        }
        stackValue = result
        result = ""
        calcState = CalculationState.newNumStarted
        return stackValue
    }
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        // clears everything
        (stackValue, calculatorLabel.text) = ("","")
        // updates to diplay to display nothing
        updateDisplay(number: "")
    }
    
    @IBAction func plusMinusPressed(_ sender: UIButton){
        // Issue when using a negative number the second time
        // Currently the
        
        var stringy: Double
        
        if calculatorLabel.text == "" {
            calculatorLabel.text = "-"
        } else if calculatorLabel.text == "-" {
            calculatorLabel.text = ""
        }else {
            // multiplies by (-1) and flips the sign
            stringy = (Double(calculatorLabel.text!))!*(-1.0)
            calcState = CalculationState.newNumStarted
            updateDisplay(number: String(stringy))
        }
    }

}

