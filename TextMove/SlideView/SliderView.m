//
//  SliderView.m
//  TextMove
//
//  Created by 曾经 on 16/4/20.
//  Copyright © 2016年 sandy. All rights reserved.
//

#import "SliderView.h"
#import <QuartzCore/QuartzCore.h>

@interface SliderView(Privater)
-(void)setupView;
-(void)animateCurrentSliderString;
-(void)pauseLayer:(CALayer *)layer;
-(void)resumeLayer:(CALayer *)layer;
@end

@implementation SliderView
@synthesize sliderStrings;
@synthesize sliderSpeed;
@synthesize loops;
@synthesize direction;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}
-(void)setupView {
    [self setBackgroundColor:[UIColor whiteColor]];
    [self.layer setCornerRadius:1.0f];
    [self.layer setBorderWidth:1.5f];
    
    [self.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self setClipsToBounds:YES];
    
    silderFont = [UIFont systemFontOfSize:25.0];
    
    
    silderLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height / 4, self.frame.size.width, self.frame.size.height)];
    silderLabel.backgroundColor = [UIColor clearColor];
    silderLabel.numberOfLines = 1;
    silderLabel.font = silderFont;
    silderLabel.textColor = [UIColor redColor];
    silderLabel.textAlignment = NSTextAlignmentJustified;
    [self addSubview:silderLabel];
    
    loops = YES;
    direction = SliderDirectionLTR;

    
    
}
- (void)animateCurrentSliderString {
    NSString *currentString = [sliderStrings objectAtIndex:currentIndex];
    
    CGSize textSize = [currentString sizeWithFont:silderFont constrainedToSize:CGSizeMake(9999, self.frame.size.height) lineBreakMode:UILineBreakModeWordWrap];
    
    float startX = 0.0;
    float endX = 0.0;
    switch (direction) {
        case SliderDirectionLTR:
            startX = -textSize.width;
            endX = self.frame.size.width;
            break;
            
        default:
            startX = self.frame.size.width;
            endX = -textSize.width;
            break;
    }
    
    [silderLabel setFrame:CGRectMake(startX, silderLabel.frame.origin.y, textSize.width, textSize.height)];
    
    [silderLabel setText:currentString];
    
    float duration = (textSize.width + self.frame.size.width) / sliderSpeed;
    
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(sliderMoveAnimationDidStop:finished:context:)];
    
    // Update end position
    CGRect tickerFrame = silderLabel.frame;
    tickerFrame.origin.x = endX;
    [silderLabel setFrame:tickerFrame];
    
    [UIView commitAnimations];

}
-(void)sliderMoveAnimationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    currentIndex++;
    if (currentIndex >= sliderStrings.count) {
        currentIndex = 0;
        if (!loops) {
            running = NO;
            return;
        }
    }
    
    [self animateCurrentSliderString];
}
#pragma mark - animate control
- (void)start {
    currentIndex = 0;
    running = YES;
    [self animateCurrentSliderString];

}
- (void)pause {
    if (running) {
        [self pauseLayer:self.layer];
        running = NO;
    }
}
- (void)resume {
    if (!running) {
        [self resumeLayer:self.layer];
        running = YES;
    }
}
#pragma mark - UIView layer animations utilities
- (void)pauseLayer:(CALayer *)layer {
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
    
}
- (void)resumeLayer:(CALayer *)layer {
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
}
@end
































