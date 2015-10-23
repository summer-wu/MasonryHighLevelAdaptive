//
//  JuneAdaptiveVC.m
//  MasonryHighLevelAdaptiveExample
//
//  Created by n on 15/10/23.
//  Copyright © 2015年 summerwu. All rights reserved.
//

#import "JuneAdaptiveVC.h"
#import "Masonry.h"
#import "UIView+MasonryHighLevelAdaptive.h"


typedef NS_ENUM(NSUInteger, RowTitle) {
    RowTitleVertical,
    RowTitleVerticalWithColor,
    RowTitleHorizontal,
    RowTitleHorizontalWithColor,
};


@interface JuneAdaptiveVC(){
    RowTitle _cellRow;
    UIImageView * _iv30x10;
    UIImageView * _iv100x10;
    UIImageView * _iv200x10;
}
@end

@implementation JuneAdaptiveVC
-(instancetype)initWithIndexPath:(NSIndexPath *)indexPath{
    self = [super init];
    if (self) {
        _cellRow=indexPath.row;
    }
    return self;
}
-(void)viewDidLoad{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self add3ImageViews];

    switch (_cellRow) {
        case RowTitleVertical:
            [self leftAlign40pt];
            [self addVerticalAdaptiveConstraints];
            break;
            
        case RowTitleVerticalWithColor:
            [self leftAlign40pt];
            [self addVerticalAdaptiveConstraintsWithColor];
            break;
            
        case RowTitleHorizontal:
            [self topAlign20pt];
            [self addHorizontalAdaptiveConstraints];
            break;
            
        case RowTitleHorizontalWithColor:
            [self topAlign20pt];
            [self addHorizontalAdaptiveConstraintsWithColor];
            break;
            
        default:
            break;
    }
    
}

-(void)add3ImageViews{
    _iv30x10=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"30x10"]];
    _iv100x10=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"100x10"]];
    _iv200x10=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"200x10"]];
    NSArray *a=@[_iv30x10,_iv100x10,_iv200x10];
    for (UIImageView * iv in a) {
        [self.view addSubview:iv];
        iv.translatesAutoresizingMaskIntoConstraints=NO;//!important
    }
}

-(void)addVerticalAdaptiveConstraints{
    UIView * topV=[self.view addEdgeViewAtEdge:UIRectEdgeTop];
    UIView * bottomV=[self.view addEdgeViewAtEdge:UIRectEdgeBottom];
    NSArray * stationViews=@[topV,_iv30x10,_iv100x10,_iv200x10,bottomV];
    [self.view addSpacerIn:stationViews forAxis:UILayoutConstraintAxisVertical];
}
-(void)addVerticalAdaptiveConstraintsWithColor{
    UIView * topV=[self.view addEdgeViewAtEdge:UIRectEdgeTop];
    UIView * bottomV=[self.view addEdgeViewAtEdge:UIRectEdgeBottom];
    NSArray * stationViews=@[topV,_iv30x10,_iv100x10,_iv200x10,bottomV];
    [self.view addSpacerIn:stationViews ForAxis:UILayoutConstraintAxisVertical thickNess:0 hidden:NO color:[UIColor redColor]];
}
-(void)addHorizontalAdaptiveConstraints{
    UIView * leftV=[self.view addEdgeViewAtEdge:UIRectEdgeLeft];
    UIView * rightV=[self.view addEdgeViewAtEdge:UIRectEdgeRight];
    NSArray * stationViews=@[leftV,_iv30x10,_iv100x10,_iv200x10,rightV];
    [self.view addSpacerIn:stationViews forAxis:UILayoutConstraintAxisHorizontal];
}
-(void)addHorizontalAdaptiveConstraintsWithColor{
    UIView * leftV=[self.view addEdgeViewAtEdge:UIRectEdgeLeft];
    UIView * rightV=[self.view addEdgeViewAtEdge:UIRectEdgeRight];
    NSArray * stationViews=@[leftV,_iv30x10,_iv100x10,_iv200x10,rightV];
    [self.view addSpacerIn:stationViews ForAxis:UILayoutConstraintAxisHorizontal thickNess:0 hidden:NO color:[UIColor redColor]];
}
-(void)leftAlign40pt{
    [_iv30x10 mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(@40);
        make.left.equalTo(_iv100x10);
        make.left.equalTo(_iv200x10);
    }];
}
-(void)topAlign20pt{
    [_iv30x10 mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(@20);
        make.top.equalTo(_iv100x10);
        make.top.equalTo(_iv200x10);
    }];
}

@end
