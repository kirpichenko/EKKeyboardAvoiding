## EKKeyboardAvoiding
It's an universal solution for keyboard avoiding that automatically changes content inset of your `UIScrollView` classes. When keyboard appears you will be able to see all content of your scroll views.

## How to install
Install using `CocoaPods`. 
<pre><code>pod 'EKKeyboardAvoiding'</code></pre>

## Usage
First import `UIScrollView+EKKeyboardAvoiding` category to your project
<pre><code>@import UIScrollView+EKKeyboardAvoiding</code></pre>

To enable keyboard avoiding you have to set `contentSize` of your scroll view and enable keyboard avoiding using category method `setKeyboardAvoidingEnabled:`
<pre><code>UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[[self view] bounds]];
[scrollView setContentSize:[scrollView frame].size];
...
[scrollView setKeyboardAvoidingEnabled:YES];
</code></pre>

To disable keyboard avoiding provide `NO` to `setKeyboardAvoidingEnabled:` method

##Example
![screenshot#1](https://github.com/kirpichenko/EKKeyboardAvoiding/raw/develop/README/screenshot_1.PNG)![screenshot#2](https://github.com/kirpichenko/EKKeyboardAvoiding/raw/develop/README/screenshot_2.PNG)

##Notes
Works on iPhone/iPad iOS 5.0+
