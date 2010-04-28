//
//  DesignAvatar1.m
//  MySchool
//
//  Created by Ashley Kayler on 1/25/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import "DesignAvatar1.h"
#import "Avatar.h"
#import "User.h"
#import "AvatarPlus.h"
#import "MySchoolAppDelegate.h"

@implementation DesignAvatar1

@synthesize segmentControl;
@synthesize segmentControl2;
@synthesize imageArray;
@synthesize avatarImageView;
@synthesize descriptions;

- (void)dealloc {
	[descriptions release];
	[avatarImageView release];
	[imageArray release];
	[segmentControl release];
	[segmentControl2 release];
    [super dealloc];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[self setBackgroundColor];
	[self setTopBarTitle:@"Customize Your Avatar" withLogo:NO backButton:YES];
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];	
	//[self setAvatarImageView:[delegate.teacher.avatar customAvatar]];
	[self.avatarImageView addSubview:[delegate.teacher.avatar customAvatar]];
	
	//descriptive array
	NSArray *skinArray = [NSArray arrayWithObjects:@"Pale",@"Tan",@"Dark",nil];
	NSArray *clothesArray = [NSArray arrayWithObjects:@"Purple",@"Green",@"Red",nil];
	NSArray *eyeArray = [NSArray arrayWithObjects:@"Blue",@"Brown",@"Green",nil];
	NSArray *hairArray = [NSArray arrayWithObjects:@"Black",@"Blond",@"Red",nil];
	NSArray *glassesArray = [NSArray arrayWithObjects:@"Yes",@"No",@"",nil];
	
	//male filenames
	NSArray *skinArrayM = [NSArray arrayWithObjects:@"MSkinPale.png",@"MSkinMed.png",@"MSkinDark.png",nil];
	NSArray *clothesArrayM = [NSArray arrayWithObjects:@"MClothes1.png",@"MClothes2.png",@"MClothes3.png",nil];
	NSArray *eyeArrayM = [NSArray arrayWithObjects:@"MEyesBlue.png",@"MEyesBrown.png",@"MEyesGreen.png",nil];
	NSArray *hairArrayM = [NSArray arrayWithObjects:@"MHairBlack.png",@"MHairBlond.png",@"MHairBrown.png",nil];
	NSArray *glassesArrayM = [NSArray arrayWithObjects:[NSNumber numberWithInt:1],[NSNumber numberWithInt:0],[NSNumber numberWithInt:0], nil];

	//female filenames
	NSArray *skinArrayF = [NSArray arrayWithObjects:@"FSkinPale.png",@"FSkinMed.png",@"FSkinDark.png",nil];
	NSArray *clothesArrayF = [NSArray arrayWithObjects:@"FClothes1.png",@"FClothes2.png",@"FClothes3.png",nil];
	NSArray *eyeArrayF = [NSArray arrayWithObjects:@"FEyesBlue.png",@"FEyesBrown.png",@"FEyesGreen.png",nil];
	NSArray *hairArrayF = [NSArray arrayWithObjects:@"FHairBlack.png",@"FHairBlond.png",@"FHairRed.png",nil];
	NSArray *glassesArrayF = [NSArray arrayWithObjects:[NSNumber numberWithInt:1],[NSNumber numberWithInt:0],[NSNumber numberWithInt:0], nil];

	self.descriptions = [NSArray arrayWithObjects:skinArray, clothesArray, eyeArray, hairArray, glassesArray, skinArrayM, clothesArrayM, eyeArrayM, hairArrayM, glassesArrayM, skinArrayF, clothesArrayF, eyeArrayF, hairArrayF, glassesArrayF, nil];


}

- (void)segmentAction:(UISegmentedControl*)sender {
	NSLog(@"segmentAction: selected segment = %d", [sender selectedSegmentIndex]);
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];	
	int index = [sender selectedSegmentIndex];
	
	if (sender.tag == 1) {
		NSLog(@"changing seg 2 titles");
		//switch the segment two choices
		NSArray *anArray = [NSArray arrayWithArray:[self.descriptions objectAtIndex:index]];
		NSLog(@"%d", [anArray count]);
		//[segmentControl2 removeAllSegments];
		//[segmentControl2 initWithItems:anArray];
		
		for (int x=0; x<[anArray count]; x++) {
			[segmentControl2 setTitle:[anArray objectAtIndex:x] forSegmentAtIndex:x];
		}
	} else {
		//segment 2 controller change the avatar
		int seg1Index = [segmentControl selectedSegmentIndex];
		NSLog(@"changing type:%d", seg1Index);
		NSLog(@"to index:%d", index);
		//if male
		int whichArray;
		if ([delegate.teacher.gender isEqualToString:@"male"]) {
			whichArray = seg1Index+5;
		} else {
			//female
			whichArray = seg1Index+10;
		}
		switch (seg1Index) {
			case 0:
				delegate.teacher.avatar.skin = [[self.descriptions objectAtIndex:whichArray] objectAtIndex:index];
				NSLog(@"%@",[[self.descriptions objectAtIndex:whichArray] objectAtIndex:index]);
				break;
			case 1:
				delegate.teacher.avatar.clothes = [[self.descriptions objectAtIndex:whichArray] objectAtIndex:index];
				NSLog(@"%@",[[self.descriptions objectAtIndex:whichArray] objectAtIndex:index]);
				break;
			case 2:
				delegate.teacher.avatar.eyes = [[self.descriptions objectAtIndex:whichArray] objectAtIndex:index];
				NSLog(@"%@",[[self.descriptions objectAtIndex:whichArray] objectAtIndex:index]);
				break;
			case 3:
				delegate.teacher.avatar.hair = [[self.descriptions objectAtIndex:whichArray] objectAtIndex:index];
				NSLog(@"%@",[[self.descriptions objectAtIndex:whichArray] objectAtIndex:index]);
				break;
			case 4:
				delegate.teacher.avatar.glasses = [[self.descriptions objectAtIndex:whichArray] objectAtIndex:index];
				NSLog(@"%@",[[self.descriptions objectAtIndex:whichArray] objectAtIndex:index]);
				break;
			default:
				break;
		}
	}
	
	//remove any subviews
	for (UIView *view in self.avatarImageView.subviews) {
		[view removeFromSuperview];
	}
	
	[self.avatarImageView addSubview:[delegate.teacher.avatar customAvatar]];

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
