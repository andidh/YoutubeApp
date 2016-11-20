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

-(void)configureCellForIcon:(NSString *)icon
{
    _imageView.image = [[UIImage imageNamed:icon] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}


- (void)setupViews
{
    _imageView = [UIImageView new];
    _imageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:_imageView];
    
    
    [self.imageView.heightAnchor constraintEqualToConstant:28].active = YES;
    [self.imageView.widthAnchor constraintEqualToConstant:28].active = YES;

    [self.imageView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
    [self.imageView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;

}

-(void)setHighlighted:(BOOL)highlighted
{
    _imageView.tintColor = highlighted ? [UIColor whiteColor] : [UIColor colorWithRed:91/255.0 green:14/255.0 blue:13/255.0 alpha:1];
}

-(void)setSelected:(BOOL)selected
{
    _imageView.tintColor = selected ? [UIColor whiteColor] : [UIColor colorWithRed:91/255.0 green:14/255.0 blue:13/255.0 alpha:1];
}

@end
