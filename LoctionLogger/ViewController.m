//
//  ViewController.m
//  LoctionLogger
//
//  Created by Cornelis Kruger on 2014/11/14.
//  Copyright (c) 2014 private. All rights reserved.
//

#import "ViewController.h"
#import "DDLog.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *accuracyLabel;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *location;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationManager = [self setupLocationListener];
    self.location = [[CLLocation alloc] init];
    DDLogDebug(@"Did load");
}

- (CLLocationManager *)setupLocationListener {
    
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [locationManager setActivityType:CLActivityTypeFitness];// since this is a pedestrian activity
    locationManager.distanceFilter = kCLDistanceFilterNone;
    
    if ([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [locationManager performSelector:@selector(requestAlwaysAuthorization)];
    }
    
    [locationManager startUpdatingLocation];
    
    self.accuracyLabel.textColor = [UIColor redColor];
    self.accuracyLabel.text = [NSString stringWithFormat:@"..."];
    
    return locationManager;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    self.location = locations.lastObject;
    self.locationLabel.text = [NSString stringWithFormat:@"Lat: %.3f, Lon: %.3f", self.location.coordinate.latitude, self.location.coordinate.longitude];
    DDLogInfo(@"%@", self.location.description);
    
    self.accuracyLabel.textColor = [UIColor greenColor];
    self.accuracyLabel.text = [NSString stringWithFormat:@"%.3f", self.location.horizontalAccuracy];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
