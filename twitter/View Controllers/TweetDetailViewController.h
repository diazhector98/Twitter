//
//  TweetDetailViewController.h
//  twitter
//
//  Created by Hector Diaz on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@interface TweetDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *label;

@property (nonatomic, strong) Tweet *tweet;


@end

