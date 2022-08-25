//
//  Service.swift
//  pryaniki
//
//  Created by Sergei Kovalev on 26.08.2022.
//

import Foundation
import Combine

protocol ServiceProtocol {
    func getPryaniki() -> AnyPublisher<Welcome, Error>

}

class Sevice: ServiceProtocol {

    
    func getPryaniki() -> AnyPublisher<Welcome, Error> {
      let url = URL(string: "https://pryaniky.com/static/json/sample.json")
      return URLSession.shared.dataTaskPublisher(for: url!)
        .catch { error in
          return Fail(error: error).eraseToAnyPublisher()
        }.map({ $0.data })
        .decode(type: Welcome.self, decoder: JSONDecoder())
        .eraseToAnyPublisher()
    }
    
    
    
    
    
}
