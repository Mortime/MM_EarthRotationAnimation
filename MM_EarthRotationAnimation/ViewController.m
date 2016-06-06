//
//  ViewController.m
//  MM_EarthRotationAnimation
//
//  Created by Mortimey on 16/6/6.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "ViewController.h"


#define ScreenWidth self.view.bounds.size.width
#define ScreenHeight self.view.bounds.size.height


@interface ViewController ()
{
    
    UIImageView *earthImage;
    UIImageView *peopelImage;
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    [self initUI];
    
}
- (void)initUI{
    earthImage = [[UIImageView alloc]initWithFrame:CGRectMake(- (ScreenWidth / 2), 200, ScreenWidth * 2, ScreenWidth * 2)];
    earthImage.image = [UIImage imageNamed:@"5_05"];
    [self rotationpAnimationImageView:earthImage];
    [self.view addSubview:earthImage];
    
    peopelImage = [[UIImageView alloc]initWithFrame:CGRectMake(50,ScreenHeight / 2 , 60, 60)];
    [self animationImageView:@"run" count:9];
    [self.view addSubview:peopelImage];

}
#pragma mark --- 实现效果图中小人的动态跑步
 - (void)animationImageView:(NSString *)imageName count:(NSInteger)count
{
    // 判断动画是否在执行
    if ([peopelImage isAnimating]) return;
    NSMutableArray *arrayM = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        NSString *imageNamePath = [NSString stringWithFormat:@"%@%d.png", imageName, i+1];
        // 设置全路径
        NSString *path = [[NSBundle mainBundle] pathForResource:imageNamePath ofType:nil];
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        [arrayM addObject:image];
    }
    // 设置动画数据
    peopelImage.animationImages = arrayM;
    peopelImage.animationRepeatCount = 0;
    peopelImage.animationDuration = peopelImage.animationImages.count * 0.05;
    // 动画开始
    [peopelImage startAnimating];}

#pragma mark --- 旋转动画
-(void)rotationpAnimationImageView:(UIImageView *)image
{
    CABasicAnimation *animation = [ CABasicAnimation
                                   animationWithKeyPath: @"transform" ];
    // 设置类型
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    // 让旋转围绕Z轴
    animation.toValue = [ NSValue valueWithCATransform3D:
                         CATransform3DMakeRotation(M_PI , 0.0, 0.0, 1.0) ];
    animation.duration = 5;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    // 添加一个像素的透明图片,去除边缘锯齿
    CGRect imageRrect = CGRectMake(0, 0,image.frame.size.width, image.frame.size.height);
    UIGraphicsBeginImageContext(imageRrect.size);
    [image.image drawInRect:CGRectMake(1,1,image.frame.size.width-2,image.frame.size.height-2)];
    image.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [image.layer addAnimation:animation forKey:nil]; }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
