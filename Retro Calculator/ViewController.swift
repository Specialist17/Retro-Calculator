//
//  ViewController.swift
//  Retro Calculator
//
//  Created by Fernando on 1/10/16.
//  Copyright © 2016 Fernando. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Clear = "Clear"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLbl: UILabel!

    var btnSound: AVAudioPlayer!
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        outputLbl.text = "0"
        
        do{
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
        }catch let err as NSError{
            print(err.debugDescription)
        }
        
    }

    
    @IBAction func numberPressed(btn: UIButton!){
        //btnSound.play()
        
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
    }

    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }

    @IBAction func onMulitplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onEqualsPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    @IBAction func onClearPressed(sender: AnyObject) {
        processOperation(Operation.Clear)
    }
    
    
    func processOperation(op: Operation){
        
        //playSound()
        
        if currentOperation != Operation.Empty {
            //Run some math
            
            if currentOperation == Operation.Clear{
                outputLbl.text = "0"
                result = ""
                leftValStr = runningNumber
                rightValStr = "0"
                runningNumber = ""
            }
            
            //A user selected an operator but then selected another operator without choosing a number
            if runningNumber != "" {
                
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                }else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                }else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }else if currentOperation == Operation.Subtract{
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                }
                leftValStr = result
                outputLbl.text = result
            }

            
            currentOperation = op
            
        }else{
            //This is the first time an operator has been pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
        }
        
        if currentOperation == Operation.Clear{
            outputLbl.text = "0"
            leftValStr = "0"
            rightValStr = "0"
            runningNumber = ""
            currentOperation = op
        }

    }
    
    func playSound(){
        if btnSound.playing{
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
}

