//
//  MenuBar.m
//  YoutubeApp
//
//  Created by Dehelean Andrei on 11/19/16.
//  Copyright © 2016 Dehelean Andrei. All rights reserved.
//

#import "MenuBar.h"
#import "MenuCell.h"

@interface MenuBar()
{
    UICollectionView *collection;
    NSArray *icons;

}
@end


@implementation MenuBar


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        icons = @[@"home",@"trending",@"subscriptions",@"account"];
        [self setupViews];
        NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
        [collection selectItemAtIndexPath:path animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    }
    return self;
}


- (void)setupViews
{
    collection = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:[UICollectionViewFlowLayout new]];
    collection.backgroundColor = [UIColor colorWithRed:230/255.0 green:32/255.0 blue:31/255.0 alpha:1];
    [collection registerClass:[MenuCell class] forCellWithReuseIdentifier:@"cellId"];
    collection.delegate = self;
    collection.dataSource = self;

    [self addSubview:collection];
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    NSString *icon = icons[indexPath.item];
    [cell configureCellForIcon:icon];
    cell.tintColor = [UIColor colorWithRed:91/255.0 green:14/255.0 blue:13/255.0 alpha:1];
    return cell;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = self.frame.size.width / 4;
    return CGSizeMake(width, self.frame.size.height);
}

@end
