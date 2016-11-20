//
//  DataManager.m
//  YoutubeApp
//
//  Created by Dehelean Andrei on 11/20/16.
//  Copyright © 2016 Dehelean Andrei. All rights reserved.
//

#import "DataManager.h"
#import "Video.h"
#import "Channel.h"

@interface DataManager()
{
    NSMutableArray *videosArray;
}
@end

@implementation DataManager

+(instancetype)sharedInstance
{
    static dispatch_once_t once;
    static id _sharedInstance = nil;
    dispatch_once(&once, ^{
        _sharedInstance = [[self alloc] init];
        [_sharedInstance fetchVideos];
    });
    
    return _sharedInstance;
}


- (void)fetchVideos
{
    videosArray = [NSMutableArray array];
    NSURL *url = [NSURL URLWithString:@"https://s3-us-west-2.amazonaws.com/youtubeassets/home.json"];
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error != nil) {
            NSLog(@"%@",error);
            return;
        }
        
        @try {
            NSError *error = nil;
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            
            for (NSDictionary *dict in jsonDict) {
                
                NSString *thumbnail = dict[@"thumbnail_image_name"];
                NSString *title = dict[@"title"];
                NSNumber *views = dict[@"number_of_views"];
                NSString *profileURL = dict[@"channel"][@"profile_image_name"];
                NSString *name = dict[@"channel"][@"name"];
                Channel *channel = [[Channel alloc] initWithName:name profileURL:profileURL];
                Video *video = [[Video alloc] initWithThumbnailURL:thumbnail Title:title Channel:channel NumberOfViews:views];
                
                [videosArray addObject:video];
                
                
            }
        } @catch (NSException *exception) {
            NSLog(@"%@",error);
        }
    }] resume];
}

- (void)postNotification
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kNotificationVideoReceived" object:nil];
}




-(NSArray *)getVideos
{
    return [videosArray copy];
}

@end
