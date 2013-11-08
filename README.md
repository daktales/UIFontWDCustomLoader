UIFontWDCustomLoader
======
You can use UIFontWDCustomLoader category to load any compatible font into your iOS projects without messing with plist or strange magic.

The only things you'll have to know are your font filename and this library name. 
##Usage
###Adding font to Project
1. Drag'n drop your font into Xcode project
2. Check "Target Membership" of your font files

If you can't see a font, check under `Build Phases > Copy Bundle Resource`: you must see the font filename listed here.

###Using font

    #import "UIFont+WDCustomLoader.h"
    …
    UIFont *myCustomFont = [UIFont customFontOfSize:18.0f withName:@"Lato-Hairline" withExtension:@"ttf"];
    …
    
*(Replace name and extension with yours)*

##Install



###Basic
Simply download it from [here](https://github.com/daktales/UIFontWDCustomLoader/archive/master.zip) and include it in your project manually.

###GIT submodule

You have the canonical `git submodule` option. Simply issue

    git submodule add https://github.com/daktales/UIFontWDCustomLoader.git <path>

in your root folder of your repository.

##License

This code is distributed under the terms and conditions of the [MIT license](LICENSE). 

##Thanks
The entire idea behind this library came after I see how FlatUIKit loads its fonts. So a big thanks over them. [Link](https://github.com/Grouper/FlatUIKit)