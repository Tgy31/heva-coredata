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

@interface HCSplitViewController() <HCLeftViewControllerDelegate>

@end

@implementation HCSplitViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        
        // Left VC
        HCLeftViewController *leftVC = [HCLeftViewController new];
        leftVC.delegate = self;
        UINavigationController *leftNavVC = [[UINavigationController alloc] initWithRootViewController:leftVC];
        
        // Right VC
        UIViewController *rightVC = [self rightViewControllerForHospital:nil];
        
        [self setViewControllers:@[leftNavVC, rightVC]];
        
    }
    return self;
}

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Right VC factory

- (UIViewController *)rightViewControllerForHospital:(HCHospital *)hospital {
    
    HCRightViewController *rootVC = [[HCRightViewController alloc] initWithHospital:hospital];
    return [[UINavigationController alloc] initWithRootViewController:rootVC];
}

#pragma mark - HCLeftViewControllerDelegate

- (void)leftViewController:(HCLeftViewController *)viewController didSelectHospital:(HCHospital *)hospital {
    if (hospital) {
        UIViewController *destination = [self rightViewControllerForHospital:hospital];
        [self showDetailViewController:destination sender:viewController];
    }
}

@end
