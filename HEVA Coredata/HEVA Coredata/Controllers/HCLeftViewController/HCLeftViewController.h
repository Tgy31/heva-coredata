//
//  HCLeftViewController.h
//  HEVA Coredata
//
//  Created by Tanguy Hélesbeux on 07/12/2015.
//  Copyright © 2015 Tanguy Hélesbeux. All rights reserved.
//

#import <UIKit/UIKit.h>

// Super class
#import "CoreDataTableViewController.h"

// Model
#import "HCHospital.h"

@protocol HCLeftViewControllerDelegate;

@interface HCLeftViewController : CoreDataTableViewController

@property (weak, nonatomic) id<HCLeftViewControllerDelegate> delegate;

@end

@protocol HCLeftViewControllerDelegate <NSObject>

- (void)leftViewController:(HCLeftViewController *)viewController didSelectHospital:(HCHospital *)hospital;

@end
