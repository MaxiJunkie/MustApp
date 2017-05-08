//
//  MiniToLargeViewInteractive.h
//  MustApp
//
//  Created by Максим Стегниенко on 02.05.17.
//  Copyright © 2017 Максим Стегниенко. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MiniToLargeViewInteractive : UIPercentDrivenInteractiveTransition

@property (nonatomic) UIViewController *viewController;
@property (nonatomic) UIViewController *presentViewController;
@property (nonatomic) UIPanGestureRecognizer *pan;




- (void)attachToViewController:(UIViewController *)viewController withView:(UIView *)view presentViewController:(UIViewController *)presentViewController;

@end
