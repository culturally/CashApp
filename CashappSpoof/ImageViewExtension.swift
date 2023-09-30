//
//  ImageViewExtension.swift
//  CashappSpoof


import Foundation
import UIKit

extension UIView {
    func makeCircle() {
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.contentMode = UIView.ContentMode.scaleAspectFit
        
    }
    func setFirstLetter(_ letter : String) {
        var letter = letter
        while let f = letter.first, f == "$" {
            letter.removeFirst()
        }
            
        let f = letter.first!
        var found = false
        for subview in self.subviews {
            if subview.tag == 88 {
            found = true
            }
        }
        if !found {
            var offset : CGFloat = 10.0
            var size : CGFloat = 17.0
            if self.bounds.height > 70 {
                size = 30
                offset = 0
            }
        let label =  UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height:( self.bounds.height-offset)))
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: size)
        label.text = String(f)
        label.tag = 88
        label.textColor = .white
        self.addSubview(label)
        }
    }
}
