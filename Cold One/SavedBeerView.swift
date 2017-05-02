//
//  BeerView.swift
//  Cold One
//
//  Created by TJ Carney on 4/24/17.
//  Copyright © 2017 TJ Carney. All rights reserved.
//

import UIKit

protocol BeerDelegate {
    func reloadData()
}

class SavedBeerView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var beerNameLabel: UILabel!
    @IBOutlet weak var breweryLabel: UILabel!
    
    let cdStore = CoreDataStack.sharedInstance
    
    var delegate: BeerDelegate?
    var brew: Brew! {
        didSet {
            beerNameLabel.text = brew.name
            breweryLabel.text = brew.brewery
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
        Bundle.main.loadNibNamed("SavedBeerView", owner: self, options: nil)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        contentView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    }
    
    @IBAction func pourButtonTapped(_ sender: Any) {
        brew.isPoured = true
        brew.isSaved = false
        for state in cdStore.states {
            if brew.state == state.name {
                brew.usstate = state
            }
        }
        brew.usstate?.isFilled = true
        cdStore.saveContext()
        delegate?.reloadData()
    }
}
