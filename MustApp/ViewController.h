//
//  ViewController.h
//  MustApp
//
//  Created by Максим Стегниенко on 25.04.17.
//  Copyright © 2017 Максим Стегниенко. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController 

@property (nonatomic) BOOL disableInteractivePlayerTransitioning;
@property (nonatomic) id<UIViewControllerTransitioningDelegate> transitioningDelegate;


@end

