//
//  BarAlertController.h
//  TestDraft
//
//  Created by Casinolinkpa on 11/2/18.
//  Copyright © 2018 Casinolinkpa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BarAlertController : UIAlertController
-(id)init;
-(void)updateProgress:(float)value;
@end

NS_ASSUME_NONNULL_END
