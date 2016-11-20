//
//  Channel.m
//  YoutubeApp
//
//  Created by Dehelean Andrei on 11/19/16.
//  Copyright © 2016 Dehelean Andrei. All rights reserved.
//

#import "Channel.h"

@implementation Channel

-(instancetype)initWithName:(NSString *)name profileURL:(NSString *)url
{
    if([self init]){
        _name = name;
        _profileURL = url;
    }
    return self;
}


@end
