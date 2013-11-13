UIFontWDCustomLoader
======
You can use UIFontWDCustomLoader category to load any compatible font into your iOS projects without messing with plist, font unknown names or strange magic.

The only things you'll have to know are your font filename and this library name. 
##Usage
###Adding font to Project
1. Drag'n drop your font into Xcode project, selecting "Add to Target" when prompted.
2. Check "Target Membership" of your added font files (just to be sure).

If you can't see a font, check under `Build Phases > Copy Bundle Resource`: you must see the font filename listed here.

###Using font

    #import "UIFont+WDCustomLoader.h"
    …
    UIFont *myCustomFont = [UIFont customFontOfSize:18.0f withName:@"Lato-Hairline" withExtension:@"ttf"];
    …    

*(Replace filename and extension with yours)*

Fonts will be "saved" with postscript name so you can't use `[UIFont fontWithName:<filename> withSize:<size>]` to get them. 
**Use only this category's method or define a new one yourself.**

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