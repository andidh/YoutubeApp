//
//  MenuView.h
//  YoutubeApp
//
//  Created by Dehelean Andrei on 11/22/16.
//  Copyright © 2016 Dehelean Andrei. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MenuView : UIView <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

- (void)show;
- (void)dismiss;

@end
