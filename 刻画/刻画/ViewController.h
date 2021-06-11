//
//  ViewController.h
//  刻画
//
//  Created by apple on 13-12-5.
//  Copyright (c) 2013年 suin. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface ViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>







- (IBAction)toNewAction:(id)sender;



- (IBAction)toHistoryAction:(id)sender;


- (IBAction)toSettingAction:(id)sender;







@end
