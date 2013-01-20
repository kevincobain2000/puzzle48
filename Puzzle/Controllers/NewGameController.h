//
//  NewGameController.h
//  Puzzle
//
//  Created by Andrea Barbon on 28/04/12.
//  Copyright (c) 2012 Università degli studi di Padova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "MTAnimatedLabel.h"
#import "SEFilterControl.h"
#define IsRunningTallPhone() ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height == 568)
@class MenuController, PuzzleLibraryController;

@protocol NewGameDelegate

- (void)createNewGame;

@end

@interface NewGameController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPopoverControllerDelegate> {
    
    IBOutlet UILabel *pieceNumberLabel;
    IBOutlet UIButton *piecesLabel;
    IBOutlet UISlider *slider;
    IBOutlet UIButton *backButton;
    IBOutlet UIButton *imageButton;
    IBOutlet UIButton *cameraButton;
    IBOutlet UIButton *yourPhotosButton;
    IBOutlet UIActivityIndicatorView *indicator;
    IBOutlet UIView *loadingView;
    IBOutlet UIView *tapToSelectView;
    IBOutlet UIView *containerView;
    IBOutlet UIView *typeOfImageView;
    NSTimer *timer;
    
    int times;
    int difficultyLevel;
    AVAudioPlayer *audioPlayer;
    SEFilterControl *filter;
}

@property (nonatomic, strong) IBOutlet UIProgressView *progressView;


@property (nonatomic, strong) UIPopoverController *popover;
@property (nonatomic, strong) NSString *imagePath;
@property (nonatomic, unsafe_unretained) MenuController *delegate;
@property (nonatomic, strong) IBOutlet UIButton *startButton;
@property (nonatomic, strong) IBOutlet UIImageView *image;
@property (nonatomic, strong) IBOutlet UIView *tapToSelectLabel;
@property (nonatomic, strong) IBOutlet UIButton *puzzleLibraryButton;
@property (nonatomic, strong) IBOutlet UISlider *slider;

- (IBAction)startNewGame:(id)sender;
- (IBAction)numberSelected:(UISlider*)sender;
- (IBAction)selectImage:(id)sender;
- (void)gameStarted;
- (void)moveBar;
- (void)startLoading;
- (void)loadingFailed;
- (void)imagePickedFromPuzzleLibrary:(UIImage*)pickedImage;

@end
