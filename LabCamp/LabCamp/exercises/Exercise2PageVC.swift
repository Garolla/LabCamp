//
//  Exercise2PageVC.swift
//  LabCamp
//
//  Created by Emanuele Garolla on 01/12/2018.
//  Copyright © 2018 Emanuele Garolla. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class Exercise2PageVC: MasterExerciseVC {

    @IBOutlet weak var topLabel: UILabel!
    
    @IBOutlet weak var number1TextField: UITextField!
    @IBOutlet weak var number2TextField: UITextField!
    @IBOutlet weak var number3TextField: UITextField!
    
    @IBOutlet weak var resultLbl: UILabel!
    
    let resultToReach = 2997
    
    let relay = BehaviorRelay<Int>(value: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let number1 = number1TextField.rx.text.orEmpty.map{Int($0) ?? 0}
        let number2 = number2TextField.rx.text.orEmpty.map{Int($0) ?? 0}
        let number3 = number3TextField.rx.text.orEmpty.map{Int($0) ?? 0}
        
        //TODO: Start of your playground.
        // You should COMBINE the latest content of each text field. The combining function should SUM the content of the events
        // Then the result of this combination should be binded to the relay. Alternatively you can subscribe and make the relay accept the result
        // You should be able to pass this exercise by adding 3-8 lines of code
        
        
        
        //MARK: end of your playground.
        
        relay.asObservable()
            .map{"The sum of the 3 text fields is: \($0)"}
            .bind(to: resultLbl.rx.text)
            .disposed(by: disposeBag)
        
        relay.asObservable()
            .map { [weak self] value -> Bool in
                return value == self?.resultToReach
            }
            .bind(to: exercisePassedBtn.rx.isEnabled)
            .disposed(by: disposeBag)
        
        topLabel.text = "To pass the exercise the sum of the 3 text fields should be: \(resultToReach)"
    } 
}

extension Exercise2PageVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let textFieldText: NSString = (textField.text ?? "") as NSString
        let txtAfterUpdate = textFieldText.replacingCharacters(in: range, with: string)
        
        return (txtAfterUpdate.isNumeric && txtAfterUpdate.count <= 3) || txtAfterUpdate == ""
    }
}
