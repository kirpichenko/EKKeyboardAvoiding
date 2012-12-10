## EKKeyboardAvoidingScrollView

It's an universal solution that allows automatically change content inset of UIScrollView and it's subclasses. When keyboard is presented you will be able to see all content of your scroll views.


## Usage
To enable keyboard avoiding for `UIScrollView` subclasses use `EKKeyboardAvoidingScrollViewManger` class and `registerScrollViewForKeyboardAvoiding:` method to register your scroll views. 

<pre><code>UITableView *tableView = [[UITableView alloc] init];
...
[[EKKeyboardAvoidingScrollViewManger sharedInstance] registerScrollViewForKeyboardAvoiding:tableView];
</code></pre>
To disable keyboard avoiding use unregisterScrollViewFromKeyboardAvoiding: method of EKKeyboardAvoidingScrollViewManger class

<pre><code>[[EKKeyboardAvoidingScrollViewManger sharedInstance] unregisterScrollViewFromKeyboardAvoiding:tableView];
</code></pre>

You can also use `EKKeyboardAvoidingScrollView` class instead of `UIScrollView` that automatically registers objects for keyboard avoiding. If you use xib, set the scroll view's class to `EKKeyboardAvoidingScrollView`, and put all your controls within that scroll view. You can also create it programmatically, without using xibs - use `EKKeyboardAvoidingScrollView` class as a superclass for all your scroll views.

##Example
![Alt text](README/screenshot_1.png)![Alt text](README/screenshot_2.png)