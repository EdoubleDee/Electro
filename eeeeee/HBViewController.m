//
//  HBViewController.m
//  eeeeee
//
//  Created by Buddha on 1/27/13.
//  Copyright (c) 2013 Buddha. All rights reserved.
//

#import "HBViewController.h"

@interface HBViewController ()

@property (strong, nonatomic) NSArray *menu;
@property (strong, nonatomic) NSArray *submenu;
@property (strong, nonatomic) IBOutlet UITableView *table;

@end

@implementation HBViewController

- (void)viewDidLoad {
    //main news titles
    self.menu = [NSArray arrayWithObjects:@"News", @"Events",@"Music",@"Pictures",@"Social",nil];
    //sub news titles
    self.submenu = [NSArray arrayWithObjects:@"Latest Electro News ", @"Upcoming Events",@"Recorded DJ Sets",@"See What Happend!",@"Get Social @ Facebook and/or Twitter",nil];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.menu count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"mainCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.menu objectAtIndex:indexPath.row]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [self.submenu objectAtIndex:indexPath.row]];
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Row Selected = %i",indexPath.row);
    if(indexPath.row == 0) {
        [self performSegueWithIdentifier:@"pushToNewsList" sender:self.view];
    }
    else if (indexPath.row == 1){
        [self performSegueWithIdentifier:@"pushToEventsList" sender:self.view];
    }
    else if(indexPath.row == 2) {
             [self performSegueWithIdentifier:@"pushToDJList" sender:self.view];
    }
    else if(indexPath.row == 3) {
        UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Not implemented.\n" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [errorView show];
    }
    else {
        UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Not implemented" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [errorView show];
    }
}
//pass shared data from origin to next pushed view
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
}

@end