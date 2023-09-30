//
//  SuccessViewController.swift
//  CashappSpoof

import UIKit

class SuccessViewController: UIViewController {
    var userName = ""
    var amount = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        topLabel.text = "You sent \(amount)"
        bottomLabel.text = "to \(userName)"
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var topLabel: UILabel!
    
    @IBOutlet weak var bottomLabel: UILabel!


    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
