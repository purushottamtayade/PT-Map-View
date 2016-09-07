//
//  ViewController.h
//  PTMaps
//
//  Created by Student P_06 on 06/09/16.
//  Copyright © 2016 Purushottam Tayade. All rights reserved.
//

#import <Mapkit/Mapkit.h>
#import <Corelocation/Corelocation.h>
#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <MKMapViewDelegate,CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
}

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
- (IBAction)segmentedControlMapType:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *mapType;

@end

