//
//  ViewController.m
//  iBeaconSample
//
//  Created by inukai on 2014/02/15.
//  Copyright (c) 2014年 inukai. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()<CLLocationManagerDelegate>{
}

@property (nonatomic) CLLocationManager *manager;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// 領域観測が利用可能かチェック
    if( ![CLLocationManager isMonitoringAvailableForClass:[CLBeaconRegion class]] ){
        NSLog(@"CLBeaconRegion利用不可");
        return;
    }
    // CLLocationManagerの生成
    self.manager = [[CLLocationManager alloc] init];
    self.manager.delegate = self;
    // UUIDを作成
    NSUUID *proximityUUID = [[NSUUID alloc] initWithUUIDString:@"906A3A7A-1A25-4F22-B375-92124D079EB5"];
    // CLBeaconRegionを生成
    CLBeaconRegion *beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:proximityUUID identifier:@"com.oukasoft.iBeaconSample"];
    // 監視をスタート
    [self.manager startMonitoringForRegion:beaconRegion];
    
    
    
}

/*
 * 監視を開始
 */
- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region{
    NSLog(@"%s",__FUNCTION__);
    [self sendNotification:@"start monitoring"];
}
/*
 * 領域に入った
 */
- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region{
    [self sendNotification:@"enter region"];
    if ([region isMemberOfClass:[CLBeaconRegion class]] && [CLLocationManager isRangingAvailable]) {
        // 領域内に入ったビーコンデバイスとの距離を監視する
        [self.manager startRangingBeaconsInRegion:(CLBeaconRegion *)region];
    }
}
/*
 * 領域から出た
 */
- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region{
    [self sendNotification:@"exit region"];
    if ([region isMemberOfClass:[CLBeaconRegion class]] && [CLLocationManager isRangingAvailable]) {
        // 領域内から出たビーコンデバイスの監視を止める
        [self.manager stopRangingBeaconsInRegion:(CLBeaconRegion *)region];
    }
}
/*
 * ビーコンデバイスの監視中に定期的に呼ばれる
 */
- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region{
    NSLog(@"%s",__FUNCTION__);
    if (beacons.count > 0) {
        CLBeacon *nearestBeacon = beacons.firstObject;
        
        NSString *rangeMessage;
        
        switch (nearestBeacon.proximity) {
            case CLProximityImmediate:
                rangeMessage = @"Range Immediate: ";
                break;
            case CLProximityNear:
                rangeMessage = @"Range Near: ";
                break;
            case CLProximityFar:
                rangeMessage = @"Range Far: ";
                break;
            default:
                rangeMessage = @"Range Unknown: ";
                break;
        }
        
        NSString *message = [NSString stringWithFormat:@"major:%@, minor:%@, accuracy:%f, rssi:%ld",
                             nearestBeacon.major, nearestBeacon.minor, nearestBeacon.accuracy, (long)nearestBeacon.rssi];
        [self sendNotification:message];
    }
}
/*
 * 監視中に何かのエラーが発生した時
 */
- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error{
    NSLog(@"%s",__FUNCTION__);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)sendNotification:(NSString *)message
{
    NSLog(@"message:%@",message);
    UILocalNotification *localNotification = [UILocalNotification new];
    localNotification.alertBody = message;
    localNotification.fireDate = [NSDate date];
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

@end
