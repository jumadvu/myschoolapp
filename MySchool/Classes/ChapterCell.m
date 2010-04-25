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

@synthesize lblTitle;
@synthesize article;
@synthesize chapter;

- (void)dealloc {
	[chapter release];
	[lblTitle release];
	[article release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		
		lblTitle = [[UILabel alloc] initWithFrame:CGRectZero];
		lblTitle.textColor = [UIColor blackColor];
		lblTitle.font = [UIFont boldSystemFontOfSize:15.0];
		lblTitle.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:lblTitle];
				
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
		
	
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}



@end
