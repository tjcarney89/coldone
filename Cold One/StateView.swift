//
//  StateView.swift
//  Cold One
//
//  Created by TJ Carney on 5/1/17.
//  Copyright © 2017 TJ Carney. All rights reserved.
//

import UIKit

class StateView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var filledImageView: UIImageView!
    
    var state: USState! {
        
        didSet {
            stateLabel.text = state.name
            if state.isFilled {
                filledImageView.image = #imageLiteral(resourceName: "full beer")
            } else {
                filledImageView.image = #imageLiteral(resourceName: "empty beer")
            }
            //backgroundColor = UIColor(red: 205/255, green: 100/255, blue: 40/255, alpha: 1.0)
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("StateView", owner: self, options: nil)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        contentView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    }
    
    
    
}
