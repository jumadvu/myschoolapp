//
//  StoreHome.m
//  MySchool
//
//  Created by Ashley Kayler on 1/26/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import "StoreHome.h"
#import "StoreItem.h"
#import "StoreItemPlus.h"
#import "Image.h"
#import "StoreHomeCell.h"
#import "MySchoolAppDelegate.h"
#import "User.h"

@implementation StoreHome

@synthesize storeItems;
@synthesize tableView;
@synthesize pointsLabel;

- (void)dealloc {
	[pointsLabel release];
	[storeItems release];
	[tableView release];
    [super dealloc];
}


/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[self setBackgroundColor];
	
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];

	[self setStoreItems:[StoreItem storeItemsArray]];
	tableView.backgroundColor = [UIColor clearColor];
	tableView.rowHeight = 100;
	pointsLabel.text = [delegate.teacher.totalPoints stringValue];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.storeItems count];
}


- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];

	static NSString *CellIdentifier = @"Cell";
    
	CGRect cellFrame = CGRectMake(0,0,100,320);

    StoreHomeCell *cell = (StoreHomeCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[StoreHomeCell alloc] initWithFrame:cellFrame reuseIdentifier:CellIdentifier] autorelease];
		//cell.delegate = self;
    }
	
	StoreItem *storeItem = [storeItems objectAtIndex:indexPath.row];
	
	[cell setItem:storeItem];	
	
	//remove all previous subviews from previously created cells
	for (UIView *view in cell.contentView.subviews) {
		[view removeFromSuperview];
	}
	
	UIColor* myColor;
	if ([[storeItem cost] intValue] > [delegate.teacher.totalPoints intValue]) {
		//can't afford it
		myColor = [UIColor grayColor];
	} else {
		//can afford it
		myColor = [UIColor blackColor];
	}

	//set item image (as button)
	UIButton *myButton = [UIButton buttonWithType:UIButtonTypeCustom]; 
	UIImage *image = [UIImage imageNamed:[[storeItem image] fileName]];
	myButton.imageView.frame = CGRectMake(0, 0, 90, 75); 
	myButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
	[myButton setBackgroundImage:image forState:UIControlStateNormal];
	myButton.frame = CGRectMake(200, 10, 90, 75); 
	[cell setItemButton:myButton];
	[cell.contentView addSubview:cell.itemButton];

	// create the heading label object
	UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	titleLabel.backgroundColor = [UIColor clearColor];
	titleLabel.textAlignment = UITextAlignmentLeft;
	titleLabel.font = [UIFont boldSystemFontOfSize:17];
	titleLabel.textColor = myColor;
	titleLabel.frame = CGRectMake(10.0, 10.0, 190, 30.0);
	[titleLabel setText:[storeItem title]];
	[cell setLblTitle:titleLabel];
	[cell.contentView addSubview:cell.lblTitle];
	[titleLabel release];
	
	// create the heading label object
	UILabel * costLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	costLabel.backgroundColor = [UIColor clearColor];
	costLabel.textAlignment = UITextAlignmentLeft;
	costLabel.font = [UIFont boldSystemFontOfSize:14];
	costLabel.textColor = myColor;
	costLabel.frame = CGRectMake(10.0, 50.0, 190, 50.0);
	[costLabel setText:[NSString stringWithFormat:@"%@ Points", [[storeItem cost] stringValue]]];
	[cell setLblCost:costLabel];
	[cell.contentView addSubview:cell.lblCost];
	[costLabel release];

    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	StoreItem *storeItem = [storeItems objectAtIndex:indexPath.row];
	if ([[storeItem cost] intValue] > [delegate.teacher.totalPoints intValue]) {
		//can't afford it
		NSString *msg = [NSString stringWithFormat:@"You don't have enough teaching points to purchase this item.  You can earn more teaching points by teaching more lessons!"];
		UIAlertView *alert = [[UIAlertView alloc] 
							  initWithTitle:@"Hold on a second!" 
							  message:msg 
							  delegate:self 
							  cancelButtonTitle:@"OK" 
							  otherButtonTitles:nil];
		[alert show];
		[alert release];
	} else {
		//can afford it
		delegate.teacher.totalPoints = [NSNumber numberWithInt:[delegate.teacher.totalPoints intValue] - [[storeItem cost] intValue]];
		[self.pointsLabel setText:[delegate.teacher.totalPoints stringValue]];
		[delegate.teacher addPurchasesObject:storeItem];
		NSString *msg = [NSString stringWithFormat:@"You can see your new %@ in your classroom!", [storeItem title]];
		UIAlertView *alert = [[UIAlertView alloc] 
							  initWithTitle:@"Your students will be happy." 
							  message:msg 
							  delegate:self 
							  cancelButtonTitle:@"OK" 
							  otherButtonTitles:nil];
		[alert show];
		[alert release];
		[self.tableView reloadData];
	}
	
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
