//
//  VideoCell.m
//  YoutubeApp
//
//  Created by Dehelean Andrei on 11/19/16.
//  Copyright © 2016 Dehelean Andrei. All rights reserved.
//

#import "UIView+UIView_autolayout.h"
#import "VideoCell.h"
#import "Video.h"
#import "Channel.h"

@interface VideoCell()
{
    UIView *separatorLine;
    NSURLSessionDataTask *task;
    NSCache *imageCache;
}

@property (nonatomic) UIImageView *videoImageView;
@property (nonatomic) UIImageView *profileImageView;
@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UILabel *subtitleLabel;

@end

@implementation VideoCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeViews];
        imageCache = [[NSCache alloc] init];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initializeViews];
    }
    return self;
}

-(void)configureCellWithVideo:(Video *)video
{
    [self loadProfileImageWithURL:video.channel.profileURL];
    [self loadThumbnailImageWithURL:video.thumbnailURL];
    _titleLabel.text = video.title;
    NSString *views = [NSString localizedStringWithFormat:@"%@",video.views];
    _subtitleLabel.text = [NSString stringWithFormat:@"%@ • %@", video.channel.name, views];
}

- (void)loadProfileImageWithURL:(NSString *)urlString
{
    UIImage *cachedImage = [imageCache objectForKey:urlString];
    if (cachedImage) {
        _profileImageView.image = cachedImage;
        return;
    }
    
    NSURL *url = [NSURL URLWithString:urlString];
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"%@",error);
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageWithData:data];
            _profileImageView.image = image;
            [imageCache setObject:image forKey:urlString];
        });
    }] resume];
}

- (void)loadThumbnailImageWithURL:(NSString *)urlString
{
    UIImage *cachedImage = [imageCache objectForKey:urlString];
    if (cachedImage) {
        _videoImageView.image = cachedImage;
        return;
    }
    
    NSURL *url = [NSURL URLWithString:urlString];
    task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"%@",error);
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageWithData:data];
            _videoImageView.image = image;
            [imageCache setObject:image forKey:urlString];
        });
    }];
    [task resume];
}

-(void)prepareForReuse
{
    [super prepareForReuse];
    
    [task cancel];
    task = nil;
    
    _profileImageView.image = nil;
    _videoImageView.image = nil;
    _subtitleLabel.text = nil;
    _titleLabel.text = nil;
    
}

- (void)initializeViews
{
    _videoImageView = [UIImageView autolayoutView];
    _videoImageView.contentMode = UIViewContentModeScaleAspectFill;
    _videoImageView.clipsToBounds = YES;
    
    _profileImageView = [UIImageView autolayoutView];
    _profileImageView.layer.cornerRadius = 22;
    _profileImageView.contentMode = UIViewContentModeScaleAspectFill;
    _profileImageView.layer.masksToBounds = YES;
    
    _titleLabel = [UILabel autolayoutView];
    _titleLabel.numberOfLines = 0;
    _titleLabel.font = [UIFont systemFontOfSize:14];
    
    _subtitleLabel = [UILabel autolayoutView];
    _subtitleLabel.numberOfLines = 0;
    _subtitleLabel.font = [UIFont systemFontOfSize:12];
    _subtitleLabel.textColor = [UIColor lightGrayColor];
    
    separatorLine = [UIView autolayoutView];
    separatorLine.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
    
    
    [self addSubview:_videoImageView];
    [self addSubview:_profileImageView];
    [self addSubview:_titleLabel];
    [self addSubview:_subtitleLabel];
    [self addSubview:separatorLine];
    
    [self createConstraints];
}

- (void)createConstraints
{
    NSDictionary *views = @{@"video":_videoImageView,
                            @"profile":_profileImageView,
                            @"title":_titleLabel,
                            @"subtitle":_subtitleLabel,
                            @"line":separatorLine};
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[video]-[profile(44)]" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[video]-8-|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[profile(44)]-[title]-8-|" options:0 metrics:nil views:views]];
    [_titleLabel.topAnchor constraintEqualToAnchor:_videoImageView.bottomAnchor constant:8].active = YES;
    [_subtitleLabel.topAnchor constraintEqualToAnchor:_titleLabel.bottomAnchor constant:4].active = YES;
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[subtitle]-|" options:0 metrics:nil views:views]];
    [_subtitleLabel.leadingAnchor constraintEqualToAnchor:_titleLabel.leadingAnchor].active = YES;
    [_subtitleLabel.bottomAnchor constraintEqualToAnchor:separatorLine.topAnchor constant:-16].active = YES;
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[line]|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[line(1)]|" options:0 metrics:nil views:views]];

}

@end
