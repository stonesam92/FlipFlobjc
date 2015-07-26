//
//  SSViewController.m
//  FlipFlobjc
//
//  Created by Sam Stone on 07/03/2015.
//  Copyright (c) 2015 Sam Stone. All rights reserved.
//

#import "SSViewController.h"
#import <FlipFlobjc/FlipFlobjc.h>

@interface SSViewController ()
@property (strong, nonatomic) FlipFlobjc *flipbook;
@end

@implementation SSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _flipbook = [[FlipFlobjc alloc] initWithOutputDirectory:@"/Users/Sam/Desktop/Images"];
    
    //start rendering progressview once activity view rendering complete
    __weak SSViewController *weakself = self;
    _flipbook.completetionBlock = ^(UIView *view) {
        if (view == weakself.progressView) {
            [weakself renderActivityView];
        }
    };
    [self renderProgressView];
}


- (void)renderActivityView {
    [self.activityIndicator startAnimating];
    [self.flipbook renderTargetView:self.activityIndicator
                        imagePrefix:@"activityIndicator"
                           duration:2.0
                      frameInterval:5];
}

- (void)renderProgressView {
    [self.flipbook renderTargetView:self.progressView
                        imagePrefix:@"progressView"
                         frameCount:101
                        updateBlock:^(UIView *view, NSInteger frame) {
                            UIProgressView *progressView = (UIProgressView *)view;
                            [progressView setProgress:1.0 / 100.0 * frame];
                            if ([NSThread isMainThread]) NSLog(@"yah we are");
                        }];
}

@end
