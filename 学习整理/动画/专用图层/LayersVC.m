//
//  LayersVC.m
//  学习整理
//
//  Created by 王涛 on 16/11/23.
//  Copyright © 2016年 王涛. All rights reserved.
//

#import "LayersVC.h"

@interface LayersVC ()
@property (weak, nonatomic) IBOutlet UIView *shapeLayerView;
@property (weak, nonatomic) IBOutlet UIView *replicatorLayerView;

@end

@implementation LayersVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view layoutIfNeeded];
    //[self setShapeLayer];
    //[self setCAGradientLayer];
    //[self setReplicatorLayer];
    [self setEmitterLayer];
}

// 基础形状
- (void)setShapeLayer {
    CGRect rect = CGRectMake(0, 0, self.shapeLayerView.frame.size.width, self.shapeLayerView.frame.size.height);
    CGSize radii = CGSizeMake(20, 20);
    UIRectCorner corners = UIRectCornerTopRight | UIRectCornerBottomRight | UIRectCornerBottomLeft;
    //create path
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 5;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = path.CGPath;
    //add it to our view
    [self.shapeLayerView.layer addSublayer:shapeLayer];
}

//基础渐变
- (void)setCAGradientLayer {
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.shapeLayerView.bounds;
    [self.shapeLayerView.layer addSublayer:gradientLayer];
    
    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,(__bridge id)[UIColor blueColor].CGColor,(__bridge id)[UIColor yellowColor].CGColor];
    gradientLayer.locations = @[@0.0, @0.5,@0.7];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
}

// 重复layer
- (void)setReplicatorLayer {
    
    self.shapeLayerView.hidden = YES;
    //create a replicator layer and add it to our view
    CAReplicatorLayer *replicator = [CAReplicatorLayer layer];
    replicator.frame = self.view.bounds;
    [self.view.layer addSublayer:replicator];
    
    //configure the replicator
    replicator.instanceCount = 5;
    
    //apply a transform for each instance
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, 0, 150, 0);
    replicator.instanceTransform = transform;
    
    //apply a color shift for each instance
    replicator.instanceBlueOffset = -0.1;
    replicator.instanceGreenOffset = -0.1;
    
    //create a sublayer and place it inside the replicator
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(10.0f, 10.0f, 100.0f, 100.0f);
    layer.cornerRadius = 50.0f;
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    [replicator addSublayer:layer];
    
}

//EmitterLayer 例子引擎

/**
 
 CAEmitterLayer :
 
 birthRate: 粒子 产 生系数，默 认 1.0 ；
 
 emitterCells:   装着 CAEmitterCell 对 象的数 组 ，被用于把粒子投放到 layer 上；
 
 emitterDepth: 决定粒子形状的深度 联 系： emitter shape
 
 emitterMode: 发 射模式
 
 NSString * const kCAEmitterLayerPoints;
 
 NSString * const kCAEmitterLayerOutline;
 
 NSString * const kCAEmitterLayerSurface;
 
 NSString * const kCAEmitterLayerVolume;
 
 emitterPosition: 发 射位置
 
 emitterShape: 发 射源的形状：
 
 NSString * const kCAEmitterLayerPoint;
 
 NSString * const kCAEmitterLayerLine;
 
 NSString * const kCAEmitterLayerRectangle;
 
 NSString * const kCAEmitterLayerCuboid;
 
 NSString * const kCAEmitterLayerCircle;
 
 NSString * const kCAEmitterLayerSphere;
 
 emitterSize: 发 射源的尺寸大；
 
 emitterZposition: 发 射源的 z 坐 标 位置；
 
 lifetime: 粒子生命周期
 
 preservesDepth: 不是多很清楚（粒子是平展在 层 上）
 
 renderMode: 渲染模式：
 
 NSString * const kCAEmitterLayerUnordered;
 
 NSString * const kCAEmitterLayerOldestFirst;
 
 NSString * const kCAEmitterLayerOldestLast;
 
 NSString * const kCAEmitterLayerBackToFront;
 
 NSString * const kCAEmitterLayerAdditive;
 
 scale: 粒子的缩放比例：
 
 seed ：用于初始化随机数产生的种子
 
 spin: 自旋转速度
 
 velocity ：粒子速度
 
 -----------CAEmitterCell:--------------
 
 CAEmitterCell 类 代从从 CAEmitterLayer 射出的粒子； emitter cell 定 义 了粒子 发 射的方向。
 
 alphaRange:    一个粒子的 颜 色 alpha 能改 变 的范 围 ；
 
 alphaSpeed: 粒子透明度在生命周期内的改变速度；
 
 birthrate ：粒子参数的速度乘数因子；
 
 blueRange ：一个粒子的 颜 色 blue   能改 变 的范 围 ；
 
 blueSpeed:   粒子 blue 在生命周期内的改变速度；
 
 color: 粒子的颜色
 
 contents ：是个 CGImageRef 的对象 , 既粒子要展现的图片；
 
 contentsRect ：应该画在 contents 里的子 rectangle ：
 
 emissionLatitude ：发射的 z 轴方向的角度
 
 emissionLongitude:x-y 平面的 发 射方向
 
 emissionRange ；周 围发射角度
 
 emitterCells ：粒子发射的粒子
 
 enabled ：粒子是否被渲染
 
 greenrange:   一个粒子的 颜 色 green   能改 变 的范 围 ；
 
 greenSpeed:   粒子 green 在生命周期内的改变速度；
 
 lifetime ：生命周期
 
 lifetimeRange ：生命周期范围
 
 magnificationFilter ：不是很清楚好像增加自己的大小
 
 minificatonFilter ：减小自己的大小
 
 minificationFilterBias ：减小大小的因子
 
 name ：粒子的名字
 
 redRange ： 一个粒子的 颜 色 red   能改 变 的范 围 ；
 
 redSpeed;   粒子 red 在生命周期内的改变速度；
 
 scale ：缩放比例：
 
 scaleRange ：缩放比例范围；
 
 scaleSpeed ：缩放比例速度：
 
 spin ：子旋转角度
 
 spinrange ：子旋转角度范围
 
 style ：不是很清楚：
 
 velocity ：速度
 
 velocityRange ：速度范围
 
 xAcceleration: 粒子 x 方向的加速度分量
 
 yAcceleration: 粒子 y 方向的加速度分量
 
 zAcceleration: 粒子 z 方向的加速度分量
 
 */
- (void)setEmitterLayer {
    
    //create particle emitter layer
    CAEmitterLayer *emitter = [CAEmitterLayer layer];
    //发射源的尺寸大小
    emitter.frame = self.shapeLayerView.bounds;
    [self.shapeLayerView.layer addSublayer:emitter];
    
    //renderMode 控制着在视觉上粒子图片是如何混合的。你可能已经注意到了示例中我们把它设置为kCAEmitterLayerAdditive，它实现了这样一个效果：合并粒子重叠部分的亮度使得看上去更亮。如果我们把它设置为默认的kCAEmitterLayerUnordered，效果就没那么好看了
    emitter.renderMode = kCAEmitterLayerAdditive;
    emitter.emitterPosition = CGPointMake(emitter.frame.size.width / 2.0, emitter.frame.size.height / 2.0);
    
    //create a particle template
    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    cell.contents = (__bridge id)[UIImage imageNamed:@"icon_eva02"].CGImage;
    //粒子参数的速度乘数因子
    cell.birthRate = 150;
    cell.lifetime = 5.0;
    cell.color = [UIColor colorWithRed:1 green:0.5 blue:0.1 alpha:1.0].CGColor;
    //指定值在时间线上的变化。比如，在示例中，我们将alphaSpeed设置为-0.4，就是说粒子的透明度每过一秒就是减少0.4，这样就有发射出去之后逐渐消失的效果。
    cell.alphaSpeed = -0.4;
    //粒子速度
    cell.velocity = 50;
    //粒子的速度范围
    cell.velocityRange = 50;
    //周围发射角度
    cell.emissionRange = M_PI * 2.0;
    
    //add particle template to emitter
    emitter.emitterCells = @[cell];
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
