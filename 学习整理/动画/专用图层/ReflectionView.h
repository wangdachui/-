//
//  ReflectionView.h
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@interface ReflectionView : UIView

@property (nonatomic, assign) CGFloat reflectionGap;
@property (nonatomic, assign) CGFloat reflectionScale;
@property (nonatomic, assign) CGFloat reflectionAlpha;
@property (nonatomic, assign) BOOL dynamic;

@end
