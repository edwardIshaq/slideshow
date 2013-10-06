//
//  ViewController.m
//  SlideShow
//
//  Created by Edward Ashak on 10/6/13.
//  Copyright (c) 2013 EdwardIshaq. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "SimpleCell.h"
#import "Slide.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    self.mainSlideShow = [(AppDelegate*)[[UIApplication sharedApplication] delegate] presentation];
    self.mainSlideShow.slideshowDelegate = self;
    [super viewDidLoad];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    //register cell
    [self.collectionView registerClass:[SimpleCell class] forCellWithReuseIdentifier:@"SIMPLE_CELL_ID"];

    //adjust layout
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    layout.minimumLineSpacing = 20.0;
    layout.itemSize = CGSizeMake(100, 100);
    layout.sectionInset = UIEdgeInsetsMake(20, 20, 40, 20);
    layout.headerReferenceSize = CGSizeMake(50, 65);
    layout.footerReferenceSize = CGSizeMake(50, 75);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSLog(@"%d",[self.mainSlideShow.slides count]);
    return [self.mainSlideShow.slides count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    Slide *slide = [self.mainSlideShow.slides objectAtIndex:indexPath.row];
    SimpleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SIMPLE_CELL_ID" forIndexPath:indexPath];
    cell.label = [NSString stringWithFormat:@"%d,%d", indexPath.section, indexPath.row];
    
    if (slide.thumbImage) {
        [cell setImage:slide.thumbImage];
    }
    return cell;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(204, 204);
}

- (void)slideshowDidFinishLoading:(Slideshow*)slideshow {
    [self.collectionView reloadData];
}
@end

