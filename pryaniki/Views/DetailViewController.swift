//
//  DetailViewController.swift
//  pryaniki
//
//  Created by Sergei Kovalev on 26.08.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var selectedText: UILabel!
    
    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var tableView2: UITableView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var choose: UILabel!
    
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
            selectedText.isHidden = true
            tableView2.isHidden = true
            choose.isHidden = true
            textLabel.text = datum.data?.text!
        case "picture":
            imageView.isHidden = false
            selectedText.isHidden = true
            tableView2.isHidden = true
            choose.isHidden = true
            textLabel.text = datum.data?.text!
            getImage(with: (datum.data?.url!)!)
        case "selector":
            imageView.isHidden = true
            selectedText.isHidden = false
            tableView2.isHidden = false
            choose.isHidden = false
            tableView2.delegate = self
            tableView2.dataSource = self
            let id: String = String((datum.data?.selectedID!)!)
            textLabel.text = "\(id)"
            let idd: Int = (datum.data?.selectedID)! - 1
            let selectedTextt: String = String((datum.data?.variants![idd].text!)!)
            selectedText.text = selectedTextt
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

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (datum.data?.variants!.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)

        cell.textLabel?.text = String((datum.data?.variants![indexPath.row].id)!)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let text: String = String((datum.data?.variants![indexPath.row].id)!)
        textLabel.text = text
        selectedText.text = datum.data?.variants![indexPath.row].text
    }
    
    
    
    
    
}
