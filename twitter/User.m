//
//  User.m
//  twitter
//
//  Created by Hector Diaz on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    self = [super init];
    
    NSLog(@"%@", dictionary);
    
    if(self) {
        
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        self.profileImageUrl = dictionary[@"profile_image_url"];
        
    }
    
    
    return self;
    
    
}

@end
