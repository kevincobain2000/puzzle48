//
//  PuzzleController.h
//  Puzzle
//
//  Created by Andrea Barbon on 19/04/12.
//  Copyright (c) 2012 Università degli studi di Padova. All rights reserved.
//


#define IF_IPAD if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IF_IPHONE if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define HIDE_STATUS_BAR IF_IPAD [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:YES];
#define SHOW_STATUS_BAR IF_IPAD [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:YES];

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVAudioPlayer.h>
#import <MediaPlayer/MediaPlayer.h>
#import "UIImage+CWAdditions.h"

#import "PieceView.h"
#import "MenuController.h"
#import "PuzzleCompletedController.h"
#import "Lattice.h"
#import "Piece.h"
#import "Puzzle.h"
#import "Image.h"
#import "CreatePuzzleOperation.h"
#import "iAdViewController.h"

#define QUALITY 1.5

#define PIECE_SIZE_IPAD 180
#define PIECE_SIZE_IPHONE 75



@interface PuzzleController : iAdViewController <UIGestureRecognizerDelegate, PieceViewProtocol, MenuProtocol, CreatePuzzleDelegate, UIAlertViewDelegate> {
 
    
    BOOL swiping;
    BOOL didRotate;
    BOOL receivedFirstTouch;
    BOOL loadingGame;
    BOOL panningMode;
    BOOL panningDrawerUP;
    BOOL loadingFailed;
        
    CGPoint drawerFirstPoint;
    
    IBOutlet UIStepper *stepper;
    IBOutlet UIView *stepperDrawer;
    IBOutlet UIButton *restartButton;
    IBOutlet UILabel *percentageLabel;
    IBOutlet UILabel *scoreLabel;
    
    IBOutlet UIView *HUDView;
    IBOutlet UIView *firstPointView;


    
    NSArray *directions_positions;
    NSArray *directions_numbers;
    
    UIAlertView *alertView;

    
    int numberOfPiecesInDrawer;
    
    int DrawerPosition;
    int firstPiecePlace;
    
    float drawerSize;
    float drawerMargin;

    float biggerPieceSize;
    float screenWidth;
    float screenHeight;

    NSTimer *timer;
    
    PieceView *movingPiece;
    
    AVAudioPlayer *audioPlayer;
    AVAudioPlayer *audioPlayerGameFinished;
    
}


@property(nonatomic) float piceSize;
@property(nonatomic) float elapsedTime;
@property(nonatomic) int NumberSquare;
@property(nonatomic) float padding;

@property(nonatomic) int pieceNumber;
@property(nonatomic) int loadedPieces;
@property(nonatomic) int missedPieces;
@property(nonatomic) int imageSize;
@property(nonatomic) int moves;
@property(nonatomic) int rotations;
@property(nonatomic) int score;

@property(nonatomic) BOOL loadingGame;
@property(nonatomic) BOOL creatingGame;
@property(nonatomic) BOOL puzzleCompete;
@property(nonatomic) BOOL drawerStopped;
@property(nonatomic) BOOL duringGame;

- (IBAction)buttonInfoPressed:(id)sender;


@property (nonatomic, strong) AVAudioPlayer *positionedSound;
@property (nonatomic, strong) AVAudioPlayer *completedSound;
@property (nonatomic, strong) AVAudioPlayer *neighborSound;

@property (strong, nonatomic) IBOutlet UIButton *buttonMenuOutlet;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;


@property (nonatomic, strong, readonly) NSOperationQueue *operationQueue;

@property (nonatomic,strong) CreatePuzzleOperation *puzzleOperation;
@property (nonatomic,strong) Puzzle *puzzleDB;


@property (nonatomic, strong) IBOutlet UIView *drawerView;
@property (nonatomic, strong) IBOutlet UIView *menuButtonView;
@property (nonatomic, strong) IBOutlet UIImageView *puzzleCompleteImage;
@property (nonatomic, strong) IBOutlet UILabel *elapsedTimeLabel;;
@property (nonatomic, strong) IBOutlet UIButton *panningSwitch;


@property (nonatomic, strong) NSMutableArray *pieces;
@property (nonatomic, strong) NSMutableArray *groups;
@property (nonatomic, strong) Lattice *lattice;
@property (nonatomic, strong) UIPanGestureRecognizer *pan;
@property (nonatomic, strong) UIPanGestureRecognizer *panDrawer;
@property (nonatomic, strong) UIPinchGestureRecognizer *pinch;


@property (nonatomic, strong) MenuController *menu;
@property (nonatomic, strong) PuzzleCompletedController *completedController;
@property (nonatomic,strong) UIViewController *adViewController;


@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *imageViewLattice;




+ (float)computeFloat:(float)f modulo:(float)m;
- (NSMutableArray*)shuffleArray:(NSMutableArray*)array;

- (void)fuckingRotateTo:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration;

- (BOOL)pieceIsOut:(PieceView *)piece;
- (PieceView*)pieceWithNumber:(int)j;
- (PieceView*)pieceWithPosition:(int)j;
- (int)positionOfPiece:(PieceView*)piece;

- (void)toggleImageWithDuration:(float)duration;

- (IBAction)restartPuzzle:(id)sender;
- (IBAction)scrollDrawerRight:(id)sender;
- (IBAction)scrollDrawerLeft:(id)sender;
- (IBAction)togglePanningMode:(id)sender;
- (IBAction)puzzleCompleted;
- (IBAction)toggleMenu:(id)sender;

- (void)loadPuzzle:(Puzzle*)puzzleDB;
- (BOOL)drawerStoppedShouldBeStopped;
- (Puzzle*)lastSavedPuzzle;
- (void)prepareForNewPuzzle;
- (void)prepareForLoading;

- (CGRect)frameOfLatticePiece:(int)i;

- (UIView*)upperPositionedThing;

- (void)panDrawer:(UIPanGestureRecognizer*)gesture;
- (void)pan:(UIPanGestureRecognizer*)gesture;

- (BOOL)pieceIsOut:(PieceView*)piece;
- (void)movePiece:(PieceView*)piece toLatticePoint:(int)i animated:(BOOL)animated;
- (void)groupMoved:(GroupView*)group;


- (void)startNewGame;
- (void)print_free_memory;
- (void)removeOldPieces;

- (void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view;

- (void)adjustForAd:(int)direction;


- (void)allPiecesLoaded;
- (Piece*)pieceOfCurrentPuzzleDB:(int)n;

- (void)startTimer;
- (void)stopTimer;

- (void)loadingFailed;

- (void)puzzleSaved:(NSNotification *)saveNotification;
- (void)addPiecesToView;
- (void)resetSizeOfAllThePieces;
- (IBAction)rateGame;
- (BOOL)saveGame;
- (BOOL)isPositioned:(PieceView*)piece;

- (UIView*)upperGroupBut:(GroupView*)group;
- (void)moveBar;
- (void)addAnothePieceToView;

@end
