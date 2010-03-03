//
//  NewGameHome.m
//  MySchool
//
//  Created by Ashley Kayler on 1/21/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import "NewGameHome.h"
#import "DesignAvatar1.h"
#import "User.h"
#import "Avatar.h"
#import "Student.h"
#import "StudentPlus.h"

@implementation NewGameHome

@synthesize continueButton;
@synthesize avatar1Button;
@synthesize avatar2Button;
@synthesize firstField;
@synthesize lastField;
@synthesize avatarImages;
@synthesize avatarImagesWaistUp;
@synthesize selectedImage;

- (void)dealloc {
	[avatarImages release];
	[avatarImagesWaistUp release];
	[avatar1Button release];
	[avatar2Button release];
	[firstField release];
	[lastField release];
	[continueButton release];
    [super dealloc];
}

- (void)viewDidLoad {
	[self setBackgroundColor];

	NSArray *array = [[NSArray alloc] initWithObjects:@"TeacherFBody.png", @"TeacherMBody.png", nil];
	[self setAvatarImages:array];
	[array release];
	
	NSArray *array2= [[NSArray alloc] initWithObjects:@"TeacherFWaistUp.png", @"TeacherMWaistUp.png", nil];
	[self setAvatarImagesWaistUp:array2];
	[array2 release];
	
	[firstField setDelegate:self];
	[lastField setDelegate:self];
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated {
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	if (delegate.teacher == nil) {
		//default for no image
		selectedImage = 100;
	} else {
		[firstField setText:delegate.teacher.firstName];
		[lastField setText:delegate.teacher.lastName];
		//set alpha of avatars
		if ([delegate.teacher.avatar.avatarImage isEqualToString:[avatarImages objectAtIndex:0]]) {
			avatar1Button.alpha = 1;
			[self setSelectedImage:0];
		} else {
			avatar1Button.alpha = .2;
		}
		
		if ([delegate.teacher.avatar.avatarImage isEqualToString:[avatarImages objectAtIndex:1]]) {
			avatar2Button.alpha = 1;
			[self setSelectedImage:1];
		} else {
			avatar2Button.alpha = .2;
		}
		
		//set default for existing image
		selectedImage = 101;
	}
}

-(void)continueAvatarDesign {
	//go back to previous page
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	BOOL requiredDataMissing = NO;
	if (firstField.text.length == 0) requiredDataMissing = YES;
	if (lastField.text.length == 0) requiredDataMissing = YES;
	if (selectedImage == 100) requiredDataMissing = YES;

	if (requiredDataMissing) {
		NSMutableString *msg = [[NSMutableString alloc] initWithFormat:@"Please choose a first and a last name and select an avatar."];
		UIAlertView *alert = [[UIAlertView alloc] 
							  initWithTitle:@"Required Info Missing" 
							  message:msg 
							  delegate:self 
							  cancelButtonTitle:@"OK" 
							  otherButtonTitles:nil];
		[alert show];
		[alert release];
		[msg release];
		
	} else {
		if (delegate.teacher == nil) {
			//create new teacher
			User *aTeacher = (User *)[NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:delegate.managedObjectContext];
			Avatar *avatar = (Avatar *)[NSEntityDescription insertNewObjectForEntityForName:@"Avatar" inManagedObjectContext:delegate.managedObjectContext];
			[aTeacher setFirstName:[NSString stringWithFormat:firstField.text]];
			[aTeacher setLastName:[NSString stringWithFormat:lastField.text]];
			[avatar setAvatarImage:[avatarImages objectAtIndex:selectedImage]];
			[avatar setAvatarImageWaistUp:[avatarImagesWaistUp objectAtIndex:selectedImage]];
			[aTeacher setStudents:[Student createStudentsInContext:delegate.managedObjectContext]];
			[aTeacher setAvatar:avatar];
			//assign the main account holder to this parent
			delegate.teacher = aTeacher;
		} else {
			//set the image only if it is changed
			if (selectedImage != 101) {
				[delegate.teacher.avatar setAvatarImage:[avatarImages objectAtIndex:selectedImage]];
			}
			[delegate.teacher setFirstName:[NSString stringWithFormat:firstField.text]];
			[delegate.teacher setLastName:[NSString stringWithFormat:lastField.text]];
			
		}

		
		
		//save the managed object
		NSError *error;
		if (![delegate.managedObjectContext save:&error]) {
			NSLog(@"error saving managed object");
			// Handle the error.
		}
		//go to second phase of avatar design
		DesignAvatar1 *vc = [[[DesignAvatar1 alloc] initWithNibName:nil bundle:nil] autorelease];
		[delegate.navCon pushViewController:vc animated:YES];
	}
}

- (void)avatarSelected:(UIButton *)sender {
	NSLog(@"button selected");
	if (avatar1Button == sender) {
		avatar1Button.alpha = 1;
		[self setSelectedImage:0];
	} else {
		avatar1Button.alpha = .2;
	}

	if (avatar2Button == sender) {
		avatar2Button.alpha = 1;
		[self setSelectedImage:1];
	} else {
		avatar2Button.alpha = .2;
	}
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	NSLog(@"return");
	[textField resignFirstResponder];
	return YES;
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
