

//  Created by summerwu on 15/2/10.
//  Copyright (c) 2015年 summerwu. All rights reserved.


#import <UIKit/UIKit.h>

#define kJuneDefaultBackColor [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1]
#define kJuneDefaultLineColor [UIColor colorWithRed:0xe6/255. green:0xe6/255. blue:0xe6/255. alpha:1]

/// a new class name will be more easily to distinct when debugging
@interface JuneEdgeView:UIView
@end
/// a new class name will be more easily to distinct when debugging
@interface JuneSpacerView:UIView
@end

@interface UIView (MasonryHighLevelAdaptive)

///移除约束，参数是relation
-(void)removeConstraintWhichAttributeIs:(NSLayoutAttribute)attribute;
///移除约束，参数是relation
-(void)removeConstraintWhichRelationIs:(NSLayoutRelation)relation;
///移除约束，参数是关联的view，或一个array
-(void)removeConstraintsWhichItemEqualTo:(id)item;
//移除这样的约束 <NSIBPrototypingLayoutConstraint:0x7facdbd5ddb0 UIView:0x7facdbd52610.height == 60>
-(void)removePrototypingConstraints;
/// [self.view exerciseAmbiguityInLayoutRepeatedly:YES]
- (void)exerciseAmbiguityInLayoutRepeatedly:(BOOL)recursive;


/// add one edgeView
-(JuneEdgeView *)addEdgeViewAtEdge:(UIRectEdge)edge;

/**
 垂直方向可以用topLayoutGuide。
 [self.view addSpacerIn:@[self.topLayoutGuide,_distanceTotalLabel,_sportTimesView,_startContainerView,self.bottomLayoutGuide] ForAxis:UILayoutConstraintAxisVertical];
 [self.view addSpacerIn:@[_sportTimesView,_signalStrengthView,helperViewAboveStartContainerView] ForAxis:UILayoutConstraintAxisVertical]

 水平方向只能用leftHelperView。
 [self.view addSpacerIn:@[leftV,_label0,_label1,righV] ForAxis:UILayoutConstraintAxisHorizontal]
 本来想把这个方法写成不依赖masonry的。但是masonry太好用了，所以这个方法是masonry和系统方法都有。
 
 会调用 `-(void)addSpacerIn:(NSArray *)viewsOrGuideArray ForAxis:(UILayoutConstraintAxis)axis thickNess:(NSUInteger)thickNess`
 */
-(void)addSpacerIn:(NSArray *)viewsOrGuideArray forAxis:(UILayoutConstraintAxis)axis;

///0==thickNess，thickNess will not be set
-(void)addSpacerIn:(NSArray *)viewsOrGuideArray ForAxis:(UILayoutConstraintAxis)axis thickNess:(NSUInteger)thickNess;

-(void)addSpacerIn:(NSArray *)viewsOrGuideArray ForAxis:(UILayoutConstraintAxis)axis thickNess:(NSUInteger)thickNess hidden:(BOOL)hiddenArg color:(UIColor *)backgroundcolorArg;

@end
