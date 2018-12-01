//
//  MasterExerciseVC.swift
//  LabCamp
//
//  Created by Emanuele Garolla on 01/12/2018.
//  Copyright © 2018 Emanuele Garolla. All rights reserved.
//

import UIKit

class MasterExerciseVC: UIViewController{
    
    @IBOutlet weak var exercisePassedBtn: UIButton!
    var exerciseNumber : Int!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.isKind(of: Exercise1PageVC.self) {
            exerciseNumber = 1
        }
        
        exercisePassedBtn.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let `self` = self else {return}
                CoreLogic.shared.setExercisePassed(exerciseNumber: self.exerciseNumber)
                self.navigationController?.popViewController(animated: true)
            }).disposed(by: disposeBag)
        
        //The temptation to comment this line is great, but please don't, it's for your own good. The choice is yours.
        exercisePassedBtn.isEnabled = false
    }
}
