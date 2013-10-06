//
//  Presentation.m
//  SlideShow
//
//  Created by Edward Ashak on 10/6/13.
//  Copyright (c) 2013 EdwardIshaq. All rights reserved.
//

#import "Slideshow.h"
#import "Slide.h"

#import <Foundation/Foundation.h>

@interface Slideshow ()
@property (nonatomic, retain) NSOperationQueue *networkQ;
@property (nonatomic) NSMutableString *currentParsedCharacterData;
@property BOOL accumulatingParsedCharacterData;
@property (nonatomic, retain) Slide* currentSlide;

@property (retain, nonatomic) NSString* imgURL;
@property (retain, nonatomic) NSString* thumbURL;


@end

@implementation Slideshow
- (id)init{
    self = [super init];
    if (self) {
        self.currentParsedCharacterData = [NSMutableString new];
        self.networkQ = [[NSOperationQueue alloc] init];
    }
    return self;
}

- (void)requestSlideshow {
    NSURL *url = [NSURL URLWithString:@"https://s3-us-west-1.amazonaws.com/public-cs-dev/challenge/android-deck.xml"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:self.networkQ completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
        if (error) {
            NSLog(@"URL request failed, Do something about it");
            return;
        }
        NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:data];
        xmlParser.delegate = self;
        [xmlParser parse];

    }];
}

#pragma mark - NSXMLParserDelegate implementation
static NSString * const kSlideshow = @"slideshow";
static NSString * const kimgURL = @"img_url";
static NSString * const kthumbURL = @"thumb_url";
static NSString * const kDeck = @"deck";
static NSString * const kSlides = @"slides";
static NSString * const kdeckName = @"deck_name";
static NSString * const kSlide = @"slide";

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
//    NSLog(@"Started: elementName: %@",elementName);
    if ([elementName isEqualToString:kSlideshow]) {
        
    }
    else if ([elementName isEqualToString:kDeck]) {
        self.slides = [NSMutableArray new];
    }
    else if ([elementName isEqualToString:kimgURL] || [elementName isEqualToString:kthumbURL] || [elementName isEqualToString:kdeckName]) {
        self.accumulatingParsedCharacterData = YES;
        [self.currentParsedCharacterData setString:@""];
    }
    else if ([elementName isEqualToString:kSlide]) {
        self.currentSlide = [[Slide alloc] initWithDictionary:attributeDict];
    }

}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
//    NSLog(@"Ended: elementName: %@",elementName);
    if ([elementName isEqualToString:kimgURL]) {
        self.imgURL = [NSString stringWithString:self.currentParsedCharacterData];
        self.currentParsedCharacterData = [NSMutableString new];
    }
    if ([elementName isEqualToString:kthumbURL]) {
        self.thumbURL = [NSString stringWithString:self.currentParsedCharacterData];
        self.currentParsedCharacterData = [NSMutableString new];
    }
    if ([elementName isEqualToString:kdeckName]) {
        self.deckName = [NSString stringWithString:self.currentParsedCharacterData];
        self.currentParsedCharacterData = [NSMutableString new];
    }
    else if ([elementName isEqualToString:kSlide]) {
        [self.slides addObject:self.currentSlide];
        self.currentSlide = nil;
    }
    
    self.accumulatingParsedCharacterData = NO;
    [self.currentParsedCharacterData setString:@""];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if (self.currentParsedCharacterData) {
        // If the current element is one whose content we care about, append 'string'
        // to the property that holds the content of the current element.
        //
        [self.currentParsedCharacterData appendString:string];
    }
}
- (void)parserDidEndDocument:(NSXMLParser *)parser {
    if (self.slideshowDelegate && [self.slideshowDelegate conformsToProtocol:@protocol(SlideshowDelegate)]) {
        [self downloadSlideThumbs];
        [self.slideshowDelegate slideshowDidFinishLoading:self];
    }
}


- (void)downloadThumb:(NSURL*)thumbURL forSlide:(Slide*)slide {
    NSURLRequest *request = [NSURLRequest requestWithURL:thumbURL];
    NSError *error = nil;
    NSHTTPURLResponse *response = nil;

    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    NSLog(@"%@",response);
     slide.thumbImage = [UIImage imageWithData:data];
//    [NSURLConnection sendAsynchronousRequest:request queue:self.networkQ completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
//        if (error) {
//            NSLog(@"URL request failed, Do something about it");
//            return;
//        }
//        slide.thumbImage = [UIImage imageWithData:data];
//    }];
}
- (void)downloadSlideThumbs {
    for (Slide* slide in self.slides) {
        NSURL *thumbURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.thumbURL, slide.code]];
        [self downloadThumb:thumbURL forSlide:slide];
    }
}
@end
