//
//  A_CALayer_ContentsRectVC.m
//  core_animation
//
//  Created by 王涛 on 15/4/22.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "A_CALayer_ContentsRectVC.h"

@interface A_CALayer_ContentsRectVC ()

@end

@implementation A_CALayer_ContentsRectVC

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];

    [self contentRect];
    [self maskLayer];
    [self groupAlpha];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 动画类型
//切图
- (void)contentRect {
    UIImage *image = [UIImage imageNamed:@"student_about"];
    CGRect rectOne = CGRectMake(0, 0, 0.5, 0.5);
    [self addImage:image andRect:rectOne toLayer:self.viewOne.layer];
    CGRect rectTwo = CGRectMake(0.5, 0, 0.5, 0.5);
    [self addImage:image andRect:rectTwo toLayer:self.viewTwo.layer];
    CGRect rectThree = CGRectMake(0, 0.5, 0.5, 0.5);
    [self addImage:image andRect:rectThree toLayer:self.viewThree.layer];
    CGRect rectFour = CGRectMake(0.5, 0.5, 0.5, 0.5);
    [self addImage:image andRect:rectFour toLayer:self.viewFour.layer];
}
//加蒙版
- (void)maskLayer {
    //给viewOne加蒙版
    CALayer *maskLayer = [CALayer layer];
    maskLayer.frame = self.viewOne.layer.bounds;
    UIImage *maskImage = [UIImage imageNamed:@"chat_me3"];
    maskLayer.contents = (__bridge id)maskImage.CGImage;
    self.viewOne.layer.mask = maskLayer;
}
//组透明
- (void)groupAlpha {
    //组透明
    UIButton *button1 = [self customButton];
    [self.view addSubview:button1];
    
    UIButton *button2 = [self customButton];
    button2.center = CGPointMake(250, self.viewThree.frame.origin.y + self.viewThree.frame.size.height + 30);
    button2.alpha = 0.5;
    [self.view addSubview:button2];
    
    button2.layer.shouldRasterize = YES;
    button2.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

#pragma mark - Private Method
- (UIButton *)customButton
{
    //create button
    CGRect frame = CGRectMake(20, self.viewThree.frame.origin.y + self.viewThree.frame.size.height + 30, 150, 50);
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    button.backgroundColor = [UIColor whiteColor];
    button.layer.cornerRadius = 10;
    
    //add label
    frame = CGRectMake(20, 10, 110, 30);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = @"Hello World";
    label.textAlignment = NSTextAlignmentCenter;
    [button addSubview:label];
    return button;
}

- (void)addImage:(UIImage *)image andRect:(CGRect)rect toLayer:(CALayer*)layer{
    
    layer.contents = (__bridge id)image.CGImage;
    layer.contentsGravity = kCAGravityResizeAspect;
    layer.contentsRect = rect;
    //在Retina屏幕上显示出正确的尺寸
    layer.contentsScale = [UIScreen mainScreen].scale;
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
