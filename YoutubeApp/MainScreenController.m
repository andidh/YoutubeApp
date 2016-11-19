//
//  ViewController.m
//  YoutubeApp
//
//  Created by Dehelean Andrei on 11/19/16.
//  Copyright © 2016 Dehelean Andrei. All rights reserved.
//

#import "MainScreenController.h"
#import "MenuBar.h"
#import "VideoCell.h"

@interface MainScreenController ()
{
    MenuBar *menu;
}
@end

@implementation MainScreenController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor redColor];
    [self.collectionView registerClass:[VideoCell class] forCellWithReuseIdentifier:@"cellId"];
    [self.collectionView setContentInset:UIEdgeInsetsMake(50, 0, 0, 0)];
    
    [self setupBar];
    [self setupBarButtons];
    [self setupMenuBar];
}

- (void)setupBarButtons{
    UIImage *search = [UIImage imageNamed:@"search_icon"];
    UIBarButtonItem *searchBtn = [[UIBarButtonItem alloc] initWithImage:search style:UIBarButtonItemStylePlain target:self action:@selector(handleSearch)];
    searchBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItems = @[searchBtn];
}

- (void)setupMenuBar
{
    menu = [[MenuBar alloc] initWithFrame:CGRectMake(0, 0, self.collectionView.frame.size.width, 50)];
    [self.view addSubview:menu];
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
    return 3;
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
