//
//  SettingCell.m
//  YoutubeApp
//
//  Created by Dehelean Andrei on 11/22/16.
//  Copyright © 2016 Dehelean Andrei. All rights reserved.
//

#import "SettingCell.h"
#import "UIView+UIView_autolayout.h"
#import "MenuView.h"

@implementation SettingsItem

- (instancetype)initWithName:(NSString *)name
{
    self = [super init];
    if(self) {
        _name = name;
    }
    return self;
}

@end

@interface SettingCell()

@property (nonatomic) UILabel *nameLabel;

@end


@implementation SettingCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initializeView];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeView];
    }
    return self;
}


- (void)initializeView
{
    _nameLabel = [UILabel autolayoutView];
    _nameLabel.font = [UIFont systemFontOfSize:13];
    _nameLabel.textColor = [UIColor darkGrayColor];
    
    [self addSubview:_nameLabel];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(16)-[name]-|" options:0 metrics:nil views:@{@"name":_nameLabel}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[name]-|" options:0 metrics:nil views:@{@"name":_nameLabel}]];
}

-(void)configureWithSetting:(SettingsItem *)setting
{
    _nameLabel.text = setting.name;
}

-(void)setHighlighted:(BOOL)highlighted
{
    _nameLabel.textColor = highlighted ? [UIColor whiteColor] : [UIColor darkGrayColor];
    self.backgroundColor = highlighted ? [UIColor darkGrayColor] : [UIColor whiteColor];
}



@end
