//
//  SliderView.h
//  TextMove
//
//  Created by 曾经 on 16/4/20.
//  Copyright © 2016年 sandy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    SliderDirectionLTR = 0,
    SliderDirecrionRTL,
} SliderDirection;
@interface SliderView : UIView
{
    NSArray *sliderStrings;
    int currentIndex;
    float silderSpeed;
    BOOL loops;
    BOOL running;
    UILabel *silderLabel;
    UIFont *silderFont;
}
@property (nonatomic, strong) NSArray *sliderStrings;
@property (nonatomic, assign) float sliderSpeed;
@property (nonatomic) BOOL loops;
@property (nonatomic) SliderDirection direction;

- (void)start;
//- (void)stop;
- (void)pause;
- (void)resume;
@end
