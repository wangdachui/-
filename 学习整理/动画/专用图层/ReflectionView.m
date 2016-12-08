//
//  ReflectionView.m
//

#import "ReflectionView.h"
#import <QuartzCore/QuartzCore.h>
#import <GLKit/GLKit.h>
#import <Availability.h>

@interface ReflectionView ()

@end


@implementation ReflectionView

+ (Class)layerClass
{
    return [CAReplicatorLayer class];
}

- (void)update
{
    CAReplicatorLayer *layer = (CAReplicatorLayer *)self.layer;
    layer.shouldRasterize = YES;
    layer.rasterizationScale = [UIScreen mainScreen].scale;
    layer.instanceCount = 2;
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, 0.0, layer.bounds.size.height + _reflectionGap, 0.0);
    transform = CATransform3DScale(transform, 1.0, -1.0, 0.0);
    layer.instanceTransform = transform;
    layer.instanceAlphaOffset = _reflectionAlpha - 1.0;

}

- (void)setUp
{
    //set default properties
    _reflectionAlpha = 0.5;
    
    //update reflection
    [self setNeedsLayout];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder]))
    {
        [self setUp];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
    {
        [self setUp];
    }
    return self;
}

- (void)layoutSubviews
{
    [self update];
    [super layoutSubviews];
}

@end
