//
//  WebViewController.h
//  Nerdfeed
//
//  Created by joeconway on 9/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ListViewController.h"

@class RSSItem;

@interface WebViewController : UIViewController <ListViewControllerDelegate, UISplitViewControllerDelegate>

{
    UIToolbar *toolbar;
    UIBarButtonItem *addFavBtn;
    UIBarButtonItem *removeFavBtn;
    RSSItem *favItem;
    // Block is function not method so we have ()
    //void (^reloadTableView)();
}

@property (nonatomic, readonly) UIWebView *webView;
@property (nonatomic, copy) void (^reloadTableView)();

@end
