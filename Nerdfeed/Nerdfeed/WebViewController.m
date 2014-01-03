//
//  WebViewController.m
//  Nerdfeed
//
//  Created by joeconway on 9/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "WebViewController.h"
#import "RSSItem.h"
#import "BNRFeedStore.h"

@implementation WebViewController


- (void)listViewController:(ListViewController *)lvc handleObject:(id)object
{
    // Cast the passed object to RSSItem
    RSSItem *entry = object;
    
    // set favItem here
    favItem = entry;
    
    // Make sure that we are really getting a RSSItem
    if (![entry isKindOfClass:[RSSItem class]])
        return;

    // Grab the info from the item and push it into the appropriate views         
    NSURL *url = [NSURL URLWithString:[entry link]];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [[self webView] loadRequest:req];

    [[self navigationItem] setTitle:[entry title]];
}
- (void)splitViewController:(UISplitViewController *)svc 
     willShowViewController:(UIViewController *)aViewController 
  invalidatingBarButtonItem:(UIBarButtonItem *)button
{
    // Remove the bar button item from our navigation item
    // We'll double check that its the correct button, even though we know it is
    if (button == [[self navigationItem] leftBarButtonItem])
        [[self navigationItem] setLeftBarButtonItem:nil];
}

- (void)splitViewController:(UISplitViewController *)svc
     willHideViewController:(UIViewController *)aViewController
          withBarButtonItem:(UIBarButtonItem *)barButtonItem
       forPopoverController:(UIPopoverController *)pc
{
    // If this bar button item doesn't have a title, it won't appear at all.
    [barButtonItem setTitle:@"List"];
    
    // Take this bar button item and put it on the left side of our nav item.
    [[self navigationItem] setLeftBarButtonItem:barButtonItem];
}

- (void)loadView 
{
    // Create an instance of UIWebView as large as the screen
    CGRect screenFrame = [[UIScreen mainScreen] applicationFrame];
    UIWebView *wv = [[UIWebView alloc] initWithFrame:screenFrame];
    // Tell web view to scale web content to fit within bounds of webview 
    [wv setScalesPageToFit:YES];
    
    [self setView:wv];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)io
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
        return YES;
    return io == UIInterfaceOrientationPortrait;
}
- (UIWebView *)webView
{
    return (UIWebView *)[self view];
}

- (void)viewWillAppear:(BOOL)animated
{
    toolbar = [[UIToolbar alloc] init];
    [toolbar setFrame:CGRectMake(0, self.view.frame.size.height-44, self.view.frame.size.width, 44)];
    
    
    addFavBtn = [[UIBarButtonItem alloc] initWithTitle:@"+F"
                                                               style:UIBarButtonItemStyleBordered
                                                              target:self action:@selector(addFav)];
    removeFavBtn = [[UIBarButtonItem alloc] initWithTitle:@"-F"
                                                               style:UIBarButtonItemStyleBordered
                                                              target:self action:@selector(removeFav)];
    
    [self updateToolBarButton];
    
    UIBarButtonItem *emptyBtn = [[UIBarButtonItem alloc] init];
    [toolbar setItems:[NSArray arrayWithObjects:addFavBtn, emptyBtn,
                       emptyBtn,
                       emptyBtn,
                       emptyBtn,
                       emptyBtn,
                       emptyBtn,
                       emptyBtn,
                       emptyBtn,
                       emptyBtn,
                       emptyBtn,
                       emptyBtn,
                       removeFavBtn, nil]];
    [[self view] addSubview:toolbar];

}

- (void)updateToolBarButton
{
    if ([[BNRFeedStore sharedStore] hasItemBeenLiked:favItem]) {
        [addFavBtn setEnabled:NO];
        [removeFavBtn setEnabled:YES];
    } else {
        [addFavBtn setEnabled:YES];
        [removeFavBtn setEnabled:NO];
    }
}

- (void)addFav
{
    [[BNRFeedStore sharedStore] addFavItem:favItem];
    
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Successful"
                                                 message:@"Added to favorite"
                                                delegate:nil
                                       cancelButtonTitle:@"OK"
                                       otherButtonTitles:nil];
    [av show];
    
    [self updateToolBarButton];
    
    if ([self reloadTableView]) {
        [self reloadTableView]();
    }
}

- (void)removeFav
{
    [[BNRFeedStore sharedStore] removeFavItem:favItem];
    
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Successful"
                                                 message:@"Removed from favorite"
                                                delegate:nil
                                       cancelButtonTitle:@"OK"
                                       otherButtonTitles:nil];
    [av show];
    
    [self updateToolBarButton];
    
    if ([self reloadTableView]) {
        [self reloadTableView]();
    }
}
@end
