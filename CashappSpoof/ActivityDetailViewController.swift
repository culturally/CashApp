//
//  ActivityDetailViewController.swift
//  CashappSpoof

import UIKit

class ActivityDetailViewController: UIViewController {
    @IBOutlet weak var profileImageView: UIView!
    var username = " "
    var amount = 0
    var TimeSent : String?
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var reasonLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameLabel.text = self.username
        self.profileImageView.setFirstLetter(self.username)
        self.profileImageView.makeCircle()
        self.amountLabel.text = String.toCurrency(amount)
        self.profileImageView.backgroundColor = .blue
        self.reasonLabel.numberOfLines = 0
        
        // Add formatted date
        for paymentItem in DataManger.shared.payment {
            if paymentItem.userName == username {
                dateLabel.text = paymentItem.timeSent
            }
            break
        }
        
        if success {
            self.reasonLabel.isHidden = true
        } else {
            self.reasonLabel.text = "To protect you from potential fraudulent charges, we have temporarily placed a hold on your payment of \(String.toCurrency(self.amount)). This hold will remain in effect until you have received a minimum of $35 worth of transactions from \(self.username)."
        }
    }
    
    @IBAction func closeButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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

// In order to ensure the security of your funds and protect you from potential fraudulent charges, we have temporarily placed a hold on your payment of $200. This hold will remain in effect until you have received a minimum of $35 worth of transactions from John

// "\(self.username) has been flagged as a high risk of fraud. To prevent fraudulent charges, your payment of \(String.toCurrency(self.amount)) will be pending until you have recieved a minimum transaction(s) of $35 from \(self.username)."
