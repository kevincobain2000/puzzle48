//
//  Image.h
//  Puzzle
//
//  Created by Andrea Barbon on 13/05/12.
//  Copyright (c) 2012 Università degli studi di Padova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Piece, Puzzle;

@interface Image : NSManagedObject

@property (nonatomic, strong) NSData * data;
@property (nonatomic, strong) Piece *piece;
@property (nonatomic, strong) Puzzle *puzzle;

@end
