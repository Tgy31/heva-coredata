//
//  HCRightViewController.m
//  HEVA Coredata
//
//  Created by Tanguy Hélesbeux on 07/12/2015.
//  Copyright © 2015 Tanguy Hélesbeux. All rights reserved.
//

#import "HCRightViewController.h"

// Model
#import "HCModelManager.h"

// Views
#import "HCPieView.h"

@interface HCRightViewController ()

@property (strong, nonatomic) HCHospital *hospital;

@property (weak, nonatomic) IBOutlet HCPieView *unitPieView;
@property (weak, nonatomic) IBOutlet HCPieView *turnoverPieView;

@end

@implementation HCRightViewController

#pragma mark - Constructor

- (instancetype)initWithHospital:(HCHospital *)hospital {
    self = [super initWithNibName:@"HCRightViewController" bundle:nil];
    if (self) {
        _hospital = hospital;
    }
    return self;
}

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.hospital.name.capitalizedString;
    
    NSInteger totalUnit = [[HCModelManager defaultModel] sumOfUnitCount];
    self.unitPieView.percent = [self.hospital.unitCount floatValue] / totalUnit;
    self.unitPieView.fillColor = [UIColor redColor];
    
    NSDecimalNumber *totalTurnover = [[HCModelManager defaultModel] sumOfTurnover];
    self.turnoverPieView.percent = [[self.hospital.turnover decimalNumberByDividingBy:totalTurnover] floatValue];
    self.turnoverPieView.fillColor = [UIColor blueColor];
}

@end
