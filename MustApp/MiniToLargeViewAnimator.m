//
//  MiniToLargeViewAnimator.m
//  MustApp
//
//  Created by Максим Стегниенко on 02.05.17.
//  Copyright © 2017 Максим Стегниенко. All rights reserved.
//

#import "MiniToLargeViewAnimator.h"


static NSTimeInterval kAnimationDuration = .4f;

@implementation MiniToLargeViewAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return kAnimationDuration;
}

- (void)animatePresentingInContext:(id<UIViewControllerContextTransitioning>)transitionContext toVC:(UIViewController *)toVC fromVC:(UIViewController *)fromVC
{
 
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    CGRect fromVCRect = [transitionContext initialFrameForViewController:fromVC];
    CGRect toVCRect = fromVCRect;
    toVCRect.origin.y = toVCRect.size.height - self.initialY;
    
    toView.frame = toVCRect;
    UIView *container = [transitionContext containerView];

    
    
    UIViewController *bottomVC =  fromVC ;
    UIView *bottomPresentingView = [bottomVC view ];

    
    
    
    [container addSubview:fromView];
    [container addSubview:toView];
    
    [UIView animateWithDuration:kAnimationDuration animations:^{
        toView.frame = fromVCRect;
    
        if (self.numberOfModalVC ==0) {
        CGFloat scalingFactor =  0.92f ;
     
        bottomPresentingView.transform = CGAffineTransformScale(CGAffineTransformIdentity, scalingFactor, scalingFactor);

        bottomPresentingView.alpha = 0.2f;
        bottomPresentingView.layer.masksToBounds = YES;
        bottomPresentingView.layer.cornerRadius = 10.f;
        
        }
        if (self.numberOfModalVC ==1) {
            
         bottomPresentingView.transform = CGAffineTransformScale(bottomPresentingView.transform, 1, 0.98);
          
            
            
        }
        
     
    } completion:^(BOOL finished) {

        
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];
            
            bottomPresentingView.layer.masksToBounds = YES;
            
            bottomPresentingView.layer.cornerRadius = 0.f;
            
            if  (self.numberOfModalVC ==1) {
               bottomPresentingView.layer.cornerRadius = 10.f;
            }
        } else {
            [transitionContext completeTransition:YES];
            bottomPresentingView.layer.cornerRadius = 10.f;
        }
    }];
}

- (void)animateDismissingInContext:(id<UIViewControllerContextTransitioning>)transitionContext toVC:(UIViewController *)toVC fromVC:(UIViewController *)fromVC
{
    CGRect fromVCRect = [transitionContext initialFrameForViewController:fromVC];
    fromVCRect.origin.y = fromVCRect.size.height - self.initialY;
    
    UIView *container = [transitionContext containerView];
    [container addSubview:toVC.view];
    [container addSubview:fromVC.view];

    
    UIViewController *bottomVC = toVC;
    UIView *bottomPresentingView = [bottomVC view];
    
    bottomPresentingView.layer.masksToBounds = YES;
    bottomPresentingView.layer.cornerRadius = 10.f;

    [UIView animateWithDuration:kAnimationDuration animations:^{
        fromVC.view.frame = fromVCRect;
    
        if (self.numberOfModalVC ==0) {
        CGFloat scalingFactor =  1.0f;
 
        bottomPresentingView.transform = CGAffineTransformScale(CGAffineTransformIdentity, scalingFactor, scalingFactor);
        
        bottomPresentingView.alpha = 1;
        bottomPresentingView.layer.masksToBounds = YES;
        bottomPresentingView.layer.cornerRadius = 10.f;
        }
        if (self.numberOfModalVC ==1) {
     
             bottomPresentingView.transform = CGAffineTransformScale(bottomPresentingView.transform, 1, 1.02);
            bottomPresentingView.alpha = 1;
            bottomPresentingView.layer.masksToBounds = YES;
            bottomPresentingView.layer.cornerRadius = 10.f;
        }
        
        
        
    } completion:^(BOOL finished) {
       
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];
            bottomPresentingView.layer.masksToBounds = YES;
           bottomPresentingView.layer.cornerRadius = 10.f;
            
        } else {
            [transitionContext completeTransition:YES];
               bottomPresentingView.layer.cornerRadius = 0.f;
            
            if (self.numberOfModalVC ==1) {
                 bottomPresentingView.layer.cornerRadius = 10.f;
            }
        }
    }];
}





@end
