//
//  ResultViewController.swift
//  CashappSpoof

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet weak var profileImageView: UIView!
    var username = " "
    var amount = 0
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var reasonLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameLabel.text = self.username
        self.profileImageView.setFirstLetter(self.username)
        self.profileImageView.makeCircle()
        self.amountLabel.text = String.toCurrency(amount)
        self.profileImageView.backgroundColor = .blue
        self.reasonLabel.numberOfLines = 0
        if success {
            self.reasonLabel.isHidden = true
        } else {
            self.reasonLabel.text = "Due to suspecious transactions from the recipient, a minimum of $35 in transactions must be received from \(self.username). Once this threshold is met, the amount of \(String.toCurrency(self.amount)) will be transferred into \(self.username)'s account."
            
        }
        // Do any additional setup after loading the view.
    }
    @IBAction func closeButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    class ResultViewController: UIViewController {
        
        override func viewDidLoad() {
            super.viewDidLoad()
            navigationController?.isNavigationBarHidden = false
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(close))
            
            // Do any additional setup after loading the view.
        }
        
        @objc func close() {
            dismiss(animated: true, completion: nil)
        }
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
    }
}
