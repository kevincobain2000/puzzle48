//
//  PuzzleLibraryController.h
//  Puzzle
//
//  Created by Andrea Barbon on 10/05/12.
//  Copyright (c) 2012 Università degli studi di Padova. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewGameController;

@interface PuzzleLibraryController : UITableViewController {
    
    NSArray *contents;
    
    NSArray *thumbs;
    NSArray *paths;
}

@property (nonatomic, unsafe_unretained) NewGameController *delegate;


@end


@interface PhotoCell : UITableViewCell {
    
}

@property (nonatomic, strong) UIImageView *photo;

@end