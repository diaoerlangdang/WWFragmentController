//
//  WWFragmentController.h
//  WWFragmentControllerDemo
//
//  Created by wuruizhi on 2017/3/21.
//  Copyright © 2017年 wuruizhi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WWFragment.h"

typedef enum : NSUInteger {
    WWFragmentAnimationStyle_None,
    WWFragmentAnimationStyle_Vertical,
    WWFragmentAnimationStyle_Horizontal,
} WWFragmentAnimationStyle;

@interface WWFragmentController : UIViewController

//fragment数组
@property(nonatomic, strong, readonly) NSMutableArray<WWFragment *> *fragmentArray;


/**
 *  添加fragment,对应的index为fragmentArray的角标
 *
 *  @param fragment  添加的fragment
 *  @param frame     fragment的位置
 */
- (void)addFragment:(WWFragment *)fragment frame:(CGRect)frame;


/**
 *  移除fragment
 *
 *  @param fragment  要移除的fragment
 */
- (void)removeFragment:(WWFragment *)fragment;


/**
 *  移除fragment
 *
 *  @param fragmentIndex  要移除的fragment的index
 */
- (void)removeFragmentWithIndex:(int)fragmentIndex;


/**
 *  跳转到新的fragment
 *
 *  @param newFragmentIndex     要跳转的fragment的index
 *  @param style                动画类型
 */
- (void)changeFragmentTo:(int)newFragmentIndex animations:(WWFragmentAnimationStyle)style;

@end
