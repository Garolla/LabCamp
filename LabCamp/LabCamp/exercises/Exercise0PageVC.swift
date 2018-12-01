//
//  Exercise0PageVC.swift
//  LabCamp
//
//  Created by Emanuele Garolla on 01/12/2018.
//  Copyright © 2018 Emanuele Garolla. All rights reserved.
//

import UIKit

class Exercise0PageVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        CoreLogic.shared.setExercisePassed(exerciseNumber: 0)
    }

}
