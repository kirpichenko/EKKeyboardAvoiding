EKKeyboardAvoidingScrollView
============================

It's an universal solution that allows automatically change content inset of UIScrollView and it's subclasses.
When keyboard you will be able to see all content of your scroll views.

Usage
==========

To enable keyboard avoiding for UIScrollView subclasses use EKKeyboardAvoidingScrollViewManger and registerScrollViewForKeyboardAvoiding method to register your scroll views. 

<code>UITableView \*tableView = [[UITableView alloc] init];
...
[[EKKeyboardAvoidingScrollViewManger sharedInstance] registerScrollViewForKeyboardAvoiding:tableView];
</code>
To disable keyboard avoiding use unregisterScrollViewFromKeyboardAvoiding method of EKKeyboardAvoidingScrollViewManger class

<code>
[[EKKeyboardAvoidingScrollViewManger sharedInstance] unregisterScrollViewFromKeyboardAvoiding:tableView];
</code>
If you need to use an object of UIScrollView class you can use EKKeyboardAvoidingScrollView class that automatically registers itself for keyboard avoiding.

