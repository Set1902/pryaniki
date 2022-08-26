//
//  DetailViewController.swift
//  pryaniki
//
//  Created by Sergei Kovalev on 26.08.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    
    var datum = Datum()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = datum.name!
    
        
        
        
    }
    

}
