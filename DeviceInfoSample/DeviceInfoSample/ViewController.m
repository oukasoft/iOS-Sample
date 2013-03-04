//
//  ViewController.m
//  SampleDeviceInfo
//
//  Created by inukai on 2013/02/26.
//  Copyright (c) 2013年 inukai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize output;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    output = [[UILabel alloc]initWithFrame:CGRectMake(10.0, 10.0, self.view.frame.size.height, self.view.frame.size.width)];
    output.numberOfLines = 20;
    output.textColor = [UIColor blackColor];
    output.font      = [UIFont fontWithName:@"AppleGothic" size:16];
    output.textAlignment = UITextAlignmentLeft;
    
    NSString *str = @"[端末の名称/OSの情報など]\r\n";
    UIDevice *dev = [UIDevice currentDevice];
    
    str = [str stringByAppendingFormat:@"name -%@\r\n" , dev.name ];
    str = [str stringByAppendingFormat:@"model -%@\r\n", dev.model ];
    str = [str stringByAppendingFormat:@"localizedModel -%@\r\n" , dev.localizedModel ];
    str = [str stringByAppendingFormat:@"systemName -%@\r\n", dev.systemName ];
    str = [str stringByAppendingFormat:@"systemVersion -%@\r\n", dev.systemVersion ];
    
    str = [str stringByAppendingFormat:@"[バッテリーの情報]\r\n"];
    dev.batteryMonitoringEnabled = YES;
    str = [str stringByAppendingFormat:@"batteryLevel -%f\r\n", dev.batteryLevel ];
    if( UIDeviceBatteryStateUnknown == dev.batteryState ){
        str = [str stringByAppendingFormat:@"batteryLevel 不明\r\n" ];
    }else if( UIDeviceBatteryStateUnplugged == dev.batteryState ){
        str = [str stringByAppendingFormat:@"batteryLevel 充電してない\r\n" ];
    }else if( UIDeviceBatteryStateCharging == dev.batteryState ){
        str = [str stringByAppendingFormat:@"batteryLevel 充電なう\r\n" ];
    }else if( UIDeviceBatteryStateFull == dev.batteryState ){
        str = [str stringByAppendingFormat:@"batteryLevel フル充電\r\n" ];
    }
    output.text = str;
    [self.view addSubview:output];
}
-(void)viewDidAppear:(BOOL)animated{
    UIDevice *dev = [UIDevice currentDevice];
    NSString *str = output.text;
    str = [str stringByAppendingFormat:@"[端末の向き]\r\n"];
    if( UIDeviceOrientationPortrait ==  [dev orientation]){
        str = [str stringByAppendingFormat:@"Portrait\r\n"];
    }else if( UIDeviceOrientationPortraitUpsideDown ==  [dev orientation] ){
        str = [str stringByAppendingFormat:@"PortraitUpsideDown\r\n"];
    }else if( UIDeviceOrientationLandscapeLeft  ==  [dev orientation] ||
             UIDeviceOrientationLandscapeRight  == [dev orientation] ){
        str = [str stringByAppendingFormat:@"Landscape\r\n"];
    }
    output.text = str;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setOutput:nil];
    [super viewDidUnload];
}


@end
