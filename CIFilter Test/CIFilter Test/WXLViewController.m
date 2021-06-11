//
//  WXLViewController.m
//  CIFilter Test
//
//  Created by Kiven Wang on 14-4-13.
//  Copyright (c) 2014年 Kiven Wang. All rights reserved.
//

#import "WXLViewController.h"
#import "WXLFilterPhotoViewController.h"
#import "NSString+MyExtern.h"

@interface WXLViewController ()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
{
    NSArray *properties;
    
    NSArray *curArray;
    
    IBOutlet UITableView *tableView;
    
    IBOutlet UISwitch *switchBtn;
}

@end

@implementation WXLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
//    NSMutableString *mStr = [NSMutableString stringWithString:@"本机可用过滤器及其相关可用属性：\n"];
    
    properties = [CIFilter filterNamesInCategory: kCICategoryBuiltIn];
    
    curArray = properties;
//    NSLog(@"%@", properties);
//    [mStr appendString:properties.description];
//    [mStr appendString:@"\n"];
//    [mStr appendString:@"\n"];
//    for (NSString *filterName in properties) {
//        CIFilter *fltr = [CIFilter filterWithName:filterName];
//        NSLog(@"%@", [fltr attributes]);
//        [mStr appendString:filterName];
//        [mStr appendString:@"::"];
//        [mStr appendString:@"\n"];
//        [mStr appendString:fltr.attributes.description];
//        [mStr appendString:@"\n"];
//        [mStr appendString:@"\n"];
//    }
}


- (void) showFilterMessage:(NSInteger) flag
{
    [tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:flag inSection:0] animated:NO scrollPosition:UITableViewScrollPositionMiddle];
}

- (void) showFilterMessageWithName:(NSString *) filterName
{
    NSInteger i = [curArray indexOfObject:filterName];
    if (i >= 0) {
        
        [tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0] animated:NO scrollPosition:UITableViewScrollPositionMiddle];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return curArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *iden;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:iden];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%D::%@",indexPath.row,[curArray objectAtIndex:indexPath.row]];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView1 didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (switchBtn.on) {
        WXLFilterPhotoViewController *ctr = [self.tabBarController.viewControllers objectAtIndex:0];
//        [ctr setFilter:indexPath.row];
        [ctr setfilter:[curArray objectAtIndex:indexPath.row]];
        
        self.navigationController.tabBarController.selectedIndex = 0;
    }else{
        
        CIFilter *fltr = [CIFilter filterWithName:[curArray objectAtIndex:indexPath.row]];
        
        UITextView *textView = [[UITextView alloc] init];
        textView.text = fltr.attributes.description;
        textView.editable = NO;
        
        UIViewController *viewCtr = [[UIViewController alloc] init];
        viewCtr.title = [curArray objectAtIndex:indexPath.row];
        viewCtr.view = textView;
        
        [self.navigationController pushViewController:viewCtr animated:YES];
        
        
        NSLog(@"%@",textView.text);
    }
    
}




- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    [self searchBar:searchBar textDidChange:nil];
    
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    curArray = properties;
    
    [tableView reloadData];
    
    [searchBar resignFirstResponder];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSMutableArray *ar = [NSMutableArray array];
    
    NSInteger i = 0;
    for (NSString *str in properties) {
        
        if ([str containsSubString1:searchBar.text]) {
            
            [ar addObject:str];
        }
        
        i++;
    }
    
    curArray = ar;
    
    [tableView reloadData];
    
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    switch (selectedScope) {
        case 0:
        {
            properties = [CIFilter filterNamesInCategory: kCICategoryBuiltIn];
        }
            break;
        case 1:
        {
            properties = [CIFilter filterNamesInCategory: kCICategoryStillImage];
        }
            break;
        case 2:
        {
            properties = [CIFilter filterNamesInCategory: kCICategoryVideo];
        }
            break;
            
        default:
            break;
    }
    
    [self searchBarSearchButtonClicked:searchBar];
}
@end
