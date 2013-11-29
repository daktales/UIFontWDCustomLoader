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
 You can use UIFont+WDCustomLoader category to load custom fonts for your
 application without worring about plist or real font names.
 */
@interface UIFont (WDCustomLoader)

/**
 *Will be Deprecated*
 Calls *customFontWithURL:size* method
 
 @param size Font size
 @param name Font filename without extension
 @param extension Font filename extension (@"ttf" and @"otf" are supported)
 @return UIFont object or nil on errors
 */
+ (UIFont *) customFontOfSize:(CGFloat)size withName:(NSString *)name withExtension:(NSString *)extension;

/**
 Get UIFont object for the selected font (ttf, otf)
 
 The first call of this method will register the font using 
 *registerFontFromURL* method.
 
 Note:
 This library will return nil on errors so default font is used.
 (you will be notified by log)
 
 @param fontURL Font file absolute url
 @param size Font size
 @return UIFont object or nil on errors
 */
+ (UIFont *) customFontWithURL:(NSURL *)fontURL size:(CGFloat)size;

/**
 Allow custom fonts registration.
 
 With this method you can load all supported font file: ttf, otf, ttc and otc.
 Font that are already registered, with this library or by system, will not be 
 registered and you will see a warning log.
 
 @param fontURL Font file absolute url
 @return An array of postscript name which represent the file's font(s) or nil
 on errors. (with iOS < 7 as target you will see an empty array for collections)
 */
+ (NSArray *) registerFontFromURL:(NSURL *)fontURL;



@end
