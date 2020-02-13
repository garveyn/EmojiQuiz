//
//  File.swift
//  EmojiQuiz
//
//  Created by Garvey, Nicholas on 2/12/20.
//  Copyright © 2020 Garvey, Nicholas. All rights reserved.
//

import UIKit

class QuizSetupController: UIViewController {
    
    @IBOutlet weak var category: UISegmentedControl!
    @IBAction func categoryChanged(_ sender: UISegmentedControl) {
        
    }
    
    @IBOutlet weak var questionNumLabel: UILabel!
    @IBOutlet weak var questionNumStepper: UIStepper!
    @IBAction func questionNumChanged(_ sender: UIStepper) {
        questionNumLabel.text = String(Int(sender.value))
    }
    
    override func viewDidLoad() {
        // Setup stuff...
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? QuizController {
            controller.category = category.titleForSegment(at: category.selectedSegmentIndex) ?? "Flags"
            controller.totalQuestions = Int(questionNumStepper.value)
        }
    }
}
