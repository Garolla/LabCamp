//
//  Exercise1PageVC.swift
//  LabCamp
//
//  Created by Emanuele Garolla on 01/12/2018.
//  Copyright © 2018 Emanuele Garolla. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class Exercise1PageVC: UIViewController {
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var exercisePassedBtn: UIButton!
    
    private let disposeBag = DisposeBag()
    
    let numberToSelectIfYouWantToPassThisExercise = 8
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Start of your playground. You should be able to pass this exercise by modifying 1 line of code
        Observable.just([50, 126, 72, 432, 1])
            .bind(to: pickerView.rx.itemTitles) { _, item in
                return "\(item)"
            }
            .disposed(by: disposeBag)
        // end of your playground
        
        topLabel.text = "To pass this exercise you must pick \(numberToSelectIfYouWantToPassThisExercise) in the picker."
        
        exercisePassedBtn.isEnabled = false
        
        pickerView.rx.modelSelected(Int.self)
            .subscribe(onNext: { [weak self] model in
                guard let `self` = self else {return}
                
                let numberPicked = model[0]
                print("Exercise1PageVC: numberPicked is: \(numberPicked)")
                
                if numberPicked == self.numberToSelectIfYouWantToPassThisExercise {
                    self.exercisePassedBtn.isEnabled = true
                } else {
                    self.exercisePassedBtn.isEnabled = false
                }
                
            }).disposed(by: disposeBag)
        
        
        exercisePassedBtn.rx.tap
            .subscribe(onNext: { [weak self] _ in
                CoreLogic.shared.setExercisePassed(exerciseNumber: 1)
                self?.navigationController?.popViewController(animated: true)
            }).disposed(by: disposeBag)
    } 
    
}
