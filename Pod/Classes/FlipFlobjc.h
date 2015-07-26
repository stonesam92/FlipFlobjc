//
//  FlipFlobjc.h
//  FlipFlobjc Example
//
//  Created by Sam Stone on 30/06/2015.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FlipFlobjc : NSObject
/**
 *  The directory to which rendered images will be output. The default value is the app's documents directory.
 */
@property (strong, nonatomic) NSString *outputDirectory;
/**
 *  A block to be called when an image capture session is complete. The UIView which was the target of the capture is passed as a parameter.
 */
@property (strong, nonatomic) void (^completetionBlock)(UIView *targetView);
/**
 *  Initialises a new FlipFlobjc object.
 *
 *  @param outputDirectory The directory to which captured images will be saved. If nil is given, or if the given directory does not exist, the app's documents directory will be used.
 *
 */
- (instancetype)initWithOutputDirectory:(NSString *)outputDirectory;
/**
 *  Renders a UIView to a sequence of images, updating the view between captures using a provided block.
 *
 *  @param targetView  The UIView to render into an image sequence.
 *  @param imagePrefix The prefix to use to name the output files.
 *  @param frameCount  The number of frames to be captured.
 *  @param updateBlock A block to be called before each frame is captured.
 */
- (void)renderTargetView:(UIView *)targetView
             imagePrefix:(NSString *)imagePrefix
              frameCount:(NSInteger)frameCount
             updateBlock:(void (^)(UIView *view, NSInteger frameNum))updateBlock;
/**
 *  Renders a UIView into a sequence of images over the provided period of time.
 *
 *  @param targetView    The UIView to render into an image sequence.
 *  @param imagePrefix   The prefix to use to name the output files.
 *  @param duration      The duration of time the capture session should last.
 *  @param frameInterval The number of frames that should pass between each capture. Must be greater than or equal to 1.
 */
- (void)renderTargetView:(UIView *)targetView
             imagePrefix:(NSString *)imagePrefix
                duration:(NSTimeInterval)duration
           frameInterval:(NSInteger)frameInterval;
@end
