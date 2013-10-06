//
//  ViewController.h
//  SlideShow
//
//  Created by Edward Ashak on 10/6/13.
//  Copyright (c) 2013 EdwardIshaq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Slideshow.h"

@interface ViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SlideshowDelegate>

@property (retain, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

//Should be dynamically selected by user
@property (retain, nonatomic) Slideshow *mainSlideShow;
@end

