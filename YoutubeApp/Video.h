//
//  Video.h
//  YoutubeApp
//
//  Created by Dehelean Andrei on 11/19/16.
//  Copyright © 2016 Dehelean Andrei. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Channel;

@interface Video : NSObject

@property (nonatomic,copy,readonly) NSString *thumbnailURL;
@property (nonatomic,copy,readonly) NSString *title;
@property (nonatomic,readonly) Channel *channel;
@property (nonatomic, readonly) NSNumber *views;


-(instancetype)initWithThumbnailURL:(NSString *)url Title:(NSString *)title Channel:(Channel *)channel NumberOfViews:(NSNumber *)views;

@end
