//
//  DetailViewController.swift
//  pryaniki
//
//  Created by Sergei Kovalev on 26.08.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var textLabel: UILabel!
    
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    var datum = Datum()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        title = datum.name!
        updateUI(with: datum)
    }
    
    
    private func updateUI(with datum: Datum) {
        
        switch datum.name {
        case "hz":
            textLabel.isHidden = false
            textLabel.text = datum.data?.text!
        case "picture":
            textLabel.isHidden = false
            imageView.isHidden = false
            textLabel.text = datum.data?.text!
            getImage(with: (datum.data?.url!)!)
        case .none:
            print("error")
        case .some(_):
            print("error")
        }
        
        
    }
    
    private func getImage(with image: String) {
        guard let imageURL = URL(string: image) else { return }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
        
    }
    
    
}
