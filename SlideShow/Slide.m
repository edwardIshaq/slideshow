//
//  Slide.m
//  SlideShow
//
//  Created by Edward Ashak on 10/6/13.
//  Copyright (c) 2013 EdwardIshaq. All rights reserved.
//

#import "Slide.h"

@implementation Slide

- (id)initWithDictionary:(NSDictionary*)XMLDic {
    self = [super init];
    if (self) {
        id __Code = [XMLDic objectForKey:@"code"];
        if ([__Code isKindOfClass:[NSString class]]) {
            self.code = [NSString stringWithString:__Code];
        }
        
        CGFloat width, height, origWidth, origHeight;
        width = [[XMLDic objectForKey:@"width"] floatValue];
        height = [[XMLDic objectForKey:@"height"] floatValue];
        self.size = CGSizeMake(width, height);
        
        origWidth = [[XMLDic objectForKey:@"orig_width"] floatValue];
        origHeight = [[XMLDic objectForKey:@"orig_height"] floatValue];
        self.origSize = CGSizeMake(origWidth, origHeight);

    }
    return self;
}
@end
