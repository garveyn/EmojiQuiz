//
//  FirstViewController.swift
//  EmojiQuiz
//
//  Created by Garvey, Nicholas on 2/9/20.
//  Copyright © 2020 Garvey, Nicholas. All rights reserved.
//

import UIKit
import AVFoundation

class QuizController: UIViewController {
    /* The ideas for spacing on the keyboard were inspired by this
     * stack overflow answer: https://stackoverflow.com/a/30249550
     */
    
    let LIVES_TEXT: String = "Lives:"
    let QUESTIONS_TEXT: String = "Question #"
    
    var category: String = ""
    var totalQuestions: Int = 0
    var questions: Array<String> = []
    var answers: Array<String> = []
    var currentQuestion: Int = -1
    
    var guessPool: [Character] = []
    var lives: Int = 3
    
    var player = AVAudioPlayer()

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
            guessesLabel.text = String(answers[currentQuestion].map {char in
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
                playSounds(fileName: "correctSound")
                
            } else {
                color = UIColor(named: "Incorrect")
                lives -= 1
                playSounds(fileName: "wrongSound")
                
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
        
        if solved {
            questionSolved()
        }
    }
    
    func playSounds(fileName: String) {
        do {
            let session = AVAudioSession.sharedInstance()
            
            try! session.setCategory(.playback, mode: .default)
            
            player = try AVAudioPlayer(data: NSDataAsset(name: fileName)!.data, fileTypeHint: "m4a")
            
            player.play()
            
        } catch let e {
            print(e.localizedDescription)
        }
    }
    
    func outOfLives() {
        currentQuestion -= 1
        performSegue(withIdentifier: "finished", sender: false)
    }
    
    func questionSolved() {
        // TODO: Implement sounds
        currentQuestion += 1
        if currentQuestion >= totalQuestions {
            currentQuestion -= 1
            performSegue(withIdentifier: "finished", sender: true)
        }
        qNumbLabel.text = "\(QUESTIONS_TEXT)\(currentQuestion + 1) of \(totalQuestions)"
        guessesLabel.text = String(answers[currentQuestion].map {char in
            if char == " " {
                return " "
            } else {
                return "_"
            }
        })
        
        UIView.animate(withDuration: 1.0, animations: {
            self.questionLabel.alpha = 0.0
        }, completion: {_ in
            self.questionLabel.text = self.questions[self.currentQuestion]
            self.questionLabel.alpha = 1.0
        })
        
        for button in letterButtons {
            button.isEnabled = true
            button.setTitleColor(.systemBlue, for: .normal)
        }
        
        guessPool = []
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = category
        
        // Load Questions | Sourced from: https://gist.github.com/db42/e7a009dd864c7d40fd2a750e3ae24155
        if let path = Bundle.main.path(forResource: category, ofType: "plist"),
            let xml = FileManager.default.contents(atPath: path) {
            do {
                let plist = try PropertyListSerialization.propertyList(from: xml, options: PropertyListSerialization.ReadOptions(), format: nil)
                let arrays = plist as? Dictionary<String, Array<String>> ?? [:]
                questions = arrays["Questions"] ?? ["Something went wrong!"]
                answers   = arrays["Answers"]   ?? ["oops..."]
            } catch {
                
            }
        }
        questionSolved()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let won = sender as? Bool,
        let destination = segue.destination as? EndScreenController{
            destination.won = won
            destination.questionsAnswered = currentQuestion + 1
        }
    }


}

