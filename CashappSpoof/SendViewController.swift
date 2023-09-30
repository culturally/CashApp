//
//  SendViewController.swift
//  CashappSpoof

import UIKit

class SendViewController: UIViewController, UITextFieldDelegate {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.3
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        self.userTextField.layer.add(animation, forKey: "shake")
    }
    @IBOutlet weak var amountlabel: UILabel!
    var amountString = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        userTextField.delegate = self
        notesTextField.delegate = self
        userTextField.autocorrectionType = .no
        amountlabel.text = String.toCurrency(amountString)
        
        // Do any additional setup after loading the view.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 1 {
            textField.textColor = UIColor(red: 0/255.0, green: 200/255.0, blue: 0/255.0, alpha: 1.0)
        }
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func payButton(_ sender: Any) {
       let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoadingViewController") as? LoadingViewController
        vc!.amount = amountString
        if userTextField.text == "" {
            shake()
        } else {
            vc!.userName = userTextField.text!
            navigationController?.pushViewController(vc!, animated: true)
        }
    }
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var notesTextField: UITextField!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
