//
//  LoadGameController.h
//  Puzzle
//
//  Created by Andrea Barbon on 14/05/12.
//  Copyright (c) 2012 Università degli studi di Padova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class MenuController;

@interface LoadGameController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    
    NSMutableArray *contents;
    NSDateFormatter *df;
    BOOL loading;
    
    IBOutlet UIActivityIndicatorView *indicator;
}

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext; 
@property (nonatomic, unsafe_unretained) MenuController *delegate; 
@property (nonatomic, strong) NSMutableArray *contents;
@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
- (IBAction)buttonDismissPressed:(id)sender;

- (void)reloadData;

@end
