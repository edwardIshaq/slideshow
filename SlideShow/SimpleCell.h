//
//  SimpleCell.h
//  Collections
//
//  Created by Edward Ashak on 12/10/12.
//  Copyright (c) 2012 EdwardIshaq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimpleCell : UICollectionViewCell {
    @private
    UILabel *indexLabel;
    UIImageView *imgView;
}

@property (nonatomic, retain) NSString *label;
- (void)setImage:(UIImage*)image;
@end
