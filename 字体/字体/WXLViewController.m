//
//  WXLViewController.m
//  字体
//
//  Created by Kiven Wang on 14-8-1.
//  Copyright (c) 2014年 Kiven Wang. All rights reserved.
//

#import "WXLViewController.h"

@interface WXLViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) IBOutlet UITableView *tableView;


@property (nonatomic, strong) NSArray *failyNames;

@end

@implementation WXLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.failyNames = [UIFont familyNames];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return self.failyNames.count;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [UIFont fontNamesForFamilyName:[self.failyNames objectAtIndex:section]].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *iden = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:iden];
    }
    
    NSString *failyName = [self.failyNames objectAtIndex:indexPath.section];
    NSString *fontName = [[UIFont fontNamesForFamilyName:failyName] objectAtIndex:indexPath.row];
    
    cell.textLabel.text = fontName;
    cell.textLabel.font = [UIFont fontWithName:fontName size:15];
    
    cell.detailTextLabel.text = @"杯莫停-1234-ABCD-abcd";
    cell.detailTextLabel.font = [UIFont fontWithName:fontName size:15];
    
    return cell;
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.failyNames objectAtIndex:section];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *failyName = [self.failyNames objectAtIndex:indexPath.section];
    NSString *fontName = [[UIFont fontNamesForFamilyName:failyName] objectAtIndex:indexPath.row];
    NSLog(@"%@", fontName);
}

@end
