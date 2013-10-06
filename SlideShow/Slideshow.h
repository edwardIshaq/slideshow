//
//  Presentation.h
//  SlideShow
//
//  Created by Edward Ashak on 10/6/13.
//  Copyright (c) 2013 EdwardIshaq. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol SlideshowDelegate;
@class Slide;

@interface Slideshow : NSObject <NSXMLParserDelegate>

@property (retain, nonatomic) NSString *deckName;
@property (retain, nonatomic) NSMutableArray *slides;
@property (assign) id<SlideshowDelegate> slideshowDelegate;
- (void)requestSlideshow;
- (void)downloadSlideThumbs;
@end


@protocol SlideshowDelegate <NSObject>
- (void)slideshowDidFinishLoading:(Slideshow*)slideshow;


@end