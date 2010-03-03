//
//  ChapterHome.m
//  MySchool
//
//  Created by Ashley Kayler on 1/26/10.
//  Copyright 2010 DataJedi. All rights reserved.
//
#import "Article.h"
#import "ChapterHome.h"
#import "Chapter.h"
#import "ArticleHome.h"
#import "TBXML.h"
#import "Image.h"


@implementation ChapterHome

@synthesize imageArray, currentButton, numLabel, learnButton, chapterNameLabel, chapterName, scrollView, fileName, article;

- (void)dealloc {
	[fileName release];
	[learnButton release];
	[currentButton release];
	[chapterName release];
	[chapterNameLabel release];
	[numLabel release];
	[scrollView release];
	[article release];
	[imageArray release];
    [super dealloc];
}

-(void)toArticle {
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	ArticleHome *vc = [[[ArticleHome alloc] initWithNibName:nil bundle:nil] autorelease];
	[delegate.navCon pushViewController:vc animated:YES];	
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
	chapterNameLabel.text=chapterName;
	imageArray = [[NSArray alloc] init];
	[self arrangeImageArray];
	//NSArray * narray = [[NSArray alloc] initWithObjects:@"String",nil];
	//imageArray = narray;
	//[narray release];
	NSLog(@"%@", [self.imageArray objectAtIndex:0]);
	//NSString *strin = [[imageArray objectAtIndex:0] desc];
	//NSLog(@"%@", strin);
	[self loadTextIntoScrollView];
	//NSString *strin2 = [[imageArray objectAtIndex:0] desc];
	//NSLog(@"%@", strin2);


}

- (void)loadTextIntoScrollView {
	//create a UILabel for each regular word in the text and a UIButton for each keyword
	//add these labels and buttons to the scrollview
	
	scrollView.backgroundColor = [UIColor whiteColor];
	NSMutableArray *words = [[NSMutableArray alloc] init];
	NSArray *lines = [article.text componentsSeparatedByString:@"\n"];
	NSEnumerator *enumerator = [lines objectEnumerator];
	id obj;
	while(obj = [enumerator nextObject]) {
		[words addObjectsFromArray:[obj componentsSeparatedByString:@" "]];
		[words addObject:@"zzz"];	
	}
	NSString *word;
	int x = 0;
	int y = 0;
	int spacer = 5;
	NSEnumerator *wordEnumerator = [words objectEnumerator];
	UIColor *labelColor;
	labelColor = [UIColor clearColor]; //default
	int tagCount = 0;
	while (word = [wordEnumerator nextObject]) {
		//turn on label coloring
		if ([word isEqualToString:@"zzz"]) {
			y = y + 30;
			x = 0;
			break;
		}
		if ([[word substringToIndex:1] isEqualToString:@"["]) {
			NSMutableString *buttonWord = (NSMutableString*)[word stringByReplacingOccurrencesOfString:@"[" withString:@""];
			while ([word rangeOfString:@"]"].location == NSNotFound) {
				word = [wordEnumerator nextObject];
				[buttonWord appendFormat:@" %@", word];
			}			
			buttonWord = (NSMutableString*)[buttonWord stringByReplacingOccurrencesOfString:@"]" withString:@""];
			
			UIButton *memberButt = [UIButton buttonWithType:UIButtonTypeCustom]; 
			memberButt.titleLabel.font = [UIFont systemFontOfSize:17.0];
			[memberButt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
			memberButt.backgroundColor = [UIColor clearColor];
			[memberButt setTitle:buttonWord forState:UIControlStateNormal];
			memberButt.tag = tagCount;
			[scrollView addSubview:memberButt];
			[memberButt addTarget:self action:@selector(clickedButton:) forControlEvents:UIControlEventTouchUpInside];  
			memberButt.frame = CGRectMake(x, y, 145.0, 30.0);  
			[memberButt sizeToFit];
			x = x + memberButt.frame.size.width + spacer;
			if (x > (scrollView.frame.size.width-10)) {
				x = 0;
				y = y + 30;
				//move label to next row
				CGRect newFrame = CGRectMake(x, y, 140, 30.0);
				memberButt.frame = newFrame;
				[memberButt sizeToFit];
				x = x + memberButt.frame.size.width + spacer;
			}
			tagCount++;
			
		} else {
			UILabel * label = [[UILabel alloc] initWithFrame:CGRectZero];
			label.backgroundColor = [UIColor clearColor];
			label.font = [UIFont systemFontOfSize:17.0];
			label.text = word;
			
			CGRect labelFrame = CGRectMake(x, y, 240, 30.0);
			label.frame = labelFrame;
			[label sizeToFit];
			x = x + label.frame.size.width + spacer;
			
			if (x > (scrollView.frame.size.width-10)) {
				x = 0;
				y = y + 30;
				//move label to next row
				CGRect newLabelFrame = CGRectMake(x, y, 240, 30.0);
				label.frame = newLabelFrame;
				[label sizeToFit];
				x = x + label.frame.size.width + spacer;
			}
			[scrollView addSubview:label];
			[label release];
		}
		//NSLog(@"%@ isButton: %d", word, isButton);
		/*
		 if ([word rangeOfString:@"]"].location != NSNotFound) {
		 isButton = NO;
		 }
		 */
	}
	[scrollView setContentSize:CGSizeMake(280, y+30)];

	numLabel.text=[NSString stringWithFormat:@"%d", tagCount];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)clickedButton:(UIButton *)button {
	NSString *str = [[imageArray objectAtIndex:button.tag] desc];
	UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Secret found!" message:[NSString stringWithFormat:@"%@", str] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
    [alert show];
	button.backgroundColor = [UIColor clearColor];
	[button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
	numLabel.text = [NSString stringWithFormat:@"%d", [numLabel.text intValue]-1];
	

}

- (void)arrangeImageArray {
	NSArray *array = [[NSArray alloc] initWithArray:[article.images allObjects]];
	NSSortDescriptor *descriptor =
    [[NSSortDescriptor alloc] initWithKey:@"order"
								 ascending:YES];
	
	NSArray *descriptors = [NSArray arrayWithObjects:descriptor, nil];
	[self setImageArray:[array sortedArrayUsingDescriptors:descriptors]];
	
}
@end
