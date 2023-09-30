//
//  BalanceViewController.swift
//  CashappSpoof
//
//
//

import UIKit

class BalanceViewController: UIViewController {

    override func viewDidLoad() {
        self.updateBalance()
        super.viewDidLoad()
        self.balanceLabel.text = String.toCurrency(Int(DataManger.shared.totalFunds))
        // Do any additional setup after loading the view.
    }
    
    func round(_ num: Double, to places: Int) -> Double {
        let p = log10(abs(num))
        let f = pow(10, p.rounded() - Double(places) + 1)
        let rnum = (num / f).rounded() * f

        return rnum
    }

    func round(_ num: Int, to places: Int) -> Int {
        let p = log10(abs(Double(num)))
        let f = pow(10, p.rounded() - Double(places) + 1)
        let rnum = (Double(num) / f).rounded() * f

        return Int(rnum)
    }
    
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var balLabel: UILabel!
    
    func updateBalance() {
        if Int(DataManger.shared.totalFunds) < 1000 {
            self.balLabel.text = "$" + String(Int(DataManger.shared.totalFunds))
        } else {
            self.balLabel.text = "$" + String(round(DataManger.shared.totalFunds/1000, to: 3)) + "K"
        }
    }
    
    @IBAction func sendButton(_ sender: Any) {
        self.updateBalance()
        self.navigationController?.popViewController(animated: false)
    }
    @IBAction func historyButton(_ sender: Any) {
        self.updateBalance()
        if let vc =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ActivityViewController") as? ActivityViewController {
            
            navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    @IBAction func changeBalanceButton(_ sender: Any) {
        // create the actual alert controller view that will be the pop-up
        let alertController = UIAlertController(title: "Balance", message: "Enter New Balance", preferredStyle: .alert)

        alertController.addTextField { (textField) in
            // configure the properties of the text field
            textField.placeholder = "0"
        }

        // add the buttons/actions to the view controller
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        let saveAction = UIAlertAction(title: "Save", style: .default) { (_: UIAlertAction) in
            // this code runs when the user hits the "save" button
            let inputName = alertController.textFields?[0].text
            DataManger.shared.totalFunds = Double(inputName ?? "10.00") ?? 10.00
        }

        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)

        present(alertController, animated: true, completion: nil)
        self.updateBalance()
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
