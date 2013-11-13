//
//  UIFont+WDCustomLoader.m
//
//  Created by Walter Da Col on 10/17/13.
//  Copyright (c) 2013 Walter Da Col (walter.dacol<at>gmail.com)
//
//  Inspired by FlatUIKit font code (https://github.com/Grouper/FlatUIKit)
//

#import "UIFont+WDCustomLoader.h"
#import <CoreText/CoreText.h>

// Activate/Deactive logging only in Xcode
#ifdef DEBUG
#define UIFontWDCustomLoaderDLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define UIFontWDCustomLoaderDLog(...)
#endif

@implementation UIFont (Custom)

/**
 Read font postscript name directly from file url
 
 @param fontURL Font file URL
 */
+ (NSString *)fontNameFromFontUrl:(NSURL *)fontURL{
    // Font name
    NSString *postScriptName = nil;
    
    // Read data
    NSData *fontData = [NSData dataWithContentsOfURL:fontURL];
    
    // Check data creation
    if (fontData) {
        
        // Load font
        CGDataProviderRef fontDataProvider = CGDataProviderCreateWithCFData((CFDataRef)fontData);
        CGFontRef loadedFont = CGFontCreateWithDataProvider(fontDataProvider);
        
        // Check font
        if (loadedFont != NULL){
            
            // Read name
            postScriptName = (NSString *)CFBridgingRelease(CGFontCopyPostScriptName(loadedFont));
            
        }
        
        // Release
        CGFontRelease(loadedFont);
        CGDataProviderRelease(fontDataProvider);
    }
    
    return postScriptName;
}

+ (UIFont *) customFontOfSize:(CGFloat)size withName:(NSString *)name withExtension:(NSString *)extension{
    // Define syncronization structures
    static dispatch_once_t onceLock;
    static dispatch_once_t onceFontDict;
    static NSLock *fontSetLock = nil;
    static NSMutableDictionary *registeredFontDictionary = nil;
    
    // Return value
    UIFont *returnFont = nil;
    
    // Once lock creation
    dispatch_once(&onceLock, ^{
        fontSetLock = [[NSLock alloc] init];
    });
    
    // Begin critical section
    [fontSetLock lock];{
        // Once dict creation
        dispatch_once(&onceFontDict, ^{
            registeredFontDictionary = [[NSMutableDictionary alloc] init];
        });
        
        // Test for registered fonts
        if ([registeredFontDictionary objectForKey:name]){
            
            returnFont = [UIFont fontWithName:registeredFontDictionary[name] size:size];
            
        } else {
            
            // Get url for font resource
            NSURL *fontURL = [[NSBundle mainBundle] URLForResource:name withExtension:extension];
            
            // Test url
            if (fontURL){
                
                // Get font name
                NSString *fontName = [[self class] fontNameFromFontUrl:fontURL];
                
                // Check if font has a name (font validation too)
                if (fontName){
                    
                    // Check if font is not registered
                    if ([UIFont fontWithName:fontName size:size] == nil){
                        
                        // Begin font registration
                        CFErrorRef error;
                        BOOL registrationResult = YES;
                        
                        registrationResult = CTFontManagerRegisterFontsForURL((__bridge CFURLRef)fontURL, kCTFontManagerScopeProcess, &error);
                        
                        // If registration went ok
                        if (registrationResult){
                            
                            [registeredFontDictionary setObject:fontName forKey:name];
                            returnFont = [UIFont fontWithName:fontName size:size];
                            
                        } else {
                            
                            UIFontWDCustomLoaderDLog(@"Error with font registration: %@",error);
                            
                        }
                    } else {
                        
                        UIFontWDCustomLoaderDLog(@"Error with font registration: Font '%@' already registered",fontName);
                        
                    }
                    
                } else {
                    
                    UIFontWDCustomLoaderDLog(@"Error with font registration: File '%@' is not a Font",fontURL);
                    
                }
            } else {
                
                UIFontWDCustomLoaderDLog(@"Error with font registration: File '%@.%@' not exists",name,extension);
                
            }
        }
    }
    [fontSetLock unlock];
    
    
    return returnFont;
}
@end
