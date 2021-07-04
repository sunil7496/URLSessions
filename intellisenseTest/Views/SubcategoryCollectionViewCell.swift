//
//  SubcategoryCollectionViewCell.swift
//  intellisenseTest
//
//  Created by UttamTech on 03/07/21.
//

import UIKit

class SubcategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productSize: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var buttonView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.layer.cornerRadius = 5
        mainView.layer.borderWidth = 1.0
        mainView.layer.borderColor = UIColor.systemOrange.cgColor
        
        buttonView.layer.cornerRadius = 5
        buttonView.layer.borderWidth = 1.0
        buttonView.layer.borderColor = UIColor.systemOrange.cgColor
        
    }

}
