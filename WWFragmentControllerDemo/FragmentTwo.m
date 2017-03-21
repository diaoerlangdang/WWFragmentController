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

- (void)willShowFragment
{
    NSLog(@"FragmentTwo 将要显示");
}

@end
