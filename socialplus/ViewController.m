//
//  ViewController.m
//  socialplus
//
//  Created by ohtatomotaka on 2014/07/08.
//  Copyright (c) 2014年 ohtatomotaka. All rights reserved.
//

#import "ViewController.h"
#import "KMXMLParser.h"
#import "WebViewController.h"
@interface ViewController ()

@end

@implementation ViewController{
    UIRefreshControl *_refreshControl;
}
@synthesize dataArray = _dataArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set the navigation bar title
    self.title = @"Feed";

    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    _refreshControl = refreshControl;
    [refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [table addSubview:_refreshControl];
    
    /* Create the parser and initialize with the feed URL. The URL must start with http:// . If it starts
     with feed:// change it to http:// */
    NSURL *feedURL = [NSURL URLWithString:@"http://pad-plus.com/feed"];
    KMXMLParser *parser = [[KMXMLParser alloc] initWithURL:feedURL delegate:self];
    //To get the result and store it in an array call the parser 'posts' method
    self.dataArray = [parser posts];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *CellIdentifier = @"Cell";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
//    }
    
    // Get the title and summary from the array and display
    // You can get the date the content was published using the 'date' key
//    cell.textLabel.text = [[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"title"];
//    cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
//    cell.detailTextLabel.text = [[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"summary"];
//    cell.detailTextLabel.numberOfLines = 3;
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    UILabel *label = (UILabel*)[cell viewWithTag:1];
    label.text =  [[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    
    UILabel *titlelabel = (UILabel*)[cell viewWithTag:2];
    titlelabel.text =  [[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"date"];
    
    NSLog(@"%@",[[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"date"]);
    NSArray *bits = [[[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"date"] componentsSeparatedByString: @" "];
    NSLog(@"%@",bits[4]);
    
    return cell;
}
#pragma mark - Table view Refresh

- (void)refresh
{
    NSLog(@"refresh");
    // 本当はここで更新終了のときにendRefresh:を呼んであげよう
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(endRefresh) userInfo:nil repeats:NO];
}
- (void)endRefresh
{
    [_refreshControl endRefreshing];
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark - Parser delegate

- (void)parserDidFailWithError:(NSError *)error
{
    NSLog(@"Error: %@", error);
}

- (void)parserCompletedSuccessfully
{
    NSLog(@"Parse complete. You may need to reload the table view to see the data.");
}

- (void)parserDidBegin
{
    NSLog(@"Parsing has begun");
}

@end
