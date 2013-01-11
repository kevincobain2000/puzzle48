//
//  iAdViewController.h
//  Puzzle
//
//  Created by Andrea Barbon on 07/06/12.
//  Copyright (c) 2012 Università degli studi di Padova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@class PuzzleController;

/*
@protocol iAdProtocol

-(void)adjustForAd:(int)direction;
-(void)fuckingRotateTo:(UIInterfaceOrientation)orientation duration:(float)suration;

@end
*/


@interface iAdViewController : UIViewController <ADBannerViewDelegate> {
    
    

}

//@property (nonatomic, assign) id<iAdProtocol> delegate;

@property (nonatomic, strong) IBOutlet ADBannerView *adBannerView;
@property (nonatomic, strong) PuzzleController *puzzle;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic) UIInterfaceOrientation prevOrientation;
@property (nonatomic) BOOL adPresent;

-(void)createAdBannerView;

@end
