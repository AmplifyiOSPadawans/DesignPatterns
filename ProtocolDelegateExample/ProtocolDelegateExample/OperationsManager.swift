//
//  OperationsManager.swift
//  ProtocolDelegateExample
//
//  Created by David Perez Espino on 29/09/23.
//

import Foundation

protocol OperationsManagerDelegate {
    func didResult(result: Double)
}



class OperationsManager {
    
    var delegate: OperationsManagerDelegate!
    
    func doSum(a: Double, b: Double) {
        delegate.didResult(result: a + b)
    }
}
