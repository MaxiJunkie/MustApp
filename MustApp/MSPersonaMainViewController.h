//
//  MSPersonaMainViewController.h
//  MustApp
//
//  Created by Максим Стегниенко on 02.05.17.
//  Copyright © 2017 Максим Стегниенко. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ViewController.h"

@class MSItems;

@interface MSPersonaMainViewController : UIViewController

@property (nonatomic) BOOL disableInteractivePlayerTransitioning;
- (instancetype)initWithData:(MSItems *)item;

@end
