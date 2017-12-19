//
//  SecondViewController.m
//  GesturePassword
//
//  Created by 范保莹 on 2017/12/19.
//  Copyright © 2017年 GesturePassword. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *myBtn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 200, 100)];
    myBtn.backgroundColor = [UIColor lightGrayColor];
    [myBtn setTitle:@"返回" forState:0];
    [myBtn addTarget:self action:@selector(myBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:myBtn];
}

- (void)myBtn:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
