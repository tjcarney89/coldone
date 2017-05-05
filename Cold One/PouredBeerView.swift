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
    
    let cdStore = CoreDataStack.sharedInstance
    
    var brew: Brew! {
        didSet {
            beerNameLabel.text = brew.name
            breweryLabel.text = brew.brewery
            if brew.isFavorite {
                favoriteButton.setImage(#imageLiteral(resourceName: "filled star"), for: .normal)
            } else if !brew.isFavorite {
                favoriteButton.setImage(#imageLiteral(resourceName: "empty star"), for: .normal)
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
        Bundle.main.loadNibNamed("PouredBeerView", owner: self, options: nil)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        contentView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    }
    
    @IBAction func favoriteButtonTapped(_ sender: Any) {
        if favoriteButton.imageView?.image == #imageLiteral(resourceName: "empty star") {
            favoriteButton.setImage(#imageLiteral(resourceName: "filled star"), for: .normal)
            brew.isFavorite = true
            cdStore.saveContext()
        } else if favoriteButton.imageView?.image == #imageLiteral(resourceName: "filled star") {
            favoriteButton.setImage(#imageLiteral(resourceName: "empty star"), for: .normal)
            brew.isFavorite = false
            cdStore.saveContext()
        }
    }
}
