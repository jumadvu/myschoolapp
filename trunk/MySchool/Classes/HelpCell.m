//
//  HelpCell.m
//  MySchool
//
//  Created by Ashley Kayler on 4/20/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import "HelpCell.h"


@implementation HelpCell

@synthesize titleLbl;
@synthesize textLbl;

- (void)dealloc {
	[titleLbl release];
	[textLbl release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	//MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		//
		UIView *backView = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
		backView.backgroundColor = [UIColor clearColor];
		self.backgroundView = backView;
	}
	return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
