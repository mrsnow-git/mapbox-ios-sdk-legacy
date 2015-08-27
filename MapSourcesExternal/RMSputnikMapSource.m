//
// RMSputnikMapSource.m
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

#import "RMSputnikMapSource.h"
#import <math.h>


@implementation RMSputnikMapSource

- (id) init
{ 
	if(self = [super init])
	{
		[self setMaxZoom:18.0];
		[self setMinZoom:1.0];
	}
	
	return self;
}

- (NSURL *)URLForTile:(RMTile)tile
{
    NSAssert4(((tile.zoom >= self.minZoom) && (tile.zoom <= self.maxZoom)),
              @"%@ tried to retrieve tile with zoomLevel %d, outside source's defined range %f to %f",
              self, tile.zoom, self.minZoom, self.maxZoom);
    
    int r = 0;
    NSString *subServer = @"d";
    
    r = arc4random_uniform (100);
    if (r < 25)
        subServer = @"a";
    else if (r < 50)
        subServer = @"b";
    else if (r < 75)
        subServer = @"c";
    
    NSString *tileThing = [NSString stringWithFormat:@"http://%@.tiles.maps.sputnik.ru/%d/%d/%d.png", subServer, tile.zoom, tile.x, tile.y];

	//NSLog(@"%d %@",r, tileThing);
	return [NSURL URLWithString:tileThing];
}

-(NSString*) uniqueTilecacheKey
{
	return @"SputnikMaps";
}

-(NSString *)shortName
{
	return @"Sputnik Map";
}

-(NSString *)longDescription
{
	return @"Sputnik Maps are severely restricted by Terms of Service for typical Route-Me applications. This sample code is for demonstration purposes only.";
}

-(NSString *)shortAttribution
{
	return @"© Sputnik Maps";
}

-(NSString *)longAttribution
{
	return @"© Map data © Sputnik, though the way we are accessing these tiles is against the Sputnik Terms of Service.";
}

@end
