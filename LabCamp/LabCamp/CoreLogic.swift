//
//  CoreLogic.swift
//  LabCamp
//
//  Created by Emanuele Garolla on 01/12/2018.
//  Copyright © 2018 Emanuele Garolla. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class CoreLogic {
    
    private init() {}
    static let shared = CoreLogic() 
    
    private let NUMBER_OF_EXERCISES = 5
    private let UD_PASSED_ARRAY_ID = "ExercisePassedArray"
    
    //Array of bools, each one representing a passed exercise
    func getArrayOfPassedExercise() -> [Bool] {
        
        let passed = UserDefaults.standard.array(forKey: UD_PASSED_ARRAY_ID)  as? [Bool]
        
        //If not present (i.e. first time we launch the app), create a new array
        if let passed = passed, passed.count == NUMBER_OF_EXERCISES {
            return passed
        } else {
            let initialArray = Array<Bool>(repeating: false, count: NUMBER_OF_EXERCISES)
            UserDefaults.standard.set(initialArray, forKey: UD_PASSED_ARRAY_ID)
            return initialArray
        }
    }
    
    
    func setExercisePassed(exerciseNumber number: Int) {
        var passed = getArrayOfPassedExercise()
        
        passed[number] = true
        
        UserDefaults.standard.set(passed, forKey: UD_PASSED_ARRAY_ID)
    }
    
    
    
}
