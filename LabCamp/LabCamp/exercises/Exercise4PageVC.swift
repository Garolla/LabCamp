//
//  Exercise4PageVC.swift
//  LabCamp
//
//  Created by Emanuele Garolla on 01/12/2018.
//  Copyright © 2018 Emanuele Garolla. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class Exercise4PageVC: MasterExerciseVC {

    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private let cellIdentifier = "Exercise4Cell"
    
    private let regions = ["Abruzzo", "Valle d'aosta", "Puglia" ,"Basilicata", "Calabria", "Campagna", "Emilia romagna", "Friuli venezia giulia", "Lazio", "Liguria", "Lombardia", "Marche", "Molise", "Piemonte", "Sardegna", "Sicilia", "Trentino alto adige", "Toscana", "Umbria", "Veneto"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        topLabel.text = "Type in the search bar the name of one of the regions of Italy and it should appear in the table view below"
        
        // TODO: Start of your playground.
        // The goal is to populate the table view, whit a subset of data from "regions"
        // Observe the searchBar text. Starting from its text filter the array "regions" with the elements that CONTAINS that text
        // Then bind this new array of string to the table view items
        // You should be able to solve this task in around 12 lines of code
        
        
        
        //MARK: end of your playground.
        
        //Select a cell while the search bar is not empty to pass the exercise
        tableView.rx.itemSelected
            .withLatestFrom(searchBar.rx.text.orEmpty)
            .map{!$0.isEmpty}
            .bind(to: exercisePassedBtn.rx.isEnabled)
            .disposed(by: disposeBag)
        
    } 

}
