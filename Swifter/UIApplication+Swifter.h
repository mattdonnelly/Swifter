//
//  UIApplication+Swifter.h
//  Swifter
//
//  Created by Aditya Krishnadevan on 09/02/16.
//  Copyright © 2016 Matt Donnelly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (Swifter)
+ (nullable UIApplication *)safeSharedApplication;
- (BOOL)safeOpenURL:(nonnull NSURL *)URL;
@end
