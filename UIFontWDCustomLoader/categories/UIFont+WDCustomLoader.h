//
//  UIFont+WDCustomLoader.h
//
//  Created by Walter Da Col on 10/17/13.
//  Copyright (c) 2013 Walter Da Col (walter.dacol<at>gmail.com)
//
//  Inspired by FlatUIKit font code (https://github.com/Grouper/FlatUIKit)
//

#import <UIKit/UIKit.h>

/**
 You can use UIFont+WDCustomLoader category to load custom font for your 
 application without caring for plist or real font name.
 */
@interface UIFont (WDCustomLoader)

/**
 Get UIFont object for the selected font
 
 Note:
 You can't use fonts with same postscript name or same filename (but different
 extensions). This library will return nil on errors so default font is used
 and you will be notified by log.
 
 @param size Font size
 @param name Font filename without extension
 @param extension Font filename extension (@"ttf",@"otf", ...)
 @return UIFont object or nil on errors
 */
+ (UIFont *)customFontOfSize:(CGFloat)size withName:(NSString *)name withExtension:(NSString *)extension;
@end
