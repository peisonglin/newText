//
//  TestJSObject.h
//  JS-OC
//
//  Created by lvdesheng on 2017/8/7.
//  Copyright © 2017年 lvdesheng. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <JavaScriptCore/JavaScriptCore.h>

//首先创建一个实现了JSExport协议的协议
@protocol TestJSObjectProtocol <JSExport>

//此处我们测试几种参数的情况

-(void)closeVoiceView;
-(void)closeLvJianXiaPage;
-(void)voice;
-(void)jsPuhs:(NSString *)meg;
@end

@interface TestJSObject : NSObject<TestJSObjectProtocol>

@end


