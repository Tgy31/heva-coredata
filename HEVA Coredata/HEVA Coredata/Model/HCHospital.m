//
//  HCHospital.m
//  HEVA Coredata
//
//  Created by Tanguy Hélesbeux on 07/12/2015.
//  Copyright © 2015 Tanguy Hélesbeux. All rights reserved.
//

#import "HCHospital.h"

#define CLASS_NAME_HOSPITAL @"HCHospital"

@implementation HCHospital

#pragma mark - CoreData Access

+ (instancetype)hospitalWithName:(NSString *)name
          inManagedObjectContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:CLASS_NAME_HOSPITAL];
    request.predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
    HCHospital *hospital = nil;
    
    NSError *error = nil;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if (error || !matches || [matches count] > 1) {
        NSLog(@"%@", error);
    } else {
        if ([matches count]) {
            hospital = [matches firstObject];
        } else {
            hospital = [NSEntityDescription insertNewObjectForEntityForName:CLASS_NAME_HOSPITAL inManagedObjectContext:context];
        }
        
        //TODO attributes
    }
    
    return hospital;
}

@end
