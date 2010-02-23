//
//  ChapterHome.m
//  MySchool
//
//  Created by Ashley Kayler on 1/26/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import "ChapterHome.h"
#import "ArticleHome.h"
#import "TBXML.h"


@implementation ChapterHome

@synthesize learnButton, chapterNameLabel, chapterName, textView, fileName;

- (void)dealloc {
	[fileName release];
	[learnButton release];
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
	textView.text = nil;
	TBXML * tbxml = [[TBXML alloc] initWithXMLFile:fileName fileExtension:@"xml"];
	TBXMLElement * root = tbxml.rootXMLElement;
	TBXMLElement * module = [tbxml childElementNamed:@"module" parentElement:root];
	while (module!=nil) {
		if([textView.text isEqualToString:nil]){
		NSLog(@"In the loop.");}
		TBXMLElement * chapter=[tbxml childElementNamed:@"chapter" parentElement:module];
			while (chapter!=nil){
				if ([chapterName isEqualToString:[tbxml textForElement:[tbxml childElementNamed:@"title" parentElement:chapter]]]){
					textView.text=[tbxml textForElement:[tbxml childElementNamed:@"article" parentElement:chapter]];
					break;
				}
				else{
					chapter = [tbxml nextSiblingNamed:@"chapter" searchFromElement:chapter];
				}
			}
		module = [tbxml nextSiblingNamed:@"module" searchFromElement:module];
	}
	[tbxml release];
	
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




@end
