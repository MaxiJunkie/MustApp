//
//  MSItems.h
//  MustApp
//
//  Created by Максим Стегниенко on 01.05.17.
//  Copyright © 2017 Максим Стегниенко. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIImageView;
@class UILabel;
@interface MSItems : NSObject

@property ( strong, nonatomic) UIImageView *itemImage;
@property ( strong, nonatomic) UIImageView *fullImagePersons;
@property ( strong, nonatomic) UILabel *labelOfMovie;
@property ( strong, nonatomic) UILabel *labelOfYear;
@property ( strong, nonatomic) UILabel *labelOfPerson;

@end
