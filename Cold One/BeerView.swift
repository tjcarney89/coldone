//
//  BeerView.swift
//  Cold One
//
//  Created by TJ Carney on 4/24/17.
//  Copyright © 2017 TJ Carney. All rights reserved.
//

import UIKit
import Kingfisher

class BeerView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var beerNameLabel: UILabel!
    @IBOutlet weak var beerStyleLabel: UILabel!
    @IBOutlet weak var beerImageView: UIImageView!
    
    var beer: Beer! {
        didSet {
            if let urlString = beer.imageURL {
                let url = URL(string: urlString)
                beerImageView.kf.setImage(with: url)
            } else {
                beerImageView.image = UIImage(named: "default")
            }
            beerNameLabel.text = beer.name
            beerStyleLabel.text = beer.style
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
        Bundle.main.loadNibNamed("BeerView", owner: self, options: nil)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        contentView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    }
}
