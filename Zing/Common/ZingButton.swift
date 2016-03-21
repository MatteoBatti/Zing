//
//  ZingButton.swift
//  Zing
//
//  Created by Matteo Battistini on 21/03/16.
//  Copyright © 2016 Matteo Battistini. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class ZingButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 5.0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
        }
    }
}
