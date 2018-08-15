//
//  TransFormVC.m
//  CoreAnimation
//
//  Created by Star on 2018/8/15.
//  Copyright © 2018年 Star. All rights reserved.
//

#import "TransFormVC.h"
#import "NumberView.h"
#import <GLKit/GLKit.h>
#define LIGHT_DIRECTION 0, 1, -0.5
#define AMBIENT_LIGHT 0.5
#define RADIANS_TO_DEGREES(x) ((x)/180.0*M_PI)
@interface TransFormVC()
@property (nonatomic, strong)UIView *containerView;
@property (nonatomic, strong) NumberView *oneView;
@property (nonatomic, strong) NumberView *twoView;
@property (nonatomic, strong) NumberView *threeView;
@property (nonatomic, strong) NumberView *fourView;
@property (nonatomic, strong) NumberView *fiveView;
@property (nonatomic, strong) NumberView *sixView;
@end
@implementation TransFormVC
- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    //Create containerView
    _containerView = [UIView new];
    _containerView.backgroundColor = [UIColor lightGrayColor];
    _containerView.frame = CGRectMake(0, 0, 400, 400);
    _containerView.center = self.view.center;
    [self.view addSubview:_containerView];
    //Create numberView
    _oneView = [self createNumberViewByIndex:1];
    _twoView = [self createNumberViewByIndex:2];
    _threeView = [self createNumberViewByIndex:3];
    _fourView = [self createNumberViewByIndex:4];
    _fiveView = [self createNumberViewByIndex:5];
    _sixView = [self createNumberViewByIndex:6];
    
    //    Create TransForm:
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0/500;
    perspective = CATransform3DRotate(perspective, -M_PI_4, 1, 0, 0);
    perspective = CATransform3DRotate(perspective, -M_PI_4, 0, 1, 0);
    self.containerView.layer.sublayerTransform = perspective;
    
    //  add cube face 1:z轴向屏幕外移动100
    
    CATransform3D transform = CATransform3DMakeTranslation(0, 0, 100);
    //    _oneView.layer.transform = transform;
    [self addCubueView:_oneView WithTransForm:transform];
    //    add cube face2:
    //    1首先 沿着X轴向右移动100； M_PI_2 等于90°
    transform = CATransform3DMakeTranslation(100, 0, 0);
    //    2以Y轴为中心旋转90° 2在1的右侧
    transform = CATransform3DRotate(transform, M_PI_2, 0, 1, 0);
    [self addCubueView:_twoView WithTransForm:transform];
    
    //add cube face 3:
    //    1 沿着y轴向上移动100
    transform = CATransform3DMakeTranslation(0, -100, 0);
    //    沿着x轴 旋转90° 顺时针  3在1的顶部
    transform = CATransform3DRotate(transform, M_PI_2, 1, 0, 0);
    [self addCubueView:_threeView WithTransForm:transform];
    
    //    add cube face 4:
    //    沿着Y轴向下移动100
    transform = CATransform3DMakeTranslation(0, 100, 0);
    //    沿着x轴逆时针 旋转90°  4在1的底部
    transform = CATransform3DRotate(transform, -M_PI_2, 1, 0, 0);
    
    //    add cube face 5:
    //    沿着x轴向左移动100
    transform = CATransform3DMakeTranslation(-100, 0, 0);
    transform = CATransform3DRotate(transform, -M_PI_2,0, 1, 0);
    [self addCubueView:_fiveView WithTransForm:transform];
    
    //  add cubeface 6: 沿着z轴向屏幕内 移动100 也就是说每个面的大小应该是200 x200 现在写的100 应该是不对的
    
    transform = CATransform3DMakeTranslation(0, 0, -100);
    transform = CATransform3DRotate(transform, M_PI, 0, 1, 0);
    [self addCubueView:_sixView WithTransForm:transform];
}
//创建光影效果
- (void)applyLightingToFace:(CALayer *)face{
    CALayer *layer=[CALayer layer];
    
    layer.frame=face.bounds;
    
    [face addSublayer:layer];
    
    CATransform3D transform=face.transform;
//    之前一直被这句坑
    GLKMatrix4 matrix4 = GLKMatrix4Make(transform.m11, transform.m12, transform.m13, transform.m14, transform.m21, transform.m22, transform.m23, transform.m24, transform.m31, transform.m32, transform.m33, transform.m34, transform.m41, transform.m42, transform.m43, transform.m44);//三矩阵转四矩阵
    
    GLKMatrix3 matrix3=GLKMatrix4GetMatrix3(matrix4);
    
    GLKVector3 normal=GLKVector3Make(0, 0, 1);
    
    
    normal=GLKMatrix3MultiplyVector3(matrix3, normal);
    
    normal=GLKVector3Normalize(normal);
    
    GLKVector3 light=GLKVector3Normalize(GLKVector3Make(0, 1, -0.5));
    
    float dotProduct=GLKVector3DotProduct(light, normal);
    
    CGFloat shadow=1+dotProduct-AMBIENT_LIGHT;
    
    UIColor *color=[UIColor colorWithWhite:0 alpha:shadow];
    
    layer.backgroundColor=color.CGColor;
    
    
    
}

- (void)addCubueView:(NumberView *)numberView WithTransForm:(CATransform3D)transForm{
    [self.containerView addSubview:numberView];
    CGSize containerSize = self.containerView.bounds.size;
    numberView.center = CGPointMake(containerSize.width/2, containerSize.height/2);
    numberView.layer.transform = transForm;
    [self applyLightingToFace:numberView.layer];
    
}
- (NumberView *)createNumberViewByIndex:(NSInteger)index{
    if (index != 3) {
        NumberView *numberView = [[NumberView alloc]initWithFrame:CGRectMake(0, 0, 200, 200) Number:index Type:viewTypeDefault];
        numberView.backgroundColor = [UIColor whiteColor];
         return numberView;
    }else{
        NumberView *numberView = [[NumberView alloc]initWithFrame:CGRectMake(0, 0, 200, 200) Number:index Type:viewTypeButton];
        numberView.backgroundColor = [UIColor whiteColor];
        return numberView;
    }
    
   
}
@end
