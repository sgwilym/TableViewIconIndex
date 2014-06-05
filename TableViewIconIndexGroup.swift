//
//  TableViewIconIndexGroup.swift
//  Comique
//
//  Created by Samuel Gwilym on 5/6/14.
//  Copyright (c) 2014 Samuel Gwilym. All rights reserved.
//

import UIKit

class TableViewIconIndexGroup: UIView {

    var items: TableViewIconIndexItem[]
    var icon: UIImage?
    
    init(items: TableViewIconIndexItem[], icon: UIImage?) {
        
        self.items = items
        self.icon = icon
        super.init(frame: CGRectZero)
     
        let metrics = ["sideLength": 15, "itemSpacing": 1]
        var itemAbove: AnyObject?
        self.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        if let icon = self.icon {
            let iconImageView = UIImageView(image: icon)
            iconImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
            self.addSubview(iconImageView)
            let views = ["iconImageView": iconImageView]
            
            var constraintsToApply = NSLayoutConstraint[]()
            let horizontalConstraintFormat = "|[iconImageView(sideLength)]|"
            let verticalConstraintFormat = "V:|[iconImageView(sideLength)]"
            constraintsToApply += NSLayoutConstraint.constraintsWithVisualFormat(horizontalConstraintFormat, options: nil, metrics: metrics, views: views) as NSLayoutConstraint[]
            constraintsToApply += NSLayoutConstraint.constraintsWithVisualFormat(verticalConstraintFormat, options: nil, metrics: metrics, views: views) as NSLayoutConstraint[]
            self.addConstraints(constraintsToApply)
            
            itemAbove = iconImageView
        }
        
        var counted = 0
        for item in self.items {
            ++counted
            self.addSubview(item)
            
            var verticalConstraintFormat: String
            var viewsBindingDictionary: Dictionary<String, AnyObject>
            
            if let itemAbove: AnyObject = itemAbove {
                verticalConstraintFormat = "V:[itemAbove]-itemSpacing-[item]"
                viewsBindingDictionary = ["itemAbove": itemAbove, "item": item]
            } else {
                verticalConstraintFormat = "V:|[item]"
                viewsBindingDictionary = ["item": item]
            }
            if counted == self.items.count {
                verticalConstraintFormat += "|"
            }
            
            var horizontalConstraintFormat = "|[item]|"
            var constraintsToApply = NSLayoutConstraint[]()
            constraintsToApply += NSLayoutConstraint.constraintsWithVisualFormat(verticalConstraintFormat, options: nil, metrics: metrics, views: viewsBindingDictionary) as NSLayoutConstraint[]
            constraintsToApply += NSLayoutConstraint.constraintsWithVisualFormat(horizontalConstraintFormat, options: nil, metrics: metrics, views: viewsBindingDictionary) as NSLayoutConstraint[]
            self.addConstraints(constraintsToApply)
            
            itemAbove = item
        }

    }

}
