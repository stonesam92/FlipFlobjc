//
//  FlipFlobjc.m
//  FlipFlobjc Example
//
//  Created by Sam Stone on 30/06/2015.
//  Copyright (c) 2015 Sam Stone. All rights reserved.
//

#import "FlipFlobjc.h"

@interface FlipFlobjc ()
@property (strong, nonatomic) CADisplayLink *displayLink;
@property (strong, nonatomic) NSString *imagePrefix;
@property (weak, nonatomic) UIView *targetView;
@property (assign, nonatomic) NSInteger imageCounter;
@property (assign, nonatomic) NSTimeInterval captureEndTime;
@property (assign, nonatomic) NSTimeInterval captureDuration;
@end

@implementation FlipFlobjc
- (instancetype)initWithOutputDirectory:(NSString *)outputDirectory {
    if (self = [super init]) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkTick:)];
        _outputDirectory = outputDirectory ? outputDirectory : [self appDocumentsDirectory];
        _imageCounter = 0;
        _captureEndTime = 0;
    }
    
    return self;
}

- (void)renderTargetView:(UIView *)targetView
             imagePrefix:(NSString *)imagePrefix
              frameCount:(NSInteger)frameCount
             updateBlock:(void (^)(UIView *view, NSInteger frameNum))updateBlock {
    
    NSLog(@"[FlipFlobjc] Beginning block-based capture...");

    _targetView = targetView;
    _imagePrefix = imagePrefix;
    
    for (int frame = 0; frame < frameCount; frame++) {
        updateBlock(self.targetView, frame);
        [self renderViewToImage:self.targetView];
    }
    
    self.imageCounter = 0;
    self.targetView = nil;
    self.imagePrefix = nil;
    
    NSLog(@"[FlipFlobjc] Capture complete");
    NSLog(@"[FlipFlobjc] Images saved to %@", self.outputDirectory);
    
    if (self.completetionBlock) self.completetionBlock(targetView);
}

- (void)renderTargetView:(UIView *)targetView
             imagePrefix:(NSString *)imagePrefix
                duration:(NSTimeInterval)duration
           frameInterval:(NSInteger)frameInterval {
    
    NSLog(@"[FlipFlobjc] Beginning duration-based capture...");
    
    _targetView = targetView;
    _imagePrefix = imagePrefix;
    _captureDuration = duration;
    self.displayLink.frameInterval = frameInterval;
    
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)displayLinkTick:(CADisplayLink *)sender {
    if (!self.captureEndTime) {
        self.captureEndTime = sender.timestamp + self.captureDuration;
    }
    
    [self renderViewToImage:self.targetView];
    
    if (sender.timestamp > self.captureEndTime) {
        [sender invalidate];
        [sender removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
        
        UIView *targetView = self.targetView;
        self.imageCounter = 0;
        self.captureEndTime = 0;
        self.captureDuration = 0;
        self.targetView = nil;
        
        NSLog(@"[FlipFlobjc] Capture complete");
        NSLog(@"[FlipFlobjc] Images saved to %@", self.outputDirectory);
        
        if (self.completetionBlock) self.completetionBlock(targetView);
    }
    
}

- (NSString *)appDocumentsDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return paths.lastObject;
}

- (NSString *)pathForNextImage {
    NSString *imageFilename = [NSString stringWithFormat:@"%@-%ld@2x.png", self.imagePrefix, (long)self.imageCounter];
    return [self.outputDirectory stringByAppendingPathComponent:imageFilename];
}

- (void)renderViewToImage:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 2.0);
    CALayer *presentationLayer = view.layer.presentationLayer;
    if (!presentationLayer)
        presentationLayer = view.layer;
    [presentationLayer setNeedsDisplay];
    [presentationLayer displayIfNeeded];
    
    [presentationLayer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *imageOutput = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    [UIImagePNGRepresentation(imageOutput) writeToFile:[self pathForNextImage] atomically:YES];
    
    self.imageCounter++;
}
@end
