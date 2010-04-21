//
//  HelpHome.m
//  MySchool
//
//  Created by Ashley Kayler on 1/21/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import "HelpHome.h"
#import "Library.h"
#import "HelpCell.h"


@implementation HelpHome

@synthesize tableview;
@synthesize helpitems;

- (void)dealloc {
	[helpitems release];
	[tableview release];
    [super dealloc];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[self setBackgroundColor];
	[self setTopBarTitle:@"Helpful Tips" withLogo:YES backButton:YES];
	[self.tableview setBackgroundColor:[UIColor clearColor]];
    [super viewDidLoad];
	
	[self setHelpitems:[Library getHelp]];
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	//MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	
    return [helpitems count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
	NSArray *helpBit = [self.helpitems objectAtIndex:indexPath.row];
	
	NSString *text = [helpBit objectAtIndex:0];
	CGSize constraint = CGSizeMake (300,700);
	CGSize size1 = [text sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
	float myHeight1 = size1.height;
	
	NSString *text2 = [helpBit objectAtIndex:1];
	CGSize constraint2 = CGSizeMake (300,700);
	CGSize size2 = [text2 sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:constraint2 lineBreakMode:UILineBreakModeWordWrap];
	float myHeight2 = size2.height;
	
	float myTotalHeight = myHeight1 + myHeight2 + 25;

	CGRect cellFrame = CGRectMake(0,0,myTotalHeight,320);

    HelpCell *cell = [[[HelpCell alloc] initWithFrame:cellFrame reuseIdentifier:CellIdentifier] autorelease];
	
    // Set up the cell...
	cell.titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, myHeight1)];
	cell.titleLbl.textColor = [UIColor blackColor];
	cell.titleLbl.font = [UIFont systemFontOfSize:16.0];
	cell.titleLbl.backgroundColor = [UIColor clearColor];
	
	//main help bit
	cell.textLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, myHeight1+18, 300, myHeight2)];
	cell.textLbl.textColor = [UIColor darkGrayColor];
	cell.textLbl.font = [UIFont systemFontOfSize:14.0];
	cell.textLbl.backgroundColor = [UIColor clearColor];
	cell.textLbl.lineBreakMode = UILineBreakModeWordWrap;
	cell.textLbl.numberOfLines = 0;
		
	cell.titleLbl.text = [helpBit objectAtIndex:0];
	cell.textLbl.text = [helpBit objectAtIndex:1];

	[cell.contentView addSubview:cell.titleLbl];
	[cell.contentView addSubview:cell.textLbl];
	/*
	[cell.contentView setBackgroundColor:[UIColor clearColor]];
	[cell setBackgroundColor:[UIColor clearColor]];
	cell.backgroundView.backgroundColor = [UIColor clearColor];
	*/
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSArray *helpBit = [self.helpitems objectAtIndex:indexPath.row];
	
	NSString *text = [helpBit objectAtIndex:0];
	CGSize constraint = CGSizeMake (300,700);
	CGSize size1 = [text sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
	float myHeight1 = size1.height;
	
	NSString *text2 = [helpBit objectAtIndex:1];
	CGSize constraint2 = CGSizeMake (300,700);
	CGSize size2 = [text2 sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:constraint2 lineBreakMode:UILineBreakModeWordWrap];
	float myHeight2 = size2.height;
	
	float myTotalHeight = myHeight1 + myHeight2 + 25;
	
	return myTotalHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
	return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	//MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}




@end
