//
//  ViewController.m
//  TextMove
//
//  Created by 曾经 on 16/4/20.
//  Copyright © 2016年 sandy. All rights reserved.
//

#import "ViewController.h"
#import "SliderView.h"
@interface ViewController ()
@property (nonatomic, strong) SliderView *aView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.aView];
    
    
}
- (SliderView *)aView {
    if (!_aView) {
        NSArray *strings = @[@"我们都是好孩子", @"最最善良的孩子", @"相信爱可以永远啊"];
        self.aView = [[SliderView alloc] initWithFrame:CGRectMake(50, 100, 200, 40)];
        _aView.sliderStrings = strings;
        _aView.backgroundColor = [UIColor yellowColor];
        _aView.sliderSpeed = 100.0;
        _aView.direction = 0;
        _aView.loops = YES;
        [_aView start];
    }
    return _aView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
