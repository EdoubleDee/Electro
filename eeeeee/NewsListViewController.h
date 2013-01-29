//
//  NewsListViewController.h
//  eeeeee
//
//  Created by Buddha on 1/28/13.
//  Copyright (c) 2013 Buddha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ODRefreshControl.h"

@interface NewsListViewController : UIViewController  {
    IBOutlet UITableView *newsTable;
    NSArray *news;
    NSArray *menu;
    NSMutableData *data;
}

@property (strong, nonatomic) NSArray *news;
@property (strong,nonatomic) IBOutlet UITableView *newsTable;

@end
