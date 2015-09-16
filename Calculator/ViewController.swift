//
//  ViewController.swift
//  Calculator
//
//  Created by Luis Garcia on 9/14/15.
//  Copyright (c) 2015 CSUMB_Luis. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    
    @IBOutlet weak var display: UILabel!
    
    @IBOutlet weak var history: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false
    var decimalIsPressed = false
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text!  + digit
        }
        else{
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
        
        //println("digit = \(digit)")
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        
        if userIsInTheMiddleOfTypingANumber{
            enter()
        }
        switch operation{
        case "✕":performOperation({ $0 * $1 })
            
        case "÷":performOperation({ $0 / $1 })
            
        case "＋":performOperation({ $0 + $1 })
        case "-":performOperation({ $0 - $1 })
        case "√":performOperation2{ sqrt($0)}
        case "sin":performOperation2({sin($0)})
        case "cos":performOperation2({cos($0)})
        case "∏":performOperation2({$0 * 3.14})
        default: break
        }
    }
    
    @IBAction func decimal() {
        userIsInTheMiddleOfTypingANumber = true
        if decimalIsPressed == false{
            display.text = display.text! + "."
            decimalIsPressed = true
        }
        
    }
    
    @IBAction func clear() {
        userIsInTheMiddleOfTypingANumber = false
        operandStack.removeAll()
        display.text = "0"
        enter()
        
    }
    
    
    func performOperation(operation: (Double, Double) -> Double){
        if operandStack.count >= 2{
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    func performOperation2(operation: Double -> Double){
        if operandStack.count >= 1{
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        decimalIsPressed = false
        userIsInTheMiddleOfTypingANumber = false
        operandStack.append(displayValue)
        history.text = "\(displayValue)"
        println("operandStack = \(operandStack)")
    }
    
    var displayValue: Double {
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }

}

