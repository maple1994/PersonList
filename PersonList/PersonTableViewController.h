//
//  PersonTableViewController.h
//  PersonList
//
//  Created by maple on 16/8/26.
//  Copyright © 2016年 maple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PersonTableViewController;
@protocol PersonTableViewControllerDelagte <NSObject>

- (void)personTableViewController:(PersonTableViewController *)tableView didSelect:(NSString *)result;

@end

@interface PersonTableViewController : UITableViewController

/// 为排序前的数据
@property (nonatomic, strong) NSArray *stringsToSort;
@property (nonatomic, weak) id<PersonTableViewControllerDelagte> delegate;

@end
