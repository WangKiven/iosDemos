//
//  AppDelegate.m
//  POPGame
//
//  Created by Kiven Wang on 14-6-17.
//  Copyright Kiven Wang 2014年. All rights reserved.
//
// -----------------------------------------------------------------------

#import "AppDelegate.h"
#import "IntroScene.h"

@implementation AppDelegate

// 
-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	// This is the only app delegate method you need to implement when inheriting from CCAppDelegate.
	// This method is a good place to add one time setup code that only runs when your app is first launched.
	
	// Setup Cocos2D with reasonable defaults for everything.
	// There are a number of simple options you can change.
	// If you want more flexibility, you can configure Cocos2D yourself instead of calling setupCocos2dWithOptions:.
	[self setupCocos2dWithOptions:@{
		// Show the FPS and draw call label.
		CCSetupShowDebugStats: @(NO),
		
		// More examples of options you might want to fiddle with:
		// (See CCAppDelegate.h for more information)
		
		// Use a 16 bit color buffer: 
//		CCSetupPixelFormat: kEAGLColorFormatRGB565,
		// Use a simplified coordinate system that is shared across devices.
//		CCSetupScreenMode: CCScreenModeFixed,
		// Run in portrait mode.
		CCSetupScreenOrientation: CCScreenOrientationLandscape,
		// Run at a reduced framerate.
//		CCSetupAnimationInterval: @(1.0/30.0),
		// Run the fixed timestep extra fast.
//		CCSetupFixedUpdateInterval: @(1.0/180.0),
		// Make iPad's act like they run at a 2x content scale. (iPad retina 4x)
		CCSetupTabletScale2X: @(YES),
	}];
    
    NSLog(@"%@", NSUserName());
    NSLog(@"%@", NSHomeDirectory());
    
    [self chackUpdate];
	
	return YES;
}

-(CCScene *)startScene
{
	// This method should return the very first scene to be run when your app starts.
	return [IntroScene scene];
}

- (void) chackUpdate
{
    NSURL *url = [NSURL URLWithString:@"http://itunes.apple.com/cn/lookup"];
    
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingMacChineseSimp);
    
    NSString *postStr = @"id=791481599";
    NSData *postData = [postStr dataUsingEncoding:enc allowLossyConversion:YES];
    
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:postData];
    [req setTimeoutInterval:20];
    
    _connection = [[NSURLConnection alloc] initWithRequest:req delegate:self];
    
    [_connection start];
}


#pragma mark - NSURLConnectionDataDelegate
- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (!_data) {
        _data = [NSMutableData data];
    }
    
    [_data appendData:data];
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (!_data) {
        
        return ;
    }
    
    
    NSError *error;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:_data options:NSJSONReadingMutableLeaves error:&error];
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"读取数据失败！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }else{
        
        NSArray *ar = [dic objectForKey:@"results"];
        
        if (ar.count < 1) {
            
        }else{
            
            NSDictionary *dic2 = [ar objectAtIndex:0];
            
            NSString *version = [dic2 objectForKey:@"version"];
            
            NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
            NSString *currentVersion = [infoDict objectForKey:@"CFBundleVersion"];
            
            if ([[NSUserDefaults standardUserDefaults] floatForKey:@"Front_Chack_Version"] < version.floatValue) {
                [[NSUserDefaults standardUserDefaults] setFloat:version.floatValue forKey:@"Front_Chack_Version"];
            }else{
                return ;
            }
            
            if (currentVersion.floatValue < version.floatValue) {
                
                UIAlertView *alert;
                alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                   message:@"有新版本，是否升级！"
                                                  delegate: self
                                         cancelButtonTitle:@"取消"
                                         otherButtonTitles: @"升级", nil];
                alert.tag = 1001;
                [alert show];
            }
        }
    }
}

#pragma mark - UIAlertViewDelegate
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
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
