//
// ScatStreetMapSource.m
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

#import "ScatStreetMapSource.h"

@implementation ScatStreetMapSource
{
    NSString *_host;
    NSString *_path;
    NSString *_layer;
}

- (id)init
{
	if (!(self = [super init]))
        return nil;

    self.minZoom = 1;
    self.maxZoom = 18;

	return self;
} 

- (id)initWithHost:(NSString *)host path:(NSString *)path layer:(NSString *)layer
{
    if (!(self = [super init]))
        return nil;
    
    _host = host;
    _path = path;
    _layer = layer;
    
    self.minZoom = 1;
    self.maxZoom = 18;
    
	return self;
}

- (NSURL *)URLForTile:(RMTile)tile
{
    NSAssert4(((tile.zoom >= self.minZoom) && (tile.zoom <= self.maxZoom)),
              @"%@ tried to retrieve tile with zoomLevel %d, outside source's defined range %f to %f",
              self, tile.zoom, self.minZoom, self.maxZoom);
    
	NSString *tileThing = [NSString stringWithFormat:@"http://%@/%@/%@/%d/%d/%d.png", _host, _path, _layer, tile.zoom-1, tile.x, (int)pow(2, tile.zoom)-1-tile.y];

    //NSLog(@"%@",tileThing);
    return [NSURL URLWithString:tileThing];
}

- (NSString *)uniqueTilecacheKey
{
	return @"OpenStreetMap";
}

- (NSString *)shortName
{
	return @"Open Street Map";
}

- (NSString *)longDescription
{
	return @"Open Street Map, the free wiki world map, provides freely usable map data for all parts of the world, under the Creative Commons Attribution-Share Alike 2.0 license.";
}

- (NSString *)shortAttribution
{
	return @"© OpenStreetMap CC-BY-SA";
}

- (NSString *)longAttribution
{
	return @"Map data © OpenStreetMap, licensed under Creative Commons Share Alike By Attribution.";
}

@end
