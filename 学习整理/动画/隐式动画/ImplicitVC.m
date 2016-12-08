//
//  ImplicitVC.m
//  学习整理
//
//  Created by 王涛 on 16/12/8.
//  Copyright © 2016年 王涛. All rights reserved.
//

#import "ImplicitVC.h"

@interface ImplicitVC ()
@property (weak, nonatomic) IBOutlet UIView *layerView;
@property (strong, nonatomic) CALayer *colorLayer;
@end

@implementation ImplicitVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(12, 12, 60, 60);
    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.layerView.layer addSublayer:self.colorLayer];
}
- (IBAction)changeColor:(id)sender {
    CGFloat red = arc4random()/(CGFloat)INT_MAX;
    CGFloat green = arc4random()/(CGFloat)INT_MAX;
    CGFloat blue = arc4random()/(CGFloat)INT_MAX;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1];
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"backgroundColor";
    animation.toValue = (__bridge id)color.CGColor;
    [self.colorLayer addAnimation:animation forKey:nil];
    
    //self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1].CGColor;
    //self.layerView.layer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1].CGColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
