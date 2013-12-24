# SAAutoCompletingTextField

<img src="https://github.com/Shmoopi/SAAutoCompletingTextField/raw/master/AutoCompletingTextFieldDemo/SAAutoCompletingTextFieldDemo.png" alt="SAAutoCompletingTextField Screenshot" width="400" height="480" />
<img src="https://github.com/Shmoopi/SAAutoCompletingTextField/raw/master/AutoCompletingTextFieldDemo/SAAutoCompletingTextFieldDemo.gif" alt="SAAutoCompletingTextField Screenshot" width="320" height="480" />


This is a UITextField subclass that autofills the top google suggestion based on the text input.  This is designed as a textfield replacement to provide suggestions.

## Demo

Build and run the `AutoCompletingTextFieldDemo` project in Xcode to see `SAAutoCompletingTextField` in action.

## Installation

1.  Drag and drop the SAAutoCompletingTextField class files into your project, along with the [AFNetworking](https://github.com/AFNetworking/AFNetworking) and [TouchXML](https://github.com/TouchCode/TouchXML) folders (if not already included).

2.  Include the following framework in your project:
```objective-c
libxml2.dylib
```

3.  In Project > Build Settings > Header Search Paths, add this “non-recursive” directory for TouchXML:
```objective-c
/usr/include/libxml2 
```

4.  In Project > Build Phases > Compile Sources, add this Compiler Flag for all TouchXML .m files:
```objective-c
-fno-objc-arc
```

## Example Usage

Change the textfield class in IB in the Identity inspector > Custom Class field to SAAutoCompletingTextField.  Or add the textfield into your view manually with:
```objective-c
SAAutoCompletingTextField *textField = [[SAAutoCompletingTextField alloc] init];
[self.view addSubview:textField];
```

## Third Party Plugins

A big thank you to the makers of:
  * [TouchXML](https://github.com/TouchCode/TouchXML)
  * [AFNetworking](https://github.com/AFNetworking/AFNetworking)
  * [Google Suggestions](http://sugartin.info)
  * [APAutocompleteTextField](https://github.com/Antol/APAutocompleteTextField)
  
## Contact

Shmoopi LLC

  * shmoopillc@gmail.com
  * http://www.shmoopi.net/
  * [@shmoopillc](https://twitter.com/shmoopillc)

## License

Copyright © 2009-2014 Shmoopi LLC.

This class and its usage are very intuitive and provide as simple an interface as possible for developers to plug into. Please feel free to customize the class as much as you'd like, or use any of the code within your projects. If you do add to the project, make sure to let me know so we can merge any changes.

If you like what you see here, or on our website, please feel free to drop us a line or purchase one of our applications!

~Shmoopi LLC
