//
//  PersonNavigationController.m
//  PersonList
//
//  Created by maple on 16/8/26.
//  Copyright © 2016年 maple. All rights reserved.
//

#import "PersonNavigationController.h"



@interface PersonNavigationController()<PersonTableViewControllerDelagte>
@property (nonatomic, weak) id<PersonNavigationControllerDelegate> delegate1;
@end

@implementation PersonNavigationController

- (instancetype)initWithDelegate:(id)delegate {
    PersonTableViewController *personVC = [[PersonTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    
    if (self = [super initWithRootViewController:personVC]) {
        personVC.delegate = self;
        self.delegate1 = delegate;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)personTableViewController:(PersonTableViewController *)tableView didSelect:(NSString *)result {
    if ([self.delegate1 respondsToSelector:@selector(personNavigationController:didSelect:)]) {
        [self.delegate1 personNavigationController:self didSelect:result];
    }
}



@end
