//
//  MTZColorSpaceView.m
//  Colors
//
//  Created by Matt Zanchelli on 11/2/13.
//  Copyright (c) 2013 Matt Zanchelli. All rights reserved.
//

#import "MTZColorSpaceView.h"

#import <Colors/Colors.h>

#define SCALE 0.25f

@implementation MTZColorSpaceView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setHue:(CGFloat)hue
{
	_hue = hue;
	[self setNeedsDisplay];
}

- (void)setLightness:(CGFloat)lightness
{
	_lightness = lightness;
	[self setNeedsDisplay];
}

- (void)setContrast:(CGFloat)contrast
{
	_contrast = contrast;
	[self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
	[super drawRect:rect];
	
    CGContextRef context = UIGraphicsGetCurrentContext();
	for ( CGFloat x=rect.origin.x; x<rect.size.width; x+=(1/SCALE) ) {
		for ( CGFloat y=rect.origin.y; y<rect.size.height; y+=(1/SCALE) ) {
			UIColor *color = [UIColor colorWithHue:_hue
										saturation:(x/((rect.size.width)-(rect.origin.x)))
										brightness:1-(y/((rect.size.height)-(rect.origin.y)))
											 alpha:1.0f];
			CGFloat contrast = [UIColor differenceBetweenColor:color
													  andColor:[UIColor colorWithHue:0.0f
																		  saturation:0.0f
																		  brightness:_lightness
																			   alpha:0.0f]];
			if ( contrast > _contrast * 100 ) {
				CGContextSetFillColorWithColor(context, color.CGColor);
			} else {
				CGContextSetRGBFillColor(context, 1.0f, 1.0f, 1.0f, 1.0f);
			}
			CGRect rectangle = CGRectMake(x, y, 1/SCALE, 1/SCALE);
			CGContextFillRect(context, rectangle);
		}
	}
}

@end
