//
//  StudentPlus.m
//  MySchool
//
//  Created by Ashley Kayler on 2/5/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import "StudentPlus.h"
#import "CompletedWorksheet.h"
#import "Library.h"
#import "BehaviorReport.h"

@implementation Student (StudentPlus)

+(NSSet*)createStudentsInContext:(NSManagedObjectContext*)context {
	
	NSArray *girlsNames = [NSArray arrayWithObjects:@"Emma",@"Isabella",@"Emily",@"Madison",@"Ava",@"Olivia",@"Sophia",@"Abigail",@"Elizabeth",@"Chloe",@"Samantha",@"Addison",@"Natalie",@"Mia",@"Alexis",@"Alyssa",@"Hannah",@"Ashley",@"Ella",@"Sarah",@"Grace",@"Taylor",@"Brianna",@"Lily",@"Hailey",@"Anna",@"Victoria",@"Kayla",@"Lillian",@"Lauren",@"Kaylee",@"Allison",@"Savannah",@"Nevaeh",@"Gabriella",@"Sofia",@"Makayla",@"Avery",@"Riley",@"Julia",@"Leah",@"Aubrey",@"Jasmine",@"Audrey",@"Katherine",@"Morgan",@"Brooklyn",@"Destiny",@"Sydney",@"Alexa",@"Kylie",@"Brooke",@"Kaitlyn",@"Evelyn",@"Layla",@"Madeline",@"Kimberly",@"Zoe",@"Jessica",@"Peyton",@"Alexandra",@"Claire",@"Madelyn",@"Maria",@"Mackenzie",@"Arianna",@"Jocelyn",@"Amelia",@"Angelina",@"Trinity",@"Andrea",@"Maya",@"Valeria",@"Sophie",@"Rachel",@"Vanessa",@"Aaliyah",@"Mariah",@"Gabrielle",@"Katelyn",@"Ariana",@"Bailey",@"Camila",@"Jennifer",@"Melanie",@"Gianna",@"Charlotte",@"Paige",@"Autumn",@"Payton",@"Faith",@"Sara",@"Isabelle",@"Caroline",@"Genesis",@"Isabel",@"Mary",@"Zoey",@"Gracie",@"Megan",nil];
	NSArray *boysNames = [NSArray arrayWithObjects:@"Jacob",@"Michael",@"Ethan",@"Joshua",@"Daniel",@"Alexander",@"Anthony",@"William",@"Christopher",@"Matthew",@"Jayden",@"Andrew",@"Joseph",@"David",@"Noah",@"Aiden",@"James",@"Ryan",@"Logan",@"John",@"Nathan",@"Elijah",@"Christian",@"Gabriel",@"Benjamin",@"Jonathan",@"Tyler",@"Samuel",@"Nicholas",@"Gavin",@"Dylan",@"Jackson",@"Brandon",@"Caleb",@"Mason",@"Angel",@"Isaac",@"Evan",@"Jack",@"Kevin",@"Jose",@"Isaiah",@"Luke",@"Landon",@"Justin",@"Lucas",@"Zachary",@"Jordan",@"Robert",@"Aaron",@"Brayden",@"Thomas",@"Cameron",@"Hunter",@"Austin",@"Adrian",@"Connor",@"Owen",@"Aidan",@"Jason",@"Julian",@"Wyatt",@"Charles",@"Luis",@"Carter",@"Juan",@"Chase",@"Diego",@"Jeremiah",@"Brody",@"Xavier",@"Adam",@"Carlos",@"Sabastian",@"Liam",@"Hayden",@"Nathaniel",@"Henry",@"Jesus",@"Ian",@"Tristan",@"Bryan",@"Sean",@"Cole",@"Alex",@"Eric",@"Brian",@"Jaden",@"Carson",@"Blake",@"Ayden",@"Cooper",@"Dominic",@"Brady",@"Caden",@"Josiah",@"Kyle",@"Colton",@"Kaden1",@"Eli",nil];
	NSMutableArray *students = [[[NSMutableArray alloc] init] autorelease];
	BOOL isGirl = YES;
	int girlNum = 0;
	int boyNum = 0;

	for (int x=0; x<4; x++) {
		Student *student = (Student *)[NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:context];
		int i = arc4random() % 100;
		[student setPoliteness:[NSNumber numberWithInt:i]];
		int j = arc4random() % 100;
		[student setIntelligence:[NSNumber numberWithInt:j]];
		int k = arc4random() % 100;
		[student setFriendliness:[NSNumber numberWithInt:k]];
		int l = arc4random() % 100;
		int m = arc4random() % 100;
		if (isGirl) {
			girlNum++;
			[student setAvatarImage:[NSString stringWithFormat:@"Girl%d", girlNum]];
			[student setFirstName:[girlsNames objectAtIndex:l]];
			[student setOrder:[NSNumber numberWithInt:x]];
			[student setGender:@"Girl"];			
			isGirl = NO;
		} else {
			boyNum++;
			[student setAvatarImage:[NSString stringWithFormat:@"Boy%d", boyNum]];
			[student setFirstName:[boysNames objectAtIndex:m]];
			[student setOrder:[NSNumber numberWithInt:x]];
			[student setGender:@"Boy"];
			isGirl = YES;
		}

		[students addObject:student];
	}
	NSSet *mySet = [NSSet setWithArray:students];
	return mySet;
}

-(UIImage *)frontView {
	NSString *mood = [NSString stringWithFormat:@"Happy"];
	//NSLog([self avatarImage]);
	NSString *imageFile = [NSString stringWithFormat:@"%@%@.png", [self avatarImage], mood];
	UIImage *image = [UIImage imageNamed:imageFile];
	return image;
}

-(void)setImageView:(UIImageView*)basicView forMood:(NSString*)mood isWaving:(BOOL)waving{
	//add face
	NSString *imageFile = [NSString stringWithFormat:@"%@%@.png", [self avatarImage], mood];
	UIImage *image = [UIImage imageNamed:imageFile];
	
	basicView.contentMode = UIViewContentModeScaleAspectFit;
	basicView.image = image;
	
	//remove any subviews
	for (UIView *view in basicView.subviews) {
		[view removeFromSuperview];
	}
		
	if (waving) {
		//add waving animation
		UIImageView * wavingView = [[UIImageView alloc] initWithFrame:
									CGRectMake(0, 0, basicView.frame.size.width, basicView.frame.size.height)];
		wavingView.contentMode = UIViewContentModeScaleAspectFit;
		wavingView.animationImages = [self wavingImageView];
		wavingView.animationDuration = 1.1;
		[wavingView startAnimating];
		[basicView insertSubview:wavingView atIndex:0];
		[self setArmRaised:[NSNumber numberWithInt:1]];

	} else {
		//just show still body
		NSString *bodyImageFile = [NSString stringWithFormat:@"%@%@.png", [self avatarImage], @"Body"];
		UIImage *bodyImage = [UIImage imageNamed:bodyImageFile];
		//UIImageView * bodyView = [[UIImageView alloc] initWithFrame:basicView.frame];
		UIImageView * bodyView = [[UIImageView alloc] initWithImage:bodyImage];
		bodyView.contentMode = UIViewContentModeScaleAspectFit;

		CGRect rect = bodyView.frame;
		rect.size.height = basicView.frame.size.height;
		rect.size.width = basicView.frame.size.width;
		rect.origin.x = 0;
		rect.origin.y = 0;
		bodyView.frame = rect;
		
		[basicView insertSubview:bodyView atIndex:0];
		[self setArmRaised:[NSNumber numberWithInt:0]];
	}

	//return basicView;
}

//CGAffineTransform rotate = CGAffineTransformMakeRotation(1.57079633);
//		 [myImageView setTransform:rotate];

-(UIImage *)frontViewForMood:(NSString*)mood {
	//moods: Happy, Confused, Aha, Unhappy
	NSString *imageFile = imageFile = [NSString stringWithFormat:@"%@%@.png", [self avatarImage], mood];
	UIImage *image = [UIImage imageNamed:imageFile];
	
	return image;
}

-(NSArray*)wavingImageView {
	NSArray * imageArray  = [[NSArray alloc] initWithObjects:
							 [UIImage imageNamed:[NSString stringWithFormat:@"%@Wave1.png", [self avatarImage]]],
							 [UIImage imageNamed:[NSString stringWithFormat:@"%@Wave2.png", [self avatarImage]]],
							 [UIImage imageNamed:[NSString stringWithFormat:@"%@Wave3.png", [self avatarImage]]],
							 [UIImage imageNamed:[NSString stringWithFormat:@"%@Wave2.png", [self avatarImage]]],
							 nil];
	return imageArray;
}

-(BOOL)hasQuestion {
	//adjusting the size of this number adjusts the frequency at which students raise their arms with questions.
	int i = arc4random() % 500;
	//NSLog(@"i:%d",i);
	if (i%417 == 0 && ![self.armRaised intValue]) {
		NSLog(@"@ has question", self.firstName);
		[self setArmRaised:[NSNumber numberWithInt:1]];
		return YES;
	} else {
		return NO;
	}
}

-(NSArray*)completedWorksheetsArray {
	
	NSArray *array = [[NSArray alloc] initWithArray:[self.worksheets allObjects]];
	NSSortDescriptor *descriptor =
    [[[NSSortDescriptor alloc] initWithKey:@"date"
								 ascending:YES] autorelease];
	
	NSArray *descriptors = [NSArray arrayWithObjects:descriptor, nil];
	NSArray *sortedArray = [array sortedArrayUsingDescriptors:descriptors];
	
	return sortedArray;
}

-(NSString*)overallGrade {
	CompletedWorksheet *cWorksheet;
	float points = 0;
	for (cWorksheet in [self completedWorksheetsArray]) {
		points += [[cWorksheet grade] floatValue];
	}
	points = points / [[self completedWorksheetsArray] count];
	
	int pointsAsInt = points * 3;
	
	NSLog(@"Grade Points: %d", pointsAsInt);
	NSString *myGrade;
	switch (pointsAsInt) {
		case 0:
			myGrade = [NSString stringWithFormat:@"D"];
			break;
		case 1:
			myGrade = [NSString stringWithFormat:@"C-"];
			break;
		case 2:
			myGrade = [NSString stringWithFormat:@"C"];
			break;
		case 3:
			myGrade = [NSString stringWithFormat:@"C+"];
			break;
		case 4:
			myGrade = [NSString stringWithFormat:@"B-"];
			break;
		case 5:
			myGrade = [NSString stringWithFormat:@"B"];
			break;
		case 6:
			myGrade = [NSString stringWithFormat:@"B+"];
			break;
		case 7:
			myGrade = [NSString stringWithFormat:@"A-"];
			break;
		case 8:
			myGrade = [NSString stringWithFormat:@"A"];
			break;
		case 9:
			myGrade = [NSString stringWithFormat:@"A+"];
			break;
		default:
			myGrade = [NSString stringWithFormat:@"--"];
			break;
	}
	return myGrade;
	
}

-(void)addPossibleReports {
	
	NSLog(@"checking for new behavior reports for %@", [self firstName]);
	if (self.lastCheckedReports == nil) {
		self.lastCheckedReports = [NSDate date];
	}
	float seconds = [self.lastCheckedReports timeIntervalSinceNow];
	float days = (-seconds) / 86400;
	NSLog(@"days: %f", days);
	
	//if its been at least a day since we last checked reports.
	if (days > 0) {
		//potentially add new behavior reports.  1 in 3 chance.
		int i = arc4random() % 3;
		if (i%1 == 0) {
			//yes add report
			NSLog(@"%@ add report", self.firstName);
			int x = arc4random() % 100;
			if (x < [self.politeness intValue]) {
				//get positive report
				NSArray *posReports = [Library fetchBehaviorReports:@"positive"];
				int y = arc4random() % [posReports count];
				BehaviorReport *report = [posReports objectAtIndex:y];
				NSLog(@"report: %@", report.text);
				[self addReportsObject:report];
			} else {
				//get negative report
				NSArray *negReports = [Library fetchBehaviorReports:@"negative"];
				int z = arc4random() % [negReports count];
				BehaviorReport *report = [negReports objectAtIndex:z];
				NSLog(@"report: %@", report.text);
				[self addReportsObject:report];
			}
		} else {
			NSLog(@"no report today");
		}

	} else {
		NSLog(@"not long enough since last check");
	}

	//update date last checked
	self.lastCheckedReports = [NSDate date];
}

-(void)adjustBehavior:(NSString*)posNeg {
	if ([posNeg isEqualToString:@"positive"]) {
		if ([self.politeness intValue] < 99) {
			int newScore = [self.politeness intValue] + 2;
			[self setPoliteness:[NSNumber numberWithInt:newScore]];
		}
	} else {
		if ([self.politeness intValue] > 1) {
			int newScore = [self.politeness intValue] - 2;
			[self setPoliteness:[NSNumber numberWithInt:newScore]];
		}
	}

}

@end
