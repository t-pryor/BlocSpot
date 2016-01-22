//
//  LocationCollectionViewCell.swift
//  BlocSpot
//
//  Created by Tim Pryor on 2016-01-20.
//  Copyright © 2016 Tim Pryor. All rights reserved.
//

import UIKit

class LocationCollectionViewCell: UICollectionViewCell {
    
    var label: UILabel!
    var text: String! {
        get {
            return label.text
        }
        set (newText) {
            // set label text to new text
            label.text = newText
 
        }
    }

    class func defaultFont() -> UIFont {
        return UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        label = UILabel(frame: self.contentView.bounds)
        label.opaque = false
        label.backgroundColor = UIColor(red: 0.8, green: 0.9, blue: 1.0, alpha: 1.0)
        label.textAlignment = .Center
        // if this call is made from a subclass of ContentCell, we want to actually call the subclass' override of defaultFont(), so we nned a reference to the subclass's type object-that's waht self.dynamicType gives us
        label.font = self.dynamicType.defaultFont()
        label.text = "McDonald's - Fast Food"
        contentView.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
