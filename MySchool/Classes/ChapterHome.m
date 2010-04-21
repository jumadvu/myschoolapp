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
#import "ClassroomHome.h"


@implementation ChapterHome

@synthesize imageArray, currentButton, numLabel, teachButton;
@synthesize chapterNameLabel, chapterName, scrollView;
//@synthesize fileName;
@synthesize article;
@synthesize chapter;

- (void)dealloc {
	[chapter release];
	//[fileName release];
	[teachButton release];
	[currentButton release];
	[chapterName release];
	[chapterNameLabel release];
	[numLabel release];
	[scrollView release];
	[article release];
	[imageArray release];
    [super dealloc];
}

-(void)teachButtonSelected:(id)sender {
	//go to classroom
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	ClassroomHome *vc = [[[ClassroomHome alloc] initWithNibName:nil bundle:nil] autorelease];
	[delegate.navCon pushViewController:vc animated:YES];
	
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
	[self setBackgroundColor];
	chapterNameLabel.text= self.chapter.title;
	[teachButton addTarget:self action:@selector(teachButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
	imageArray = [[NSArray alloc] init];
	[self arrangeImageArray];
	[self loadTextIntoScrollView];
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
			continue;
		}
		if ([word isEqualToString:@""]) {
			continue;
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
	NSString *imgStr = [[imageArray objectAtIndex:button.tag] fileName];
	
	UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"%@", imgStr]];
	int maxWidth = 250;
	int maxHeight = 250;
	int newWidth = 0;
	int newHeight = 0;
	if(img.size.width>img.size.height){
		newHeight = (maxWidth*img.size.height/img.size.width);
		newWidth = maxWidth;
	}
	else{
		newWidth = (maxHeight*img.size.width/img.size.height);
		newHeight = maxHeight;
	}
	int hspacer = (maxWidth-newWidth)/2;
	int vspacer = 10;
	UILabel *title = [alert.subviews objectAtIndex:0];
	UIImageView *imgView = [[[UIImageView alloc] initWithFrame:CGRectMake(16+hspacer, title.frame.origin.y+title.frame.size.height+vspacer, newWidth, newHeight)] autorelease];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
	imgView.image = img;
	UILabel *message = [alert.subviews objectAtIndex:1];
	message.frame = CGRectMake(message.frame.origin.x,message.frame.origin.y+newHeight+vspacer*2,
								 message.frame.size.width,message.frame.size.height);
	UIButton *buttons = [alert.subviews objectAtIndex:2];
	buttons.frame = CGRectMake(buttons.frame.origin.x,buttons.frame.origin.y+newHeight+vspacer*2, buttons.frame.size.width,buttons.frame.size.height);
	
	[alert setFrame:CGRectMake(0, 0, alert.frame.size.width, alert.frame.size.height+newHeight+vspacer*4)];
	alert.center = CGPointMake(320/2, 480/2);
    [alert addSubview:imgView];	
	
	int remaining = [numLabel.text intValue]-1;
	if(remaining>=0){
		numLabel.text = [NSString stringWithFormat:@"%d", remaining];
	}
	

}

- (void)arrangeImageArray {
	NSArray *array = [[NSArray alloc] initWithArray:[article.images allObjects]];
	NSSortDescriptor *descriptor =
    [[NSSortDescriptor alloc] initWithKey:@"order" ascending:YES];
	NSArray *descriptors = [NSArray arrayWithObjects:descriptor, nil];
	[self setImageArray:[array sortedArrayUsingDescriptors:descriptors]];
	
}
@end
