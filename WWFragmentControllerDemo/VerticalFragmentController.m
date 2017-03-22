//
//  VerticalFragmentController.m
//  WWFragmentControllerDemo
//
//  Created by wuruizhi on 2017/3/22.
//  Copyright © 2017年 wuruizhi. All rights reserved.
//

#import "VerticalFragmentController.h"
#import "FragmentOne.h"
#import "FragmentTwo.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height-64

#define TABLE_VIEW_WIDTH    100

@interface VerticalFragmentController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray<NSString *> *_titleArray;
    
    UITableView *_tableView;
}

@end

@implementation VerticalFragmentController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    _titleArray = [@[@"one", @"two", @"three"] mutableCopy];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, TABLE_VIEW_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    [_tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    
    CGRect rect = CGRectMake(TABLE_VIEW_WIDTH+5, 0, SCREEN_WIDTH-TABLE_VIEW_WIDTH+5, SCREEN_HEIGHT);
    FragmentOne *one = [[FragmentOne alloc] init];
    [self addFragment:one frame:rect];
    
    FragmentTwo *two = [[FragmentTwo alloc] init];
    [self addFragment:two frame:rect];
    
    FragmentOne *three = [[FragmentOne alloc] init];
    three.title = @"three";
    three.view.backgroundColor = [UIColor blueColor];
    [self addFragment:three frame:rect];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return _titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor lightGrayColor];
    }
    
    cell.textLabel.text = _titleArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self changeFragmentTo:(int)indexPath.row animations:WWFragmentAnimationStyle_Vertical];
}



@end
