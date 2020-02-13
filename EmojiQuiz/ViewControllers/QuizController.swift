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
    let QUESTIONS_TEXT: String = "Question #"
    let INITIAL_LIVES: Int = 3
    
    var category: String = ""
    var totalQuestions: Int = 0
    var questions: Dictionary<String, String> = [:]
    
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
        var solved: Bool = true
        
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
                    solved = false
                    return "_"
                }
            })
            if correct {
                color = UIColor(named: "Correct")
                if solved {
                    questionSolved()
                }
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
        performSegue(withIdentifier: "lose", sender: nil)
    }
    
    func questionSolved() {
        print("You Win!")
        // TODO: Implement sounds
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = category
        qNumbLabel.text = "\(QUESTIONS_TEXT)1 of \(totalQuestions)"
        
        // Load Questions | Sourced from: https://gist.github.com/db42/e7a009dd864c7d40fd2a750e3ae24155
        if let path = Bundle.main.path(forResource: category, ofType: "plist"),
            let xml = FileManager.default.contents(atPath: path) {
            do {
                let plist = try PropertyListSerialization.propertyList(from: xml, options: PropertyListSerialization.ReadOptions(), format: nil)
                questions = plist as? Dictionary<String, String> ?? ["oops!": "Something went wrong!"]
            } catch {
                
            }
        }
        
        secretWord = questions.
    }


}

