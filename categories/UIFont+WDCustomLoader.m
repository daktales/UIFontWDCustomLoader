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

@implementation UIFont (Custom)
+ (UIFont *) customFontOfSize:(CGFloat)size withName:(NSString *)name withExtension:(NSString *)extension{
    // Define syncronization structures
    static dispatch_once_t onceLock;
    static dispatch_once_t onceFontSet;
    static NSLock *fontSetLock = nil;
    static NSMutableSet *registeredFontSet = nil;
    
    // Return value
    UIFont *returnFont = nil;
    
    // Once lock creation
    dispatch_once(&onceLock, ^{
        fontSetLock = [[NSLock alloc] init];
    });
    
    // Begin critical section
    [fontSetLock lock];{
        // Once set creation
        dispatch_once(&onceFontSet, ^{
            registeredFontSet = [[NSMutableSet alloc] init];
        });
        
        // Test for registered fonts
        if ([registeredFontSet containsObject:name]){
            
            returnFont = [UIFont fontWithName:name size:size];
            
        } else {
            
            // Get url for font resource
            NSURL *fontUrl = [[NSBundle mainBundle] URLForResource:name withExtension:extension];
            
            // Test url
            if (fontUrl){
                
                // Begin font registration
                CFErrorRef error;
                BOOL registrationResult = YES;
                
                registrationResult = CTFontManagerRegisterFontsForURL((__bridge CFURLRef)fontUrl, kCTFontManagerScopeProcess, &error);
                
                // If registration went ok
                if (registrationResult){
                    
                    [registeredFontSet addObject:name];
                    returnFont = [UIFont fontWithName:name size:size];
                    
                } else {
                    
                    NSLog(@"Error with font registration: %@",error);
                    
                }
            }
        }
    }
    [fontSetLock unlock];
    
    
    return returnFont;
}
@end
