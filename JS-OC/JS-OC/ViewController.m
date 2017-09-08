//
//  ViewController.m
//  JS-OC
//
//  Created by lvdesheng on 2017/8/7.
//  Copyright © 2017年 lvdesheng. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()<UIWebViewDelegate>


@property (nonatomic,strong)UIActivityIndicatorView *hud;
@property (nonatomic,strong)JSContext *JScontext;


@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.view.backgroundColor=[UIColor grayColor];
    
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(0, 10, 100, 50)];
    [button setTitle:@"按钮" forState:0];
    button.tag=1;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [self.view addSubview:self.webView];
    
    [self.view addSubview:self.hud];
    [self.hud startAnimating];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(jsPuhsrrr) name:@"jsoooooo" object:nil];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.2.142:88/index.php/Home/index/table.html"]]];
    
//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://121.41.129.67:7093/wechatspeak/mobile.act"]]];
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
    
}






-(void)buttonAction:(UIButton *)button{
    
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    NSString *textJS = @"jsPuhs()";
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
    
    JSContext *context = [self.webView  valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
  
    
    
    JSValue *Callback = context[@"jsPuhs"];
    
    context[@"jsPuhs"] = ^() {
        
        [Callback callWithArguments:@[@"唤起本地OC回调完成"]];
        

        
    };

    
 
//    //首先创建JSContext 对象（此处通过当前webView的键获取到jscontext）
//    JSContext *context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
//    
//    //js调用iOS
//    //第一种情况
//    //其中test1就是js的方法名称，赋给是一个block 里面是iOS代码
//    //此方法最终将打印出所有接收到的参数，js参数是不固定的 我们测试一下就知道
//    context[@"test1"] = ^() {
//        NSArray *args = [JSContext currentArguments];
//        for (id obj in args) {
//            NSLog(@"%@",obj);
//        }
//    };
//    //此处我们没有写后台（但是前面我们已经知道iOS是可以调用js的，我们模拟一下）
//    //首先准备一下js代码，来调用js的函数test1 然后执行
//    //一个参数
//    NSString *jsFunctStr=@"test1('参数1')";
//    [context evaluateScript:jsFunctStr];
//    
//    //二个参数
//    NSString *jsFunctStr1=@"test1('参数a','参数b')";
//    [context evaluateScript:jsFunctStr1];
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    //网页加载完成调用此方法
//    
//    //首先创建JSContext 对象（此处通过当前webView的键获取到jscontext）
//    self.JScontext=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
//    
//    //第二种情况，js是通过对象调用的，我们假设js里面有一个对象 testobject 在调用方法
//    //首先创建我们新建类的对象，将他赋值给js的对象
//    
//    TestJSObject *testJO=[TestJSObject new];
//    self.JScontext[@"testobject"]=testJO;
//    
//    //同样我们也用刚才的方式模拟一下js调用方法
//    NSString *jsStr1=@"testobject.TestNOParameter()";
//    [self.JScontext evaluateScript:jsStr1];
//    NSString *jsStr2=@"testobject.TestOneParameter('参数1')";
//    [self.JScontext evaluateScript:jsStr2];
//    NSString *jsStr3=@"testobject.TestTowParameterSecondParameter('参数A','参数B')";
//    [self.JScontext evaluateScript:jsStr3];
//    
//    NSString *jsStr4=@"testobject.jsPuhs()";
//    
//    [self.JScontext evaluateScript:jsStr4];
    
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSLog(@"%@",request.URL);
    NSLog(@"type:%ld",navigationType);
    
    return YES;
}


-(UIWebView *)webView{
    
    if (!_webView) {
        
        UIWebView *webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height-100)];
        webView.delegate=self;
        [webView sizeToFit];
        _webView=webView;
    
    }
    
    return _webView;
    
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
