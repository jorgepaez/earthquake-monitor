//
//  UIImage+ColorImage.m
//  Earthquake Monitor
//
//  Created by Jorge Paez on 4/30/15.
//  Copyright (c) 2015 Jorge Paez. All rights reserved.
//

#import "UIImage+ColorImage.h"

@implementation UIImage (ColorImage)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 32.0f, 32.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
