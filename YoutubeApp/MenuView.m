//
//  MenuView.m
//  YoutubeApp
//
//  Created by Dehelean Andrei on 11/22/16.
//  Copyright © 2016 Dehelean Andrei. All rights reserved.
//

#import "MenuView.h"
#import "SettingCell.h"

@interface MenuView() <UIGestureRecognizerDelegate>
{
    UICollectionView *menuCollection;
    NSArray *items;
}


@end

@implementation MenuView

- (instancetype)init
{
    return [self initWithFrame:[[UIScreen mainScreen] bounds]];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeView];
        items = [NSArray arrayWithObjects:[[SettingsItem alloc] initWithName:@"My subscriptions"], [[SettingsItem alloc] initWithName:@"Uploads"],[[SettingsItem alloc] initWithName:@"History"],[[SettingsItem alloc] initWithName:@"Offline"],[[SettingsItem alloc] initWithName:@"Cancel"], nil];
    }
    return self;
}


- (void)initializeView
{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    tapGesture.delegate = self;
    [self addGestureRecognizer:tapGesture];
    
    
    menuCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, 250) collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    
    [self addSubview:menuCollection];
    menuCollection.backgroundColor = [UIColor whiteColor];
    menuCollection.delegate = self;
    menuCollection.dataSource = self;
    [menuCollection registerClass:[SettingCell class] forCellWithReuseIdentifier:@"cellId"];
}

-(void)show
{
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    
    CGFloat height = self.frame.size.height - 250;
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        menuCollection.frame = CGRectMake(0, height, self.frame.size.width, 250);
    } completion:nil];
    
}


-(void)dismiss
{
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
        menuCollection.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, 350);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return [touch view] == self;
}


#pragma MARK : UICollectionView delegate + data source
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SettingCell *cell = [menuCollection dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    [cell configureWithSetting:items[indexPath.item]];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.frame.size.width, 50);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}



@end





