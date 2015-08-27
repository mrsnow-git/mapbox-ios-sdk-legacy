//
// RMGoogleMapSource.m
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

#import "RMGoogleMapSource.h"
#import <math.h>


@implementation RMGoogleMapSource

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
    
    // lyrs = m, s, h, r, t
    NSString *tileThing = [NSString stringWithFormat:@"http://mt2.google.com/vt/lyrs=m&hl=ru&x=%d&y=%d&z=%d&s=Galileo", tile.x, tile.y, tile.zoom];

	//NSLog(@"%@",tileThing);
    return [NSURL URLWithString:tileThing];
}

-(NSString*) uniqueTilecacheKey
{
	return @"GoogleMaps";
}

-(NSString *)shortName
{
	return @"Google Map";
}

-(NSString *)longDescription
{
	return @"Google Maps are severely restricted by Terms of Service for typical Route-Me applications. This sample code is for demonstration purposes only.";
}

-(NSString *)shortAttribution
{
	return @"© Google Maps";
}

-(NSString *)longAttribution
{
	return @"© Map data © Google, though the way we are accessing these tiles is against the Google Terms of Service.";
}

@end
