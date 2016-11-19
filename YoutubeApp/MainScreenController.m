//
//  ViewController.m
//  YoutubeApp
//
//  Created by Dehelean Andrei on 11/19/16.
//  Copyright © 2016 Dehelean Andrei. All rights reserved.
//

#import "MainScreenController.h"
#import "VideoCell.h"

@interface MainScreenController ()

@end

@implementation MainScreenController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[VideoCell class] forCellWithReuseIdentifier:@"cellId"];
    
    [self setupBar];
    [self setupBarButtons];
}


- (void)setupBarButtons
{
}

- (void)handleSearch
{
    NSLog(@"%d",123);
}
- (void)setupBar
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width - 32, self.view.frame.size.height)];
    titleLabel.text = @"Home";
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;

}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 2;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    VideoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat height = (8+8+44+8) + (self.view.frame.size.width - 16) * 9/16;
    return CGSizeMake(self.view.frame.size.width, height);
}


@end
