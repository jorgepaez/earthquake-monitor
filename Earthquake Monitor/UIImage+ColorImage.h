//
//  UIImage+ColorImage.h
//  Earthquake Monitor
//
//  Created by Jorge Paez on 4/30/15.
//  Copyright (c) 2015 Jorge Paez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ColorImage)

+ (UIImage *)imageWithColor:(UIColor *)color;  //Method that returns an UIImage with the background color that is passed.

@end
