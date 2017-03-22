//
//  WWFragment.h
//  WWFragmentControllerDemo
//
//  Created by wuruizhi on 2017/3/21.
//  Copyright © 2017年 wuruizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WWFragment : UIViewController


/**
 *  将要显示fragment，子类可继承实现
 */
- (void)willShowFragment;

/**
 *  将要隐藏fragment，子类可继承实现
 */
- (void)willHideFragment;

@end
