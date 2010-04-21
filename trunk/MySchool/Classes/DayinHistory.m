//
//  day_in_history.m
//  MySchool
//
//  Created by Connor Riley on 4/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DayinHistory.h"
#import "TBXML.h"
#import "ScoreAnim.h"


@implementation DayinHistory
@synthesize month, entry, current, parsedDate;

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
	[self setTopBarTitle:@"Activity" withLogo:YES backButton:YES];
	current = [NSDate date];
	[self changeDate:[NSNumber numberWithInt:0]];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
-(void)changeDate:(NSNumber *)offset {
	// start by retrieving day, weekday, month and year components for date
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];	
    // now build a NSDate object for the next day
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:[offset intValue]];
    NSDate *nextDate = [gregorian dateByAddingComponents:offsetComponents toDate: current options:0];
    [offsetComponents release];
    [gregorian release];
	
	[self setCurrent:nextDate];
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"MMMM d"];
	parsedDate = [dateFormatter stringFromDate:current];
	[month setText:parsedDate];	
	[self loadCurrentEvents];
}
-(void)loadCurrentEvents {
	TBXML * tbxml = [[TBXML alloc] initWithXMLFile:@"dates" fileExtension:@"xml"];
	TBXMLElement * root = tbxml.rootXMLElement;
	
	//get the first subject from the xml file
	TBXMLElement * date = [tbxml childElementNamed:@"date" parentElement:root];
	entry.text = @"No information available.";
	while (date!=nil) {
		if([parsedDate isEqualToString:[tbxml valueOfAttributeNamed:@"value" forElement:date]]){
			TBXMLElement * event1 = [tbxml childElementNamed:@"event" parentElement:date];
			TBXMLElement * event2 = [tbxml nextSiblingNamed:@"event" searchFromElement:event1];
			NSString * baseString = @"";
			entry.text = [baseString stringByAppendingFormat:@"%@: %@\n\n%@: %@", [tbxml valueOfAttributeNamed:@"year" forElement:event1],[tbxml textForElement:event1],[tbxml valueOfAttributeNamed:@"year" forElement:event2],[tbxml textForElement:event2]];
		}
		date = [tbxml nextSiblingNamed:@"date" searchFromElement:date];
	}
}
- (void)backOneDay{
	[self changeDate:[NSNumber numberWithInt:-1]];
}
- (void)forwardOneDay{
	[self changeDate:[NSNumber numberWithInt:1]];
	//ScoreAnim *anim = [ScoreAnim alloc]
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


- (void)dealloc {
	[entry release];
	[month release];
	[current release];
	[parsedDate release];
    [super dealloc];
}


@end
