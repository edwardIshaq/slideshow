//
//  SimpleCell.m
//  Collections
//
//  Created by Edward Ashak on 12/10/12.
//  Copyright (c) 2012 EdwardIshaq. All rights reserved.
//

#import "SimpleCell.h"

@implementation SimpleCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        bg.backgroundColor = [self randomColor];
        self.backgroundView = bg;
        
        UIView *selectedBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        selectedBg.backgroundColor = [UIColor yellowColor];
        self.selectedBackgroundView = selectedBg;

        indexLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 20)];
        [self.contentView addSubview:indexLabel];
        
        imgView = [[UIImageView alloc] initWithImage:[self randomImage]];
        CGRect imgFrame = CGRectMake(0, 20, frame.size.width, frame.size.height-20);
        imgFrame = CGRectInset(imgFrame, 5, 5);
        [imgView setFrame:imgFrame];
        [imgView setContentMode:UIViewContentModeScaleToFill];
        [self.contentView addSubview:imgView];
        
        [self.contentView setClipsToBounds:YES];
    }
    return self;
}

- (void)setLabel:(NSString *)label {
    indexLabel.frame = CGRectMake(0, 0, self.frame.size.width, 20);
    indexLabel.text = label;
}

- (void)setImage:(UIImage*)image {
    imgView.image = image;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (UIColor*)randomColor {
    return [UIColor colorWithRed:arc4random()%256/255. green:arc4random()%256/255. blue:arc4random()%256/255. alpha:1];
}

- (UIImage*)randomImage {
    NSString *imgName = @"placeHolder.jpeg";
    return [UIImage imageNamed:imgName];
}
@end
