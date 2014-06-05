# TableViewIconIndex

A Swift version of [GWTableIndex](https://github.com/sgwilym/GWTableIndex)

It's easy enough to give your UITableView a navigation index like the one found in iOS' Contacts app, but if you'd like a little more customisation — like custom icons instead of initials, for example — you're out of luck. What to do?!

TableViewIconIndex helps you make a UITableView Index where:

- Each navigation item can be represented with an initial or 15x15pt icon
- Each navigation item can be sorted into seperate groups
- Each group can be given a decorative 15x15pt icon as a header

Have your UITableView's datasource implement TableViewIndexDataSource and TableViewIndexDelegate protocol methods, and you're good to go.

Note: at the moment TableViewIconIndexItem’s initial property is of type ‘’String’’ rather than the preferable ‘’Character’’ as it’s the only way I could get the still-slightly-erratic Xcode6-beta to compile the Objective-C headers properly.