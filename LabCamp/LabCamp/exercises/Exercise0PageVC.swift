//
//  Exercise0PageVC.swift
//  LabCamp
//
//  Created by Emanuele Garolla on 01/12/2018.
//  Copyright © 2018 Emanuele Garolla. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class Exercise0PageVC: MasterExerciseVC {

    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var relayContentLbl: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    var relay : BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)
    
    private let stringToWriteToPassTheExercise = "Reply is amazing"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topLabel.text = "To pass this exercise the below label must contain the text: \n\"\(stringToWriteToPassTheExercise)\" \nYou should use the below Text Field to type the string"

        textField.rx.text.orEmpty
            .subscribe(onNext: { [weak self] text in
                //TODO: Start of your playground.
                // The behavior relay needs to ACCEPT the TEXT of the textField
                // In this way observers that are binded to the relay are called
                // You should be able to pass this exercise by adding 1 line of code
                
                //MARK: end of your playground.
            }).disposed(by: disposeBag)
        
        let relayAsObservable = relay.asObservable()
            .filter{$0 != nil}
            .map{$0!}
        
        relayAsObservable
            .map{"Typed text is: " + $0}
            .bind(to: relayContentLbl.rx.text)
            .disposed(by: disposeBag)
        
        relayAsObservable
            .map({[weak self] (value) -> Bool in
                return value == self?.stringToWriteToPassTheExercise
            })
            .bind(to: exercisePassedBtn.rx.isEnabled)
            .disposed(by: disposeBag)
 
    }

}
