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
    WWFragmentAnimationStyle _animationStyle;
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
    _animationStyle = WWFragmentAnimationStyle_None;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_currentIndex >= 0 && _fragmentArray.count>_currentIndex) {
        [_fragmentArray[_currentIndex] willShowFragment];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (_currentIndex >= 0 && _fragmentArray.count>_currentIndex) {
        [_fragmentArray[_currentIndex] willHideFragment];
    }
}


/**
 *  添加fragment,对应的index为fragmentArray的角标
 *
 *  @param fragment  添加的fragment
 *  @param frame     fragment的位置
 */
- (void)addFragment:(WWFragment *)fragment frame:(CGRect)frame
{
    fragment.view.frame = frame;
    
    //初始显示第一个fragment
    if (_fragmentArray.count == 0) {
        [self addChildViewController:fragment];
        [self.view addSubview:fragment.view];
        //第一个视图差个nav bar的高度 ??
        fragment.view.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height + 64);
        [fragment didMoveToParentViewController:self];
        
        _currentIndex = 0;
    }
    
    [_fragmentArray addObject:fragment];}

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
 *  @param newFragmentIndex     要跳转的fragment的index
 *  @param style                动画类型
 */
- (void)changeFragmentTo:(int)newFragmentIndex animations:(WWFragmentAnimationStyle)style
{
    //不执行跳转
    if (newFragmentIndex<0 || newFragmentIndex>=_fragmentArray.count || newFragmentIndex==_currentIndex) {
        return;
    }
    
    //将要隐藏的fragment
    [_fragmentArray[_currentIndex] willHideFragment];
    
    //将要显示的fragment
    [_fragmentArray[newFragmentIndex] willShowFragment];
    
    
    [self addChildViewController:_fragmentArray[newFragmentIndex]];
    
    _animationStyle = style;
    
    //开始动画
    [self startAnimation:_currentIndex new:newFragmentIndex];
    
    [self transitionFromViewController:_fragmentArray[_currentIndex] toViewController:_fragmentArray[newFragmentIndex] duration:0.3 options:UIViewAnimationOptionCurveLinear animations:^{
        
        //结束动画
        [self stopAnimation:_currentIndex new:newFragmentIndex];
        
        
    }  completion:^(BOOL finished) {
        
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

//开始动画
- (void)startAnimation:(int)oldIndex new:(int)newIndex
{
    switch (_animationStyle) {
        case WWFragmentAnimationStyle_Vertical:
            if (newIndex>oldIndex) {
                [self setFrame:_fragmentArray[newIndex] y:_fragmentArray[newIndex].view.frame.size.height];
            }
            else {
                [self setFrame:_fragmentArray[newIndex] y:-_fragmentArray[newIndex].view.frame.size.height];
            }
            
            break;
            
        case WWFragmentAnimationStyle_Horizontal:
            if (newIndex>oldIndex) {
                [self setFrame:_fragmentArray[newIndex] x:_fragmentArray[newIndex].view.frame.size.width];
            }
            else {
                [self setFrame:_fragmentArray[newIndex] x:-_fragmentArray[newIndex].view.frame.size.width];
            }
            break;
            
        default:
            break;
    }
    
    
}

//结束动画
- (void)stopAnimation:(int)oldIndex new:(int)newIndex
{
    switch (_animationStyle) {
        case WWFragmentAnimationStyle_Vertical:
            [self setFrame:_fragmentArray[newIndex] y:_fragmentArray[oldIndex].view.frame.origin.y];
            
            if (newIndex>oldIndex) {
                [self setFrame:_fragmentArray[oldIndex] y:-_fragmentArray[oldIndex].view.frame.size.height];
            }
            else {
                [self setFrame:_fragmentArray[oldIndex] y:_fragmentArray[oldIndex].view.frame.size.height];
            }
            
            break;
            
        case WWFragmentAnimationStyle_Horizontal:
            [self setFrame:_fragmentArray[newIndex] x:_fragmentArray[oldIndex].view.frame.origin.x];
            
            if (newIndex>oldIndex) {
                [self setFrame:_fragmentArray[oldIndex] x:-_fragmentArray[oldIndex].view.frame.size.width];
            }
            else {
                [self setFrame:_fragmentArray[oldIndex] x:_fragmentArray[oldIndex].view.frame.size.width];
            }
            break;
            
        default:
            break;
    }
    
}

- (void)setFrame:(WWFragment *)fragment x:(CGFloat)x
{
    CGRect frame = fragment.view.frame;
    frame.origin.x = x;
    fragment.view.frame = frame;
}

- (void)setFrame:(WWFragment *)fragment y:(CGFloat)y
{
    CGRect frame = fragment.view.frame;
    frame.origin.y = y;
    fragment.view.frame = frame;
}


@end
