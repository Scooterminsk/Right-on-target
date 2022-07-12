//
//  StartViewController.swift
//  Right on target
//
//  Created by Zenya Kirilov on 16.05.22.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet var startLabel: UILabel!
    
    override func loadView() {
        super.loadView()
        print("loadView")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        startLabel.numberOfLines = 3
        startLabel.text = "Select the game"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
    }
   
}

