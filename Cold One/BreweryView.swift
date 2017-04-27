//
//  BreweryView.swift
//  Cold One
//
//  Created by TJ Carney on 4/26/17.
//  Copyright © 2017 TJ Carney. All rights reserved.
//

import UIKit

class BreweryView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var breweryNameLabel: UILabel!
    @IBOutlet weak var breweryTypeLabel: UILabel!
    @IBOutlet weak var breweryAddressLabel: UILabel!
    @IBOutlet weak var breweryDistanceLabel: UILabel!
    
    var brewery: Brewery! {
        didSet {
            breweryNameLabel.text = brewery.name
            breweryTypeLabel.text = brewery.type
            breweryDistanceLabel.text = String(brewery.distance) + " miles"
            if brewery.hasAddress && brewery.hasLocality {
                breweryAddressLabel.text = "\(brewery.address!), \(brewery.locality!), \(brewery.region)"
            } else if brewery.hasLocality && !brewery.hasAddress {
                breweryAddressLabel.text = "\(brewery.locality!), \(brewery.region)"
            } else if !brewery.hasLocality && !brewery.hasAddress {
                breweryAddressLabel.text = brewery.region
            }
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
        Bundle.main.loadNibNamed("BreweryView", owner: self, options: nil)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        contentView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    }
}
