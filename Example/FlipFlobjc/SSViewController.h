//
//  SSViewController.h
//  FlipFlobjc
//
//  Created by Sam Stone on 07/03/2015.
//  Copyright (c) 2015 Sam Stone. All rights reserved.
//

@import UIKit;

@interface SSViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *watchScreenView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@end
