//
//  PubbleLabelView.m
//  setbook
//
//  Created by Steve Wang on 2018/11/23.
//  Copyright © 2018 Steve Wang. All rights reserved.
//

#import "BubbleLabelView.h"

@interface BubbleLabelView () {
    NSMutableArray *myChildTextLabel;
    int myLineWidth;
    int myLineHeight;
}

@end

@implementation BubbleLabelView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id) init
{
    self = [super init];
    myLineWidth = 40;
    myLineHeight = 20;
    
    int MAX_LABEL = 10;
    for (int i = 0; i < MAX_LABEL; i++) {
        UILabel *curLable = [[UILabel alloc]initWithFrame:CGRectMake(0, i * myLineHeight, myLineWidth, myLineHeight)];
        curLable.text = @"test";
        
        /*UILabel *fromLabel = [[UILabel alloc]initWithFrame:CGRectMake(9, 9, 333, 22)];
        fromLabel.text = @"wewewewewewewewe";
        //fromLabel.font = customFont;
        fromLabel.numberOfLines = 1;
        fromLabel.baselineAdjustment = UIBaselineAdjustmentAlignBaselines; // or UIBaselineAdjustmentAlignCenters, or UIBaselineAdjustmentNone
        fromLabel.adjustsFontSizeToFitWidth = YES;
        fromLabel.adjustsLetterSpacingToFitWidth = YES;
        fromLabel.minimumScaleFactor = 10.0f/12.0f;
        fromLabel.clipsToBounds = YES;
        fromLabel.backgroundColor = [UIColor clearColor];
        fromLabel.textColor = [UIColor blackColor];
        fromLabel.textAlignment = NSTextAlignmentLeft;
        [self.mainScrollView addSubview:fromLabel];*/
        
        [self addSubview:curLable];
    }
    
    return self;
}

-(void) setFrame:(CGRect)frame {
    [super setFrame:frame];
    myLineWidth = frame.size.width;
    myLineHeight = frame.size.height;
}
@end
