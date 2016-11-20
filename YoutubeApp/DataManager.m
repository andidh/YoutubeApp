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
    NSTimer *timer;
}
@end

@implementation DataManager

+(instancetype)sharedInstance
{
    static dispatch_once_t once;
    static DataManager *_sharedInstance = nil;
    dispatch_once(&once, ^{
        _sharedInstance = [[self alloc] init];
    });
    
    return _sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if(self) {
        [self fetchVideos];
    }
    return self;
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
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self attemptToPost];
                });
               
                
            }
        } @catch (NSException *exception) {
            NSLog(@"%@",error);
        }
    }] resume];
}

- (void)attemptToPost
{
    [timer invalidate];
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(postReadyNotification) userInfo:nil repeats:NO];
}


- (void)postReadyNotification
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kNotificationVideoReceived" object:nil];
}


-(NSArray *)getVideos
{
    return [videosArray copy];
}

@end
