//
//  ViewController.m
//  PersonList
//
//  Created by maple on 16/8/26.
//  Copyright © 2016年 maple. All rights reserved.
//

#import "ViewController.h"
#import "PersonNavigationController.h"

@interface ViewController ()<PersonNavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)show:(id)sender {
    PersonNavigationController *person = [[PersonNavigationController alloc] initWithDelegate:self];
    [self presentViewController:person animated:YES completion:nil];
}

- (void)personNavigationController:(PersonNavigationController *)controller didSelect:(NSString *)string {
    self.label.text = string;
    [controller dismissViewControllerAnimated:YES completion:nil];
}
@end
