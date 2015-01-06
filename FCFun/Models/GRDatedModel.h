//
//  GRDatedModel.h
//  FCFun
//
//  Created by Guilherme Rambo on 06/01/15.
//  Copyright (c) 2015 Guilherme Rambo. All rights reserved.
//

#import "FCModel.h"

/**
 @abstract
 GRDatedModel represents a model which has createdAt and updateAt attributes.
 createdAt is set to the current date/time the first time the model is saved,
 updatedAt is set to the current date/time everytime the model is saved.
 */
@interface GRDatedModel : FCModel

@property (nonatomic) NSDate *createdAt;
@property (nonatomic) NSDate *updatedAt;

@end
