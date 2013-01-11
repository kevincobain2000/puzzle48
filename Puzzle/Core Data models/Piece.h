//
//  Piece.h
//  Puzzle
//
//  Created by Andrea Barbon on 03/05/12.
//  Copyright (c) 2012 Università degli studi di Padova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Image, Puzzle;

@interface Piece : NSManagedObject

@property (nonatomic, strong) NSNumber * angle;
@property (nonatomic, strong) NSNumber * edge0;
@property (nonatomic, strong) NSNumber * edge1;
@property (nonatomic, strong) NSNumber * edge2;
@property (nonatomic, strong) NSNumber * edge3;
@property (nonatomic, strong) NSNumber * isFree;
@property (nonatomic, strong) NSNumber * number;
@property (nonatomic, strong) NSNumber * position;
@property (nonatomic, strong) NSNumber * moves;
@property (nonatomic, strong) NSNumber * rotations;
@property (nonatomic, strong) Image *image;
@property (nonatomic, strong) Puzzle *puzzle;


- (BOOL) isFreeScalar;
- (void) setisFreeScalar:(BOOL)isFree_;

@end
