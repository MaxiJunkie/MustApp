//
//  MSPresentationController.h
//  MustApp
//
//  Created by Максим Стегниенко on 06.05.17.
//  Copyright © 2017 Максим Стегниенко. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSPresentationController : UIPresentationController

@property (nonatomic) UIView *dimmingView;
@property (nonatomic ) BOOL isPresent;
@property (nonatomic) NSInteger numberOfModalVC;

@end
