//
//  SettingCell.h
//  YoutubeApp
//
//  Created by Dehelean Andrei on 11/22/16.
//  Copyright © 2016 Dehelean Andrei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsItem: NSObject

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name;

@end


@interface SettingCell : UICollectionViewCell

- (void)configureWithSetting:(SettingsItem *)setting;

@end
