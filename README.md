# iOS 手势密码锁demo

#### 首先看一下效果

![手势密码锁.gif](http://upload-images.jianshu.io/upload_images/2829694-b736f56182936d33.gif?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### 源码

[GitHub-demo](https://github.com/fanbaoying/GesturePassword)

#### 使用

1. 下载demo，拷贝GestureView文件夹到项目中

2. 在ViewController中引用
```
#import "GestureView.h"
```
3. 引用代理
```
@interface ViewController ()<GestureDelegate>
```
4. 在viewDidLoad中初始化GestureView
```
GestureView *gesView = [[GestureView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-self.view.frame.size.width-60, self.view.frame.size.width, self.view.frame.size.width)];
    gesView.delegate = self;
    [self.view addSubview:gesView];
```
5. 原密码为nil调用
```
//原密码为nil调用
- (void)GestureSetResult:(NSString *)result gestureView:(GestureView *)gestureView
{
    NSLog(@"输入密码：%@",result);
    [gestureView setRigthResult:result];
    _label.text = @"请输入密码";
}
```
6. 密码核对成功调用
```
//密码核对成功调用
- (void)GesturePasswordRight:(GestureView *)gestureView
{
    NSLog(@"密码正确");
    //    _label.text = @"密码正确";
    
    SecondViewController *svc = [[SecondViewController alloc]init];
    
    [self presentViewController:svc animated:YES completion:nil];
    
}
```
7. 密码核对失败调用
```
//密码核对失败调用
- (void)GesturePasswordWrong:(GestureView *)gestureView
{
    NSLog(@"密码错误");
    _label.text = @"密码错误";
    [self performSelector:@selector(resetLabel) withObject:nil afterDelay:1];
}
```

>希望可以帮助大家
如果哪里有什么不对或者不足的地方，还望读者多多提意见或建议
iOS技术交流群：668562416

![公众号](http://upload-images.jianshu.io/upload_images/2829694-48307b4d71bc5800.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/300)
