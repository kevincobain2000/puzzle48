//
//  Puzzle.h
//  Puzzle
//
//  Created by Andrea Barbon on 13/05/12.
//  Copyright (c) 2012 Università degli studi di Padova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Image, Piece;

@interface Puzzle : NSManagedObject

@property (nonatomic, strong) NSNumber * elapsedTime;
@property (nonatomic, strong) NSDate * lastSaved;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSNumber * percentage;
@property (nonatomic, strong) NSNumber * pieceNumber;
@property (nonatomic, strong) NSNumber * moves;
@property (nonatomic, strong) NSNumber * rotations;
@property (nonatomic, strong) NSNumber * score;
@property (nonatomic, strong) Image *image;
@property (nonatomic, strong) NSSet *pieces;
@end

@interface Puzzle (CoreDataGeneratedAccessors)

- (void)addPiecesObject:(Piece *)value;
- (void)removePiecesObject:(Piece *)value;
- (void)addPieces:(NSSet *)values;
- (void)removePieces:(NSSet *)values;
@end
