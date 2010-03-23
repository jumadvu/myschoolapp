//
//  ChapterCell.m
//  MySchool
//
//  Created by Connor Riley on 2/3/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Article.h"
#import "ChapterCell.h"
#import "ChapterHome.h"
#import "MySchoolAppDelegate.h"
#import "ClassroomHome.h"


@implementation ChapterCell

@synthesize fileName;
@synthesize lblTitle;
@synthesize tButton;
@synthesize lButton;
@synthesize article;
@synthesize chapter;

- (void)dealloc {
	//[lblTitle release];//not currently using this
	//[tButton release]; //don't need to release because it is created with an autorelease
	//[lButton release];
	[chapter release];
	[fileName release];
	[lblTitle release];
	[tButton release];
	[lButton release];
	[article release];
    [super dealloc];
}

-(void)teachButtonSelected:(id)sender {
	//go to classroom
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	ClassroomHome *vc = [[[ClassroomHome alloc] initWithNibName:nil bundle:nil] autorelease];
	//[delegate setCurrentChapter:[(ModuleTable*)[self superview] chapter]];
	[delegate setCurrentChapter:[self chapter]];
	[delegate.navCon pushViewController:vc animated:YES];
	
}
-(void)learnButtonSelected:(id)sender {
	//go to learn interaction
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	ChapterHome *vc = [[[ChapterHome alloc] initWithNibName:nil bundle:nil] autorelease];
	vc.chapterName=self.textLabel.text;
	vc.fileName = fileName;
	vc.article = article;
	[delegate.navCon pushViewController:vc animated:YES];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	//MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		UIImage *teachImage = [UIImage imageNamed:@"teach.png"];
		UIImage *learnImage = [UIImage imageNamed:@"learn.png"];
		
		
		lblTitle = [[UILabel alloc] initWithFrame:CGRectZero];
		lblTitle.textColor = [UIColor blackColor];
		lblTitle.font = [UIFont boldSystemFontOfSize:15.0];
		lblTitle.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:lblTitle];
		
		tButton = [UIButton buttonWithType: UIButtonTypeCustom]; 
		[tButton setBackgroundImage:teachImage forState:UIControlStateNormal];
		[self.contentView addSubview:tButton];
		[tButton addTarget:self action:@selector(teachButtonSelected:) forControlEvents:UIControlEventTouchUpInside];  
		
		lButton = [UIButton buttonWithType: UIButtonTypeCustom]; 
		[lButton setBackgroundImage:learnImage forState:UIControlStateNormal];
		[self.contentView addSubview:lButton];
		[lButton addTarget:self action:@selector(learnButtonSelected:) forControlEvents:UIControlEventTouchUpInside];  
		
		[self.contentView setBackgroundColor:[UIColor whiteColor]];
				
	}
	return self;
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	CGRect baseRect = CGRectInset(self.contentView.bounds, 10, 0);
	CGRect rect = baseRect;
	
	rect.origin.x += 2;
	rect.origin.y += 0;
	rect.size.width = 200;
	lblTitle.frame = rect;
		
	tButton.frame = CGRectMake(270, 10, 35.0, 35.0);  
	lButton.frame = CGRectMake(220, 10, 35.0, 35.0);  
	
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	//selected the cell. Default to learning not teaching
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	ChapterHome *vc = [[[ChapterHome alloc] initWithNibName:nil bundle:nil] autorelease];
	vc.chapterName=self.textLabel.text;
	vc.fileName = fileName;
	vc.article = article;
	[delegate.navCon pushViewController:vc animated:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
