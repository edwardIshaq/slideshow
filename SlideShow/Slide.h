//
//  Slide.h
//  SlideShow
//
//  Created by Edward Ashak on 10/6/13.
//  Copyright (c) 2013 EdwardIshaq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Slide : NSObject

- (id)initWithDictionary:(NSDictionary*)XMLDic;

@property (strong, nonatomic) NSString* code;
@property CGSize size;
@property CGSize origSize;

@end
