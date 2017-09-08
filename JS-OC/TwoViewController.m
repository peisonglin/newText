//
//  TwoViewController.m
//  JS-OC
//
//  Created by lvdesheng on 2017/8/8.
//  Copyright © 2017年 lvdesheng. All rights reserved.
//

#import "TwoViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "TestJSObject.h"
@interface TwoViewController ()<UIWebViewDelegate>
@property (nonatomic,strong)UIWebView *webView;
@property (nonatomic,strong)UIActivityIndicatorView *hud;
@end

@implementation TwoViewController

-(void)keyboardWillShow{
    
    
    NSLog(@"强哥强哥强哥强哥强哥强哥强哥强哥强哥");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:@"jsoooooo"
                                               object:nil];

    UIButton *rightBuuton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [rightBuuton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [rightBuuton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [rightBuuton setTitle:@"按钮" forState:0];
    [rightBuuton addTarget:self action:@selector(rightButton:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBuuton];
    
    
    
    self.view.backgroundColor=[UIColor grayColor];
    [self.view addSubview:self.webView];
    [self.view addSubview:self.hud];
    
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.2.110:88/index.php/Home/index/table.html"]]];
    [self.hud startAnimating];
    // Do any additional setup after loading the view.
    
    
    //    $("textarea[class='question-input']")
    //    点击事件：
    //    Onclick=“voice（）”；

}

-(void)rightButton:(UIButton *)button{
    
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    NSString *textJS = @"imageClickAction('QQ')";
    [context evaluateScript:textJS];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    [self.hud stopAnimating];
    NSLog(@"失败");
    
    NSLog(@"%@",error.description);
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [self.hud stopAnimating];
    
    NSLog(@"成功");
    
    
//    [self.webView stringByEvaluatingJavaScriptFromString:@"\
//     function imageClickAction(meg){\
//     alert(meg);\
////     $('.auto-check-input').val(meg);\
//     }\
//     "];

    JSContext *context = [self.webView  valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    context.exceptionHandler = ^(JSContext *con, JSValue *exception) {
        NSLog(@"context：：：：：：：：%@", exception);
        con.exception = exception;
    };

    TestJSObject *jsObject=[[TestJSObject alloc]init];
    
    context[@"TestJSObject"]=jsObject;
    
    
    
//    [context evaluateScript:@"jsPuhs(‘qq’)"];

//    JSValue *Callback = context[@"TestJSObject.closeVoiceView()"];
//    
////    [context evaluateScript:@"imageClickAction('meg')"];
//    
//    
//    [context evaluateScript:@"TestJSObject.closeVoiceView"];

    
//    context[@"imageClickAction"] = ^() {
//        
//        [Callback callWithArguments:@[@"唤起本地OC回调完成"]];
//        
//        
//        
//    };
    
    
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
