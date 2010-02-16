//
//  StudentPlus.m
//  MySchool
//
//  Created by Ashley Kayler on 2/5/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import "StudentPlus.h"


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
			isGirl = NO;
			[student setGender:@"Girl"];
		} else {
			boyNum++;
			[student setAvatarImage:[NSString stringWithFormat:@"Boy%d", boyNum]];
			[student setFirstName:[boysNames objectAtIndex:m]];
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

@end
