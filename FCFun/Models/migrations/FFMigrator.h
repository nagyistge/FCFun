//
//  FFMigrator.h
//  FCFun
//
//  Created by Guilherme Rambo on 06/01/15.
//  Copyright (c) 2015 Guilherme Rambo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FFMigrator : NSObject

+ (void)migrateToLatestVersionWithCompletionHandler:(void(^)(int version, NSError *error))callback;

@end
