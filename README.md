## EKKeyboardAvoidingScrollView

It's an universal solution for keyboard avoiding that allows automatically change content inset of UIScrollView and it's subclasses. When keyboard is presented you will be able to see all content of your scroll views.

## How to install
If you use `CocoaPods` in your project just add it into your `Podfile`
<pre><code>pod 'EKKeyboardAvoidingScrollView'</code></pre>

If you don't use `CocoaPods` you can compile static lib and add it to your project

## Usage
To enable keyboard avoiding for `UIScrollView` subclasses use `EKKeyboardAvoidingScrollViewManager` class and `registerScrollViewForKeyboardAvoiding:` method to register your scroll views. 

<pre><code>UITableView *tableView = [[UITableView alloc] init];
...
[[EKKeyboardAvoidingScrollViewManager sharedInstance] registerScrollViewForKeyboardAvoiding:tableView];
</code></pre>
To disable keyboard avoiding use `unregisterScrollViewFromKeyboardAvoiding:` method of `EKKeyboardAvoidingScrollViewManager` class

<pre><code>[[EKKeyboardAvoidingScrollViewManager sharedInstance] unregisterScrollViewFromKeyboardAvoiding:tableView];
</code></pre>

You can also use `EKKeyboardAvoidingScrollView` class instead of `UIScrollView` that automatically registers objects for keyboard avoiding. If you use xib, set the scroll view's class to `EKKeyboardAvoidingScrollView`, and put all your controls within that scroll view. You can also create it programmatically, without using xibs - use `EKKeyboardAvoidingScrollView` class as a superclass for all your scroll views.

##Example
![screenshot#1](https://github.com/kirpichenko/EKKeyboardAvoidingScrollView/raw/develop/README/screenshot_1.PNG)![screenshot#2](https://github.com/kirpichenko/EKKeyboardAvoidingScrollView/raw/develop/README/screenshot_2.PNG)

##Notes
Works on iPhone/iPad iOS 5.0+
