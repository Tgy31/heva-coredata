//
//  HCModelManager.m
//  HEVA Coredata
//
//  Created by Tanguy Hélesbeux on 07/12/2015.
//  Copyright © 2015 Tanguy Hélesbeux. All rights reserved.
//

#import "HCModelManager.h"

// Model
#import "HCHospital.h"

#define CSV_HEADER_SIZE 1
#define CSV_COL_INDEX_NAME 0
#define CSV_COL_INDEX_UNITCOUNT 1
#define CSV_COL_INDEX_TURNOVER 2

static HCModelManager *_defaultModel;

@interface HCModelManager()

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;


@end

@implementation HCModelManager

- (instancetype)init {
    self = [super init];
    if (self) {
        [self readCSVFile:@"exercice"];
    }
    return self;
}

#pragma mark - Singleton

+ (instancetype)defaultModel {
    if (!_defaultModel) {
        _defaultModel = [HCModelManager new];
    }
    return _defaultModel;
}

#pragma mark - Fetch results controller factory

- (NSFetchedResultsController *)hospitalsFetchResultsController {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:CLASS_NAME_HOSPITAL];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name"
                                                              ascending:YES
                                                               selector:@selector(compare:)]];
    
    return [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                               managedObjectContext:self.managedObjectContext
                                                 sectionNameKeyPath:nil
                                                          cacheName:nil];
}

#pragma mark - File utilities

- (void)readCSVFile:(NSString *)file {
    
    NSString *csvString = [self stringFromCSVFile:file];
    NSArray *lines = [csvString componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    lines = [lines subarrayWithRange:NSMakeRange(CSV_HEADER_SIZE, lines.count-1)]; // Excludes header from the computed lines
    
    // Instantiate one number formatter
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    
    // Iterate through lines to create (or update) hospitals
    for (NSString *line in lines) {
        NSArray *values = [line componentsSeparatedByString:@","];
        NSLog(@"%@", values);
        
        if (values.count > CSV_COL_INDEX_TURNOVER) {
            NSString *name = [values objectAtIndex:CSV_COL_INDEX_NAME];
            
            NSString *sUnitCount = [values objectAtIndex:CSV_COL_INDEX_UNITCOUNT];
            NSNumber *unitCount = [formatter numberFromString:sUnitCount];
            
            NSString *sTurnover = [values objectAtIndex:CSV_COL_INDEX_TURNOVER];
            NSDecimalNumber *turnover = [NSDecimalNumber decimalNumberWithString:sTurnover];
            
            [self hospitalWithName:name unitCount:unitCount turnover:turnover];
        }
    }
}

- (NSString *)stringFromCSVFile:(NSString *)file {
    NSString *path = [[NSBundle mainBundle] pathForResource:file ofType:@"csv"];
    NSError *error = nil;
    NSString *string = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    
    if (error) {
        NSLog(@"%@", error);
        return nil;
    } else {
        return string;
    }
}

- (HCHospital *)hospitalWithName:(NSString *)name unitCount:(NSNumber *)unitCount turnover:(NSDecimalNumber *)tunover {
    HCHospital *hospital = [HCHospital hospitalWithName:name inManagedObjectContext:self.managedObjectContext];
    
    hospital.unitCount = unitCount;
    hospital.turnover = tunover;
    
    return hospital;
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.helesbeux.HEVA_Coredata" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"HEVA_Coredata" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"HEVA_Coredata.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
