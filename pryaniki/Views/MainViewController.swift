//
//  ViewController.swift
//  pryaniki
//
//  Created by Sergei Kovalev on 26.08.2022.
//

import UIKit
import Combine
class MainViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    private var model = Welcome()
    private var vieww: [String]?
    private let vm = MainViewModel()
    private let input: PassthroughSubject<MainViewModel.Input, Never> = .init()
    private var cancellables = Set<AnyCancellable>()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bind()
        input.send(.viewDidLoad)
    }

    
    
    
    private func bind() {
        let output = vm.transform(input: input.eraseToAnyPublisher())
        output
          .receive(on: DispatchQueue.main)
          .sink { [weak self] event in
          switch event {
          case .fetchPryanikiDidSucceed(let model):
              self?.updateUI(with: model)
          case .fetchPryanikiDidFail(let error):
              print(error)
          }
        }.store(in: &cancellables)
        
    }
    
    
    private func updateUI(with model: Welcome) {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.model = model
        self.vieww = model.view
        self.tableView.reloadData()
    }

}

extension MainViewController {
    @IBAction func unwindToMain(unwindSegue: UIStoryboardSegue) {
        
    }
}


extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.view!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        comfigureCell(cell, forCategoryAt: indexPath)

        return cell
    }
    
    func comfigureCell(_ cell: UITableViewCell, forCategoryAt indexPath: IndexPath) {
        let model = model.view![indexPath.row]
        cell.textLabel?.text = model
    }
}


extension MainViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "Show" else {return}
        
        let navController = segue.destination as! UINavigationController
        
       let datumViewController = navController.topViewController as! DetailViewController
        guard let newIndexPath = tableView.indexPathForSelectedRow else {return}

        let searchValue = model.view![newIndexPath.row]
        
        for i in 0..<model.data!.count {
            if model.data![i].name == searchValue {
                let selecteddatum: Datum = model.data![i]
                datumViewController.datum = selecteddatum
            }
            
        }
    }
}
