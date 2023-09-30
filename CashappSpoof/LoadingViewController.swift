//
//  ResultViewController.swift
//  CashappSpoof

import UIKit
class LoadingViewController: UIViewController {

    @IBOutlet weak var activityView: UIActivityIndicatorView!
    var userName = ""
    var amount = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "'Today at' h:mm a"
        let currentDate = Date()
        let formattedDate = dateFormatter.string(from: currentDate)
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(timeup), userInfo: nil, repeats: false)
        DataManger.shared.payment.insert(Payment(userName: userName, amount: amount, type: false, timeSent: formattedDate), at: 0)
        DataManger.shared.totalFunds -= Double(amount)
        // Do any additional setup after loading the view.
    }
    @objc func timeup() {
        self.activityView.isHidden = true
        if !success {
        let advc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ActivityDetailViewController") as? ActivityDetailViewController
            navigationController?.pushViewController(advc!, animated: true)
            advc?.username = userName
            advc?.amount = amount
        } else {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SuccessViewController") as? SuccessViewController
            vc?.userName = userName
            vc?.amount = String.toCurrency(amount)
            navigationController?.pushViewController(vc!, animated: true)
        }
        
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
