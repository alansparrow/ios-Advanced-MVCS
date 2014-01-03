//
//  BNRURLCache.m
//  Nerdfeed
//
//  Created by Alan Sparrow on 1/3/14.
//
//

#import "BNRURLCache.h"

@implementation BNRURLCache

- (void)storeCachedResponse:(NSCachedURLResponse *)cachedResponse
                 forRequest:(NSURLRequest *)request
{
    // Don't cache anything by default
    // I will use my own caching technology
}

@end
