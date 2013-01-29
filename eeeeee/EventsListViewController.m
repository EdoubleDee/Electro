//
//  EventsListViewController.m
//  eeeeee
//
//  Created by Buddha on 1/28/13.
//  Copyright (c) 2013 Buddha. All rights reserved.
//

#import "EventsListViewController.h"

@interface EventsListViewController ()

@end

@implementation EventsListViewController

@synthesize events;
@synthesize eventsTable;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getEvents];
    ODRefreshControl *refreshControl = [[ODRefreshControl alloc]initInScrollView:self.eventsTable];
    [refreshControl addTarget:self action:@selector(dropViewDidBeginRefreshing:) forControlEvents:UIControlEventValueChanged];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dropViewDidBeginRefreshing:(ODRefreshControl *)refreshControl {
    double delayInSeconds = 3.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [refreshControl endRefreshing];
    });
}

#pragma mark - Table view data source
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    data = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)theData {
    [data appendData:theData];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    events = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    [self.eventsTable reloadData];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:@"Connectie Error" message:@"Controleer uw 3G/4G/WiFi en probeer opnieuw" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorView show];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

-(void) getEvents {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSURL *url = [NSURL URLWithString:@"http://c0d3.dyndns-ip.com/x2.php"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.events count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"NewsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [[events objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.detailTextLabel.text = [[events objectAtIndex:indexPath.row] objectForKey:@"date_string"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *mystring = [[events objectAtIndex:indexPath.row] objectForKey:@"title"];
    NSLog(@"%@",mystring);
    NSLog(@"Row Selected = %i",indexPath.row);
}
@end