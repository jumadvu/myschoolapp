//
//  StoreHomeCell.m
//  MySchool
//
//  Created by Ashley Kayler on 3/17/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import "StoreHomeCell.h"
#import "Image.h"

@implementation StoreHomeCell

@synthesize lblCost;
@synthesize lblTitle;
@synthesize itemButton;
@synthesize item;

- (void)dealloc {
	[item release];
	[lblCost release];
	[itemButton release];
	[lblTitle release];
    [super dealloc];
}

-(void)buttonSelected:(id)sender {
	//go to classroom
	//MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	//MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
				
		[self.contentView setBackgroundColor:[UIColor colorWithRed:.9 green:.9 blue:.9 alpha:.1]];

	}
	return self;
}

- (void)layoutSubviews {
	[super layoutSubviews];
		
}

/*
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	//selected the cell. Default to learning not teaching
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	ChapterHome *vc = [[[ChapterHome alloc] initWithNibName:nil bundle:nil] autorelease];
	vc.chapterName=self.textLabel.text;
	vc.fileName = fileName;
	vc.article = article;
	[delegate.navCon pushViewController:vc animated:YES];
}
*/

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	
    [super setSelected:selected animated:animated];
	
    // Configure the view for the selected state
}


@end
