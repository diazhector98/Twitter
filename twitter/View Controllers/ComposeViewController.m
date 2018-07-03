//
//  ComposeViewController.m
//  twitter
//
//  Created by Hector Diaz on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "Tweet.h"
#import "APIManager.h"


@interface ComposeViewController () <ComposeViewControllerDelegate>

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)didTapPost:(id)sender {
    
    NSString *tweetString = self.textView.text;
    
    [[APIManager shared] composeTweetWith:tweetString completion:^(Tweet *tweet, NSError *error) {
    
        if(error) {
            
            NSLog(@"Error composing Tweet: %@", error.localizedDescription);
            
        } else {
            
            [self.delegate did:tweet];
            
            NSLog(@"Compose Tweet Success!");

            
        }
    }];
    
    [self dismissViewControllerAnimated: YES completion:nil];
    
}

- (IBAction)didTapCancel:(id)sender {
    
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
