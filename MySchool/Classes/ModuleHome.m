//
//  ModuleHome.m
//  MySchool
//
//  Created by Ashley Kayler on 1/26/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import "ModuleHome.h"
#import "ChapterHome.h"
#import "TBXML.h"
#import "ChapterCell.h"
#import "ModuleTable.h"

@implementation ModuleHome

<<<<<<< .mine
@synthesize chapterButton, tableview, moduleNameLabel, chapters, moduleName, fileName, module;
=======
@synthesize backButton, moduleNameLabel, moduleName, scrollview, pcurrent, ptotal, moduleNames, fileName;
>>>>>>> .r93

- (void)dealloc {
<<<<<<< .mine
	[module release];
=======
	[backButton release];
	[moduleName release];
	[scrollview release];
	[moduleNameLabel release];
	[ptotal release];
	[pcurrent release];
	[moduleNames release];
>>>>>>> .r93
	[fileName release];
    [super dealloc];
}



-(void)toChapter {
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	ChapterHome *vc = [[[ChapterHome alloc] initWithNibName:nil bundle:nil] autorelease];
	[delegate.navCon pushViewController:vc animated:YES];	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[self setBackgroundColor];
	scrollview.delegate = self;
	[self.scrollview setBackgroundColor:[UIColor whiteColor]];
	[scrollview setCanCancelContentTouches:NO];
	scrollview.indicatorStyle = UIScrollViewIndicatorStyleWhite;
	scrollview.clipsToBounds = YES;
	scrollview.scrollEnabled = YES;
	scrollview.pagingEnabled = YES;
	
	CGFloat cx = 0;

	TBXML * tbxml = [[TBXML alloc] initWithXMLFile:fileName fileExtension:@"xml"];
	TBXMLElement * root = tbxml.rootXMLElement;
	TBXMLElement * module = [tbxml childElementNamed:@"module" parentElement:root];
	moduleNames= [NSMutableArray new];
	while (module!=nil) {
		NSString * mName = [tbxml textForElement:[tbxml childElementNamed:@"title" parentElement:module]];
		[moduleNames addObject:mName];
		
		ModuleTable *tableview = [[ModuleTable alloc] retain];
		tableview.fileName = self.fileName;
		tableview.moduleName = mName;
		
		CGRect rect = tableview.view.frame;
		rect.size.height = 345;
		rect.size.width = 300;
		rect.origin.x = cx;
		rect.origin.y = 0;
		
		tableview.view.frame = rect;
		tableview.tableview.rowHeight = 60;
		tableview.tableview.backgroundColor = [UIColor clearColor];
		[scrollview addSubview:tableview.view];
		[tableview release];
		
		cx += scrollview.frame.size.width; 
		module = [tbxml nextSiblingNamed:@"module" searchFromElement:module];
	}
	
	moduleNameLabel.text = [moduleNames objectAtIndex: 0];
	pcurrent.text = [NSString stringWithFormat:@"1"];
	ptotal.text = [NSString stringWithFormat:@"%d", [moduleNames count]];
	[scrollview setContentSize:CGSizeMake(cx, [scrollview bounds].size.height)];
	[tbxml release];
}

#pragma mark -
#pragma mark UIScrollViewDelegate stuff
- (void)scrollViewDidScroll:(UIScrollView *)_scrollview
{
    if (pageControlIsChangingPage) {
        return;
    }
	
	/*
	 *	We switch page at 50% across
	 */
    CGFloat pageWidth = _scrollview.frame.size.width;
    int page = floor((_scrollview.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
	moduleNameLabel.text = [moduleNames objectAtIndex: page];
    pcurrent.text = [NSString stringWithFormat:@"%d", page+1];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView 
{
    pageControlIsChangingPage = NO;
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
