//
//  MatchismoHistoryViewController.m
//  Matchismo
//
//  Created by Priyanjana Bengani on 26/12/2013.
//  Copyright (c) 2013 anothercookiecrumbles. All rights reserved.
//

#import "MatchismoHistoryViewController.h"

@interface MatchismoHistoryViewController ()

@end

@implementation MatchismoHistoryViewController

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.history count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    cell.textLabel.attributedText = self.history[indexPath.row];
    
    return cell;
}

@end
