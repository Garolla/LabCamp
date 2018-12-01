//
//  ViewController.swift
//  LabCamp
//
//  Created by Emanuele Garolla on 01/12/2018.
//  Copyright © 2018 Emanuele Garolla. All rights reserved.
//

import UIKit
import RxSwift

class InitialPageVC: UIViewController {
    
    struct CellContent {
        var title : String
        var background : UIColor
    }

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topLabel: UILabel!
    
    private let disposeBag = DisposeBag()
    
    private let cellIdentifier = "ExerciseCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //To remove table view extra separator line
        self.tableView.tableFooterView = UIView()
        
        //First observable. It will be emitted "just" one event, which is an array of Strings
        let exercisesNames : Observable<[String]> = Observable.just(["Exercise 0", "Exercise 1", "Exercise 2", "Exercise 3", "Exercise 4"])
        
        //Second observable. Every time viewWillAppear function of this view controller is called, an event will be emitted
        //The event is then transformed to an array of bool, which is taken from the CoreLogic. Every bool represent if an exercise has been passed or not
        //MARK: rx.viewWillAppear is not part of RxSwift or RxCocoa, is a custom reactivex extension that you can find in Utility.swift
        let exercisesPassed : Observable<[Bool]> = self.rx.viewWillAppear
            .map({ (_) -> [Bool] in
                print("InitialPageVC: viewWillAppearCalled")
                return CoreLogic.shared.getArrayOfPassedExercise()
            })
        
        //The first observable (which emits the exercises names) and the second observable (which emits the bool array) are combined together, to create the array of cell contents which will be used to populate the table view.
        let items : Observable<[CellContent]> = Observable.combineLatest(exercisesNames, exercisesPassed){ (names: [String], passed: [Bool]) -> [CellContent] in
            var cellContents = [CellContent]()
            
            //Names count and passed count should be equal
            for i in 0..<names.count {
                let content = CellContent(title: names[i],
                                          background: passed[i] ? .green : .red)
                cellContents.append(content)
            } 
            
            return cellContents
        }
    
        //Items is an Observable of array of CellContent. Every time items emits a new event (every event is a [CellContent] ), the table view (which is the Observer) is drawn again
        items
            .bind(to: tableView.rx.items) { [weak self] (tableView, row, cellContent) in
                //alt+9 on mac to have the backtick character `
                guard let `self` = self else {return UITableViewCell()}
                
                let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier)!
                
                cell.textLabel?.text = cellContent.title
                cell.backgroundColor = cellContent.background
            
                return cell
        }.disposed(by: disposeBag)
        
        
        //Reactive wrapper for tableView didSelectRow function. It emits a new event every time a cell is "clicked". The event is the indexPath of the cell selected.
        //Then the indexPath is transformed to the name of the related storyboard to push
        tableView.rx.itemSelected
            .map {indexPath in
                return "Exercise\(indexPath.row)Page"
            }.subscribe(onNext: { [weak self] nextExerciseToPush in
                
                print("InitialPageVC: Selected " + nextExerciseToPush)
                let storyboard = UIStoryboard(name: nextExerciseToPush, bundle: nil)
                let vc = storyboard.instantiateInitialViewController()!
                
                self?.navigationController?.pushViewController(vc, animated: true)
                
            }).disposed(by: disposeBag)
        
        
        // The observable exercisesPassed is also used to change the content of the top label 
        exercisesPassed
            .map{"You have completed \($0.filter{$0 == true}.count) exercise"}
            .bind(to: topLabel.rx.text)
            .disposed(by: disposeBag)
    }
}

