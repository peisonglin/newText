//
//  ThreeViewController.m
//  JS-OC
//
//  Created by lvdesheng on 2017/8/8.
//  Copyright © 2017年 lvdesheng. All rights reserved.
//

#import "ThreeViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
@interface ThreeViewController ()<AMapLocationManagerDelegate>
@property (nonatomic,strong) AMapLocationManager * locManager;
@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _locManager = [[AMapLocationManager alloc]init];
//    _locManager.delegate = self;
//    _locManager.pausesLocationUpdatesAutomatically = NO;
//    _locManager.locatingWithReGeocode=YES;

    
    // Do any additional setup after loading the view.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [_locManager startUpdatingLocation];
    
}


- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error{
    
    NSLog(@"定位错误");
    
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode{
    
    NSLog(@"%@:::%@",location,reGeocode.formattedAddress);
    
    
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
