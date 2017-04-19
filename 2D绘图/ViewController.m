//
//  ViewController.m
//  2D绘图
//
//  Created by dashuios126 on 17/1/12.
//  Copyright © 2017年 dashuios126. All rights reserved.
//

#import "ViewController.h"

#import "StrokeView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic,strong) StrokeView *strokeView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

//    UIImage *image = [self createImageWithColor:[UIColor blueColor]];
//    self.imageView.image = image;

    self.strokeView = [[StrokeView alloc] init];
    self.strokeView.frame = self.view.bounds;
    self.strokeView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.strokeView];
}

- (UIImage *)createImageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
