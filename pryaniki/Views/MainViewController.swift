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
              print(model)
              self?.updateUI(with: model)
              //self?.label.text = String(news.totalCount!)
          case .fetchPryanikiDidFail(let error):
              print(error)
              //self?.errorr(with: error)
          }
        }.store(in: &cancellables)
        
    }
    
    
    private func updateUI(with model: Welcome) {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.model = model
        self.tableView.reloadData()
    }
    

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.data!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        comfigureCell(cell, forCategoryAt: indexPath)

        return cell
    }
    
    func comfigureCell(_ cell: UITableViewCell, forCategoryAt indexPath: IndexPath) {
        let model = model.data![indexPath.row]
        cell.textLabel?.text = model.name!
    }
    
    
}
