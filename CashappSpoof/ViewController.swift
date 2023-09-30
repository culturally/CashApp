//
//  ViewController.swift
//  CashappSpoof

import UIKit
class SlideAndBounceAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let isPresentation: Bool
    
    init(isPresentation: Bool) {
        self.isPresentation = isPresentation
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let toView = transitionContext.view(forKey: .to) else { return }
        
        let finalFrame = toView.frame
        
        if isPresentation {
            toView.frame = CGRect(x: finalFrame.origin.x, y: containerView.bounds.size.height, width: finalFrame.size.width, height: finalFrame.size.height)
            containerView.addSubview(toView)
        }
        
        let duration = transitionDuration(using: transitionContext)
        let damping: CGFloat = 0.7
        let initialSpringVelocity: CGFloat = 0.1
        
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: damping, initialSpringVelocity: initialSpringVelocity, options: [], animations: {
            if self.isPresentation {
                toView.frame = finalFrame
            } else {
                toView.frame = CGRect(x: finalFrame.origin.x, y: containerView.bounds.size.height, width: finalFrame.size.width, height: finalFrame.size.height)
            }
        }) { finished in
            transitionContext.completeTransition(finished)
        }
    }
    
}

extension ViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideAndBounceAnimator(isPresentation: true)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideAndBounceAnimator(isPresentation: false)
    }
    
}

class ViewController: UIViewController {

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var BalanceLabel: UILabel!
    override func viewDidLoad() {
        self.updateBalance()
        super.viewDidLoad()
    }
    
    func updateBalance() {
        if Int(DataManger.shared.totalFunds) < 1000 {
            self.BalanceLabel.text = "$" + String(Int(DataManger.shared.totalFunds))
        } else {
            self.BalanceLabel.text = "$" + String(round(DataManger.shared.totalFunds/1000, to: 3)) + "K"
        }
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
    func shake() {
        self.updateBalance()
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.duration = 0.5
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.5, 5.5, 0.0 ]
        self.numberLabel.layer.add(animation, forKey: "shake")
    }
    func Transition() {
        self.updateBalance()
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = 0.17
        self.numberLabel.layer.add(animation, forKey: CATransitionType.reveal.rawValue)
    }
    @IBAction func numberPad_Touch(_ sender: Any) {
        self.updateBalance()
        if let button = sender as? UIButton {
            var text = self.numberLabel.text ?? ""
            if text.count == 2 && text.last! == "0" && button.tag != 0 {
                text.removeLast()
            } else if text.count == 2 && text.last! == "0" && button.tag == 0 {
                return
            }
            text.append("\(button.tag)")
            if text.count == 5 {
                text.insert(",", at: text.index(text.startIndex, offsetBy: 2))
            }; if text.count == 7 {
                text = text.replacingOccurrences(of: ",", with: "", options: NSString.CompareOptions.literal, range: nil)
                text.insert(",", at: text.index(text.startIndex, offsetBy: 3))
            }; if text.count > 7 {
                shake()
            } else {
                var money = text
                money.removeFirst()
                money = money.replacingOccurrences(of: ",", with: "", options: NSString.CompareOptions.literal, range: nil)
                if Int(money) ?? 0 > 100000 {
                    shake()
                } else {
                    Transition()
                    self.numberLabel.text = text
                }
            }
        }
    }
    
    @IBAction func backspace(_ sender: Any) {
        self.updateBalance()
        if let text = self.numberLabel.text, text.count > 2 {
            var text = text
            text.removeLast()
            if text.count == 6 {
                text = text.replacingOccurrences(of: ",", with: "", options: NSString.CompareOptions.literal, range: nil)
                text.insert(",", at: text.index(text.startIndex, offsetBy: 2))
            }; if text.count == 5 {
                text = text.replacingOccurrences(of: ",", with: "", options: NSString.CompareOptions.literal, range: nil)
            }
            Transition()
            self.numberLabel.text = text
        } else {
            Transition()
            self.numberLabel.text = "$0"
        }
    }
    


    @IBAction func balance(_ sender: Any) {
        self.updateBalance()
        if let vc =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BalanceViewController") as? BalanceViewController {
            
            navigationController?.pushViewController(vc, animated:false)
        }
    }

    @IBAction func pay_button(_ sender: Any) {
        self.updateBalance()
        if let vc =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SendViewController") as? SendViewController {
            vc.modalPresentationStyle = .fullScreen
            
           let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            nav.isNavigationBarHidden = true
            
            var money = self.numberLabel.text!
            money.removeFirst()
            money = money.replacingOccurrences(of: ",", with: "", options: NSString.CompareOptions.literal, range: nil)
            vc.amountString = Int(money)!
            if vc.amountString == 0 {
                shake()
            } else {
                nav.transitioningDelegate = self
                navigationController?.present(nav, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func historyButton(_ sender: Any) {
        self.updateBalance()
        if let vc =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ActivityViewController") as? ActivityViewController {
            
            navigationController?.pushViewController(vc, animated: false)
        }
    }
}

