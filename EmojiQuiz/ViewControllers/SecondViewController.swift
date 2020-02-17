//
//  SecondViewController.swift
//  EmojiQuiz
//
//  Created by Garvey, Nicholas on 2/9/20.
//  Copyright © 2020 Garvey, Nicholas. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let fName = UserDefaults.standard.string(forKey: ScoreConstants.FIRST_NAME_KEY) {
            let fScore = UserDefaults.standard.integer(forKey: ScoreConstants.FIRST_SCORE_KEY)
            firstLabel.text = "🥇: \(fName) - \(fScore)"
            firstLabel.isHidden = false
        }
        
        if let sName = UserDefaults.standard.string(forKey: ScoreConstants.SECOND_NAME_KEY) {
            let sScore = UserDefaults.standard.integer(forKey: ScoreConstants.SECOND_SCORE_KEY)
            secondLabel.text = "🥈: \(sName) - \(sScore)"
            secondLabel.isHidden = false
        }
        
        if let tName = UserDefaults.standard.string(forKey: ScoreConstants.THIRD_NAME_KEY) {
            let tScore = UserDefaults.standard.integer(forKey: ScoreConstants.THIRD_SCORE_KEY)
            thirdLabel.text = "🥉: \(tName) - \(tScore)"
            thirdLabel.isHidden = false
        }
    }


}

