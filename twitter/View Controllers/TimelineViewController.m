//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "Tweet.h"
#import "TweetCell.h"
#import "APIManager.h"
#import "ComposeViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "TweetDetailViewController.h"

@interface TimelineViewController () <UITableViewDelegate, UITableViewDataSource, ComposeViewControllerDelegate>

@end

@implementation TimelineViewController
- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear: YES];
    
    [self.tableView reloadData];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    
    [self.tableView insertSubview:refreshControl atIndex:0];
    
    self.tweets = [[NSMutableArray alloc] init];
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    self.tableView.rowHeight = 130;
    
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            
            //self.tweets = [Tweet tweetsWithArray:tweets];
            self.tweets = tweets;
            
            [self.tableView reloadData];
            
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];
}

//Refresh control

-(void) beginRefresh: (UIRefreshControl *) refreshControl {
    
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            
            //self.tweets = [Tweet tweetsWithArray:tweets];
            self.tweets = tweets;
            
            [self.tableView reloadData];
            
            [refreshControl endRefreshing];
            
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];
    
}

- (void)did:(Tweet *)post {
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:self.tweets];
    
    [array addObject: post];
    
    self.tweets = [array copy];
    
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.tweets.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell" forIndexPath:indexPath];
        
    Tweet *tweet = self.tweets[indexPath.row];
    
    cell.profileImageView.layer.cornerRadius = cell.imageView.frame.size.width / 2;
    
    cell.profileImageView.clipsToBounds = YES;
    
    cell.tweet = tweet;
    
    return cell;
    
}

- (IBAction)didTapCompose:(id)sender {
    
    
}


//Logout

- (IBAction)didTapLogout:(id)sender {
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    
    appDelegate.window.rootViewController = loginViewController;
    
    [[APIManager shared] logout];
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
//
    NSString *identifier = [NSString stringWithFormat:@"%@", segue.identifier];
    
    if([identifier isEqualToString:@"composeTweetSegue"]) {
        
        ComposeViewController *composeViewController = [segue destinationViewController];
        
        composeViewController.delegate = self;
        
    } else {
        
        TweetCell *tweetCell = (TweetCell *) sender;
        
        Tweet *tweet = tweetCell.tweet;
        
        TweetDetailViewController *tweetViewController = [segue destinationViewController];
        
        tweetViewController.tweet = tweet;
        
        NSLog(@"%@", tweet.text);
                
    }
    
    
}



@end
