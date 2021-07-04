//
//  CategoryCollectionViewCell.swift
//  intellisenseTest
//
//  Created by UttamTech on 03/07/21.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var categoryLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainView.layer.cornerRadius = 5
        mainView.layer.borderColor = UIColor.systemOrange.cgColor
        mainView.layer.borderWidth = 1.0
    }

}
