//
//  ViewController.m
//  iOS8LocationDemo
//
//  Created by TTC on 4/1/15.
//  Copyright (c) 2015 TTC. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController () <CLLocationManagerDelegate> {
    CLLocationManager *_locationManager;
}

@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UIButton *locationBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
}

- (IBAction)clickLocationBtn:(id)sender {
    
    [_locationManager requestWhenInUseAuthorization]; // 使用该应用程序时访问位置
    
    // 或者选择, 未使用该应用程序时访问位置
//    [_locationManager requestAlwaysAuthorization];
    
    // 开始定位, 会调用- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
    [_locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:((CLLocation *)[locations lastObject]) completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark * placemark in placemarks) {
            __block NSDictionary *city = [placemark addressDictionary];
            __block NSString *locationCtiyStr = @"";
            __weak typeof(self) weakSelf = self;
            dispatch_async(dispatch_get_main_queue(), ^{
                if (city) {
                    NSArray *values = [city allValues];
                    for (NSInteger i = 0; i < city.count; i++) {
                        if (i == 6 || i == 4) {
                            continue;
                        }
                        NSString *temStr = [NSString stringWithFormat:@"%@\n", values[i]];
                        locationCtiyStr = [locationCtiyStr stringByAppendingString:temStr];
                    }
                    weakSelf.infoLabel.numberOfLines = city.count;
                    [weakSelf.infoLabel setText:locationCtiyStr];
                    weakSelf.infoLabel.font = [UIFont systemFontOfSize:20];
                    weakSelf.infoLabel.textAlignment = NSTextAlignmentCenter;
                    [_locationManager stopUpdatingLocation];
                }
            });
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
