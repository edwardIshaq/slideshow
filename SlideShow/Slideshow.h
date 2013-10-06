//
//  Presentation.h
//  SlideShow
//
//  Created by Edward Ashak on 10/6/13.
//  Copyright (c) 2013 EdwardIshaq. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Slide;

@interface Slideshow : NSObject <NSXMLParserDelegate>

//Need to make private
@property (nonatomic, retain) NSOperationQueue *networkQ;
@property (nonatomic) NSMutableString *currentParsedCharacterData;
@property BOOL accumulatingParsedCharacterData;
@property (nonatomic, retain) Slide* currentSlide;

@property (retain, nonatomic) NSString* imgURL;
@property (retain, nonatomic) NSString* thumbURL;
@property (retain, nonatomic) NSString *deckName;

@property (retain, nonatomic) NSMutableArray *slides;

- (void)requestSlideshow;

@end
