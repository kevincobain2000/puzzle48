//
//  GroupView.h
//  Puzzle
//
//  Created by Andrea Barbon on 05/05/12.
//  Copyright (c) 2012 Università degli studi di Padova. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PieceView, PuzzleController;

@interface GroupView : UIView <UIGestureRecognizerDelegate>{
    
    float tempAngle;
}


@property (nonatomic, strong) PieceView *boss;
@property (nonatomic) float angle;
@property (nonatomic) BOOL isPositioned;
@property (nonatomic, strong) NSMutableArray *pieces;
@property (nonatomic, unsafe_unretained) PuzzleController *delegate;


- (void)rotate:(UIRotationGestureRecognizer*)gesture;
- (void)translateWithVector:(CGPoint)traslation;
- (void)pulse;

@end

