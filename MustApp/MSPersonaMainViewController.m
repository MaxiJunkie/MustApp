//
//  MSPersonaMainViewController.m
//  MustApp
//
//  Created by Максим Стегниенко on 02.05.17.
//  Copyright © 2017 Максим Стегниенко. All rights reserved.
//

#import "MSPersonaMainViewController.h"
#import "MiniToLargeViewAnimator.h"
#import "MiniToLargeViewInteractive.h"
#import "MSItems.h"
#import "MSPersonsCollectionViewController.h"
#import "MSPresentationController.h"
#import "DummyView.h"

@interface MSPersonaMainViewController () <UIViewControllerTransitioningDelegate>

@property (nonatomic , strong) MSItems *item;
@property (nonatomic) MSPersonsCollectionViewController *personsCollectionVC;
@property (nonatomic) MiniToLargeViewInteractive *presentInteractor;
@property (nonatomic) MiniToLargeViewInteractive *dismissInteractor;
@property (nonatomic, weak) UIView *dummyView;
@end

static CGFloat kButtonHeight = 50.f;

@implementation MSPersonaMainViewController {
  }

- (instancetype)initWithData:(MSItems *) item
{
    self = [super init];
    if (self) {
        self.item = item;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
  

   
    UIImageView *image = [[UIImageView alloc ] initWithFrame:self.view.bounds];
    
    image = self.item.fullImagePersons;
   
    UIImageView * shadowImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 319, 375, 242)];
    
    shadowImage.image = [UIImage imageNamed:@"Shadow"];
    
    
    [self.view addSubview:image];
    
       self.view.backgroundColor = [UIColor blackColor];
   
    
    
    
    DummyView *dummyView = [[DummyView alloc] init];
    dummyView.translatesAutoresizingMaskIntoConstraints = NO;
    [dummyView.button addTarget:self action:@selector(bottomButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dummyView];
    
    [dummyView addConstraint:[NSLayoutConstraint constraintWithItem:dummyView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:kButtonHeight]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:dummyView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:dummyView.superview attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:dummyView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:dummyView.superview attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:dummyView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:dummyView.superview attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    
    self.dummyView = dummyView;
    
    self.personsCollectionVC = [[MSPersonsCollectionViewController alloc] init];
    
    self.personsCollectionVC.transitioningDelegate = self;
   
    self.personsCollectionVC.modalPresentationStyle = UIModalPresentationCustom;
    
    self.presentInteractor = [[MiniToLargeViewInteractive alloc] init];
    [self.presentInteractor attachToViewController:self withView:dummyView presentViewController:self.personsCollectionVC];
    self.dismissInteractor = [[MiniToLargeViewInteractive alloc] init];
    [self.dismissInteractor attachToViewController:self.personsCollectionVC withView:self.personsCollectionVC.view presentViewController:nil];
    

    
}

- (void)bottomButtonTapped
{
    self.disableInteractivePlayerTransitioning = YES;
    [self presentViewController:self.personsCollectionVC animated:YES completion:^{
        self.disableInteractivePlayerTransitioning = NO;
    }];
}


- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    
    MSPresentationController *presentedVC = [[MSPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    
    presentedVC.numberOfModalVC = 1;
    
    return presentedVC;
}


- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    
    MiniToLargeViewAnimator *animator = [[MiniToLargeViewAnimator alloc] init];
    animator.initialY = kButtonHeight;
    animator.transitionType = ModalAnimatedTransitioningTypeDismiss;
    animator.numberOfModalVC = 1;
    return animator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    MiniToLargeViewAnimator *animator = [[MiniToLargeViewAnimator alloc] init];
    animator.initialY = kButtonHeight;
    animator.transitionType = ModalAnimatedTransitioningTypePresent;
    animator.numberOfModalVC = 1;
    return animator;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator
{
    if (self.disableInteractivePlayerTransitioning) {
        return nil;
    }
    return self.presentInteractor;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator
{
    if (self.disableInteractivePlayerTransitioning) {
        return nil;
    }
    return self.dismissInteractor;
}


@end
