//
//  HCRightViewController.h
//  HEVA Coredata
//
//  Created by Tanguy Hélesbeux on 07/12/2015.
//  Copyright © 2015 Tanguy Hélesbeux. All rights reserved.
//

#import <UIKit/UIKit.h>

// Model
#import "HCHospital.h"

@interface HCRightViewController : UIViewController

- (instancetype)initWithHospital:(HCHospital *)hospital;

@end
