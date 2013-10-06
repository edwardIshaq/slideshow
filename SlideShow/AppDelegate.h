//
//  AppDelegate.h
//  SlideShow
//
//  Created by Edward Ashak on 10/6/13.
//  Copyright (c) 2013 EdwardIshaq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Slideshow;


@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong,nonatomic) Slideshow *presentation;
@property (strong, nonatomic) UIWindow *window;

@end
