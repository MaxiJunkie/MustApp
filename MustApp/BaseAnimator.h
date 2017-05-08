//
//  BaseAnimator.h
//  MustApp
//
//  Created by Максим Стегниенко on 02.05.17.
//  Copyright © 2017 Максим Стегниенко. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ModalAnimatedTransitioningType) {
    ModalAnimatedTransitioningTypePresent,
    ModalAnimatedTransitioningTypeDismiss
};

@interface BaseAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic) ModalAnimatedTransitioningType transitionType;

- (void)animatePresentingInContext:(id<UIViewControllerContextTransitioning>)transitionContext toVC:(UIViewController *)toVC fromVC:(UIViewController *)fromVC;
- (void)animateDismissingInContext:(id<UIViewControllerContextTransitioning>)transitionContext toVC:(UIViewController *)toVC fromVC:(UIViewController *)fromVC;

@end
