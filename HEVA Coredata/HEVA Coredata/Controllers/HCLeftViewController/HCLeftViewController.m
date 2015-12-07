//
//  HCLeftViewController.m
//  HEVA Coredata
//
//  Created by Tanguy Hélesbeux on 07/12/2015.
//  Copyright © 2015 Tanguy Hélesbeux. All rights reserved.
//

#import "HCLeftViewController.h"

// Model
#import "HCModelManager.h"

@interface HCLeftViewController ()

@end

@implementation HCLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Hospitals", @"Left VC title");
    
    self.fetchedResultsController = [[HCModelManager defaultModel] hospitalsFetchResultsController];
}

#pragma mark - Table view data source

- (HCHospital *)hospitalForIndexPath:(NSIndexPath *)indexPath {
    return [self.fetchedResultsController objectAtIndexPath:indexPath];
}

#define CELL_IDENTIFIER @"hospitalCell"

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    HCHospital *hospital = [self hospitalForIndexPath:indexPath];
    cell.textLabel.text = hospital.name;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self.delegate respondsToSelector:@selector(leftViewController:didSelectHospital:)]) {
        HCHospital *hospital = [self hospitalForIndexPath:indexPath];
        [self.delegate leftViewController:self didSelectHospital:hospital];
    }
}

@end
