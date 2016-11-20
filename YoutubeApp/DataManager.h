//
//  DataManager.h
//  YoutubeApp
//
//  Created by Dehelean Andrei on 11/20/16.
//  Copyright © 2016 Dehelean Andrei. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Video;

@interface DataManager : NSObject

+ (instancetype)sharedInstance;
- (NSArray *)getVideos;

@end
