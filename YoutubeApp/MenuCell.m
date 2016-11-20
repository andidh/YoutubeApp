//
//  MenuCell.m
//  YoutubeApp
//
//  Created by Dehelean Andrei on 11/19/16.
//  Copyright © 2016 Dehelean Andrei. All rights reserved.
//

#import "MenuCell.h"

@interface MenuCell()

@property (nonatomic) UIImageView *imageView;

@end

@implementation MenuCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}


- (void)setupViews
{
    _imageView = [UIImageView new];
    _imageView.image = [UIImage imageNamed:@"home"];
    _imageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:_imageView];
    
    
    [self.imageView.heightAnchor constraintEqualToConstant:28].active = YES;
    [self.imageView.widthAnchor constraintEqualToConstant:28].active = YES;

    [self.imageView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
    [self.imageView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;

}

@end
