//
//  JuneComplexVC.m
//  MasonryHighLevelAdaptiveExample
//
//  Created by n on 15/10/23.
//  Copyright © 2015年 summerwu. All rights reserved.
//

#import "JuneComplexVC.h"
#import "Masonry.h"
#import "UIView+MasonryHighLevelAdaptive.h"

@interface JuneComplexVC ()
@property (weak, nonatomic) IBOutlet UIView *redV;
@property (weak, nonatomic) IBOutlet UIView *greenV;
@property (weak, nonatomic) UIView *blueV;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *redSubviews;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *greenSubviews;

@end

@implementation JuneComplexVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadBlueView];

    //setup containers
    [self removePrototypingConstraints];
    [self rgbEqualWidthHeight];
    [self rgbHorizontalCenter];
    [self rgbVerticalAdaptive];
    
    //setup redSubviews
    [self redHorizontalAdaptive];
    
    //setup greenSubviews
    [self greenHorizontalAdaptive];
    [self greenVerticalCenter];
    [self greenSubviewsEqualWidth];
    [self greenSubviewsAddBorder];
    
    //setup blueSubviews
}

-(void)loadBlueView{
    _blueV=[[NSBundle mainBundle]loadNibNamed:@"H+VDemo" owner:nil options:nil][0];
    _blueV.translatesAutoresizingMaskIntoConstraints=NO;//important
    [self.view addSubview:_blueV];
}

///interface builder will add default constraints.These constraints are not wantted.Remove!
///!!important
-(void)removePrototypingConstraints{
    [self.view removePrototypingConstraints];//redV greenV have PrototypingConstraints
// don't need  [_redV removePrototypingConstraints]. redSubviews don't have PrototypingConstraints.Use XIB(disable autolayout) to avoid PrototypingConstraints.
    [_greenV removePrototypingConstraints];//remove 4 buttons all constraints
}

-(void)rgbEqualWidthHeight{
    [_redV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view).multipliedBy(0.8);
        make.width.equalTo(@[_greenV,_blueV]);
        make.height.equalTo(@[_greenV,_blueV]);
    }];
}
-(void)rgbHorizontalCenter{
    [_redV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerX.equalTo(@[_greenV,_blueV]);
    }];
}

//spacer's thickness is 20pt
-(void)rgbVerticalAdaptive{
    UIView * topEdge=[self.view addEdgeViewAtEdge:UIRectEdgeTop];
    UIView * bottomEdge=[self.view addEdgeViewAtEdge:UIRectEdgeBottom];
    NSArray *stationViews=@[topEdge,_redV,_greenV,_blueV,bottomEdge];
    [self.view addSpacerIn:stationViews ForAxis:UILayoutConstraintAxisVertical thickNess:20];
}
///redSubviews already have intrinsic size and Vertical constraints.They only lack horizontal constraints.
-(void)redHorizontalAdaptive{
    UIView * leftEdge=[_redV addEdgeViewAtEdge:UIRectEdgeLeft];
    UIView * rightEdge=[_redV addEdgeViewAtEdge:UIRectEdgeRight];
    NSMutableArray *stationViews=[NSMutableArray arrayWithArray:_redSubviews];
    [stationViews addObject:rightEdge];
    [stationViews insertObject:leftEdge atIndex:0];
    [_redV addSpacerIn:stationViews forAxis:UILayoutConstraintAxisHorizontal];
}

-(void)greenVerticalCenter{
    for (UIView *button in _greenSubviews) {
        [button mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerY.equalTo(_greenV);
        }];
    }
}

///spacer's thickness == 10
-(void)greenHorizontalAdaptive{
    UIView * leftEdge=[_redV addEdgeViewAtEdge:UIRectEdgeLeft];
    UIView * rightEdge=[_redV addEdgeViewAtEdge:UIRectEdgeRight];
    NSMutableArray *stationViews=[NSMutableArray arrayWithArray:_greenSubviews];
    [stationViews addObject:rightEdge];
    [stationViews insertObject:leftEdge atIndex:0];
    [_greenV addSpacerIn:stationViews ForAxis:UILayoutConstraintAxisHorizontal thickNess:10];
}
-(void)greenSubviewsAddBorder{
    for (UIButton* b in _greenSubviews) {
        b.layer.borderWidth=1;
    }
}
-(void)greenSubviewsEqualWidth{
    UIButton* leftestButton=_greenSubviews[0];
    NSArray * restButtons=@[_greenSubviews[1],_greenSubviews[2],_greenSubviews[3]];
    [leftestButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(restButtons);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
