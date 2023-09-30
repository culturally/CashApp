//
//  ActivityViewController.swift
//  CashappSpoof


import UIKit


class ActivityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var userName : String?
    var amount : String?
    var TimeSent : String?
    @IBOutlet weak var tableView: UITableView!
    var list = [Payment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        list = DataManger.shared.payment
        tableView.reloadData()
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell =  tableView.dequeueReusableCell(withIdentifier: "ActivityCell") as? ActivityCell {
            let payment = list[indexPath.row]
            cell.topLabel.text = payment.userName
            cell.amountLabel.text = String.toCurrency(payment.amount)
        
            if indexPath.row == 0 {
                cell.bottomLabel.text = "Pending"
            }
            cell.bottomLabel.text = "Successful"
            
            cell.profileImageView.setFirstLetter(payment.userName)
            cell.profileImageView.makeCircle()
            return cell
        
        }
        fatalError()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
       let payment = list[indexPath.row]
       let activity = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ActivityDetailViewController") as! ActivityDetailViewController
        activity.username = payment.userName
        activity.amount = payment.amount
        activity.TimeSent = payment.timeSent
        activity.modalPresentationStyle = .fullScreen
        self.navigationController?.present(activity, animated: true, completion: nil)
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func sendButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    @IBAction func balanceButton(_ sender: Any) {
        if let vc =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BalanceViewController") as? BalanceViewController {
            
            navigationController?.pushViewController(vc, animated:false)
        }
    }
}
