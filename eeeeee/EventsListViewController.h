//
//  EventsListViewController.h
//  eeeeee
//
//  Created by Buddha on 1/28/13.
//  Copyright (c) 2013 Buddha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ODRefreshControl.h"

@interface EventsListViewController : UITableViewController {
    IBOutlet UITableView *eventsTable;
    NSArray *events;
    NSMutableData *data;
}

@property (strong, nonatomic) NSArray *events;
@property (strong,nonatomic) IBOutlet UITableView *eventsTable;

@end
