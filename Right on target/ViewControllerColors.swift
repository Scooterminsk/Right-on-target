//
//  ViewControllerColors.swift
//  Right on target
//
//  Created by Zenya Kirilov on 16.05.22.
//

import UIKit

class ViewControllerColors: UIViewController {
    
    // instant of the game with colors
    var game: Game<SecretColorValue>!
    
    // number of the 'right' button
    var correctButtonTag: Int = 0
    
    // label for HEX-output
    @IBOutlet var hexLabel: UILabel!
    
    // buttons for color choosing
    @IBOutlet var buttonColor1: UIButton!
    @IBOutlet var buttonColor2: UIButton!
    @IBOutlet var buttonColor3: UIButton!
    @IBOutlet var buttonColor4: UIButton!
    
    // property, that gives an opportunity to work with buttons as a collection
    @IBOutlet var buttonCollection: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game = (GameFactory.getColorGame() as! Game<SecretColorValue>)
        buttonCollection = [buttonColor1, buttonColor2, buttonColor3, buttonColor4]
        updateScene()
    }
    
    private func updateScene() {
        let secretColorString = game.secretValue.value.getByHexString()
        updateSecretColorLabel(withText: secretColorString)
        updateButtons(withRightSecretValue: game.secretValue)
    }
    
    // MARK: - Interection of Model - Controller
    
    // checking user's selected color
    @IBAction func compareValue(_ sender: UIButton) {
        var userValue = game.secretValue
        userValue.value = Color(from: sender.backgroundColor!)
        game.calculateScore(secretValue: game.secretValue, userValue: userValue)
        // checking if the game was ended
        if game.isGameEnded {
            // show the window with the game results
            showAlertWith(score: game.score)
            // restart the game
            game.restartGame()
        } else {
            // begin new round of the game
            game.startNewRound()
        }
        updateScene()
    }
    
    // back button
    @IBAction func backButton() {
        self.dismiss(animated: true)
    }
    
    // MARK: - Update the View
    
    // updating the text of the secret color
    private func updateSecretColorLabel(withText newHEXColorText: String) {
        hexLabel.text = "#\(newHEXColorText)"
    }
    
    // updating background color of buttons
    private func updateButtons(withRightSecretValue secretValue: SecretColorValue) {
        // let's check, what button will be right
        correctButtonTag = Array(1...4).randomElement()!
        buttonCollection.forEach { button in
            if button.tag == correctButtonTag {
                button.backgroundColor = secretValue.value.getByUIColor()
            } else {
                var copySecretValueForButton = secretValue
                copySecretValueForButton.setRandomValue()
                button.backgroundColor = copySecretValueForButton.value.getByUIColor()
            }
        }
    }

    // showing alert-window with results
    private func showAlertWith(score: Int) {
        let alert = UIAlertController(
            title: "The game is ended",
            message: "You have earned \(score) points",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "New game", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
