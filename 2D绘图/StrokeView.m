//
//  StrokeView.m
//  2D绘图
//
//  Created by dashuios126 on 17/1/12.
//  Copyright © 2017年 dashuios126. All rights reserved.
//

#import "StrokeView.h"

//弧度转角度
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
//角度转弧度
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@implementation StrokeView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

/*   －获取一个与视图相关联的上下文

 －创建一个可变路径（本身是有一个默认路径的）

 1.创建路径

 2.设置路径起点

 3.增加路径内容

 －将路径添加到上下文

 －设置上下文状态

 1.设置边线颜色

 2.设置填充颜色

 3.设置线宽

 4.设置线段连接样式

 5.设置线段首位样式

 6.设置虚线样式

 －绘制路径
 －释放路径
 */
- (void)drawRect:(CGRect)rect {
    // Drawing code
//    [self drawLine];
//    [self drawCircle];

//    [self drawRectangle];


    [self drawArc];
    [self drawGradient];

}
#pragma mark - 绘制渐变
- (void)drawGradient
{
    //	1. 定义渐变引用CGGradientRef
    CGGradientRef gradient;
    //	2. 定义色彩空间引用
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //	3. 定义渐变颜色组件
    //	  每四个数一组，分别对应r,g,b,透明度
    CGFloat components[8] = {0.0, 0.0, 1.0, 1.0, 0.0, 0.0, 1.0, 1.0};
    //	4. 定义颜色渐变位置
    // 第一个颜色开始渐变的位置
    // 第二个颜色结束渐变的位置
    CGFloat locations[2] = {0, 1};

    //	5. 创建颜色渐进
    gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, 2);

    //	6. 创建贝塞尔路径，是OC的，如果只是制定了渐变，没有指定剪切路径，就是整个视图的渐变
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(50, 50, 200, 200)];
    //	7. 添加剪切路径
    [path addClip];

    //	8. 绘制线性渐进
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawLinearGradient(context, gradient, CGPointMake(50, 50), CGPointMake(200, 50), kCGGradientDrawsAfterEndLocation);

    //	9. 释放颜色空间
    CGColorSpaceRelease(colorSpace);
    //	10. 释放渐变引用
    CGGradientRelease(gradient);
}

#pragma mark 绘制圆弧
- (void)drawArc{

    CGContextRef context = UIGraphicsGetCurrentContext();
    // 2. 添加弧线
    // 2.1 上下文
    // 2.2 中心点坐标
    // 2.3 半径
    // 2.4 开始角度，结束角度，角度的单位是“弧度”
    CGContextAddArc(context, 150, 300, 50, DEGREES_TO_RADIANS(180), DEGREES_TO_RADIANS(0), 0);
    CGContextStrokePath(context);
}

#pragma mark 绘制矩形
- (void)drawRectangle{
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextFillRect(context, CGRectMake(100, 200, 100, 100));
    CGContextStrokeRect(context,CGRectMake(100, 100, 50, 50));
    CGContextStrokePath(context);
}
#pragma mark 绘制圆
- (void)drawCircle{

    CGContextRef context = UIGraphicsGetCurrentContext();

    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddEllipseInRect(path, NULL, CGRectMake(100, 200, 100, 100));
    CGContextAddPath(context, path);
    CGContextStrokePath(context);
    CGPathRelease(path);
}
#pragma mark 绘制线
- (void)drawLine{


    CGContextRef context = UIGraphicsGetCurrentContext();

    CGMutablePathRef path = CGPathCreateMutable();

    CGPathMoveToPoint(path, NULL, 20, 20);
    CGPathAddLineToPoint(path, NULL, 100, 100);

    CGContextAddPath(context, path);

    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextSetLineWidth(context, 2.0);
    //设置线段连接样式
    CGContextSetLineJoin(context, kCGLineJoinBevel);
    //设置线段首位样式
    CGContextSetLineCap(context, kCGLineCapSquare);

    CGContextStrokePath(context);
    CGPathRelease(path);
}

@end
