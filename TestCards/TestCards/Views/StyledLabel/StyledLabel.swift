//
//  StyledLabel.swift
//  TestCards
//
//  Created by Dmitriy Korkin on 21/12/2018.
//  Copyright © 2018 Dmitriy Korkin. All rights reserved.
//

import UIKit

class StyledLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customizeUI()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        customizeUI()
    }
    
    private func customizeUI() {
        self.textColor = .white
        self.font = UIFont.boldSystemFont(ofSize: 32)
        self.numberOfLines = 0
        self.lineBreakMode = .byWordWrapping
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 3.0
        self.layer.shadowOpacity = 1.0
        self.layer.shadowOffset = CGSize(width: 4, height: 4)
        self.layer.masksToBounds = false
    }
}
