//
//  AppDelegate.h
//  rsb
//
//  Created by Ulf Hjohlman on 2018-07-16.
//  Copyright © 2018 Ulf Hjohlman. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GoogleSignIn;

@interface AppDelegate : UIResponder <UIApplicationDelegate, GIDSignInDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

