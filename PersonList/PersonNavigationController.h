//
//  PersonNavigationController.h
//  PersonList
//
//  Created by maple on 16/8/26.
//  Copyright © 2016年 maple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonTableViewController.h"

@class PersonNavigationController;
@protocol PersonNavigationControllerDelegate <NSObject>

- (void)personNavigationController:(PersonNavigationController *)controller didSelect:(NSString *)string;

@end

@interface PersonNavigationController : UINavigationController

- (instancetype)initWithDelegate:(id)delegate;


@end
