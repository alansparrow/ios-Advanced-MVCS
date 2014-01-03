//
//  BNRFeedStore.h
//  Nerdfeed
//
//  Created by joeconway on 1/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class RSSItem;

@class RSSChannel;

@interface BNRFeedStore : NSObject

{
    NSManagedObjectContext *context;
    NSManagedObjectModel *model;
}

+ (BNRFeedStore *)sharedStore;
- (void)fetchTopSongs:(int)count withCompletion:(void (^)(RSSChannel *obj, NSError *err))block;
- (RSSChannel *)fetchRSSFeedWithCompletion:(void (^)(RSSChannel *obj, NSError *err))block;

- (void)markItemAsRead:(RSSItem *)item;
- (BOOL)hasItemBeenRead:(RSSItem *)item;
- (void)removeFavItem:(RSSItem *)item;
- (void)addFavItem:(RSSItem *)item;

// Return nil if NO, return #nil if YES
- (NSManagedObject *)hasItemBeenLiked:(RSSItem *)item;

@property (nonatomic, strong) NSDate *topSongsCacheDate;
@end
