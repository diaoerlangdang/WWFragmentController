//
//  FragmentOne.m
//  WWFragmentControllerDemo
//
//  Created by wuruizhi on 2017/3/21.
//  Copyright © 2017年 wuruizhi. All rights reserved.
//

#import "FragmentOne.h"

@interface FragmentOne ()

@end

@implementation FragmentOne

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
}

- (void)willShowFragment
{
    NSLog(@"FragmentOne 将要显示");
}

- (void)willHideFragment
{
    NSLog(@"FragmentOne 将要隐藏");
}

@end
