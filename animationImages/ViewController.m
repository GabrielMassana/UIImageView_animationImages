//
//  ViewController.m
//  animationImages
//
//  Created by GabrielMassana on 16/01/2015.
//  Copyright (c) 2015 GabrielMassana. All rights reserved.
//

#import "ViewController.h"
#import "ViewControllerTwo.h"

static NSTimeInterval const kAnimationDuration = 1.0;

@interface ViewController ()

@property (nonatomic, strong) UIImageView *animationImageView;
@property (nonatomic, strong) UIButton *button;

@end

@implementation ViewController

#pragma mark - ViewLifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.animationImageView];
    [self.view addSubview:self.button];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self animateImages];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [self stopAnimateImages];
}

#pragma mark - Subviews

- (UIImageView *)animationImageView
{
    if (!_animationImageView)
    {
        _animationImageView = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    }
    
    return _animationImageView;
}

- (UIButton *)button
{
    if (!_button)
    {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(0,
                                   20,
                                   [[UIScreen mainScreen] bounds].size.width,
                                   80);
        _button.backgroundColor = [UIColor redColor];
        
        [_button addTarget:self
                    action:@selector(buttonPressed)
          forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _button;
}

#pragma mark - ButtonActions

-(void)buttonPressed
{
    ViewControllerTwo *two = [[ViewControllerTwo alloc] init];
    
    [self presentViewController:two animated:YES completion:nil];
}

#pragma mark - Animation

- (void)animateImages
{
    self.animationImageView.animationImages = [self createImagesArray];
    self.animationImageView.animationDuration = kAnimationDuration;
    self.animationImageView.animationRepeatCount = 1;
    [self.animationImageView startAnimating];
    
    // Because there is no delegate to know the end of the animation with this method, this is the only approach.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, kAnimationDuration * NSEC_PER_SEC), dispatch_get_main_queue(), ^
    {
        [self stopAnimateImages];
    });
}

- (void)stopAnimateImages
{
    [self.animationImageView stopAnimating];
    self.animationImageView.image = [self.animationImageView.animationImages lastObject];
    self.animationImageView.animationImages = nil;
}

#pragma mark - CreateImagesArray

- (NSArray *)createImagesArray
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSInteger index = 0; index <= 16; index++)
    {
        NSString *imageName = [NSString stringWithFormat:@"frame_%03ld.png", (long)index];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:imageName
                                                         ofType:nil];
        
        // Allocating images with imageWithContentsOfFile makes images to do not cache.
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        
        [array addObject:image];
    }
    
    return array;
}

#pragma mark - MemoryManagement

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
