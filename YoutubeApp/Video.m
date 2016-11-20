//
//  Video.m
//  YoutubeApp
//
//  Created by Dehelean Andrei on 11/19/16.
//  Copyright © 2016 Dehelean Andrei. All rights reserved.
//

#import "Video.h"

@implementation Video

-(instancetype)initWithThumbnailURL:(NSString *)url Title:(NSString *)title Channel:(Channel *)channel NumberOfViews:(NSNumber *)views
{
    self = [super init];
    if(self){
        _thumbnailURL = url;
        _title = title;
        _channel = channel;
        _views = views;
    }
    return self;
}


@end
