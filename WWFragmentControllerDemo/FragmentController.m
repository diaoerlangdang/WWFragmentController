//
//  FragmentController.m
//  WWFragmentControllerDemo
//
//  Created by wuruizhi on 2017/3/21.
//  Copyright © 2017年 wuruizhi. All rights reserved.
//

#import "FragmentController.h"
#import "FragmentOne.h"
#import "FragmentTwo.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface FragmentController ()
{    
    UIButton *btn1;
    UIButton *btn2;
}

@end

@implementation FragmentController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"FragmentController";
    
    self.navigationController.navigationBar.translucent = NO;
    
    [self setButtons];
    
    [self setFragments];
}

- (void)setButtons
{
    
    btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setTitle:@"One" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(btn1Click:) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setTitleColor:[UIColor colorWithRed:0xC0/0xff green:0xC0/0xff blue:0xC0/0xff alpha:1] forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    [btn1 sizeToFit];
    btn1.frame = CGRectMake(0, 0, btn1.frame.size.width, 30);
    btn1.center = CGPointMake(SCREEN_WIDTH/4, 30/2);
    btn1.selected = true;
    [self.view addSubview:btn1];
    
    btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setTitle:@"Two" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(btn2Click:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitleColor:[UIColor colorWithRed:0xC0/0xff green:0xC0/0xff blue:0xC0/0xff alpha:1] forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    [btn2 sizeToFit];
    btn2.frame = CGRectMake(0, 0, btn2.frame.size.width, 30);
    btn2.center = CGPointMake(SCREEN_WIDTH-SCREEN_WIDTH/4, 30/2);
    btn2.selected = false;
    [self.view addSubview:btn2];
}

- (void)setFragments
{
    FragmentOne *one = [[FragmentOne alloc] init];
    [self addFragment:one frame:CGRectMake(0, 30, SCREEN_WIDTH, SCREEN_HEIGHT-30)];
    
    FragmentTwo *two = [[FragmentTwo alloc] init];
    [self addFragment:two frame:CGRectMake(0, 30, SCREEN_WIDTH, SCREEN_HEIGHT-30)];
}

- (void)btn1Click:(UIButton *)button
{
    if (button.selected) {
        return;
    }
    
    btn1.selected = true;
    btn2.selected = false;
    
    [self changeFragmentTo:0];
}

- (void)btn2Click:(UIButton *)button
{
    if (button.selected) {
        return;
    }
    
    btn1.selected = false;
    btn2.selected = true;
    
    [self changeFragmentTo:1];
}

@end
