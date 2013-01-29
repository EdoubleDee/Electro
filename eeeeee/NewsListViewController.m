//
//  NewsListViewController.m
//  eeeeee
//
//  Created by Buddha on 1/28/13.
//  Copyright (c) 2013 Buddha. All rights reserved.
//

#import "NewsListViewController.h"
#import "HBViewController.h"
#import "NewsItemViewController.h"

@interface NewsListViewController ()

@end

@implementation NewsListViewController


NSString *globalString = @""; //title of NewsItemView

@synthesize news;
@synthesize newsTable;


- (void)viewDidLoad {
    [super viewDidLoad];
    [self getNews];
    ODRefreshControl *refreshControl = [[ODRefreshControl alloc]initInScrollView:self.newsTable];
    [refreshControl addTarget:self action:@selector(dropViewDidBeginRefreshing:) forControlEvents:UIControlEventValueChanged];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//refresh and populate new data in table when pulled down
- (void)dropViewDidBeginRefreshing:(ODRefreshControl *)refreshControl {
    double delayInSeconds = 3.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [refreshControl endRefreshing];
        [self getNews];
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
    news = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    [self.newsTable reloadData];
}
//data could not be retrieved, notify user
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:@"Connection Error" message:@"Could not find server.\nPlease check your 3G/4G/WiFi connection!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorView show];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

//get path to local JSON file
-(void) getNews {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"news" withExtension:@"json"];
    NSString *json = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSURL *baseUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection connectionWithRequest:request delegate:self];
    #pragma unused(json)
    #pragma unused(baseUrl)
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.news count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"NewsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [[news objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.detailTextLabel.text = [[news objectAtIndex:indexPath.row] objectForKey:@"date_string"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    globalString = [[news objectAtIndex:indexPath.row] objectForKey:@"title"];
    NSLog(@"%@",globalString);
    NSLog(@"Row Selected = %i",indexPath.row);
    [self performSegueWithIdentifier:@"pushToNewsItem" sender:self.view];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"pushToNewsItem"]) {
        NewsItemViewController *foo = [segue destinationViewController];
        foo.title = globalString; //set title of detailview
    }
}
@end