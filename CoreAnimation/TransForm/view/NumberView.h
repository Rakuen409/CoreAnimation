//
//  NumberView.h
//  learnAni
//
//  Created by Star on 2018/8/8.
//  Copyright © 2018年 Star. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,viewType){
    viewTypeDefault,
    viewTypeButton
};
 
@interface NumberView : UIView
- (instancetype)initWithFrame:(CGRect)frame Number:(NSInteger)number Type:(viewType)type;
@end
