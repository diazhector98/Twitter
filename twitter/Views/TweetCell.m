//
//  TweetCell.m
//  twitter
//
//  Created by Hector Diaz on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"
#import "DateTools.h"


@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setTweet:(Tweet *)tweet {
    
    _tweet = tweet;
        
    [self refreshData];
    
    
}

-(void) refreshData {
    
//    Set labels
    
    User *user = self.tweet.user;
    
    self.nameLabel.text = user.name;
    
    self.tweetTextLabel.text = self.tweet.text;
    
    self.usernameLabel.text = [NSString stringWithFormat:@"@%@", user.screenName];
    
//    Date
    
    self.dateLabel.text = self.tweet.creationDate.shortTimeAgoSinceNow;


//    Set image
    
    NSURL *imageuRL = [NSURL URLWithString: user.profileImageUrl];
    
    [self.profileImageView setImageWithURL: imageuRL];
    
    self.profileImageView.layer.cornerRadius = self.imageView.frame.size.width / 2;
    
    self.profileImageView.clipsToBounds = YES;
    
//    Set favorite and retweet buttons
    
    if(self.tweet.favorited) {
                
        UIImage *image = [UIImage imageNamed:@"favor-icon-red"];
                
        [self.likeButton setImage:image forState:UIControlStateNormal];
        
    } else {
        
        UIImage *image = [UIImage imageNamed:@"favor-icon"];
        
        [self.likeButton setImage:image forState:UIControlStateNormal];
    }
    
    if(self.tweet.retweeted) {
        
        UIImage *image = [UIImage imageNamed:@"retweet-icon-green"];
        
        [self.retweetButton setImage:image forState:UIControlStateNormal];
        
    } else {
        
        UIImage *image = [UIImage imageNamed:@"retweet-icon"];
        
        [self.retweetButton setImage:image forState:UIControlStateNormal];
    }
    
}
- (IBAction)didTapFavorite:(id)sender {
    
    if(self.tweet.favorited) {
        
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            
            if(error){
                NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
            }
            
        }];
        
        self.tweet.favorited = NO;
        
        self.tweet.favoriteCount -= 1;
        
    } else {
        
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            
            if(error){
                NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            }
            
        }];
        
        self.tweet.favorited = YES;
        
        self.tweet.favoriteCount += 1;
        
    }
    
    [self refreshData];
    
    
    
}
- (IBAction)didTapRetweet:(id)sender {
    
    if(self.tweet.retweeted) {
        
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            
            if(error != nil){
                
                NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
                
            } else {
                
                NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
            }
            
        }];
        
        self.tweet.retweetCount -= 1;
        
        self.tweet.retweeted = NO;
        
        
    } else {
        
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            
            if(error != nil){
                
                NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
                
            } else {
                
                NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
            }
            
        }];
        
        self.tweet.retweetCount += 1;
        
        self.tweet.retweeted = YES;
        
    }
    
    [self refreshData];
    
    
}

@end
