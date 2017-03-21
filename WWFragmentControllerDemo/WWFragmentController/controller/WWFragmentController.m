//
//  WWFragmentController.m
//  WWFragmentControllerDemo
//
//  Created by wuruizhi on 2017/3/21.
//  Copyright © 2017年 wuruizhi. All rights reserved.
//

#import "WWFragmentController.h"

@interface WWFragmentController ()
{
    int _currentIndex;
}

@end

@implementation WWFragmentController


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initData];
    }
    
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initData];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initData];
    }
    
    return self;
}


- (void)initData
{
    _fragmentArray = [NSMutableArray array];
    _currentIndex = -1;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


/**
 *  添加fragment,对应的index为fragmentArray的角标
 *
 *  @param fragment  添加的fragment
 *  @param frame     fragment的位置
 */
- (void)addFragment:(WWFragment *)fragment frame:(CGRect)frame
{
    //初始显示第一个fragment
    if (_fragmentArray.count == 0) {
        [self addChildViewController:fragment];
        [self.view addSubview:fragment.view];
        _currentIndex = 0;
    }
    fragment.view.frame = frame;
    [fragment didMoveToParentViewController:self];
    
    [_fragmentArray addObject:fragment];
}

/**
 *  移除fragment
 *
 *  @param fragment  要移除的fragment
 */
- (void)removeFragment:(WWFragment *)fragment
{
    [fragment willMoveToParentViewController:nil];
    [fragment removeFromParentViewController];
    
    [_fragmentArray removeObject:fragment];
}


/**
 *  移除fragment
 *
 *  @param fragmentIndex  要移除的fragment的index
 */
- (void)removeFragmentWithIndex:(int)fragmentIndex
{
    if (fragmentIndex<0 || fragmentIndex>=_fragmentArray.count) {
        return ;
    }
    
    [_fragmentArray[fragmentIndex] willMoveToParentViewController:nil];
    [_fragmentArray[fragmentIndex] removeFromParentViewController];
    
    [_fragmentArray removeObjectAtIndex:fragmentIndex];
}


/**
 *  跳转到新的fragment
 *
 *  @param newFragmentIndex  要跳转的fragment的index
 */
- (void)changeFragmentTo:(int)newFragmentIndex
{
    //不执行跳转
    if (newFragmentIndex<0 || newFragmentIndex>=_fragmentArray.count || newFragmentIndex==_currentIndex) {
        return;
    }
    
    //将要显示的fragment
    [_fragmentArray[newFragmentIndex] willShowFragment];
    
    [self addChildViewController:_fragmentArray[newFragmentIndex]];
    
    [self transitionFromViewController:_fragmentArray[_currentIndex] toViewController:_fragmentArray[newFragmentIndex] duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
        
        if (finished) {
            
            //完成新fragment添加
            [_fragmentArray[newFragmentIndex] didMoveToParentViewController:self];
            
            //移除旧fragment
            [_fragmentArray[_currentIndex] willMoveToParentViewController:nil];
            [_fragmentArray[_currentIndex] removeFromParentViewController];
            
            //改变index
            _currentIndex = newFragmentIndex;
            
        }
        
    }];
}


@end
