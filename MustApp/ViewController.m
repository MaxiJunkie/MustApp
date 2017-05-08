//
//  ViewController.m
//  MustApp
//
//  Created by Максим Стегниенко on 25.04.17.
//  Copyright © 2017 Максим Стегниенко. All rights reserved.
//

#import "ViewController.h"
#import "HMSegmentedControl.h"
#import "MSCollectionViewCell.h"
#import "MSItems.h"
#import "MSPersonaMainViewController.h"
#import "MiniToLargeViewAnimator.h"
#import "MiniToLargeViewInteractive.h"
#import "MSPresentationController.h"



static CGFloat kButtonHeight = 50.f;

@interface ViewController () <UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UIPopoverPresentationControllerDelegate,UIViewControllerTransitioningDelegate>

@property (nonatomic) MiniToLargeViewInteractive *presentInteractor;
@property (nonatomic) MiniToLargeViewInteractive *dismissInteractor;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) HMSegmentedControl *segmentedControl4;
@property (nonatomic,strong) MSPersonaMainViewController *nextViewController;

@property (nonatomic , strong) UICollectionView *collectionViewForMovies;
@property (nonatomic , strong) UICollectionView *collectionViewForPersons;
@property (nonatomic , strong) NSMutableArray *itemsArray;
@property (nonatomic , strong) NSMutableArray *personsArray;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic , assign) BOOL isModal;

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
  
    //[self setNeedsStatusBarAppearanceUpdate];
    self.isModal = NO;
    
    CGRect rect = CGRectMake(0, 0, self.view.bounds.size.width , 86);
    
    UIView *view = [[UIView alloc] initWithFrame:rect];
    
    view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:view];
    
    CGRect searchRect = CGRectMake(0, 39.5, self.view.bounds.size.width , 29);
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:searchRect];
    self.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    
    
    
    [self.searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"Search Bar"] forState:UIControlStateNormal];
    self.searchBar.showsCancelButton = YES;
    UITextField *textField = [self.searchBar valueForKey:@"_searchField"];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    UIColor *colourOfTextCancelButton = [UIColor colorWithRed:74.f/255.f green:74.f/255.f blue:74.f/255.f alpha:1];
    
    [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTintColor:colourOfTextCancelButton];
    
    UIImageView *imgView = [ [UIImageView alloc] initWithImage:[UIImage imageNamed:@"Search"]];
    imgView.frame = CGRectMake(0.0, 0.0, imgView.image.size.width+4.0, imgView.image.size.height);
    imgView.contentMode = UIViewContentModeLeft;
   
    textField.placeholder  = @"Movies and TV shows";
    
    [textField setLeftViewMode:UITextFieldViewModeAlways];
    [textField setLeftView:imgView];
    
   
    
    
    [view addSubview:self.searchBar];
    
    
    
    
    CGFloat viewWidth = CGRectGetWidth(self.view.frame);
    
    self.segmentedControl4 = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, 86.5, 165.5, 40)];
    self.segmentedControl4.sectionTitles = @[@"Movies", @"Persons"];
    self.segmentedControl4.selectionIndicatorHeight = 1.0f;
    self.segmentedControl4.selectedSegmentIndex = 0;
    self.segmentedControl4.backgroundColor = [UIColor colorWithRed:245.f/255.f green:245.f/255.f blue:245.f/255.f alpha:0];
   
    UIView *viewOfBackgroundControl = [[UIView alloc ] initWithFrame:CGRectMake(0, 86.5, self.view.bounds.size.width, 40)];
    
    viewOfBackgroundControl.backgroundColor = [UIColor colorWithRed:250.f/255.f green:250.f/255.f blue:250.f/255.f alpha:1];
    viewOfBackgroundControl.layer.borderWidth = 1;
    viewOfBackgroundControl.layer.borderColor = [[UIColor colorWithRed:230.f/255.f green:230.f/255.f blue:230.f/255.f alpha:1] CGColor];
    
    
    
    [self.view addSubview:viewOfBackgroundControl];
    
    
    self.segmentedControl4.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithRed:163.f/255.f green:161.f/255.f blue:161.f/255.f alpha:1]};
    self.segmentedControl4.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor]};
    self.segmentedControl4.selectionIndicatorColor = [UIColor blackColor];
    self.segmentedControl4.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    self.segmentedControl4.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentedControl4.tag = 3;
    
   
    __weak typeof(self) weakSelf = self;
    [self.segmentedControl4 setIndexChangeBlock:^(NSInteger index) {
       
        [weakSelf.scrollView scrollRectToVisible:CGRectMake(viewWidth * index, 0, viewWidth, 325) animated:YES];
    }];
   
    [self.view addSubview:self.segmentedControl4];
    
    
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 126, viewWidth,self.view.frame.size.height - 126)];
    self.scrollView.backgroundColor = [UIColor colorWithRed:250.f/255.f green:250.f/255.f blue:250.f/255.f alpha:1];
    
    self.scrollView.layer.borderWidth = 1;
    self.scrollView.layer.borderColor = [[UIColor colorWithRed:230.f/255.f green:230.f/255.f blue:230.f/255.f alpha:1] CGColor];
    
    
    self.scrollView.scrollEnabled = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(viewWidth * 2, self.view.frame.size.height - 126);
    self.scrollView.delegate = self;
   
    [self.view addSubview:self.scrollView];

    
    
    // init a collectionView For Movies
    
    
     UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    self.collectionViewForMovies = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 20, viewWidth, 325) collectionViewLayout:layout];
    
    
    self.collectionViewForMovies.delegate = self;
    self.collectionViewForMovies.dataSource = self;
    
    [self.collectionViewForMovies setShowsHorizontalScrollIndicator:NO];
    [self.collectionViewForMovies registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifierMovies"];
    [self.collectionViewForMovies setBackgroundColor:[UIColor colorWithRed:250.f/255.f green:250.f/255.f blue:250.f/255.f alpha:1]];
    
    [self.scrollView addSubview:self.collectionViewForMovies];
    
    
    
    // init a collectionView For Persons
    
    UICollectionViewFlowLayout *layout1=[[UICollectionViewFlowLayout alloc] init];
    [layout1 setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    self.collectionViewForPersons = [[UICollectionView alloc] initWithFrame:CGRectMake(viewWidth, 30, viewWidth, 295) collectionViewLayout:layout1];
    
    self.collectionViewForPersons.delegate = self;
    self.collectionViewForPersons.dataSource = self;
    
    [self.collectionViewForPersons setShowsHorizontalScrollIndicator:NO];
    [self.collectionViewForPersons registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifierPersons"];
    [self.collectionViewForPersons setBackgroundColor:[UIColor colorWithRed:250.f/255.f green:250.f/255.f blue:250.f/255.f alpha:1]];
    
    [self.scrollView addSubview:self.collectionViewForPersons];
   
  
 
}


- (void)viewWillAppear:(BOOL)animated {
  
    
    [self.searchBar resignFirstResponder];
    
    //Test images for Movies
    
    self.itemsArray = [NSMutableArray array];
    
    MSItems *item1 = [[MSItems alloc] init];
    MSItems *item2 = [[MSItems alloc] init];
    MSItems *item3 = [[MSItems alloc] init];
    MSItems *item4 = [[MSItems alloc] init];
    
    item1.itemImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Rectangle 5"]];
    
    item1.labelOfMovie = [[UILabel alloc] initWithFrame:CGRectMake(9, 205, 110, 12)];
    item1.labelOfMovie.text = @"La la land";
    [self setApperanceForLabel:item1.labelOfMovie];
    
    item1.labelOfYear = [[UILabel alloc] initWithFrame:CGRectMake(9, 220, 110, 12)];
    item1.labelOfYear.text = @"2007";
    [self setApperanceForLabel:item1.labelOfYear];
    item1.labelOfYear.textColor = [UIColor colorWithRed:163.f/255.f green:161.f/255.f blue:161.f/255.f alpha:1];
    
    item2.labelOfMovie = [[UILabel alloc] initWithFrame:CGRectMake(9, 205, 110, 12)];
    item2.itemImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Rectangle 4"]];
    [self setApperanceForLabel:item2.labelOfMovie];
    item2.labelOfMovie.text = @"La la land";
    item2.labelOfYear = [[UILabel alloc] initWithFrame:CGRectMake(9, 220, 110, 12)];
    item2.labelOfYear.text = @"2007";
    [self setApperanceForLabel:item2.labelOfYear];
    item2.labelOfYear.textColor = [UIColor colorWithRed:163.f/255.f green:161.f/255.f blue:161.f/255.f alpha:1];
    
    item3.labelOfMovie = [[UILabel alloc] initWithFrame:CGRectMake(9, 205, 110, 12)];
    item3.itemImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Rectangle 3"]];
    [self setApperanceForLabel:item3.labelOfMovie];
    item3.labelOfMovie.text = @"La la land";
    
    item3.labelOfYear = [[UILabel alloc] initWithFrame:CGRectMake(9, 220, 110, 12)];
    item3.labelOfYear.text = @"2007";
    [self setApperanceForLabel:item3.labelOfYear];
    item3.labelOfYear.textColor = [UIColor colorWithRed:163.f/255.f green:161.f/255.f blue:161.f/255.f alpha:1];
    
    item4.labelOfMovie = [[UILabel alloc] initWithFrame:CGRectMake(9, 205, 110, 12)];
    item4.itemImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Rectangle 5"]];
    [self setApperanceForLabel:item4.labelOfMovie];
    item4.labelOfMovie.text = @"La la land";
    
    item4.labelOfYear = [[UILabel alloc] initWithFrame:CGRectMake(9, 220, 110, 12)];
    item4.labelOfYear.text = @"2007";
    [self setApperanceForLabel:item4.labelOfYear];
    item4.labelOfYear.textColor = [UIColor colorWithRed:163.f/255.f green:161.f/255.f blue:161.f/255.f alpha:1];
    
    [self.itemsArray insertObject:item1 atIndex:0];
    [self.itemsArray insertObject:item2 atIndex:1];
    [self.itemsArray insertObject:item3 atIndex:2];
    [self.itemsArray insertObject:item4 atIndex:3];
    
    
    //Test fot Persons
    
    self.personsArray = [NSMutableArray array];
    
    MSItems *item5 = [[MSItems alloc] init];
    MSItems *item6 = [[MSItems alloc] init];
    MSItems *item7 = [[MSItems alloc] init];
    MSItems *item8 = [[MSItems alloc] init];
    
    
    item5.itemImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Oval"]];
    item5.fullImagePersons = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Defoo"]];
    
    item5.labelOfPerson = [[UILabel alloc] initWithFrame:CGRectMake(16, 135, 90, 28)];
    item5.labelOfPerson.text = @"Chris Pratt";
    [self setApperanceForLabel:item5.labelOfPerson];
    
    item6.itemImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Oval2"]];
    item6.fullImagePersons = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Defoo"]];
    
    item6.labelOfPerson = [[UILabel alloc] initWithFrame:CGRectMake(16, 135, 90, 28)];
    item6.labelOfPerson.text = @"Willem Dafoe";
    [self setApperanceForLabel:item6.labelOfPerson];
    
    
    
    item7.itemImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Oval3"]];
    item7.fullImagePersons = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Defoo"]];
    
    item7.labelOfPerson = [[UILabel alloc] initWithFrame:CGRectMake(16, 135, 90, 28)];
    item7.labelOfPerson.text = @"Willem Dafoe";
    [self setApperanceForLabel:item7.labelOfPerson];
    
    
    item8.itemImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Oval"]];
    item8.fullImagePersons = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Defoo"]];
    
    item8.labelOfPerson = [[UILabel alloc] initWithFrame:CGRectMake(16, 135, 90, 28)];
    item8.labelOfPerson.text = @"Willem Dafoe";
    [self setApperanceForLabel:item8.labelOfPerson];
    
    
    [self.personsArray insertObject:item5 atIndex:0];
    [self.personsArray insertObject:item6 atIndex:1];
    [self.personsArray insertObject:item7 atIndex:2];
    [self.personsArray insertObject:item8 atIndex:3];
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    self.isModal = NO;
    [self.searchBar becomeFirstResponder];
    
    
}


- (void)setApperanceForLabel:(UILabel *)label {
    
    UIColor *color = [UIColor colorWithRed:250.f/255.f green:250.f/255.f blue:250.f/255.f alpha:1];
    label.backgroundColor = color;
    label.textColor = [UIColor colorWithRed:30.f/255.f green:30.f/255.f blue:30.f/255.f alpha:1];
    label.font = [UIFont systemFontOfSize:12.0f];
    label.textAlignment = NSTextAlignmentCenter;
    
    
    
}




#pragma mark -  UICollectionViewDelegate 

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  
    if ([collectionView isEqual:self.collectionViewForPersons]) {
     
        
        self.view.layer.shouldRasterize = YES;
        self.view.layer.rasterizationScale = [UIScreen mainScreen].scale;
        
        
        MSItems *person = [[MSItems alloc] init];
        
        person = [self.personsArray objectAtIndex:indexPath.row];
        
        MSPersonaMainViewController *container = [[MSPersonaMainViewController alloc] initWithData:person];
  
         container.modalPresentationStyle = UIModalPresentationCustom;
        container.transitioningDelegate = self;
        
        self.dismissInteractor = [[MiniToLargeViewInteractive alloc] init];
        [self.dismissInteractor attachToViewController:container withView:container.view presentViewController:nil];
        
        self.disableInteractivePlayerTransitioning = YES;
    
        
    
        [self presentViewController:container animated:YES completion: ^{
            self.disableInteractivePlayerTransitioning = NO;
             self.isModal = YES;
        }];
        
    
        
        
    }
    
}



#pragma mark -  UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.collectionViewForMovies) {
    
    return [self.itemsArray count];
    }
    else {
        return [self.personsArray count];
    }
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifierForMovies  =@"cellIdentifierMovies";
    static NSString *identifierForPersons  =@"cellIdentifierPersons";
    
    if ([collectionView isEqual:self.collectionViewForMovies]) {
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:identifierForMovies forIndexPath:indexPath];
   
    MSItems* item = [self.itemsArray objectAtIndex:indexPath.row];
    
    item.itemImage.layer.masksToBounds = YES;
    item.itemImage.layer.cornerRadius = 5.0;
    
    [cell.contentView addSubview:item.itemImage];
    [cell.contentView addSubview:item.labelOfMovie];
    [cell.contentView addSubview:item.labelOfYear];
    return cell;
    }
    
    if ([collectionView isEqual:self.collectionViewForPersons]) {
        
        UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:identifierForPersons forIndexPath:indexPath];
        
        MSItems* item = [self.personsArray objectAtIndex:indexPath.row];
        
        item.itemImage.layer.masksToBounds = YES;
        item.itemImage.layer.cornerRadius = 60.0;
        
        [cell.contentView addSubview:item.itemImage];
        [cell.contentView addSubview:item.labelOfPerson];
     
        
        return cell;
    }
    
    return nil;
    
}

#pragma mark -  UICollectionViewDelegateFlowLayout


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([collectionView isEqual:self.collectionViewForMovies]) {
    return CGSizeMake(130, 232);
        
    }
    else {
         return CGSizeMake(120, 163);
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return  20.0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if ([collectionView isEqual:self.collectionViewForMovies]) {
    UIEdgeInsets titleInsets = UIEdgeInsetsMake(40.0, 20.0, 50.0, 20.0);
    return  titleInsets;
    
    }
    else {
        UIEdgeInsets titleInsets = UIEdgeInsetsMake(30.0, 20.0, 60.0, 20.0);
        return  titleInsets;
    }
}



- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    // Here, we'll provide the presentation controller to be used for the presentation
    
    MSPresentationController *presentedVC = [[MSPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    
    presentedVC.numberOfModalVC = 0;
    
    return presentedVC;
}




- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    
    MiniToLargeViewAnimator *animator = [[MiniToLargeViewAnimator alloc] init];
    animator.initialY = kButtonHeight;
    animator.transitionType = ModalAnimatedTransitioningTypeDismiss;
    animator.numberOfModalVC = 0;
    return animator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    MiniToLargeViewAnimator *animator = [[MiniToLargeViewAnimator alloc] init];
    animator.initialY = kButtonHeight;
    animator.transitionType = ModalAnimatedTransitioningTypePresent;
    animator.numberOfModalVC = 0;
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


- (UIStatusBarStyle)preferredStatusBarStyle
{
    
    if (self.isModal) {
      return UIStatusBarStyleLightContent;
    }
    else {
         return UIStatusBarStyleDefault;
    }
    
}

@end
