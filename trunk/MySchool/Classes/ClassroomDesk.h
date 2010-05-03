//
//  ClassroomDesk.h
//  MySchool
//
//  Created by Ashley Kayler on 4/21/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ClassroomDesk : baseViewController {
	IBOutlet UIView *teacherAtDesk;
	IBOutlet UIButton *book;
	BOOL transformed;
	BOOL clicked;

}
@property (nonatomic, retain) UIView *teacherAtDesk;
@property (nonatomic, retain) UIButton *book;
@property (nonatomic) BOOL transformed;
@property (nonatomic) BOOL clicked;

-(IBAction)moveOn;
-(IBAction)stopIt;

@end
