//
//  EnglishMainControllerViewController.m
//  setbook
//
//  Created by Steve Wang on 2018/11/10.
//  Copyright © 2018 Steve Wang. All rights reserved.
//

#import "EnglishMainController.h"
#import "HttpHelper.h"
#import "BubbleLabelView.h"

@interface EnglishMainController () {
    HttpHelper *myHttpHelper;
}
@property (strong, nonatomic) IBOutlet UIButton *searchButton;
@property (strong, nonatomic) IBOutlet UILabel *resultTextLabel;
@property (strong, nonatomic) IBOutlet UITextField *searchInput;

@property (strong, nonatomic) IBOutlet UIScrollView *mainScrollView;

@end

@implementation EnglishMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self->myHttpHelper = [[HttpHelper alloc]init];
    
    [self.mainScrollView setBackgroundColor:UIColor.whiteColor];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    CGSize ff = CGSizeMake(screenWidth, screenHeight);
    [self.mainScrollView setContentSize:ff];
    
    [super beautyButton:_searchButton];
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    
    BubbleLabelView *pp = [[BubbleLabelView alloc]init];
    CGRect      curFrame;
    curFrame.size = CGSizeMake(300, 20);
    curFrame.origin = CGPointMake(9, 9);
    [pp setFrame:curFrame];
    [self.mainScrollView addSubview:pp];
    
    
    //CGSize labelSize = [text sizeWithFont:customFont constrainedToSize:CGSizeMake(380, 20) lineBreakMode:NSLineBreakByTruncatingTail];
    
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
    
    
}
- (IBAction)doSearchTouch:(id)sender {
    [self.searchInput endEditing:YES];
    if (self->_searchInput.text.length == 0)
        return;
    
    NSString *url = [NSString stringWithFormat:@"http://www.iciba.com/%@", self->_searchInput.text];
    NSString *response = [self->myHttpHelper getWWWResponse:url];
    NSRange start = [response rangeOfString:@"base-list switch_part"];
    if (start.location == NSNotFound)
    {
        return;
    }
    
    NSString *exp = [response substringFromIndex:start.location];
    NSRange end = [exp rangeOfString:@"ul"];
    if(end.location == NSNotFound)
    {
        return;
    }
    exp = [exp substringToIndex:end.location];
    NSLog(@"%@", exp);
    
    NSMutableString *showString = [[NSMutableString alloc] init];
    
    while (true) {
        start = [exp rangeOfString:@"span"];
        if (start.location == NSNotFound)
            break;
        
        exp = [exp substringFromIndex:start.location];
        start = [exp rangeOfString:@">"];
        exp = [exp substringFromIndex:start.location+1];
        
        end = [exp rangeOfString:@"</span"];
        if (end.location == NSNotFound)
            break;
        
        NSString *partShow = [exp substringToIndex:end.location];
        [showString appendString:@"\n"];
        [showString appendString:partShow];
        
        exp = [exp substringFromIndex:end.location+end.length];
    }
    self->_resultTextLabel.numberOfLines = 0;
   
    self->_resultTextLabel.text = showString;
     [self.resultTextLabel sizeToFit];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
