//
//  PouredBeerView.swift
//  Cold One
//
//  Created by TJ Carney on 4/24/17.
//  Copyright © 2017 TJ Carney. All rights reserved.
//

import UIKit

class PouredBeerView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var beerNameLabel: UILabel!
    @IBOutlet weak var breweryLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var beer: Beer! {
        
        didSet {
            beerNameLabel.text = beer.name
            breweryLabel.text = beer.brewery
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
        Bundle.main.loadNibNamed("PouredBeerView", owner: self, options: nil)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        contentView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        
    }
    
    
    @IBAction func favoriteButtonTapped(_ sender: Any) {
        print("GETTING TAPPED")
        if favoriteButton.imageView?.image == #imageLiteral(resourceName: "empty star") {
            print("EMPTY STAR!")
            favoriteButton.setImage(#imageLiteral(resourceName: "filled star"), for: .normal)
        } else {
            favoriteButton.setImage(#imageLiteral(resourceName: "empty star"), for: .normal)
        }
    }
    
    
}
