//
//  CGAffineTransformVC.m
//  学习整理
//
//  Created by 王涛 on 15/7/28.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "CGAffineTransformVC.h"

@interface CGAffineTransformVC ()
@property (weak, nonatomic) IBOutlet UIView *transformView;

@end

@implementation CGAffineTransformVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UIImage *maskImage = [UIImage imageNamed:@"pic_construction"];
    self.transformView.layer.contents = (__bridge id)maskImage.CGImage;
    self.transformView.layer.contentsGravity = kCAGravityResizeAspect;
    self.transformView.layer.contentsScale = [UIScreen mainScreen].scale;
    // 变换
    //[self transform];
    [self transform3D];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)transform {
    //我们来用这些函数组合一个更加复杂的变换，先缩小50%，再旋转30度，最后向右移动200个像素
    //图片向右边发生了平移，但并没有指定距离那么远（200像素），另外它还有点向下发生了平移。原因在于当你按顺序做了变换，上一个变换的结果将会影响之后的变换，所以200像素的向右平移同样也被旋转了30度，缩小了50%，所以它实际上是斜向移动了100像素。这意味着变换的顺序会影响最终的结果，也就是说旋转之后的平移和平移之后的旋转结果可能不同。
    
    CGAffineTransform transform = CGAffineTransformIdentity; //create a new transform
    transform = CGAffineTransformScale(transform, 0.5, 0.5); //scale by 50%
    transform = CGAffineTransformRotate(transform, M_PI / 180.0 * 30.0); //rotate by 30 degrees
    transform = CGAffineTransformTranslate(transform, 200, 0); //translate by 200 points
    //apply transform to layer
    self.transformView.layer.affineTransform = transform;
}

- (void)transform3D {
    //看起来图层并没有被旋转，而是仅仅在水平方向上的一个压缩，是哪里出了问题呢？其实完全没错，视图看起来更窄实际上是因为我们在用一个斜向的视角看它，而不是透视
    //CATransform3D transform = CATransform3DIdentity;
    //transform = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
    //self.transformView.layer.transform = transform;
    /*
     透视投影
     在真实世界中，当物体远离我们的时候，由于视角的原因看起来会变小，理论上说远离我们的视图的边要比靠近视角的边跟短，但实际上并没有发生，而我们当前的视角是等距离的，也就是在3D变换中任然保持平行，和之前提到的仿射变换类似。
     在等距投影中，远处的物体和近处的物体保持同样的缩放比例，这种投影也有它自己的用处（例如建筑绘图，颠倒，和伪3D视频），但当前我们并不需要。
     为了做一些修正，我们需要引入投影变换（又称作z变换）来对除了旋转之外的变换矩阵做一些修改，Core Animation并没有给我们提供设置透视变换的函数，因此我们需要手动修改矩阵值
     */
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0/500.0;
    transform = CATransform3DRotate(transform, M_PI_4, 0, 1, 0);
    self.transformView.layer.transform = transform;
    
}

@end
