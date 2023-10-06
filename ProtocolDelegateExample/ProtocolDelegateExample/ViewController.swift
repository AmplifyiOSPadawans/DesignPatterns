//
//  ViewController.swift
//  ProtocolDelegateExample
//
//  Created by David Perez Espino on 29/09/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtFldResult: UILabel!
    @IBOutlet weak var txtFldSecond: UITextField!
    @IBOutlet weak var txtFldFirst: UITextField!
    
    
    var manager: OperationsManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager = OperationsManager()
        manager?.delegate = self
    }


    @IBAction func doSum(_ sender: UIButton) {
        manager?.doSum( a: Double(txtFldFirst.text ?? "") ?? 0.0, b: Double(txtFldSecond.text ?? "") ?? 0.0 )
    }
}

extension ViewController: OperationsManagerDelegate {
    
    
    func didResult(result: Double) {
        txtFldResult.text = "\(result)"
    }
    
    
}


extension ViewController: UITableViewDelegate {
    
    
}
