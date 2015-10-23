//
//  JuneBlueView.m
//  MasonryHighLevelAdaptiveExample
//
//  Created by n on 15/10/23.
//  Copyright © 2015年 summerwu. All rights reserved.
//

#import "JuneBlueView.h"
#import "UIView+MasonryHighLevelAdaptive.h"
#import "Masonry.h"
@interface JuneBlueView ()
@property (weak, nonatomic) IBOutlet UITextField *leftTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *topSeg;
@property (weak, nonatomic) IBOutlet UISegmentedControl *centerSeg;
@property (weak, nonatomic) IBOutlet UISegmentedControl *bottomSeg;
@property (weak, nonatomic) IBOutlet UITextView *rightTextView;

@end


@implementation JuneBlueView

-(void)awakeFromNib{
    for (UIView *v in self.subviews) {
        v.translatesAutoresizingMaskIntoConstraints=NO;//important
    }
    [self segmentsVerticalAdaptive];
    [self segmentsHorizontalCenter];
    [self horizontalAdaptive];
    [self topAlign];
    [self textViewBottomAlign];
    [self textViewAddBorder];
}
-(void)segmentsVerticalAdaptive{
    UIView * topEdge=[self addEdgeViewAtEdge:UIRectEdgeTop];
    UIView * bottomEdge=[self addEdgeViewAtEdge:UIRectEdgeBottom];
    NSArray *stationViews=@[topEdge,_topSeg,_centerSeg,_bottomSeg,bottomEdge];
    [self addSpacerIn:stationViews forAxis:UILayoutConstraintAxisVertical];
}
-(void)segmentsHorizontalCenter{
    [_topSeg mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.equalTo(@[_centerSeg,_bottomSeg]);
        make.centerX.equalTo(self);
    }];
}

///spacer thickness==10
-(void)horizontalAdaptive{
    UIView * leftEdge=[self addEdgeViewAtEdge:UIRectEdgeLeft];
    UIView * rightEdge=[self addEdgeViewAtEdge:UIRectEdgeRight];
    NSArray *stationViews=@[leftEdge,_leftTextField,_centerSeg,_rightTextView,rightEdge];
    [self addSpacerIn:stationViews ForAxis:UILayoutConstraintAxisHorizontal thickNess:10];
}

-(void)topAlign{
    [_topSeg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@[_leftTextField,_rightTextView]);
    }];
}
-(void)textViewBottomAlign{
    [_rightTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_bottomSeg);
    }];
}
-(void)textViewAddBorder{
    _rightTextView.layer.borderWidth=1;
}
@end
