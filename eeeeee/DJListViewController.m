//
//  DJListViewController.m
//  Electro Deluxe
//
//  Created by Buddha on 1/28/13.
//  Copyright (c) 2013 Buddha. All rights reserved.
//

#import "DJListViewController.h"

@interface DJListViewController ()

@property (strong, nonatomic) NSArray *djs;
@property (strong, nonatomic) NSArray *djGenre;


@end

@implementation DJListViewController

- (void)viewDidLoad {
    self.djs = [NSArray arrayWithObjects:@"Dough", @"Big J",@"IUS Mob",@"Stefan Vincent",nil];
    self.djGenre = [NSArray arrayWithObjects:@"Electro/ Glitch / Dubstep / Hiphop   [afbeelding ]", @"Techno / Electro / Glitch / Hiphop",@"Electro / Braindance ",@"Techno / Minimal",nil];

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
    return [self.djs count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"mainCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.djs objectAtIndex:indexPath.row]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [self.djGenre objectAtIndex:indexPath.row]];
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Row Selected = %i",indexPath.row);
    if(indexPath.row == 0) {
        [self performSegueWithIdentifier:@"pushToWebDJ" sender:self.view];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
}

@end
