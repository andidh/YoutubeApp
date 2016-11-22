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
#import "Video.h"
#import "Channel.h"
#import "DataManager.h"
#import "MenuView.h"


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
    
//    [self generateVideos];
    
    [self setupBar];
    [self setupBarButtons];
    [self setupMenuBar];
    
    [[NSNotificationCenter defaultCenter] addObserver:self.collectionView selector:@selector(reloadData) name:@"kNotificationVideoReceived" object:nil];
    
}

//- (void)generateVideos
//{
//    Channel *selena = [[Channel alloc] initWithName:@"SelenaGomezVEVO" profileURL:@"selena_profile"];
//    Video *v1 = [[Video alloc] initWithThumbnailURL:@"hit_video" Title:@"Selena Gomez & The Scene - Hit The Lightsjnknjnjkjknjnkjnnknjk" Channel:selena NumberOfViews:@925478121];
//    Video *v2 = [[Video alloc] initWithThumbnailURL:@"slow_video" Title:@"Selena Gomez - Slow Down" Channel:selena NumberOfViews:@973288120];
//    
//    [videos addObject:v1];
//    [videos addObject:v2];
//
//}


- (void)setupBarButtons{
    UIImage *search = [UIImage imageNamed:@"search_icon"];
    UIBarButtonItem *searchBtn = [[UIBarButtonItem alloc] initWithImage:search style:UIBarButtonItemStylePlain target:self action:@selector(handleSearch)];
    searchBtn.tintColor = [UIColor whiteColor];
    
    UIImage *menuIcon = [UIImage imageNamed:@"nav_more_icon"];
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithImage:menuIcon style:UIBarButtonItemStylePlain target:self action:@selector(showMenu)];
    menuButton.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItems = @[menuButton, searchBtn];
}

- (void)setupMenuBar
{
    menu = [[MenuBar alloc] initWithFrame:CGRectMake(0, 0, self.collectionView.frame.size.width, 50)];
    [self.view addSubview:menu];
}


- (void)showMenu
{
    MenuView *slideMenu = [[MenuView alloc] init];
    [slideMenu show];
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
    return [[DataManager sharedInstance]getVideos].count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    VideoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    Video *video = [[DataManager sharedInstance]getVideos][indexPath.item];
    [cell configureCellWithVideo:video];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat height = (8+8+44+8) + (self.view.frame.size.width - 16) * 9/16;
    return CGSizeMake(self.view.frame.size.width, height);
}


@end
