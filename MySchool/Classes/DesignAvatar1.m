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
@synthesize segmentControl3;
@synthesize segmentControl4;
@synthesize imageArray;
@synthesize avatarImageView;
@synthesize descriptions;

- (void)dealloc {
	[descriptions release];
	[avatarImageView release];
	[imageArray release];
	[segmentControl release];
	[segmentControl2 release];
	[segmentControl3 release];
	[segmentControl4 release];
    [super dealloc];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[self setBackgroundColor];
	[self setTopBarTitle:@"Customize Your Avatar" withLogo:NO backButton:YES];
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];	
	//[self setAvatarImageView:[delegate.teacher.avatar customAvatar]];
	[self.avatarImageView addSubview:[delegate.teacher.avatar customAvatarAtSize:1]];
	
	//female descriptive array
	NSArray *skinArray = [NSArray arrayWithObjects:@"Pale",@"Tan",@"Dark",nil];
	NSArray *clothesArray = [NSArray arrayWithObjects:@"Purple",@"Aqua",@"Red",nil];
	NSArray *eyeArray = [NSArray arrayWithObjects:@"Blue",@"Brown",@"Green",nil];
	NSArray *hairArray = [NSArray arrayWithObjects:@"Black",@"Blond",@"Red",nil];
	NSArray *glassesArray = [NSArray arrayWithObjects:@"Yes",@"No",@"",nil];
	
	//male descriptive array
	NSArray *mskinArray = [NSArray arrayWithObjects:@"Pale",@"Tan",@"Dark",nil];
	NSArray *mclothesArray = [NSArray arrayWithObjects:@"Turquoise",@"Green",@"Maroon",nil];
	NSArray *meyeArray = [NSArray arrayWithObjects:@"Blue",@"Brown",@"Green",nil];
	NSArray *mhairArray = [NSArray arrayWithObjects:@"Black",@"Blond",@"Brown",nil];
	NSArray *mglassesArray = [NSArray arrayWithObjects:@"Yes",@"No",@"",nil];
	
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

	self.descriptions = [NSArray arrayWithObjects:skinArray, clothesArray, eyeArray, hairArray, glassesArray, mskinArray, mclothesArray, meyeArray, mhairArray, mglassesArray, skinArrayM, clothesArrayM, eyeArrayM, hairArrayM, glassesArrayM, skinArrayF, clothesArrayF, eyeArrayF, hairArrayF, glassesArrayF, nil];


}

- (void)segmentAction:(UISegmentedControl*)sender {
	NSLog(@"segmentAction: selected segment = %d", [sender selectedSegmentIndex]);
	int index = [sender selectedSegmentIndex];
	
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	if ([delegate.teacher.gender isEqualToString:@"male"]) {
		index = index+5;
	}
	NSLog(@"changing seg 2 titles");
	//switch the segment two choices
	NSArray *anArray = [NSArray arrayWithArray:[self.descriptions objectAtIndex:index]];
	NSLog(@"%d", [anArray count]);
	
	[segmentControl2 setTitle:[anArray objectAtIndex:0] forSegmentAtIndex:0];
	[segmentControl3 setTitle:[anArray objectAtIndex:1] forSegmentAtIndex:0];
	[segmentControl4 setTitle:[anArray objectAtIndex:2] forSegmentAtIndex:0];
	if (index == 4 || index == 9) {
		segmentControl4.hidden = YES;
	} else {
		segmentControl4.hidden = NO;
	}

} 

- (void) changeFeature:(UISegmentedControl*)sender {
	NSLog(@"changing feature");
	//segment 2 controller change the avatar
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	
	if (sender.tag == 0) {
		segmentControl3.selectedSegmentIndex = UISegmentedControlNoSegment;
		segmentControl4.selectedSegmentIndex = UISegmentedControlNoSegment;
	}
	if (sender.tag == 1) {
		segmentControl2.selectedSegmentIndex = UISegmentedControlNoSegment;
		segmentControl4.selectedSegmentIndex = UISegmentedControlNoSegment;
	}
	if (sender.tag == 2) {
		segmentControl2.selectedSegmentIndex = UISegmentedControlNoSegment;
		segmentControl3.selectedSegmentIndex = UISegmentedControlNoSegment;
	}
	
	int seg = [segmentControl selectedSegmentIndex];
	int index = sender.tag;
	NSLog(@"changing type:%d", seg);
	NSLog(@"to index:%d", index);
	//if male
	int whichArray;
	if ([delegate.teacher.gender isEqualToString:@"male"]) {
		whichArray = seg+10;
	} else {
		//female
		whichArray = seg+15;
	}
	switch (seg) {
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
	
	
	//remove any subviews (previous avatar)
	for (UIView *view in self.avatarImageView.subviews) {
		[view removeFromSuperview];
	}
	
	//add the new avatar
	[self.avatarImageView addSubview:[delegate.teacher.avatar customAvatarAtSize:1]];

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
