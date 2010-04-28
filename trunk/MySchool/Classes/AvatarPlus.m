//
//  AvatarPlus.m
//  MySchool
//
//  Created by Ashley Kayler on 4/27/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import "AvatarPlus.h"
#import "Avatar.h"
#import "User.h"

@implementation Avatar (AvatarPlus)

-(UIView*)customAvatar {
	BOOL isMale = NO;
	if ([self.user.gender isEqualToString:@"male"]) {
		isMale = YES;
	}
	UIImage *skinImage;
	UIImage *hairImage;
	UIImage *eyesImage;
	UIImage *clothesImage;
	UIImage *glassesImage;
	
	//skin
	if (!self.skin) {
		
		if (isMale) {
			NSLog(@"adding male dark skin");
			skinImage = [UIImage imageNamed:@"MSkinDark.png"];
		} else {
			skinImage = [UIImage imageNamed:@"FSkinMed.png"];
		}
	} else {
		skinImage = [UIImage imageNamed:self.skin];
	}
	
	//hair
	if (!self.hair) {
		if (isMale) {
			hairImage = [UIImage imageNamed:@"MHairBrown.png"];
		} else {
			hairImage = [UIImage imageNamed:@"FHairRed.png"];
		}
	} else {
		hairImage = [UIImage imageNamed:self.hair];
	}
	
	//clothes
	if (!self.clothes) {
		if (isMale) {
			eyesImage = [UIImage imageNamed:@"MClothes1.png"];
		} else {
			eyesImage = [UIImage imageNamed:@"FClothes1.png"];
		}
	} else {
		eyesImage = [UIImage imageNamed:self.clothes];
	}
	
	//eyes
	if (!self.eyes) {
		if (isMale) {
			clothesImage = [UIImage imageNamed:@"MEyesBrown.png"];
		} else {
			clothesImage = [UIImage imageNamed:@"FEyesBlue.png"];
		}
	} else {
		clothesImage = [UIImage imageNamed:self.eyes];
	}
	
	//glasses
	if (isMale) {
		glassesImage = [UIImage imageNamed:@"MGlasses.png"];
	} else {
		glassesImage = [UIImage imageNamed:@"FGlasses.png"];
	}
	
	//create the container view
	UIView* myView = [[[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 193, 346)] autorelease];
	//myView.backgroundColor = [UIColor redColor];

	//UIView * myView = [[UIView alloc] autorelease];
	//myView.frame = CGRectMake(0, 0, 193, 346);
	
	//create the image views for the various pieces
	UIImageView * mySkinView = [[UIImageView alloc] initWithImage:skinImage];
	mySkinView.frame = CGRectMake(0, 0, 193, 346);
	UIImageView * myHairImage = [[UIImageView alloc] initWithImage:hairImage];
	myHairImage.frame = CGRectMake(0, 0, 193, 346);
	UIImageView * myEyesImage = [[UIImageView alloc] initWithImage:eyesImage];
	myEyesImage.frame = CGRectMake(0, 0, 193, 346);
	UIImageView * myClothesImage = [[UIImageView alloc] initWithImage:clothesImage];
	myClothesImage.frame = CGRectMake(0, 0, 193, 346);
	UIImageView * myGlassesImage = [[UIImageView alloc] initWithImage:glassesImage];
	myGlassesImage.frame = CGRectMake(0, 0, 193, 346);

	[myView addSubview:mySkinView];
	[myView addSubview:myClothesImage];
	[myView addSubview:myEyesImage];
	[myView addSubview:myHairImage];
	if ([self.glasses intValue] == 1) {
		[myView addSubview:myGlassesImage];
	}
	
	[mySkinView release];
	[myHairImage release];
	[myEyesImage release];
	[myClothesImage release];
	[myGlassesImage release];
	
	return myView;
	
}

-(void)setGenericMan {
	[self setEyes:@"MEyesBlue.png"];
	[self setHair:@"MHairBrown.png"];
	[self setClothes:@"MClothes1.png"];
	[self setGlasses:nil];
	[self setSkin:@"MSkinPale.png"];
}
-(void)setGenericWoman {
	[self setEyes:@"FEyesGreen.png"];
	[self setHair:@"FHairRed.png"];
	[self setClothes:@"FClothes1.png"];
	[self setGlasses:nil];
	[self setSkin:@"FSkinPale.png"];
}
@end
