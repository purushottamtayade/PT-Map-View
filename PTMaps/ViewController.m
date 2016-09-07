//
//  ViewController.m
//  PTMaps
//
//  Created by Student P_06 on 06/09/16.
//  Copyright © 2016 Purushottam Tayade. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    locationManager = [[CLLocationManager alloc]init];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [locationManager requestWhenInUseAuthorization];
    self.mapView.showsUserLocation = YES;
    UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleGesture:)];
    longGesture.minimumPressDuration = 2.0;
    [self.mapView addGestureRecognizer:longGesture];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)handleGesture:(UIGestureRecognizer *)gesture{
    if(gesture.state == UIGestureRecognizerStateBegan)
    {
        CGPoint touchPoint = [gesture locationInView:self.mapView];
        CLLocationCoordinate2D myCoordinate = [self.mapView convertPoint:touchPoint toCoordinateFromView:gesture.view];
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc]init];
        annotation.coordinate = myCoordinate;
        
        CLGeocoder *geoCoder = [[CLGeocoder alloc
                              ]init];
        CLLocation *geoLocation = [[CLLocation alloc]initWithLatitude:myCoordinate.latitude longitude:myCoordinate.longitude];
        [geoCoder reverseGeocodeLocation:geoLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            if(error)
            {
                NSLog(@"%@",error.localizedDescription);
                return;
            }
            if(placemarks.count>0)
            {
                CLPlacemark *placemark = placemarks.firstObject;
                NSString *title;
                if(placemark.thoroughfare != nil)
                {
                    if(placemark.subThoroughfare != nil)
                    {
                        title = [placemark.thoroughfare stringByAppendingString:placemark.subThoroughfare];
                    }
                    else
                    {
                        title = placemark.thoroughfare;
                    }
                }
                NSString *subtitle = placemark.subLocality;
                annotation.title = title;
                annotation.subtitle = subtitle;
            }
            else{
                annotation.title = @"Unknown Place";
            }
            [self.mapView addAnnotation:annotation];
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)segmentedControlMapType:(id)sender {
    UISegmentedControl *control = sender;
    if(control.selectedSegmentIndex ==0)
    {
        [self.mapView setMapType:MKMapTypeStandard];
    }else if(control.selectedSegmentIndex == 1)
    {
        [self.mapView setMapType:MKMapTypeSatellite];
    }
    else if(control.selectedSegmentIndex == 2)
    {
        [self.mapView setMapType:MKMapTypeHybrid];
    }
}


#pragma mark CLLocationManager Delegate Methods

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"%@",error.localizedDescription);
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *currentLocation = locations.lastObject;
    NSLog(@"Lat : %f Long : %f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
}
@end
