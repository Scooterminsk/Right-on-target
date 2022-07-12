//
//  ViewController.swift
//  Right on target
//
//  Created by Zenya Kirilov on 2.05.22.
//

import UIKit

class ViewControllerSlider: UIViewController {
    
    // entity 'Game'
    var game: Game<SecretNumericValue>!
    
    
    // elements on the scene
    @IBOutlet var slider: UISlider!
    @IBOutlet var label: UILabel!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // creation of an entity 'Game' instance
        game = (GameFactory.getNumericGame() as! Game<SecretNumericValue>)

        // updating data about current secret number
        updateLabelWithSecretNumber(newText: String(game.secretValue.value))
    }
    
    // MARK: - Interection of View - Model
    
    // check of user's chosen number
    @IBAction func checkNumber() {
       
        // counting score for round
        var userSecretValue = game.secretValue
        userSecretValue.value = Int(slider.value)
        game.calculateScore(secretValue: game.secretValue, userValue: userSecretValue)
        // check if the game was ended
        if game.isGameEnded {
            showAlertWith(score: game.score)
            // begin a new game
            game.restartGame()
        } else {
            game.startNewRound()
        }
        // updating data about current secret number
        updateLabelWithSecretNumber(newText: String(game.secretValue.value))
        }
    
    // MARK: - Updating the View
    // updating the text of the secret number
    
    private func updateLabelWithSecretNumber(newText: String) {
        label.text = newText
    }
    
    // displaying a pop-up window with an invoice
    private func showAlertWith(score: Int) {
        let alert = UIAlertController(
            title: "The game is ended",
            message: "Your score is \(score)",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Begin a new game", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Back button
    @IBAction func backButton() {
        self.dismiss(animated: true)
    }
    
    }
    

