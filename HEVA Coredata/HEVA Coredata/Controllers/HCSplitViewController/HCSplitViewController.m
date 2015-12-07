//
//  HCSplitViewController.m
//  HEVA Coredata
//
//  Created by Tanguy Hélesbeux on 07/12/2015.
//  Copyright © 2015 Tanguy Hélesbeux. All rights reserved.
//

#import "HCSplitViewController.h"

// Controllers
#import "HCLeftViewController.h"
#import "HCRightViewController.h"

@interface HCSplitViewController ()

@end

@implementation HCSplitViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        
        // Left VC
        HCLeftViewController *leftVC = [HCLeftViewController new];
        UINavigationController *leftNavVC = [[UINavigationController alloc] initWithRootViewController:leftVC];
        
        HCRightViewController *rightVC = [HCRightViewController new];
        UINavigationController *rightNavVC = [[UINavigationController alloc] initWithRootViewController:rightVC];
        
        [self setViewControllers:@[leftNavVC, rightNavVC]];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
