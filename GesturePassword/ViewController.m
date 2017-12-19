//
//  ViewController.m
//  GesturePassword
//
//  Created by 范保莹 on 2017/12/19.
//  Copyright © 2017年 GesturePassword. All rights reserved.
//

#import "ViewController.h"

#import "GestureView.h"

#import "SecondViewController.h"

@interface ViewController ()<GestureDelegate>

@property (strong, nonatomic) UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIImageView *backImge = [[UIImageView alloc]initWithFrame:self.view.frame];
    backImge.image = [UIImage imageNamed:@"earth"];
    [self.view addSubview:backImge];
    
    GestureView *gesView = [[GestureView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-self.view.frame.size.width-60, self.view.frame.size.width, self.view.frame.size.width)];
    gesView.delegate = self;
    [self.view addSubview:gesView];
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-40, 80, 100, 30)];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.text = @"请设置密码";
    _label.textColor = [UIColor greenColor];
    [self.view addSubview:_label];
}

- (void)resetLabel
{
    _label.text = @"请输入密码";
}

#pragma mark - GestureLockViewDelegate

//原密码为nil调用
- (void)GestureSetResult:(NSString *)result gestureView:(GestureView *)gestureView
{
    NSLog(@"输入密码：%@",result);
    [gestureView setRigthResult:result];
    _label.text = @"请输入密码";
}

//密码核对成功调用
- (void)GesturePasswordRight:(GestureView *)gestureView
{
    NSLog(@"密码正确");
    //    _label.text = @"密码正确";
    
    SecondViewController *svc = [[SecondViewController alloc]init];
    
    [self presentViewController:svc animated:YES completion:nil];
    
}

//密码核对失败调用
- (void)GesturePasswordWrong:(GestureView *)gestureView
{
    NSLog(@"密码错误");
    _label.text = @"密码错误";
    [self performSelector:@selector(resetLabel) withObject:nil afterDelay:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
