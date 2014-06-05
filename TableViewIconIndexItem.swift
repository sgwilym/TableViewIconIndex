//
//  TableViewIconIndexItem.swift
//  Comique
//
//  Created by Samuel Gwilym on 4/6/14.
//  Copyright (c) 2014 Samuel Gwilym. All rights reserved.
//

import UIKit

@objc class TableViewIconIndexItem : UIView {
    
    var icon: UIImage?
    var initial: String? = "?"
    var indexPath: NSIndexPath
    
    init(icon: UIImage?, initial: String?, indexPath: NSIndexPath) {
        
        // Set properties
        self.icon = icon
        if let initial = initial {
            self.initial = initial
        }
        self.initial = initial
        self.indexPath = indexPath
        super.init(frame: CGRectZero)
        
        // Set up the views
        let metrics = ["sideLength" : 15]
        var views: Dictionary<String, AnyObject>
        if let icon = self.icon {
            let indexIconView = UIImageView(image: icon)
            indexIconView.setTranslatesAutoresizingMaskIntoConstraints(false)
            self.addSubview(indexIconView)
            views = ["indexIconView" : indexIconView]
        } else {
            let indexIconView = UILabel()
            if self.initial == nil {
                self.initial = "?"
            }
            indexIconView.text = self.initial!
            indexIconView.textAlignment = .Center
            indexIconView.font = UIFont.boldSystemFontOfSize(12)
            indexIconView.setTranslatesAutoresizingMaskIntoConstraints(false)
            self.addSubview(indexIconView)
            views = ["indexIconView" : indexIconView]
        }
        
        // Set up constraints
        var constraintsToApply = NSLayoutConstraint[]()
        let horizontalConstraintFormat = "|[indexIconView(sideLength)]|"
        let verticalConstraintFormat = "V:|[indexIconView(sideLength)]|"
        constraintsToApply += NSLayoutConstraint.constraintsWithVisualFormat(horizontalConstraintFormat, options: nil, metrics: metrics, views: views) as NSLayoutConstraint[]
        constraintsToApply += NSLayoutConstraint.constraintsWithVisualFormat(verticalConstraintFormat, options: nil, metrics: metrics, views: views) as NSLayoutConstraint[]
        self.addConstraints(constraintsToApply)

        self.setTranslatesAutoresizingMaskIntoConstraints(false)
    }
    
}