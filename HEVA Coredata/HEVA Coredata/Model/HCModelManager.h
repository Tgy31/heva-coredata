//
//  HCModelManager.h
//  HEVA Coredata
//
//  Created by Tanguy Hélesbeux on 07/12/2015.
//  Copyright © 2015 Tanguy Hélesbeux. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>

@interface HCModelManager : NSObject

+ (instancetype)defaultModel;

- (void)saveContext;

- (NSFetchedResultsController *)hospitalsFetchResultsController;
- (NSInteger)sumOfUnitCount;
- (NSDecimalNumber *)sumOfTurnover;

@end
