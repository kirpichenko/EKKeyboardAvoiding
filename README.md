## EKKeyboardAvoiding
It's an universal solution for keyboard avoiding that allows automatically change content inset of `UIScrollView` and it's subclasses. When keyboard appears you will be able to see all content of your scroll views.

## How to install
If you use `CocoaPods` in your project just add it into your `Podfile`
<pre><code>pod 'EKKeyboardAvoiding'</code></pre>

If you don't use `CocoaPods` you can compile static lib and add it to your project or just add `EKKeyboardAvoidingScrollView` and `EKKeyboardAvoidingScrollViewManager` files into your project

## Usage
To enable keyboard avoiding set `contentSize` for your scroll and use `EKKeyboardAvoidingManager` class and `registerScrollView:` method to register and start avoiding. 

<pre><code>UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[[self view] bounds]];
[scrollView setContentSize:[scrollView frame].size];
...
[[EKKeyboardAvoidingManager sharedInstance] registerScrollView:scrollView];
</code></pre>

To disable keyboard avoiding use `unregisterScrollView:` method of `EKKeyboardAvoidingManager` class

<pre><code>[[EKKeyboardAvoidingManager sharedInstance] unregisterScrollView:scrollView];
</code></pre>

You can also use `EKKeyboardAvoidingView` class instead of `UIScrollView` that automatically registers objects for keyboard avoiding. If you use xib, set the scroll view's class as `EKKeyboardAvoidingView`, and put all your controls within that scroll view. You can also create it programmatically, without using xibs - just use `EKKeyboardAvoidingView` as a superclass for your scroll views.

##Example
![screenshot#1](https://github.com/kirpichenko/EKKeyboardAvoiding/raw/develop/README/screenshot_1.PNG)![screenshot#2](https://github.com/kirpichenko/EKKeyboardAvoiding/raw/develop/README/screenshot_2.PNG)

##Notes
Works on iPhone/iPad iOS 5.0+
