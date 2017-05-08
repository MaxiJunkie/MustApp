//
//  BaseAnimator.m
//  MustApp
//
//  Created by Максим Стегниенко on 02.05.17.
//  Copyright © 2017 Максим Стегниенко. All rights reserved.
//

#import "BaseAnimator.h"

@implementation BaseAnimator

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *to = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *from = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    if (self.transitionType == ModalAnimatedTransitioningTypePresent) {
        [self animatePresentingInContext:transitionContext toVC:to fromVC:from];
    } else if (self.transitionType == ModalAnimatedTransitioningTypeDismiss) {
        [self animateDismissingInContext:transitionContext toVC:to fromVC:from];
    }
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    
    
    @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"%s must be overridden in a subclass/category", __PRETTY_FUNCTION__] userInfo:nil];
}

- (void)animatePresentingInContext:(id<UIViewControllerContextTransitioning>)transitionContext toVC:(UIViewController *)toVC fromVC:(UIViewController *)fromVC
{
    @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"%s must be overridden in a subclass/category", __PRETTY_FUNCTION__] userInfo:nil];
}

- (void)animateDismissingInContext:(id<UIViewControllerContextTransitioning>)transitionContext toVC:(UIViewController *)toVC fromVC:(UIViewController *)fromVC
{
    @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"%s must be overridden in a subclass/category", __PRETTY_FUNCTION__] userInfo:nil];
}
@end
