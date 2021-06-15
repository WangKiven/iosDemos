//
//  SettingNode.h
//  POPGame
//
//  Created by Kiven Wang on 14-7-10.
//  Copyright (c) 2014年 Kiven Wang. All rights reserved.
//

#import "CCAlterNode.h"

#import <StoreKit/StoreKit.h>

#define SettingNodeBack @"SettingNodeBack"
#define SettingNodeMusic @"SettingNodeMusic"
#define SettingNodeEffect @"SettingNodeEffect"
#define SettingNodeAboutUs @"SettingNodeAboutUs"
#define SettingNodePingfen @"SettingNodePingfen"
@interface SettingNode : CCAlterNode<SKStoreProductViewControllerDelegate>

@end
