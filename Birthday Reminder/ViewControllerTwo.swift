//
//  ViewControllerTwo.swift
//  Birthday Reminder
//
//  Created by Mac on 15.11.2022.
//

import UIKit

protocol ViewControllerTwoDelegate: class {
    func update(name: String, age: String)
}

class ViewControllerTwo: UIViewController {

    var nameFromVC: String!
    
    @IBOutlet var nameFromThree: UILabel!
    @IBOutlet var textFromThree: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
    }
    // функции для передачи данных
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? ViewControllerThree else { return }
        destination.delegate = self
    }
    func update(name: String, age: String) {
        nameFromThree.text? = name.capitalized
        textFromThree.text = age + " years"
    }

}
