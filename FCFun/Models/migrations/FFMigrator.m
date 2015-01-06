//
//  FFMigrator.m
//  FCFun
//
//  Created by Guilherme Rambo on 06/01/15.
//  Copyright (c) 2015 Guilherme Rambo. All rights reserved.
//

#import "FFMigrator.h"

#import <FCModel/FCModel.h>

@implementation FFMigrator

+ (void)migrateToLatestVersionWithCompletionHandler:(void(^)(int version, NSError *error))callback
{
    [FCModel openDatabaseAtPath:[self standardDatabasePath] withSchemaBuilder:^(FMDatabase *db, int *schemaVersion) {
        [db beginTransaction];
        
        void (^failedAt)(int statement) = ^(int statement){
            int lastErrorCode = db.lastErrorCode;
            NSString *lastErrorMessage = db.lastErrorMessage;
            [db rollback];
            
            return callback(*schemaVersion, [NSError errorWithDomain:@"ffmigrator" code:lastErrorCode userInfo:@{NSLocalizedDescriptionKey: lastErrorMessage}]);
        };
        
        // executes every migration with a version greater than the current schema version, in order
        NSArray *migrationFiles = [self migrationFiles];
        for (NSString *migrationFile in migrationFiles) {
            int fileVersion = [[migrationFile stringByDeletingPathExtension] intValue];
            if (*schemaVersion > fileVersion) continue;
            
            NSString *file = [[NSBundle mainBundle] pathForResource:migrationFile.stringByDeletingPathExtension ofType:migrationFile.pathExtension];
            if (![db executeUpdate:[NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil]]) failedAt(1);
            *schemaVersion += 1;
        }
        
        [db commit];
        
        callback(*schemaVersion, nil);
    }];
}

#pragma mark Helper Methods

+ (NSArray *)migrationFiles
{
    NSMutableDictionary *files = [NSMutableDictionary new];
    
    // find every sql file inside the app's resources
    NSDirectoryEnumerator *enumerator = [[NSFileManager defaultManager] enumeratorAtPath:[[NSBundle mainBundle] resourcePath]];
    NSString *file;
    while ((file = [enumerator nextObject])) {
        if (![file.pathExtension isEqualToString:@"sql"]) continue;
        
        NSNumber *version = @([[file stringByDeletingPathExtension] intValue]);
        [files setObject:file forKey:version];
    }
    
    // order the files by number (0.sql, 1.sql...)
    NSArray *sortedKeys = [files.allKeys sortedArrayUsingSelector:@selector(compare:)];
    NSMutableArray *sortedFiles = [[NSMutableArray alloc] initWithCapacity:sortedKeys.count];
    for (NSNumber *key in sortedKeys) {
        [sortedFiles addObject:files[key]];
    }
    
    return [sortedFiles copy];
}

+ (NSString *)standardDatabasePath
{
    NSString *supportPath = [[NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"FCFun"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:supportPath]) {
        NSError *error;
        [[NSFileManager defaultManager] createDirectoryAtPath:supportPath withIntermediateDirectories:NO attributes:nil error:&error];
        assert(error == nil);
    }

    return [NSString pathWithComponents:@[supportPath, @"testDB.sqlite3"]];
}

@end
