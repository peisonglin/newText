//
//  OneViewController.m
//  JS-OC
//
//  Created by lvdesheng on 2017/8/8.
//  Copyright © 2017年 lvdesheng. All rights reserved.
//

#import "OneViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "TestJSObject.h"
@interface OneViewController ()<UIWebViewDelegate>

@property (nonatomic,strong)UIWebView *webView;
@property (nonatomic,strong)UIActivityIndicatorView *hud;
@property (nonatomic,strong)UIView *redView;
@end

@implementation OneViewController




-(void)keyboardWillHide:(NSNotification *)notification{

    
    NSNumber *s=[[notification userInfo]objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    
    [UIView animateWithDuration:s.floatValue animations:^{
        self.webView.transform=CGAffineTransformMakeTranslation(0, 0);
        self.redView.transform=CGAffineTransformMakeTranslation(0, 0);
    }];
    
}

-(void)closeVoice{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.webView.transform=CGAffineTransformMakeTranslation(0, 0);
        self.redView.transform=CGAffineTransformMakeTranslation(0, 0);
    }];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.tabBarController.tabBar.hidden=YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(closeVoice)
                                                 name:@"jsoooooo"
                                               object:nil];

    

    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
    UIButton *rightBuuton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [rightBuuton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [rightBuuton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [rightBuuton setTitle:@"开" forState:0];
    [rightBuuton addTarget:self action:@selector(rightButton:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBuuton];
    
    
    UIButton *rightBuuton1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [rightBuuton1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [rightBuuton1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [rightBuuton1 setTitle:@"关" forState:0];
    [rightBuuton1 addTarget:self action:@selector(rightButton1:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBuuton1];

    
    
    
//    self.view.backgroundColor=[UIColor grayColor];
//    [self.view addSubview:self.webView];
//    [self.view addSubview:self.hud];
    [self.view addSubview:self.redView];
//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://121.41.129.67:7093/wechatspeak/mobile.act"]]];
//    [self.hud startAnimating];
    // Do any additional setup after loading the view.
    
    
//    $("textarea[class='question-input']")
//    点击事件：
//    Onclick=“voice（）”；
}

-(void)rightButton:(UIButton *)button{
    
    
//    [UIView animateWithDuration:0.3 animations:^{
//        self.webView.transform=CGAffineTransformMakeTranslation(0, 0);
//        self.redView.transform=CGAffineTransformMakeTranslation(0, 0);
//    }];

    
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    context.exceptionHandler = ^(JSContext *con, JSValue *exception) {
        NSLog(@"按钮：：：%@", exception);
        con.exception = exception;
    };
    
    NSString *textJS = @"imageClickAction('open')";
    
    [context evaluateScript:textJS];
}

-(void)rightButton1:(UIButton *)button{
    
    
//    [UIView animateWithDuration:0.3 animations:^{
//        self.webView.transform=CGAffineTransformMakeTranslation(0, 0);
//        self.redView.transform=CGAffineTransformMakeTranslation(0, 0);
//    }];
    
    
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    context.exceptionHandler = ^(JSContext *con, JSValue *exception) {
        NSLog(@"按钮：：：%@", exception);
        con.exception = exception;
    };
    
    NSString *textJS = @"imageClickAction('close')";
    
    [context evaluateScript:textJS];
}


-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    [self.hud stopAnimating];
    NSLog(@"失败");
    
    NSLog(@"%@",error.description);
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [self.hud stopAnimating];

    [self.webView stringByEvaluatingJavaScriptFromString:@"\
     function imageClickAction(meg){\
     \
     }\
     "];

    JSContext *context = [self.webView  valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    context.exceptionHandler = ^(JSContext *con, JSValue *exception) {
        NSLog(@"context：：：：：：：：%@", exception);
        con.exception = exception;
    };

//    JSValue *Callback = context[@"voice"];
    
    TestJSObject *jsObject=[[TestJSObject alloc]init];
    
    context[@"TestJSObject"]=jsObject;

    context[@"imageClickAction"]=^(NSString *meg){
        
        if ([meg isEqualToString:@"close"]) {
            NSLog(@"关闭");
            [UIView animateWithDuration:0.3 animations:^{
                webView.transform=CGAffineTransformMakeTranslation(0, 0);
                self.redView.transform=CGAffineTransformMakeTranslation(0, 0);
            }];
            
        }else if([meg isEqualToString:@"open"]){
            
            NSLog(@"打开");
            [UIView animateWithDuration:0.3 animations:^{
                webView.transform=CGAffineTransformMakeTranslation(0, -261);
                self.redView.transform=CGAffineTransformMakeTranslation(0, -261);
            
                
            }];

        }
        
    };
    
    context[@"voice"] = ^() {
        
        
        if (self.redView.frame.origin.y==self.view.frame.size.height) {
            
            [UIView animateWithDuration:0.3 animations:^{
                webView.transform=CGAffineTransformMakeTranslation(0, -261);
                self.redView.transform=CGAffineTransformMakeTranslation(0, -261);
            }];
            
            JSContext *context1 = [webView  valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
            
            [context1 evaluateScript:@"$('textarea.question-input').val('婚姻法');$('.send-btn').attr('disabled', false);$('.send-btn').css('backgroundColor', '#1E90FF');"];

        }else{
            [UIView animateWithDuration:0.3 animations:^{
                webView.transform=CGAffineTransformMakeTranslation(0, 0);
                self.redView.transform=CGAffineTransformMakeTranslation(0, 0);
            }];

        }
        
        
     
        //         [Callback callWithArguments:@[@"唤起本地OC回调完成"]];
        
    };


}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSLog(@"%@",request.URL);
    NSLog(@"type:%ld",navigationType);
    
    return YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UIActivityIndicatorView *)hud{
    
    if (!_hud) {
        
        UIActivityIndicatorView *testActivityIndicator =[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        
        testActivityIndicator.center = self.view.center;
        
        testActivityIndicator.color = [UIColor redColor]; // 改变圈圈的颜色为红色； iOS5引入
        [testActivityIndicator setHidesWhenStopped:YES]; //当旋转结束时隐藏
        
        _hud=testActivityIndicator;
        
    }
    return _hud;
    
}
-(UIView *)redView{
    
    if (!_redView) {
        
        UIView *redView=[[UIView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 260)];
        redView.backgroundColor=[UIColor whiteColor];
        
        
        NSMutableArray *arrayLeft=[@[] mutableCopy];
        NSMutableArray *arrayRight=[@[] mutableCopy];
        
        for (int i=1; i<9; i++) {
            UIImage *image=[UIImage imageNamed:[NSString stringWithFormat:@"voice%d.png",i]];
            UIImage *image1=[UIImage imageNamed:[NSString stringWithFormat:@"voiceR%d.png",i]];
            [arrayLeft addObject:image];
            [arrayRight addObject:image1];
        }
        
        CGFloat dis=40;
        CGFloat w=50;
        CGFloat x=(self.view.frame.size.width-w*2-dis)/2;
        CGFloat y=50;
        CGFloat h=20;
        
        for (int i=0; i<2; i++) {
            UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(x+(dis+w)*i, y, w, h)];
            imageView.contentMode=UIViewContentModeScaleAspectFit;
            imageView.animationImages = i==0?arrayLeft:arrayRight; //获取Gif图片列表
            imageView.animationDuration = 1;     //执行一次完整动画所需的时长
            imageView.animationRepeatCount = MAX_CANON;  //动画重复次数
            [imageView startAnimating];
            [redView addSubview:imageView];
            
        }
        _redView=redView;
    }
    
    return _redView;

}
-(UIWebView *)webView{
    
    if (!_webView) {
        
        UIWebView *webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        webView.delegate=self;
        [webView sizeToFit];
        _webView=webView;
        
    }
    
    return _webView;
    
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
