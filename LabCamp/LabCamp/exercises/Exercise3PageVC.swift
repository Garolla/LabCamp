//
//  Exercise3PageVC.swift
//  LabCamp
//
//  Created by Emanuele Garolla on 01/12/2018.
//  Copyright © 2018 Emanuele Garolla. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

private let minimalUsernameLength = 5
private let minimalPasswordLength = 5

class Exercise3PageVC: MasterExerciseVC {

    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topLabel.text = "Username has to be at least \(minimalUsernameLength) characters\nPassword has to be at least \(minimalPasswordLength) characters"

        // TODO: Start of your playground.
        // The goal is to realize username and password validation
        // You need to observe the text of the usernameTextField and map it to a bool value (true if it username is longer than minimalUsernameLength)
        // You need to observe the text of the passwordTextField and map it to a bool value (true if it èassword is longer than minimalPasswordLength)
        // Then you should modify everythingValid, combining the previous two observable streams. When the first AND the second are both true, then everything should emit true
        // You should be able to solve this task in 5 - 8 lines of code
        
        
        let everythingValid = Observable.just(false) // to be modified
        //MARK: end of your playground.

        everythingValid
            .bind(to: exercisePassedBtn.rx.isEnabled)
            .disposed(by: disposeBag)
    } 

}
