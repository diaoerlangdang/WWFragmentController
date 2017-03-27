//
//  FragmentTwo.m
//  WWFragmentControllerDemo
//
//  Created by wuruizhi on 2017/3/21.
//  Copyright © 2017年 wuruizhi. All rights reserved.
//

#import "FragmentTwo.h"

@interface FragmentTwo ()

@end

@implementation FragmentTwo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
}

- (void)rightClicked
{
    NSLog(@"two");
}

- (void)willShowFragment
{
    NSLog(@"FragmentTwo 将要显示");
    self.parentViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"测试" style:UIBarButtonItemStylePlain target:self action:@selector(rightClicked)];
}

- (void)willHideFragment
{
    NSLog(@"FragmentTwo 将要隐藏");
}

@end
