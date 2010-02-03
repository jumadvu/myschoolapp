//
//  ModuleCell.m
//  MySchool
//
//  Created by Connor Riley on 2/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ModuleCell.h"
#import "ModuleHome.h"
#import "MySchoolAppDelegate.h"


@implementation ModuleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // Initialization code
    }
    return self;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	ModuleHome *vc = [[[ModuleHome alloc] initWithNibName:nil bundle:nil] autorelease];
	vc.moduleName=self.textLabel.text;
	[delegate.navCon pushViewController:vc animated:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [super dealloc];
}


@end
