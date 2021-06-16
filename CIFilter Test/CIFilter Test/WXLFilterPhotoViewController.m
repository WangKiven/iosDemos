//
//  WXLFilterPhotoViewController.m
//  CIFilter Test
//
//  Created by Kiven Wang on 14-4-13.
//  Copyright (c) 2014年 Kiven Wang. All rights reserved.
//

#import "WXLFilterPhotoViewController.h"
#import "WXLSliderTableView.h"
#import "WXLViewController.h"
#import <CoreImage/CoreImage.h>

@interface WXLFilterPhotoViewController ()<WXLSliderTableViewDelegate>
{
    NSArray *properties;
    NSInteger ii;
    
    
    CIFilter *filter;
}

@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *textLabel_detail;
@property (strong, nonatomic) IBOutlet WXLSliderTableView *tableView;

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, strong) CIContext *context;

@end

@implementation WXLFilterPhotoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.image = [UIImage imageNamed:@"testImage"];
    
    
    properties = [CIFilter filterNamesInCategory: kCICategoryBuiltIn];
    
    
    
    
    self.context = [CIContext contextWithOptions:nil];
    
    ii = COUNT - 1;
    [self filterImage:ii];
    
    
    self.tableView.sliderDelegate = self;
    
    //-------------------------
    NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    for (NSString *fn in properties) {
        
        filter = [CIFilter filterWithName:fn];
        NSDictionary *dic = filter.attributes;
        
        for (NSString *key in dic) {
            
            
            NSArray *array = mdic.allKeys;
            
            if (![array containsObject:key]) {
                
                id obj = [dic objectForKey:key];
                if ([obj isKindOfClass:[NSDictionary class]]) {
                    
                    NSDictionary *subDic = obj;
                    
                    NSString *className = [subDic objectForKey:@"CIAttributeClass"];
                    
                    [mdic setObject:className forKey:key];
                }else{
                    [mdic setObject:obj forKey:key];
                }
            }
        }
    }
    NSLog(@"%@",mdic);
    NSMutableArray *aar = [NSMutableArray array];
    for (NSString *key in mdic) {
        id obj = [mdic objectForKey:key];
        if (![aar containsObject:obj]) {
            [aar addObject:obj];
        }
    }
    NSLog(@"%@",aar);
    //---------------------------
}

- (IBAction) showAttribute:(id)sender
{
    UINavigationController *nva = [self.tabBarController.viewControllers objectAtIndex:1];
    WXLViewController *ctr = [nva.viewControllers objectAtIndex:0];
//    [ctr showFilterMessage:ii];
    [ctr showFilterMessageWithName:properties[ii]];
    
    [self.tabBarController setSelectedIndex:1];
}

- (IBAction)showYuanTu:(id)sender {
    UIButton *bu = sender;
    
    if (bu.tag == 10) {
        
        self.imageView.image = self.image;
        bu.tag = 11;
    }else{
        [self showFilterImage];
        bu.tag = 10;
    }
}


- (void) setFilter:(NSInteger) flag
{
    ii = flag;
    
    [self filterImage:ii];
}

- (void) setfilter:(NSString *) filterName
{
    NSInteger i = [properties indexOfObject:filterName];
    if (i >= 0) {
        ii = i;
        [self filterImage:ii];
    }
}

- (IBAction) jian:(id)sender
{
    ii--;
    if (ii < 0) {
        ii = COUNT - 1;
    }
    [self filterImage:ii];
}

- (IBAction) add:(id)sender
{
    ii++;
    if (ii >= COUNT) {
        ii = 0;
    }
    [self filterImage:ii];
}

- (void) filterImage:(NSInteger) i
{
    NSLog(@"%@\n",properties[ii]);
    [self.tableView clearData];
    
    self.textLabel_detail.text = [NSString stringWithFormat:@"%d::%@\n",ii,properties[ii]];
    
    CIImage *beginImage = [CIImage imageWithCGImage:self.image.CGImage];
    CIImage *backGroundImage = [CIImage imageWithCGImage:[UIImage imageNamed:@"testImage5"].CGImage];
    CIImage *maskImage = [CIImage imageWithCGImage:[UIImage imageNamed:@"testImage2"].CGImage];
    
    filter = [CIFilter filterWithName:properties[ii]];
    
    NSDictionary *dic = filter.attributes;
    
    NSLog(@"%@",dic);
    
    for (NSString *key in dic) {
        id obj = [dic objectForKey:key];
        
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSDictionary *subDic = obj;
            
            NSString *className = [subDic objectForKey:@"CIAttributeClass"];
            
            if ([className isEqualToString:@"NSNumber"]) {
                NSNumber *minValue = [subDic objectForKey:@"CIAttributeSliderMin"];
                NSNumber *maxValue = [subDic objectForKey:@"CIAttributeSliderMax"];
                NSNumber *defaultValue = [subDic objectForKey:@"CIAttributeDefault"];
                
                if (minValue == 0 && maxValue == 0) {
                    minValue = [subDic objectForKey:@"CIAttributeMin"];
                    maxValue = [subDic objectForKey:@"CIAttributeMax"];
                }
                
                
                [self.tableView addData:key MinValue:minValue.floatValue MaxValue:maxValue.floatValue CurValue:defaultValue.floatValue];
            }
        }
        
        if ([key isEqualToString:@"inputImage"]) {
            [filter setValue:beginImage forKey:kCIInputImageKey];
        }
        
        if ([key isEqualToString:@"inputBackgroundImage"]) {
            [filter setValue:backGroundImage forKey:@"inputBackgroundImage"];
        }
        
        if ([key isEqualToString:@"inputTargetImage"]) {
            [filter setValue:backGroundImage forKey:@"inputTargetImage"];
        }
        
        if ([key isEqualToString:@"inputMaskImage"]) {
            [filter setValue:maskImage forKey:@"inputMaskImage"];
        }
        
        if ([key isEqualToString:@"inputTransform"]) {
            CGAffineTransform transform = CGAffineTransformMakeScale(0.5, 0.33);
            [filter setValue:[NSValue valueWithBytes:&transform objCType:@encode(CGAffineTransform)] forKey:@"inputTransform"];
        }
        
        if ([key isEqualToString:@"inputColor0"]) {
            [filter setValue:[CIColor colorWithRed:0.35 green:0.71 blue:0.62 alpha:0.6] forKey:@"inputColor0"];
        }
        
        if ([key isEqualToString:@"inputColor1"]) {
            [filter setValue:[CIColor colorWithRed:0.03 green:0.44 blue:0.84 alpha:1] forKey:@"inputColor1"];
        }
        
        if ([key isEqualToString:@"inputColor"]) {
            [filter setValue:[CIColor colorWithCGColor:[UIColor blueColor].CGColor] forKey:@"inputColor"];
        }
        
        if ([key isEqualToString:@"inputGradientImage"]) {
            [filter setValue:[CIImage imageWithCGImage:[UIImage imageNamed:@"testImage4"].CGImage] forKey:@"inputGradientImage"];
        }
        
        if ([key isEqualToString:@"inputRectangle"]) {
            [filter setValue:[CIVector vectorWithCGRect:CGRectMake(20, 20, 100, 200)] forKey:@"inputRectangle"];
        }
        
        if ([key isEqualToString:@"inputText"]) {
            NSShadow *shadow = [[NSShadow alloc]init];
                shadow.shadowOffset = CGSizeMake(5, 5);     // 影子偏移量
                shadow.shadowColor = [UIColor blueColor];   // 影子颜色
                shadow.shadowBlurRadius = 20.0;             // 模糊程度
                  
                  
                NSDictionary *dict = @{
                                       NSFontAttributeName:[UIFont fontWithName:@"Marion-Italic" size:50.0],
                                       NSShadowAttributeName:shadow,
                                       NSKernAttributeName:@(2)
                                       };
//            [filter setValue:@"Kiven最帅，☺️" forKey:@"inputText"];
            [filter setValue:[[NSAttributedString alloc]initWithString:@"Kiven最帅，☺️\n明天吃鸡" attributes:dict] forKey:@"inputText"];
        }
    }
    
    [self showFilterImage];
    
    [self.tableView reloadData];
}

- (void) showFilterImage
{
    // 得到过滤后的图片
    CIImage *outputImage = [filter outputImage];
    // 转换图片, 创建基于GPU的CIContext对象
    CGImageRef cgimg;
    
    CGRect ff = [outputImage extent];
    
    if (ff.origin.x <= 0) {
        ff = [[CIImage imageWithCGImage:self.image.CGImage] extent];
    }
    
    cgimg = [self.context createCGImage:outputImage fromRect:ff];
    
//    if (ii == 9 || ii == 22) {
//        cgimg = [self.context createCGImage:outputImage fromRect:CGRectMake(10, 10, 300, 300)];
//    }else if(ii == 1 || ii == 2 || ii == 10 || ii == 30 || ii == 35 || ii == 36 || ii == 37 || ii == 41){
//        cgimg = [self.context createCGImage:outputImage fromRect:[[CIImage imageWithCGImage:self.image.CGImage] extent]];
//    }else{
//        cgimg = [self.context createCGImage:outputImage fromRect:[outputImage extent]];
//    }
    
    UIImage *newImg = [UIImage imageWithCGImage:cgimg];
    // 显示图片
    [self.imageView setImage:newImg];
    // 释放C对象
    CGImageRelease(cgimg);
}

#pragma mark - degate

- (void) tableView:(WXLSliderTableView *)tableView attribute:(NSString *)attributeName changedValue:(CGFloat)changedValue
{
    
    if (ii == 15) {
        return ;
    }
    
    if (filter) {
        
        [filter setValue:[NSNumber numberWithFloat:changedValue] forKey:attributeName];
        
        [self showFilterImage];
        
    }
}

@end
