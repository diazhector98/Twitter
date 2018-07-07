//
//  TweetDetailViewController.m
//  twitter
//
//  Created by Hector Diaz on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TweetDetailViewController.h"

@interface TweetDetailViewController ()

@end

@implementation TweetDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.label.text = @"Hi!";

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setTweet:(Tweet *)tweet {
    
    _tweet = tweet;
    
    NSLog(@"Set tweet called");
    
}

- (IBAction)didPressBack:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
