//
//  AppDelegate.h
//  POPGame
//
//  Created by Kiven Wang on 14-6-17.
//  Copyright Kiven Wang 2014年. All rights reserved.
//
// -----------------------------------------------------------------------

#import "cocos2d.h"
#import <StoreKit/StoreKit.h>

@interface AppDelegate : CCAppDelegate<NSURLConnectionDataDelegate, UIAlertViewDelegate, SKStoreProductViewControllerDelegate>
{
    NSMutableData *_data;
    
    NSURLConnection *_connection;
}
@end
