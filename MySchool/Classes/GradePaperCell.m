//
//  GradePaperCell.m
//  MySchool
//
//  Created by Connor Riley on 2/3/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MySchoolAppDelegate.h"
#import "GradePaperCell.h"
#import "WorksheetAnswer.h"
#import "GradePaper.h"

@implementation GradePaperCell

@synthesize correctButton;
@synthesize wrongButton;
@synthesize lblQuestion;
@synthesize lblAnswer;
@synthesize delegate;

- (void)dealloc {
	NSLog(@"grade paper cell dealloc");
	//[correctButton release];
	//[wrongButton release];
	[lblAnswer release];
	[lblQuestion release];
    [super dealloc];
}

-(void)correctButtonSelected:(UIButton*)sender {
	//go to classroom
	//MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	int row = sender.tag;
	self.wrongButton.alpha = .1;
	self.correctButton.alpha = 1;
	[delegate gradedQuestion:[NSNumber numberWithInt:row] value:[NSNumber numberWithInt:1]];
	
}
-(void)wrongButtonSelected:(UIButton*)sender {
	//go to learn interaction
	int row = sender.tag;
	//MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	//NSIndexPath *indexPath = [(UITableView*)self.superview indexPathForCell:(UITableViewCell *)[sender superview]];
	//WorksheetAnswer *answer = [[(UITableView*)self.superview answers] objectAtIndex:[sender tag]];
	//do something here if this is actually the right answer
	self.wrongButton.alpha = 1;
	self.correctButton.alpha = .1;
	//UITableView *tableView = (UITableView*)self.superview;
	//GradePaper *gradePaper = [tableView super];
	[delegate gradedQuestion:[NSNumber numberWithInt:row] value:[NSNumber numberWithInt:0]];
	
}

-(void)setQuestion:(NSString*)qText andAnswer:(NSString*)aText qHeight:(NSNumber*)qHeight aHeight:(NSNumber*)aHeight {
	
	// Initialization code 
	lblQuestion = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, [qHeight floatValue])];
	lblQuestion.text = qText;
	lblQuestion.textColor = [UIColor blackColor];
	lblQuestion.lineBreakMode = UILineBreakModeWordWrap;
	lblQuestion.numberOfLines = 0;
	lblQuestion.font = [UIFont systemFontOfSize:16.0];
	lblQuestion.backgroundColor = [UIColor clearColor];
	//CGRect frame = CGRectMake(10, 10, 200, lblQuestion.frame.size.height);
	//lblQuestion.frame = frame;	
	[self.contentView addSubview:lblQuestion];
	
	float yValue = 10 + lblQuestion.frame.size.height + 10;
	
	lblAnswer = [[UILabel alloc] initWithFrame:CGRectMake(10, yValue, 200, [aHeight floatValue])];
	lblAnswer.text = aText;
	lblAnswer.textColor = [UIColor grayColor];
	lblAnswer.lineBreakMode = UILineBreakModeWordWrap;
	lblAnswer.numberOfLines = 0;
	lblAnswer.font = [UIFont fontWithName:@"Marker Felt" size:18.0];
	//MarkerFelt-Thin
	lblAnswer.backgroundColor = [UIColor clearColor];
	[self.contentView addSubview:lblAnswer];
	
	correctButton.frame = CGRectMake(260, lblAnswer.frame.origin.y-10, 40.0, 40.0);
	//correctButton.tag = [[(UITableView*)self.superview indexPathForCell:self] row];
	wrongButton.frame = CGRectMake(210, lblAnswer.frame.origin.y-10, 40.0, 40.0);  
	//wrongButton.tag = [[(UITableView*)self.superview indexPathForCell:self] row];

}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	//MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		UIImage *correctImage = [UIImage imageNamed:@"checkmark.png"];
		UIImage *wrongImage = [UIImage imageNamed:@"xmark.png"];
		
		correctButton = [UIButton buttonWithType: UIButtonTypeCustom]; 
		//correctButton.backgroundImage.co
		[correctButton setBackgroundImage:correctImage forState:UIControlStateNormal];
		correctButton.contentMode = UIViewContentModeScaleAspectFit;
		[self.contentView addSubview:correctButton];
		[correctButton addTarget:self action:@selector(correctButtonSelected:) forControlEvents:UIControlEventTouchUpInside];  
		
		wrongButton = [UIButton buttonWithType: UIButtonTypeCustom]; 
		[wrongButton setBackgroundImage:wrongImage forState:UIControlStateNormal];
		wrongButton.contentMode = UIViewContentModeScaleAspectFit;
		[self.contentView addSubview:wrongButton];
		[wrongButton addTarget:self action:@selector(wrongButtonSelected:) forControlEvents:UIControlEventTouchUpInside];  
		
		[self.contentView setBackgroundColor:[UIColor whiteColor]];
				
	}
	return self;
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	
}

/*
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	//selected the cell. Default to learning not teaching
	//MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	
}
*/
/*
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
*/


@end
