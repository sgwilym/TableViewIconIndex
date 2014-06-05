//
//  TableViewIconIndex.swift
//  Comique
//
//  Created by Samuel Gwilym on 5/6/14.
//  Copyright (c) 2014 Samuel Gwilym. All rights reserved.
//

import UIKit

@objc protocol TableViewIconIndexDataSource {
    func indexGroups() -> TableViewIconIndexGroup[]
}

@objc protocol TableViewIconIndexDelegate {
    func jumpToSectionWithIndexPath(indexPath: NSIndexPath)
}

@objc class TableViewIconIndex: UIView {

    var dataSource: TableViewIconIndexDataSource?
    var delegate: TableViewIconIndexDelegate?
    var indexGroups: TableViewIconIndexGroup[]?
    
    init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }
    
    func reloadIndex() {
        for subview: AnyObject in self.subviews {
            subview.removeFromSuperview()
        }
        
        self.indexGroups = dataSource!.indexGroups()
        self.layoutIndexGroups()
    }
    
    func layoutIndexGroups() {
        
        let indexGroupsCenteredView = UIView(frame: CGRectZero)
        self.addSubview(indexGroupsCenteredView)
        
        var constraintsToApply = NSLayoutConstraint[]()
        let horizontalConstraintFormat = "|[indexGroupsCenteredView]"
        let views = ["indexGroupsCenteredView": indexGroupsCenteredView]
        constraintsToApply.append(NSLayoutConstraint(item: indexGroupsCenteredView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0))
        constraintsToApply += NSLayoutConstraint.constraintsWithVisualFormat(horizontalConstraintFormat, options: nil, metrics: nil, views: views) as NSLayoutConstraint[]
        
        self.addConstraints(constraintsToApply)
        
        var groupAbove: TableViewIconIndexGroup?
        for (index, group) in enumerate(indexGroups!) {
            indexGroupsCenteredView.addSubview(group)
            var verticalConstraintFormat: String
            var views: Dictionary<String, AnyObject>
            var metrics = ["groupSpacing": 10, "rightSpacing": 1]
            if let groupAbove = groupAbove {
                verticalConstraintFormat = "V:[groupAbove]-groupSpacing-[group]"
                views = ["groupAbove": groupAbove, "group": group]
            } else {
                verticalConstraintFormat = "V:|-groupSpacing-[group]"
                views = ["group": group]
            }
            if index == indexGroups!.count - 1{
                verticalConstraintFormat += "|"
            }
            let horizontalConstraintFormat = "|[group]-rightSpacing-|"
            
            var constraintsToApply = NSLayoutConstraint[]()
            constraintsToApply += NSLayoutConstraint.constraintsWithVisualFormat(verticalConstraintFormat, options: nil, metrics: metrics, views: views) as NSLayoutConstraint[]
            constraintsToApply += NSLayoutConstraint.constraintsWithVisualFormat(horizontalConstraintFormat, options: nil, metrics: metrics, views: views) as NSLayoutConstraint[]
            
            indexGroupsCenteredView.addConstraints(constraintsToApply)
            groupAbove = group
            group.setTranslatesAutoresizingMaskIntoConstraints(false)
        }
        
        self.setTranslatesAutoresizingMaskIntoConstraints(false)
        indexGroupsCenteredView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
    }
    
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
        let item = self.hitTest(touches.anyObject().locationInView(self), withEvent: nil)
        if item.isKindOfClass(TableViewIconIndexItem) {
            let indexItem = item as TableViewIconIndexItem
            self.delegate!.jumpToSectionWithIndexPath(indexItem.indexPath)
        }
    }
    
    override func touchesMoved(touches: NSSet!, withEvent event: UIEvent!) {
        self.touchesBegan(touches, withEvent: event)
    }
    
}
