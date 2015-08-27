//
// RMYandexMapSource.m
//
// Copyright (c) 2013-2015, Route-Me & Mapbox Contributor, Denis Kozhukhov
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// * Redistributions of source code must retain the above copyright notice, this
//   list of conditions and the following disclaimer.
// * Redistributions in binary form must reproduce the above copyright notice,
//   this list of conditions and the following disclaimer in the documentation
//   and/or other materials provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.

#import "RMYandexMapSource.h"
#import <math.h>


@implementation RMYandexMapSource
{
    RMProjection *_yandexProjection;
}

- (id) init
{ 
	if(self = [super init])
	{
		[self setMaxZoom:18]; 
		[self setMinZoom:1];
	}
	
	return self;
}

- (NSURL *)URLForTile:(RMTile)tile
{
    NSAssert4(((tile.zoom >= self.minZoom) && (tile.zoom <= self.maxZoom)),
              @"%@ tried to retrieve tile with zoomLevel %d, outside source's defined range %f to %f",
              self, tile.zoom, self.minZoom, self.maxZoom);

    NSString *tileThing = [NSString stringWithFormat:@"http://vec0%d.maps.yandex.net/tiles?l=map&v=4.28.0&x=%d&y=%d&z=%d&scale=2&lang=ru_RU", arc4random_uniform(4) + 1, tile.x, tile.y, tile.zoom];

	//NSLog(@"%@",tileThing);
	return [NSURL URLWithString:tileThing];
}

- (RMProjection *)projection
{
    if (_yandexProjection)
    {
        return _yandexProjection;
    }
    else
    {
        // this hardcoded data valid only for Moscow, Russia
        RMProjectedRect theBounds = RMProjectedRectMake(-20037508.34, -20037508.34, 20037508.34 * 2, 20037508.34 * 2);
        _yandexProjection = [[RMProjection alloc] initWithString:@"+title= Yandex Mercator EPSG:900913 +proj=merc +a=6378137 +b=6378137 +lat_ts=5.561 +lon_0=-0.1778 +x_0=0.0 +y_0=0 +k=1.0 +units=m +nadgrids=@null +no_defs"
                                                        inBounds:theBounds];
        return _yandexProjection;
    }
}

-(NSString*) uniqueTilecacheKey
{
	return @"YandexMaps";
}

-(NSString *)shortName
{
	return @"Yandex Map";
}

-(NSString *)longDescription
{
	return @"Yandex Maps are severely restricted by Terms of Service for typical Route-Me applications. This sample code is for demonstration purposes only.";
}

-(NSString *)shortAttribution
{
	return @"© Yandex Maps";
}

-(NSString *)longAttribution
{
	return @"© Map data © Yandex, though the way we are accessing these tiles is against the Yandex Terms of Service.";
}

@end
