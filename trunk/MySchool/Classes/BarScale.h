//
//  BarScale.h
//  MySchool
//
//  Created by Ashley Kayler on 5/2/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Student;

@interface BarScale : UIView {
	UILabel *titleLabel;
	UILabel *scoreLabel;
	UIImageView *bar;
	Student *student;
	NSString *type;
}

@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *scoreLabel;
@property (nonatomic, retain) UIImageView *bar;
@property (nonatomic, retain) Student *student;
@property (nonatomic, retain) NSString *type;

-(void) animateBarBy:(int)amount;
-(id)initWithData:(NSString*)labelType student:(Student*)student;

@end
