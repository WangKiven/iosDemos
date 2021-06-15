//
//  SettingNode.m
//  POPGame
//
//  Created by Kiven Wang on 14-7-10.
//  Copyright (c) 2014年 Kiven Wang. All rights reserved.
//

#import "SettingNode.h"

#import "AboutUsController.h"
#import "Header.h"

@implementation SettingNode
- (instancetype) init
{
    self = [super init];
    if (!self) return(nil);
    
    CGSize s = [CCDirector sharedDirector].designSize;
    
    
    CCSprite *bgSprite = [CCSprite spriteWithImageNamed:@"SettingNode_kuangBtn.png"];
    bgSprite.position = ccp(s.width / 2, s.height / 2);
    [self addChild:bgSprite];
    
    
    CCButton *backBtn = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"SettingNode_backBtn.png"]];
    backBtn.name = SettingNodeBack;
    backBtn.positionType = CCPositionTypeNormalized;
    backBtn.position = ccp(0.12f, 0.92f);
    [backBtn setTarget:self selector:@selector(clickBtn:)];
    [bgSprite addChild:backBtn];
    
    
    CCButton *bgMusicBtn = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"SettingNode_bgEffectbtn.png"]];
    [bgMusicBtn setBackgroundSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"SettingNode_bgEffect_selectedbtn.png"] forState:CCControlStateSelected];
    bgMusicBtn.name = SettingNodeMusic;
    bgMusicBtn.positionType = CCPositionTypeNormalized;
    bgMusicBtn.position = ccp(0.36f, 0.745f);
    [bgMusicBtn setTarget:self selector:@selector(clickBtn:)];
    [bgSprite addChild:bgMusicBtn];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:NSUserDefaults_Music]) {
        bgMusicBtn.selected = YES;
    }
    
    
    CCButton *bgEffectBtn = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"SettingNode_bgMusicbtn.png"]];
    [bgEffectBtn setBackgroundSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"SettingNode_bgMusic_selectedbtn.png"] forState:CCControlStateSelected];
    bgEffectBtn.name = SettingNodeEffect;
    bgEffectBtn.positionType = CCPositionTypeNormalized;
    bgEffectBtn.position = ccp(0.64f, 0.745f);
    [bgEffectBtn setTarget:self selector:@selector(clickBtn:)];
    [bgSprite addChild:bgEffectBtn];
//    if (!isPlayEffect) {
//        bgEffectBtn.selected = YES;
//    }
    
    
    CCButton *aboutUsBtn = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"SettingNode_AboutmeBtn.png"]];
    aboutUsBtn.name = SettingNodeAboutUs;
    aboutUsBtn.positionType = CCPositionTypeNormalized;
    aboutUsBtn.position = ccp(0.5f, 0.5f);
    [aboutUsBtn setTarget:self selector:@selector(clickBtn:)];
    [bgSprite addChild:aboutUsBtn];
    
    
    CCButton *pingfenBtn = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"SettingNode_pingfenBtn.png"]];
    pingfenBtn.name = SettingNodePingfen;
    pingfenBtn.positionType = CCPositionTypeNormalized;
    pingfenBtn.position = ccp(0.5f, 0.255f);
    [pingfenBtn setTarget:self selector:@selector(clickBtn:)];
    [bgSprite addChild:pingfenBtn];
    
    return self;
}

- (void) clickBtn:(CCButton *) btn
{
    
    if([btn.name isEqualToString:SettingNodeMusic]){
        btn.selected = !btn.selected;
        [[NSUserDefaults standardUserDefaults] setBool:btn.selected forKey:NSUserDefaults_Music];
        
        if (!btn.selected) {
            [[OALSimpleAudio sharedInstance] playBg:@"bg.mp3" loop:YES];
        }else{
            [[OALSimpleAudio sharedInstance] stopBg];
        }
    }else if([btn.name isEqualToString:SettingNodeEffect]){
        btn.selected = !btn.selected;
        [[NSUserDefaults standardUserDefaults] setBool:btn.selected forKey:NSUserDefaults_Effect];
//        isPlayEffect = !isPlayEffect;
    }else if([btn.name isEqualToString:SettingNodeAboutUs]){
        UIViewController *vc = [[AboutUsController alloc] init];
        
        [[CCDirector sharedDirector].navigationController pushViewController:vc animated:YES];
    }else if([btn.name isEqualToString:SettingNodePingfen]){
        [self getNewVersionInfo];
    }else{
        [self removeFromParent];
    }
    
    
}

#pragma mark - 检测更新

- (void) getNewVersionInfo
{
    SKStoreProductViewController *storeCtr = [[SKStoreProductViewController alloc] init];
    
    storeCtr.delegate = self;
    
    [storeCtr loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier : @"843036474"} completionBlock:^(BOOL result, NSError *error) {
        
    }];
    
    [[CCDirector sharedDirector] presentViewController:storeCtr animated:YES completion:^{
        
    }];
}
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController
{
    [viewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}
@end
