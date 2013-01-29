//
//  WEBViewController.m
//  Electro Deluxe
//
//  Created by Buddha on 1/28/13.
//  Copyright (c) 2013 Buddha. All rights reserved.
//

#import "WEBViewController.h"

@interface WEBViewController ()

@end

@implementation WEBViewController
@synthesize customWebView;

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidLoad {
    [super viewDidLoad];
     NSString *httpSource = @"http://m.soundcloud.com/dough-dough/tracks";
     NSURL *fullUrl = [NSURL URLWithString:httpSource];
     NSURLRequest *httpRequest = [NSURLRequest requestWithURL:fullUrl];
     [customWebView loadRequest:httpRequest];
}

- (void)viewDidUnload {
    [self setCustomWebView:nil];
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
@end