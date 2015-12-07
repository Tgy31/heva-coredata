//
//  HCHospital+CoreDataProperties.h
//  HEVA Coredata
//
//  Created by Tanguy Hélesbeux on 07/12/2015.
//  Copyright © 2015 Tanguy Hélesbeux. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "HCHospital.h"

NS_ASSUME_NONNULL_BEGIN

@interface HCHospital (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *unitCount;
@property (nullable, nonatomic, retain) NSDecimalNumber *turnover;

@end

NS_ASSUME_NONNULL_END
