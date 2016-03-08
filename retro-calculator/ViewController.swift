//
//  ViewController.swift
//  retro-calculator
//
//  Created by Mike Piatin on 7/03/2016.
//  Copyright © 2016 Aurora Software. All rights reserved.
//

import UIKit
import AVFoundation //add a player

class ViewController: UIViewController {

    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    
    
    @IBOutlet weak var outputLbl: UILabel! //discribe the var for output
    
    var btnSound: AVAudioPlayer! //add a player
    
    var runningNumber = "" //shows an empty string on the first start & stores the pressed button tags 0-9
    var leftValStr = ""
    var rightValStr = ""
    
    var currentOperation: Operation = Operation.Empty
    var result = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path =
            NSBundle.mainBundle().pathForResource("button-3", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl) //assign a sound to button
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription) //format DO TRY CATCH is created in case the player does not work, than that block is just skipped
        }
        
    }
    
    @IBAction func numberPressed(btn: UIButton) {
        playSound()
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
        
    }
    
    @IBAction func onDividePressed(sender: UIButton) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: UIButton) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractionPressed(sender: UIButton) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onAddPressed(sender: UIButton) {
            processOperation(Operation.Add)
    }
    
    @IBAction func onEqualPressed(sender: UIButton) {
        processOperation(currentOperation)
    }
    
    func processOperation(op: Operation) {
         playSound()
        
        
        if currentOperation != Operation.Empty {
            //run some maths
            
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                }
                leftValStr = result
                outputLbl.text = result
                
            }
            currentOperation = op
            
        } else {
            //this is the first time the operator has been pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
                
        }
    }
    
    func playSound() {
        if btnSound.playing {
            btnSound.stop()
        }
        btnSound.play()
        
    }
    
    
    

}

