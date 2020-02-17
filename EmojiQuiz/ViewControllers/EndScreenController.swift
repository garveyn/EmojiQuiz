//
//  EndScreenController.swift
//  EmojiQuiz
//
//  Created by Garvey, Nicholas on 2/10/20.
//  Copyright © 2020 Garvey, Nicholas. All rights reserved.
//

import UIKit

class EndScreenController: UIViewController, UITextFieldDelegate {
    
    var won: Bool = false
    var questionsAnswered: Int = 0
    var scores: [Int?] = [UserDefaults.standard.integer(forKey: ScoreConstants.FIRST_SCORE_KEY), UserDefaults.standard.integer(forKey: ScoreConstants.SECOND_SCORE_KEY), UserDefaults.standard.integer(forKey: ScoreConstants.THIRD_SCORE_KEY)]
    
    @IBOutlet weak var statusBanner: UILabel!
    @IBOutlet weak var numberSolvedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if won {
            statusBanner.text = "You Win!"
        } else {
            statusBanner.text = "You ran out of lives!"
        }
        numberSolvedLabel.text = "Questions Answered: \(questionsAnswered)"
        
        // Sourced from: https://stackoverflow.com/a/51950602
        navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(EndScreenController.back(sender:)))
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func back(sender: UIBarButtonItem) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let name = textField.text {
            scoreLoop: for (index, score) in scores.enumerated() {
                if questionsAnswered >= score ?? -1 {
                    switch index {
                    case 0:
                        UserDefaults.standard.set(questionsAnswered, forKey: ScoreConstants.FIRST_SCORE_KEY)
                        UserDefaults.standard.set(name, forKey: ScoreConstants.FIRST_NAME_KEY)
                        UserDefaults.standard.synchronize()
                        break scoreLoop
                    case 1:
                        UserDefaults.standard.set(questionsAnswered, forKey: ScoreConstants.SECOND_SCORE_KEY)
                        UserDefaults.standard.set(name, forKey: ScoreConstants.SECOND_NAME_KEY)
                        UserDefaults.standard.synchronize()
                        break scoreLoop
                    case 2:
                        UserDefaults.standard.set(questionsAnswered, forKey: ScoreConstants.THIRD_SCORE_KEY)
                        UserDefaults.standard.set(name, forKey: ScoreConstants.THIRD_NAME_KEY)
                        UserDefaults.standard.synchronize()
                        break scoreLoop
                    default:
                        break
                    }
                }
            }
        }
        resignFirstResponder()
        back(sender: UIBarButtonItem())
        return true
    }
}
