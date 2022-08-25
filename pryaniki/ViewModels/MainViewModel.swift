//
//  MainViewModel.swift
//  pryaniki
//
//  Created by Sergei Kovalev on 26.08.2022.
//

import Foundation
import Combine

class MainViewModel {
    
    enum Input {
      case viewDidLoad
    }
    
    enum Output {
      case fetchPryanikiDidFail(error: Error)
      case fetchPryanikiDidSucceed(models: Welcome)
    }
    
    
    
    
    
    private let modelService: ServiceProtocol
    private let output: PassthroughSubject<Output, Never> = .init()
    private var cancellables = Set<AnyCancellable>()
    
    init(modelService: ServiceProtocol = Sevice()) {
      self.modelService = modelService
    }
    
    var reloadTableView: (() -> Void)?
    
    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
      input.sink { [weak self] event in
        switch event {
        case .viewDidLoad:
          self?.handleGetPryaniki()
        }
      }.store(in: &cancellables)
      return output.eraseToAnyPublisher()
    }
    
    private func handleGetPryaniki() {
        modelService.getPryaniki().sink { [weak self] completion in
        if case .failure(let error) = completion {
          self?.output.send(.fetchPryanikiDidFail(error: error))
        }
      } receiveValue: { [weak self] models in
          self?.output.send(.fetchPryanikiDidSucceed(models: models))
      }.store(in: &cancellables)
    }
}
