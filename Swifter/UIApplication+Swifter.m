//
//  UIApplication+Swifter.m
//  Swifter
//
//  Created by Aditya Krishnadevan on 09/02/16.
//  Copyright © 2016 Matt Donnelly. All rights reserved.
//

#import "UIApplication+Swifter.h"

@import ObjectiveC;

@implementation UIApplication (Swifter)

+ (BOOL)isRunningInAppExtension {
    // Apple's docs clearly mention that app extensions have the .appex suffix
    return [[NSBundle mainBundle].bundlePath hasSuffix:@".appex"];
}

+ (UIApplication *)safeSharedApplication {
    if ([[self class] isRunningInAppExtension]) {
        return nil;
    }
    SEL sharedAppSelector = @selector(sharedApplication);
    
    UIApplication *(*sharedAppMsgSend)(id, SEL) = (void *)objc_msgSend;
    
    return sharedAppMsgSend([UIApplication class], sharedAppSelector);
}

- (BOOL)safeOpenURL:(nonnull NSURL *)URL {
    if ([[self class] isRunningInAppExtension]) {
        return NO;
    }
    
    BOOL (*openURLMsgSend)(id, SEL, NSURL *) = (void *)objc_msgSend;
    
    UIApplication *sharedApp = [[self class] safeSharedApplication];
    return openURLMsgSend(sharedApp, @selector(openURL:), URL);
}

@end
