//
//  ViewControllerTwo.m
//  KeyAnimation
//
//  Created by GabrielMassana on 13/01/2015.
//  Copyright (c) 2015 GabrielMassana. All rights reserved.
//

#import "ViewControllerTwo.h"

@interface ViewControllerTwo ()

@property (nonatomic, strong) UIButton *button;

@end

@implementation ViewControllerTwo

#pragma mark - ViewLifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.button];
}

#pragma mark - Subviews

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
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - MemoryManagement

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
