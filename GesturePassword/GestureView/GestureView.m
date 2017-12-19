//
//  GestureView.m
//  GesturePassword
//
//  Created by 范保莹 on 2017/12/19.
//  Copyright © 2017年 GesturePassword. All rights reserved.
//

#import "GestureView.h"

#define SELECT_COLOR [UIColor colorWithRed:0.3 green:0.7 blue:1 alpha:1]

@interface GestureView ()

@property (strong, nonatomic) NSMutableArray *selectBtnArr;
@property (assign, nonatomic) CGPoint currentPoint;
@property (strong, nonatomic) NSString *rightResult;

@end

@implementation GestureView
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _selectBtnArr = [[NSMutableArray alloc]initWithCapacity:0];
        self.backgroundColor = [UIColor clearColor];
        float interval = frame.size.width/13;
        float radius = interval*3;
        for (int i = 0; i < 9; i ++) {
            int row = i/3;
            int list = i%3;
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(list*(interval+radius)+interval, row*(interval+radius)+interval, radius, radius)];
            btn.userInteractionEnabled = NO;
            [btn setImage:[self drawUnselectImageWithRadius:radius-6] forState:UIControlStateNormal];
            [btn setImage:[self drawSelectImageWithRadius:radius-6] forState:UIControlStateSelected];
            [self addSubview:btn];
            btn.tag = i + 1;
        }
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    UIBezierPath *path;
    if (_selectBtnArr.count == 0) {
        return;
    }
    path = [UIBezierPath bezierPath];
    path.lineWidth = 6;
    path.lineJoinStyle = kCGLineCapRound;
    path.lineCapStyle = kCGLineCapRound;
    if (self.userInteractionEnabled) {
        [[UIColor yellowColor] set];
    }else
    {
        [[UIColor orangeColor] set];
    }
    for (int i = 0; i < _selectBtnArr.count; i ++) {
        UIButton *btn = _selectBtnArr[i];
        if (i == 0) {
            [path moveToPoint:btn.center];
        }else
        {
            [path addLineToPoint:btn.center];
        }
    }
    [path addLineToPoint:_currentPoint];
    [path stroke];
}

//设置密码
- (void)setRigthResult:(NSString *)rightResult
{
    _rightResult = rightResult;
}

//视图恢复原样
- (void)resetView
{
    for (UIButton *oneSelectBtn in _selectBtnArr) {
        oneSelectBtn.selected = NO;
    }
    [_selectBtnArr removeAllObjects];
    [self setNeedsDisplay];
}

//输入错误回到原状态
- (void)wrongRevert:(NSArray *)arr
{
    self.userInteractionEnabled = YES;
    for (UIButton *btn in arr) {
        float interval = self.frame.size.width/13;
        float radius = interval*3;
        [btn setImage:[self drawSelectImageWithRadius:radius-6] forState:UIControlStateSelected];
    }
    [self resetView];
}

#pragma mark - Touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *oneTouch = [touches anyObject];
    CGPoint point = [oneTouch locationInView:self];
    for (UIButton *oneBtn in self.subviews) {
        if (CGRectContainsPoint(oneBtn.frame, point)) {
            oneBtn.selected = YES;
            if (![_selectBtnArr containsObject:oneBtn]) {
                [_selectBtnArr addObject:oneBtn];
            }
        }
    }
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *oneTouch = [touches anyObject];
    CGPoint point = [oneTouch locationInView:self];
    _currentPoint = point;
    for (UIButton *oneBtn in self.subviews) {
        if (CGRectContainsPoint(oneBtn.frame, point)) {
            oneBtn.selected = YES;
            if (![_selectBtnArr containsObject:oneBtn]) {
                [_selectBtnArr addObject:oneBtn];
            }
        }
    }
    [self setNeedsDisplay];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //获取结果
    NSMutableString *result = [[NSMutableString alloc]initWithCapacity:0];
    for (int i = 0; i < _selectBtnArr.count; i ++) {
        UIButton *btn = (UIButton *)_selectBtnArr[i];
        [result appendFormat:@"%d",(int)btn.tag];
    }
    
    
    UIButton *lastBtn = [_selectBtnArr lastObject];
    _currentPoint = lastBtn.center;
    
    
    //结果与正确密码比较
    if (_rightResult) {
        if ([_rightResult isEqualToString:result]) {//密码正确
            [self.delegate GesturePasswordRight:self];
            [self resetView];
        }else
        {//密码错误
            [self.delegate GesturePasswordWrong:self];
            for (UIButton *btn in _selectBtnArr) {
                float interval = self.frame.size.width/13;
                float radius = interval*3;
                [btn setImage:[self drawWrongImageWithRadius:radius-6] forState:UIControlStateSelected];
            }
            [self performSelector:@selector(wrongRevert:) withObject:[NSArray arrayWithArray:_selectBtnArr] afterDelay:1];
            self.userInteractionEnabled = NO;
            [self setNeedsDisplay];
        }
    }else
    {//无密码设置密码
        [self.delegate GestureSetResult:result gestureView:self];
        [self resetView];
    }
    
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

#pragma mark - CGContext使用
//画未选中点图片
- (UIImage *)drawUnselectImageWithRadius:(float)radius
{
    UIGraphicsBeginImageContext(CGSizeMake(radius+6, radius+6));
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextAddEllipseInRect(context, CGRectMake(3, 3, radius, radius));
    [[UIColor colorWithRed:1 green:1 blue:1 alpha:0.8] setStroke];
    CGContextSetLineWidth(context, 5);
    
    CGContextDrawPath(context, kCGPathStroke);
    
    UIImage *unselectImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return unselectImage;
}

//画选中点图片
- (UIImage *)drawSelectImageWithRadius:(float)radius
{
    UIGraphicsBeginImageContext(CGSizeMake(radius+6, radius+6));
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 5);
    
    CGContextAddEllipseInRect(context, CGRectMake(3+radius*5/12, 3+radius*5/12, radius/6, radius/6));
    
    UIColor *selectColor = SELECT_COLOR;
    
    [selectColor set];
    
    CGContextDrawPath(context, kCGPathFillStroke);
    
    CGContextAddEllipseInRect(context, CGRectMake(3, 3, radius, radius));
    
    [selectColor setStroke];
    
    CGContextDrawPath(context, kCGPathStroke);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

//画错误图片
- (UIImage *)drawWrongImageWithRadius:(float)radius
{
    UIGraphicsBeginImageContext(CGSizeMake(radius+6, radius+6));
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 5);
    
    CGContextAddEllipseInRect(context, CGRectMake(3+radius*5/12, 3+radius*5/12, radius/6, radius/6));
    
    UIColor *selectColor = [UIColor orangeColor];
    
    [selectColor set];
    
    CGContextDrawPath(context, kCGPathFillStroke);
    
    CGContextAddEllipseInRect(context, CGRectMake(3, 3, radius, radius));
    
    [selectColor setStroke];
    
    CGContextDrawPath(context, kCGPathStroke);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

@end
