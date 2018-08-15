//
//  NumberView.m
//  learnAni
//
//  Created by Star on 2018/8/8.
//  Copyright © 2018年 Star. All rights reserved.
//

#import "NumberView.h"
@interface NumberView()
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UIButton *tapButton;
@end
@implementation NumberView
- (instancetype)initWithFrame:(CGRect)frame Number:(NSInteger)number Type:(viewType)type{
    if (self = [super initWithFrame:frame]) {
        if (type == viewTypeDefault) {
            self.numberLabel.text = [NSString stringWithFormat:@"%ld",number];
            [self addSubview:self.numberLabel];
            self.userInteractionEnabled = NO;
        }
        if (type == viewTypeButton) {
            [self.tapButton setTitle:[NSString stringWithFormat:@"%ld",number] forState:UIControlStateNormal];
            [self addSubview:self.tapButton];
        }
    }
    return self;
}
- (void)tapButtonMethod{
    self.backgroundColor = [UIColor redColor];
}
- (UILabel *)numberLabel{
    if (!_numberLabel) {
        _numberLabel = [UILabel new];
        _numberLabel.font = [UIFont systemFontOfSize:40 weight:10];
        _numberLabel.textColor = [UIColor redColor];
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        _numberLabel.frame = CGRectMake(0, 0, 100, 100);
        _numberLabel.center = self.center;
        
    }
    return _numberLabel;
}

-(UIButton *)tapButton{
    if (!_tapButton) {
        _tapButton = [[UIButton alloc]init];
        _tapButton.titleLabel.font = [UIFont systemFontOfSize:40 weight:10];
        _tapButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_tapButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _tapButton.frame = CGRectMake(0, 0, 100, 100);
        _tapButton.center = self.center;
        [_tapButton addTarget:self action:@selector(tapButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    }
    return _tapButton;
}
- (NSString *)debugDescription{
    
    NSString *result = [super debugDescription];
    return [NSString stringWithFormat:@"%@\n%@\n%@",result,self.layer.sublayers,NSStringFromCGRect(self.layer.sublayers[1].frame) ];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
