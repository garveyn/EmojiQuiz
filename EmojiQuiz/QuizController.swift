//
//  FirstViewController.swift
//  EmojiQuiz
//
//  Created by Garvey, Nicholas on 2/9/20.
//  Copyright © 2020 Garvey, Nicholas. All rights reserved.
//

import UIKit

class QuizController: UIViewController {
    /* The ideas for spacing on the keyboard were inspired by this
     * stack overflow answer: https://stackoverflow.com/a/30249550
     */
    
    let LIVES_TEXT: String = "Lives:"
    let INITIAL_LIVES: Int = 3
    
    var secretWord: String = "C H I C K E N"
    var guessPool: [Character] = []
    var lives: Int = 3
    

    @IBOutlet weak var qNumbLabel: UILabel!
    @IBOutlet weak var livesNumLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var guessesLabel: UILabel!
    
    @IBOutlet var letterButtons: [UIButton]!
    
    @IBAction func letterGuessed(_ sender: UIButton) {
        let color: UIColor?
        var correct: Bool = false
        
        if let guess = sender.currentTitle?.first {
            guessPool.append(guess)
            guessesLabel.text = String(secretWord.map {char in
                if char == guess {
                    correct = true
                    return guess
                } else if char == " " {
                    return " "
                } else if guessPool.contains(char) {
                    return char
                } else {
                    return "_"
                }
            })
            if correct {
                color = UIColor(named: "Correct")
            } else {
                color = UIColor(named: "Incorrect")
                lives -= 1
                
                if lives > 0 {
                    livesNumLabel.text = "\(LIVES_TEXT) \(String(repeating: "❤️", count: lives))"
                } else {
                    outOfLives()
                    return
                }
            }
            
        } else {
            // Should not happen...
            color = nil
        }
        
        sender.isEnabled = false
        sender.setTitleColor(color, for: .disabled)
    }
    
    func outOfLives() {
        print("You Lose!")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

