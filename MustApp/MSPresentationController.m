//
//  MSPresentationController.m
//  MustApp
//
//  Created by Максим Стегниенко on 06.05.17.
//  Copyright © 2017 Максим Стегниенко. All rights reserved.
//

#import "MSPresentationController.h"
#import "MiniToLargeViewAnimator.h"



@implementation MSPresentationController

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController;
{
    self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
    
    return self;
}

- (void)presentationTransitionWillBegin
{
    

    UIViewController* presentedViewController = [self presentedViewController];
 
    
    self.isPresent = YES;
  
    if (self.numberOfModalVC ==0) {
    presentedViewController.view.layer.masksToBounds = YES;
    presentedViewController.view.layer.cornerRadius = 10.f;
    }
    
 

}

- (void)dismissalTransitionWillBegin
{
   
    self.isPresent = NO;
  
 
 
}

- (void)containerViewWillLayoutSubviews
{
    if (self.numberOfModalVC ==1) {
    CGRect containerBounds = [[self containerView] bounds];
    CGRect presentedViewFrame = CGRectZero;
    presentedViewFrame.size = CGSizeMake(containerBounds.size.width, containerBounds.size.height-47.0f);
    presentedViewFrame.origin = CGPointMake(0.0f, 47.0f);
    [[[self presentingViewController]view] setFrame:presentedViewFrame] ;
    }
    
    [[self presentedView] setFrame:[self frameOfPresentedViewInContainerView]];
}


- (BOOL)shouldPresentInFullscreen
{
    if (self.numberOfModalVC ==0){
       return YES;
    }
    else {
    return YES;
    }
}
- (BOOL) shouldRemovePresentersView {
    
    if (self.isPresent && self.numberOfModalVC ==0)
    {
      
        return NO;
    }
    if (!self.isPresent && self.numberOfModalVC ==0) {
        return  YES;
    }
    
    if  (self.isPresent && self.numberOfModalVC ==1){
     
        return  YES;
    }
    if  (!self.isPresent && self.numberOfModalVC ==1){
        
        return  YES;
    }
    
    else {
      
        return  YES;
    }
}

- (CGRect)frameOfPresentedViewInContainerView
{
 
    if (self.numberOfModalVC == 0 ) {
        
        
        CGRect containerBounds = [[self containerView] bounds];
        CGRect presentedViewFrame = CGRectZero;
        presentedViewFrame.size = CGSizeMake(containerBounds.size.width, containerBounds.size.height-40.0f);
        presentedViewFrame.origin = CGPointMake(0.0f, 40.0f);
        return presentedViewFrame;
    }
    
    else {
        CGRect containerBounds = [[self containerView] bounds];
        CGRect presentedViewFrame = CGRectZero;
        presentedViewFrame.size = CGSizeMake(containerBounds.size.width, containerBounds.size.height-25.0f);
        presentedViewFrame.origin = CGPointMake(0.0f, 25.0f);
        return presentedViewFrame;
    }
}



- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
