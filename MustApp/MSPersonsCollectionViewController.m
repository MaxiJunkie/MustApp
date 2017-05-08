//
//  MSPersonsCollectionViewController.m
//  MustApp
//
//  Created by Максим Стегниенко on 08.05.17.
//  Copyright © 2017 Максим Стегниенко. All rights reserved.
//

#import "MSPersonsCollectionViewController.h"

@interface MSPersonsCollectionViewController ()

@end

@implementation MSPersonsCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor clearColor];

    UIImageView *image = [[UIImageView alloc ] initWithFrame:self.view.bounds];
 
 
    image.image = [UIImage imageNamed:@"Group 19"];
    
    
    [self.view addSubview:image];

    
    
}





@end
