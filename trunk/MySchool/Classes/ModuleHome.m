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
#import "Library.h"
#import "Module.h"
#import "ModulePlus.h"

@implementation ModuleHome

@synthesize backButton, moduleNameLabel, moduleName, scrollview, pcurrent, ptotal, moduleNames, fileName, targetModule, modules;


- (void)dealloc {
	[backButton release];
	[moduleName release];
	[scrollview release];
	[moduleNameLabel release];
	[ptotal release];
	[pcurrent release];
	[moduleNames release];
	[fileName release];
	[targetModule release];
	[modules release];
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
	
	ModuleTable *tableview = [[ModuleTable alloc] retain];
	tableview.fileName = self.fileName;
	tableview.module = targetModule;
	tableview.moduleName = targetModule.title;
		
	CGRect rect = tableview.view.frame;
	rect.size.height = 345;
	rect.size.width = 300;
	rect.origin.x = 0;
	rect.origin.y = 0;
		
	tableview.view.frame = rect;
	tableview.tableview.rowHeight = 60;
	tableview.tableview.backgroundColor = [UIColor clearColor];
	[scrollview addSubview:tableview.view];
	[tableview release];
		
	
	moduleNameLabel.text = targetModule.title;
	//[scrollview setContentSize:CGSizeMake(cx, [scrollview bounds].size.height)];
	
	//[scrollview setContentOffset:CGPointMake(tx, 0) animated:YES];
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
	moduleNameLabel.text = [[modules objectAtIndex: page] objectAtIndex:0];
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
