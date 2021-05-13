//
//  TicTacToe.swift
//  Games
//
//  Created by period4 on 4/7/21.
//  Copyright © 2021 period4. All rights reserved.
//

import UIKit

class TicTacToe: UIViewController {
    
@IBOutlet weak var labelOne: UILabel!
@IBOutlet weak var labelTwo: UILabel!
@IBOutlet weak var labelThree: UILabel!
@IBOutlet weak var labelFour: UILabel!
@IBOutlet weak var labelFive: UILabel!
@IBOutlet weak var labelSix: UILabel!
@IBOutlet weak var labelSeven: UILabel!
@IBOutlet weak var labelEight: UILabel!
@IBOutlet weak var labelNine: UILabel!
 
    @IBOutlet weak var myView: UIView!
    
    var allLabels: [UILabel] = []

    
    @IBAction func resetButton(_ sender: Any)
    {
        reset()
        turnLabel.text = "X"
    }
    
    @IBOutlet weak var turnLabel: UILabel!
  
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
 
        turnLabel.text = "X"
        
        allLabels = [labelOne, labelTwo, labelThree, labelFour, labelFive, labelSix, labelSeven, labelEight, labelNine]
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
                 
                 let selectedPoint = sender.location(in: myView)
                 for label in allLabels
                 {
                     if label.frame.contains(selectedPoint)
                     {
                         placeInToLabel(myLabel: label)
                     }
                }
           checkForWinner()
    }
   

    func checkForWinner()

    {
            if labelOne.text == labelTwo.text && labelTwo.text == labelThree.text  && labelOne.text != ""
            {
                alert()
            }
            if labelOne.text == labelFour.text && labelFour.text == labelSeven.text && labelOne.text != ""
            {
                alert()
            }
            if labelOne.text == labelFive.text && labelFive.text == labelNine.text && labelOne.text != ""
            {
                alert()
            }
            if labelTwo.text == labelFive.text && labelFive.text == labelEight.text && labelTwo.text != ""
            {
                alert()
            }
            if labelThree.text == labelSix.text && labelSix.text == labelNine.text && labelTwo.text != ""
            {
                alert()
            }
            if labelFour.text == labelFive.text && labelFive.text == labelSix.text && labelFour.text != ""
            {
                alert()
            }
            if labelSeven.text == labelEight.text && labelEight.text == labelNine.text && labelSeven.text != ""
            {
                alert()
            }
            if labelSeven.text == labelFive.text && labelFive.text == labelThree.text && labelSeven.text != ""
            {
                alert()
            }
            
    }
    
    //Use the parameter in conditional
     func placeInToLabel(myLabel: UILabel)
     {
             if myLabel.text == ""
             {
                if turnLabel.text == "X"
                {
                    myLabel.text = turnLabel.text
                    turnLabel.text = "O"
                }
              else
              {
                    myLabel.text = turnLabel.text
                    turnLabel.text = "X"
              }
            }
    }
  
func alert()
    {
        let winningAlert = UIAlertController(title: "You Won!", message: "", preferredStyle: .alert)
        let newGameButton = UIAlertAction(title: "New Game?", style: .default){ (action) in
            self.reset()
            self.turnLabel.text = "X"
            }
        winningAlert.addAction(newGameButton)
        present(winningAlert, animated: true, completion: nil)
    }

     //reset all the labels

    func reset()
    {
        for label in allLabels
        {
            label.text = ""
            print(label)
        }
    }
}
