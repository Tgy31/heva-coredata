//
//  HCHospital.h
//  HEVA Coredata
//
//  Created by Tanguy Hélesbeux on 07/12/2015.
//  Copyright © 2015 Tanguy Hélesbeux. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface HCHospital : NSManagedObject

+ (instancetype)hospitalWithName:(NSString *)name
          inManagedObjectContext:(NSManagedObjectContext *)context;

@end

NS_ASSUME_NONNULL_END

#import "HCHospital+CoreDataProperties.h"
