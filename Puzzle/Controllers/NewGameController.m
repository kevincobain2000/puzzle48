//
//  NewGameController.m
//  Puzzle
//
//  Created by Andrea Barbon on 28/04/12.
//  Copyright (c) 2012 Università degli studi di Padova. All rights reserved.
//

#import "NewGameController.h"
#import "MenuController.h"
#import "PuzzleController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImage+CWAdditions.h"
#import "PuzzleLibraryController.h"
#import "Animations.h"


#define IMAGE_QUALITY 0.5
#define WOOD [UIColor colorWithPatternImage:[UIImage imageNamed:@"Wood.jpg"]]

@interface NewGameController ()

@end

@implementation NewGameController

@synthesize popover, delegate, imagePath, startButton, image, tapToSelectLabel, puzzleLibraryButton, progressView, slider;

- (void)viewDidLoad
{
    [super viewDidLoad];

    [image setImage:[UIImage imageNamed:@"57_puzzle_thumb.jpg"]];
    difficultyLevel = 3;
    //Adding a Filter
    if IsRunningTallPhone(){
        CGRect buttonFrame = backButton.frame;
        buttonFrame.origin.y += 60;
        backButton.frame = buttonFrame;
        
        CGRect buttonFrame2 = startButton.frame;
        buttonFrame2.origin.y += 60;
        startButton.frame = buttonFrame2;
        
        
        filter = [[SEFilterControl alloc]initWithFrame:CGRectMake(10, 30, 300, 70) Titles:[NSArray arrayWithObjects:NSLocalizedString(@"Easy", @"Easy"), NSLocalizedString(@"Medium", @"Medium"), NSLocalizedString(@"Hard", @"Hard"), nil]];
        [filter addTarget:self action:@selector(filterValueChanged:) forControlEvents:UIControlEventValueChanged];
        [filter setHandlerColor:[UIColor yellowColor]];
        [filter setProgressColor:[UIColor magentaColor]];
        [filter setTitlesFont:[UIFont fontWithName:@"MarkerFelt-Wide" size:14]];
        [self.view addSubview:filter];
    }
    else{
        CGRect buttonFrame = backButton.frame;
        buttonFrame.origin.y -= 40;
        backButton.frame = buttonFrame;
        
        CGRect buttonFrame2 = startButton.frame;
        buttonFrame2.origin.y -= 40;
        startButton.frame = buttonFrame2;
        
        
        filter = [[SEFilterControl alloc]initWithFrame:CGRectMake(10, 45, 300, 70) Titles:[NSArray arrayWithObjects:NSLocalizedString(@"Easy", @"Easy"), NSLocalizedString(@"Medium", @"Medium"), NSLocalizedString(@"Hard", @"Hard"), nil]];
        [filter addTarget:self action:@selector(filterValueChanged:) forControlEvents:UIControlEventValueChanged];
        [filter setHandlerColor:[UIColor yellowColor]];
        [filter setProgressColor:[UIColor magentaColor]];
        [filter setTitlesFont:[UIFont fontWithName:@"MarkerFelt-Wide" size:14]];
        [self.view addSubview:filter];
    }
    
    
    
    //End Adding Filter
    
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Button" ofType:@"wav"]];
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil] ;
    [audioPlayer prepareToPlay]; //sound when image is tapped
    
    [Animations frameAndShadow:image];
    //piecesLabel.titleLabel.font = [UIFont fontWithName:@"Bello-Pro" size:40];
    //backButton.titleLabel.font = [UIFont fontWithName:@"Bello-Pro" size:40];
    //startButton.titleLabel.font = [UIFont fontWithName:@"Bello-Pro" size:40];
    
    pieceNumberLabel.text = [NSString stringWithFormat:@"%d ", (int)slider.value*(int)slider.value];
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        cameraButton.enabled = NO;
    }
    
    if (image.image==nil) {
        
        startButton.enabled = NO;
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
        
        slider.maximumValue = difficultyLevel;
        
    } else {
        
    }
    
    image.layer.cornerRadius = 10;
    image.layer.masksToBounds = YES;
    
    imagePath = [[NSString alloc] initWithFormat:@""];
    typeOfImageView.backgroundColor = WOOD;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pink-hearts.png"]];
    
}


-(void)filterValueChanged:(SEFilterControl *) sender{
    [audioPlayer play];
    NSLog(@"%d", sender.SelectedIndex);
    if (sender.SelectedIndex == 0){
        difficultyLevel = 3;//3 pieces
    }
    else if (sender.SelectedIndex == 1){
        difficultyLevel = 4; //4 pieces
    }
    else if (sender.SelectedIndex == 2){
        difficultyLevel = 5; //5 pieces
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    typeOfImageView.hidden = YES;
    [UIView animateWithDuration:0.3 animations:^{
        delegate.chooseLabel.alpha = 0;
    }];
    
    [delegate.delegate.view bringSubviewToFront:delegate.delegate.menuButtonView];
    
    DLog(@"After picking");
    [delegate.delegate print_free_memory];
    
    NSData *dataJPG = UIImageJPEGRepresentation([info objectForKey:UIImagePickerControllerEditedImage], IMAGE_QUALITY);
    
    DLog(@"Image size JPG = %.2f", (float)2*((float)dataJPG.length/10000000.0));
    
    [self dismissPicker];
    
    UIImage *temp = [UIImage imageWithData:dataJPG];
    CGRect rect = [[info objectForKey:UIImagePickerControllerCropRect] CGRectValue];
    imagePath = [[info objectForKey:UIImagePickerControllerReferenceURL] absoluteString];
    
    rect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.width);
    DLog(@"Original Rect = %.1f, %.1f, %.1f, %.1f",rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
    
    tapToSelectLabel.hidden = YES;
    startButton.enabled = YES;
    
    
    //image.image = [delegate.delegate clipImage:temp toRect:rect];
    image.image = temp;
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    
    popover = nil;
    [UIView animateWithDuration:0.3 animations:^{
        delegate.chooseLabel.alpha = 0;
    }];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [UIView animateWithDuration:0.3 animations:^{
        delegate.chooseLabel.alpha = 0;
    }];
    [self dismissPicker];
    
}

- (void)dismissPicker {
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        
        [popover dismissPopoverAnimated:YES];
        
    } else {
        
        [self dismissModalViewControllerAnimated:YES];
    }
    
}

- (void)imagePickedFromPuzzleLibrary:(UIImage*)pickedImage {
    
    typeOfImageView.hidden = YES;
    [UIView animateWithDuration:0.3 animations:^{
        delegate.chooseLabel.alpha = 0;
    }];
    
    
    [delegate.delegate.view bringSubviewToFront:delegate.delegate.menuButtonView];
    
    DLog(@"After picking");
    [delegate.delegate print_free_memory];
    
    NSData *dataJPG = UIImageJPEGRepresentation(pickedImage, IMAGE_QUALITY);
    
    DLog(@"Image size JPG = %.2f", (float)2*((float)dataJPG.length/10000000.0));
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        
        [popover dismissPopoverAnimated:YES];
        
    } else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        
        [self dismissModalViewControllerAnimated:YES];
    }
    
    image.image = [UIImage imageWithData:dataJPG];
    
    
    
    tapToSelectLabel.hidden = YES;
    startButton.enabled = YES;
    
}





- (IBAction)selectImageFromPuzzleLibrary:(id)sender {
    [audioPlayer play];
    CGFloat xWidth = self.view.bounds.size.width - 20.0f;
    CGFloat yHeight = 272.0f;
    CGFloat yOffset = (self.view.bounds.size.height - yHeight)/2.0f;
    UIPopoverListView *poplistview = [[UIPopoverListView alloc] initWithFrame:CGRectMake(10, yOffset, xWidth, yHeight)];
    poplistview.delegate = self;
    poplistview.datasource = self;
    poplistview.listView.scrollEnabled = FALSE;
    [poplistview setTitle:NSLocalizedString(@"Choose Library", @"Choose Library")];
    [poplistview show];
    
    /*
    [audioPlayer play];
    //[delegate playMenuSound];
    delegate.chooseLabel.alpha = 1;
    

    PuzzleLibraryController *c = [[PuzzleLibraryController alloc] init];
    
    
    c.delegate = self;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        
        popover = [[UIPopoverController alloc] initWithContentViewController:c];
        popover.delegate = self;
        CGRect rect = CGRectMake(self.view.center.x, -20, 1, 1);
        [popover setPopoverContentSize:self.view.bounds.size];
        [popover presentPopoverFromRect:rect inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        
    } else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        
        [self presentModalViewController:c animated:YES];
    }
     */
     
    
}

#pragma mark - UIPopoverListViewDataSource

- (UITableViewCell *)popoverListView:(UIPopoverListView *)popoverListView
                    cellForIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                    reuseIdentifier:identifier];
    
    int row = indexPath.row;
    
    if(row == 0){
        cell.textLabel.text = NSLocalizedString(@"AKB-48 Library", @"Puzzle48 Library");
        cell.imageView.image = [UIImage imageNamed:@"akb-44-ic.jpg"];
    }else if (row == 1){
        cell.textLabel.text = NSLocalizedString(@"Photo Library", @"Photo Library");
        cell.imageView.image = [UIImage imageNamed:@"photo-icon-44.png"];
    }
    else if (row == 2){
        cell.textLabel.text = NSLocalizedString(@"Camera", @"camera");
        cell.imageView.image = [UIImage imageNamed:@"Camera-Icon.jpg"];
    }
    return cell;
}

- (NSInteger)popoverListView:(UIPopoverListView *)popoverListView
       numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

#pragma mark - UIPopoverListViewDelegate
- (void)popoverListView:(UIPopoverListView *)popoverListView
     didSelectIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s : %d", __func__, indexPath.row);
    // your code here
    [audioPlayer play];
    if (indexPath.row == 0) {
        NSLog(@"Puzzle 48 Library");
        
        delegate.chooseLabel.alpha = 1;
        
        
        PuzzleLibraryController *c = [[PuzzleLibraryController alloc] init];
        
        
        c.delegate = self;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
            
            popover = [[UIPopoverController alloc] initWithContentViewController:c];
            popover.delegate = self;
            CGRect rect = CGRectMake(self.view.center.x, -20, 1, 1);
            [popover setPopoverContentSize:self.view.bounds.size];
            [popover presentPopoverFromRect:rect inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
        } else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            
            [self presentModalViewController:c animated:YES];
        }

    }
    else if (indexPath.row == 1){
        NSLog(@"Phone Library");
        
        delegate.chooseLabel.alpha = 1;
        
        int direction;
        
        UIImagePickerController *c = [[UIImagePickerController alloc] init];
        

            
        c.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        direction = UIPopoverArrowDirectionUp;
        
        c.allowsEditing = YES;
        c.delegate = self;
        
        DLog(@"B4 picking");
        [delegate.delegate print_free_memory];
        
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
            
            popover = [[UIPopoverController alloc] initWithContentViewController:c];
            popover.delegate = self;
            CGRect rect = CGRectMake(self.view.center.x, -20, 1, 1);
            [popover setPopoverContentSize:self.view.bounds.size];
            [popover presentPopoverFromRect:rect inView:self.view permittedArrowDirections:direction animated:YES];
            
        } else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            
            [self presentModalViewController:c animated:YES];
        }

    }
    else{
        NSLog(@"Camera");
        delegate.chooseLabel.alpha = 1;
        
        int direction;
        
        UIImagePickerController *c = [[UIImagePickerController alloc] init];
        c.sourceType = UIImagePickerControllerSourceTypeCamera;
        direction = UIPopoverArrowDirectionUp;
            
        c.allowsEditing = YES;
        c.delegate = self;
        
        DLog(@"B4 picking");
        [delegate.delegate print_free_memory];
        
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
            
            popover = [[UIPopoverController alloc] initWithContentViewController:c];
            popover.delegate = self;
            CGRect rect = CGRectMake(self.view.center.x, -20, 1, 1);
            [popover setPopoverContentSize:self.view.bounds.size];
            [popover presentPopoverFromRect:rect inView:self.view permittedArrowDirections:direction animated:YES];
            
        } else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            
            [self presentModalViewController:c animated:YES];
        }
    }
}

- (CGFloat)popoverListView:(UIPopoverListView *)popoverListView
   heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}


- (IBAction)selectImageFromPhotoLibrary:(UIButton*)sender {
    
    //[delegate playMenuSound];
    delegate.chooseLabel.alpha = 1;
    
    int direction;
    
    UIImagePickerController *c = [[UIImagePickerController alloc] init];
    
    if ([sender.titleLabel.text isEqualToString:@"Camera"]) {
        
        c.sourceType = UIImagePickerControllerSourceTypeCamera;
        direction = UIPopoverArrowDirectionUp;
        
    } else {
        
        c.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        direction = UIPopoverArrowDirectionUp;
    }
    c.allowsEditing = YES;
    c.delegate = self;
    
    DLog(@"B4 picking");
    [delegate.delegate print_free_memory];
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        
        popover = [[UIPopoverController alloc] initWithContentViewController:c];
        popover.delegate = self;
        CGRect rect = CGRectMake(self.view.center.x, -20, 1, 1);
        [popover setPopoverContentSize:self.view.bounds.size];
        [popover presentPopoverFromRect:rect inView:self.view permittedArrowDirections:direction animated:YES];
        
    } else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        
        [self presentModalViewController:c animated:YES];
    }
    
}

- (IBAction)selectImage:(id)sender {
    
    //[delegate playMenuSound];
    
    typeOfImageView.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        delegate.chooseLabel.alpha = 0;
    }];
}

- (IBAction)startNewGame:(id)sender {
    [audioPlayer play];
    [Animations buttonPressAnimate:startButton andAnimationDuration:0.25 andWait:YES];
    
    //[delegate playMenuSound];
    
    DLog(@"Started");
    
    tapToSelectView.hidden = YES;
    
    delegate.delegate.loadingGame = NO;

    delegate.delegate.image = image.image;
    
    delegate.delegate.imageView.image = delegate.delegate.image;
    delegate.delegate.imageViewLattice.image = delegate.delegate.image;
    delegate.delegate.pieceNumber = difficultyLevel;//(int)slider.value;
    
    
    [self startLoading];
    
    [delegate.delegate removeOldPieces];
    
    
    [delegate createNewGame];
    
}

- (IBAction)back:(id)sender {
    [audioPlayer play];
    [Animations buttonPressAnimate:backButton andAnimationDuration:0.25 andWait:YES];
    //[delegate playMenuSound];
    
    if (typeOfImageView.hidden) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.view.frame = CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
            delegate.mainView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            
        }completion:^(BOOL finished) {
            
            typeOfImageView.hidden = YES;
        }];
        
    } else {
        
        typeOfImageView.hidden = YES;
    }
    
}

- (void)startLoading {
    
    startButton.hidden = YES;
    backButton.hidden = YES;
    
    
    if (delegate.delegate.loadingGame) {
        
        int n = [delegate.delegate.puzzleDB.pieceNumber intValue];
        pieceNumberLabel.text = [NSString stringWithFormat:@"%d ", n*n];
        slider.value = (float)n;
        tapToSelectView.hidden = YES;
        image.image = delegate.delegate.image;
        
    } else {
        
        image.image = delegate.delegate.image;
    }
    
    slider.enabled = NO;
    
    if (image.image==nil) {
        image.image = [UIImage imageNamed:@"Wood.jpg"];
    }
    
    progressView.hidden = NO;
    loadingView.hidden = NO;
    progressView.progress = 0.0;
    
    //timer = [NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(moveBar) userInfo:nil repeats:YES];
    
    
}


- (void)gameStarted {
    
    DLog(@"Game is started");
    
    [timer invalidate];
    
    [delegate toggleMenuWithDuration:0];
    
    progressView.progress = 0.0;
    delegate.delegate.loadedPieces = 0;
    progressView.hidden = YES;
    loadingView.hidden = YES;
    startButton.hidden = NO;
    backButton.hidden = NO;
    pieceNumberLabel.hidden = YES;
    slider.enabled = YES;
    piecesLabel.hidden = YES;
    tapToSelectView.hidden = YES;
    tapToSelectLabel.hidden = YES;
    
    
    pieceNumberLabel.text = [NSString stringWithFormat:@"%d ", (int)slider.value*(int)slider.value];
    
}

- (void)loadingFailed {
    
    DLog(@"Game failed");
    
    [timer invalidate];
    
    [delegate toggleMenuWithDuration:0];
    
    progressView.progress = 0.0;
    delegate.delegate.loadedPieces = 0;
    progressView.hidden = YES;
    loadingView.hidden = YES;
    
    startButton.hidden = NO;
    backButton.hidden = NO;
    
    pieceNumberLabel.hidden = NO;
    slider.enabled = YES;
    piecesLabel.hidden = NO;
    tapToSelectView.hidden = NO;
    tapToSelectLabel.hidden = NO ;
    
    pieceNumberLabel.text = [NSString stringWithFormat:@"%d ", (int)slider.value*(int)slider.value];
    
    self.view.frame = CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
    
}


- (void)moveBar {
    
    float a = (float)delegate.delegate.loadedPieces;
    float b = (float)((int)slider.value*(int)slider.value);
    
    if (delegate.delegate.loadingGame) {
        
        b = delegate.delegate.NumberSquare;
    }
    
    progressView.progress = a/b;
    
}


- (IBAction)numberSelected:(UISlider*)sender {
    
    pieceNumberLabel.text = [NSString stringWithFormat:@"%d ", (int)slider.value*(int)slider.value];
    
    
}





- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidUnload
{
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end