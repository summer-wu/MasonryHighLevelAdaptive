
//  Created by summerwu on 15/2/10.
//  Copyright (c) 2015年 summerwu. All rights reserved.
//

#import "UIView+MasonryHighLevelAdaptive.h"
#import "Masonry.h"
#define kJuneScreenWidth [UIScreen mainScreen].bounds.size.width
#define kTagCustomBadgeView 61500


@implementation JuneEdgeView
@end
@implementation JuneSpacerView
@end

@implementation UIView (MasonryHighLevelAdaptive)


-(void)removeConstraintWhichRelationIs:(NSLayoutRelation)relation{
    NSArray * a=[self constraints];
    for (NSLayoutConstraint * c in a) {
        if (c.relation == relation ) {
            [self removeConstraint:c];
        }else{
            continue;
        }
    }
}
-(void)removeConstraintWhichAttributeIs:(NSLayoutAttribute)attribute{
    NSArray * a=[self constraints];
    for (NSLayoutConstraint * c in a) {
        if (c.firstAttribute==attribute || c.secondAttribute==attribute) {
            [self removeConstraint:c];
        }else{
            continue;
        }
    }
}
-(void)removeConstraintsWhichItemEqualTo:(id)item{
    if([item isKindOfClass:[NSArray class]]){
        NSArray *a=(NSArray*)item;
        [a enumerateObjectsUsingBlock:^(UIView *v, NSUInteger idx, BOOL *stop) {
            NSAssert([v isKindOfClass:[UIView class]], @"数组中每个元素都应该是UIView");
            [self removeConstraintsWhichItemEqualToAView:item];
        }];
    }else{
        [self removeConstraintsWhichItemEqualToAView:item];
    }
}
-(void)removeConstraintsWhichItemEqualToAView:(id)aview{
    NSArray * a=[self constraints];
    for (NSLayoutConstraint * c in a) {
        if ([c.firstItem isEqual:aview] || [c.secondItem isEqual:aview]) {
            [self removeConstraint:c];
        }else{
            continue;
        }
    }
}
//移除这样的约束 <NSIBPrototypingLayoutConstraint:0x7facdbd5ddb0 UIView:0x7facdbd52610.height == 60>
-(void)removePrototypingConstraints{
    NSArray *a=self.constraints;
    for (NSLayoutConstraint *c in a) {
        if([NSStringFromClass(c.class) isEqualToString:@"NSIBPrototypingLayoutConstraint"]){
            [self removeConstraint:c];
        }
    }
}
- (void)exerciseAmbiguityInLayoutRepeatedly:(BOOL)recursive{
#ifdef DEBUG
    if (self.hasAmbiguousLayout) {
        [NSTimer scheduledTimerWithTimeInterval:0.5
                                         target:self
                                       selector:@selector(debugExerciseAmbiguityInLayout)
                                       userInfo:nil
                                        repeats:YES];
    }
    if (recursive) {
        for (UIView *subview in self.subviews) {
            if ([subview hasAmbiguousLayout]) {
                [subview exerciseAmbiguityInLayoutRepeatedly:YES];
            }
        }
    }
#endif
}

/// 一次只能在一个方向添加edgeView
-(JuneEdgeView *)addEdgeViewAtEdge:(UIRectEdge)edge{
    __weak __typeof(self) weakSelf=self;
//创建edgeView
    JuneEdgeView * edgeView=[JuneEdgeView new];
    edgeView.translatesAutoresizingMaskIntoConstraints = NO;
    edgeView.hidden = YES;
    [self addSubview:edgeView];
    
    NSUInteger thickNess=0;
#ifdef DEBUG
    edgeView.hidden=NO;
    edgeView.backgroundColor=[UIColor blueColor];
    thickNess=10;
#endif
    
    switch (edge) {
        case UIRectEdgeTop :{
            [edgeView mas_makeConstraints:^(MASConstraintMaker *make){
                make.left.top.right.equalTo(weakSelf);
                make.height.equalTo(@(thickNess));
            }];
            break;
        }
        case UIRectEdgeLeft:{
            [edgeView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.bottom.equalTo(weakSelf);
                make.width.equalTo(@(thickNess));
            }];
            break;
        }
        case UIRectEdgeBottom:{
            [edgeView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.bottom.right.equalTo(weakSelf);
                make.height.equalTo(@(thickNess));
            }];
            break;
        }
        case UIRectEdgeRight:{
            [edgeView mas_makeConstraints:^(MASConstraintMaker *make){
                make.top.right.bottom.equalTo(weakSelf);
                make.width.equalTo(@(thickNess));
            }];
            break;
        }
        default:{
            [edgeView removeFromSuperview];
            edgeView = nil;
            break;
        }
    }
    return edgeView;
}
-(void)addSpacerIn:(NSArray *)viewsOrGuideArray ForAxis:(UILayoutConstraintAxis)axis thickNess:(NSUInteger)thickNess hidden:(BOOL)hiddenArg color:(UIColor *)backgroundcolorArg{
    BOOL isVertical=(UILayoutConstraintAxisVertical==axis);
    NSAssert(viewsOrGuideArray.count>=3, @"viewsOrGuideArray.cout>=3");
    NSUInteger viewOrGuideCount=viewsOrGuideArray.count;
    //a.cout为3，spacer为2个。count为4，spacer为3个。
    NSMutableArray * ma =[NSMutableArray array];
    //addsubview spacer
    for (NSInteger i=0; i<viewOrGuideCount-1; i++) {
        JuneSpacerView * spacer=[JuneSpacerView new];
        spacer.translatesAutoresizingMaskIntoConstraints = NO;
        spacer.hidden = hiddenArg;
        if(backgroundcolorArg!=nil){
            spacer.backgroundColor=backgroundcolorArg;
        }
        //        #ifdef DEBUG
        //                spacer.hidden=NO;
        //                spacer.backgroundColor=[UIColor purpleColor];
        ////                thickNess=100;
        //        #endif
        
        [ma addObject:spacer];
        [self addSubview:spacer];
        
        //vertical方向的话，width为0、水平方向靠近superview左边
        //        NSLayoutConstraint * lc = [NSLayoutConstraint constraintWithItem:spacer attribute:isVertical?NSLayoutAttributeWidth:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:thickNess];
        //        [spacer addConstraint:lc];
        //        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:isVertical?@"H:|-[spacer(>=thickNess)]-|":@"V:|-[spacer(>=thickNess)]-|" options:0 metrics:@{@"thickNess":@(thickNess)} views:NSDictionaryOfVariableBindings(spacer)]];
        [spacer mas_makeConstraints:^(MASConstraintMaker *make){
            if (isVertical) {
                make.left.right.equalTo(self);
                if(thickNess>0) make.height.equalTo(@(thickNess)); //thickNess为0，高度是自动调整的
            }else{
                make.top.bottom.equalTo(self);
                if(thickNess>0) make.width.equalTo(@(thickNess)); //thickNess为0，宽度自动调整
            }
        }];
        
        //[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:isVertical?@"H:|[spacer(>=thickNess)]":@"V:|[spacer(>=thickNess)]" options:0 metrics:@{@"thickNess":@(thickNess)} views:NSDictionaryOfVariableBindings(spacer)]];
        
    }
    UIView * firstSpacer=ma[0];
    
    //给第一个spacer加约束，因为第一个spacer不设置高度值（如果是vertical）
    [ma[0] mas_makeConstraints:^(MASConstraintMaker *make) {
        //左上角的约束可能是UIView可能是UILayoutSupport。正确地说，只有可能上面是UILayoutSupport
        id topOrLeftConstraint;
        if ([viewsOrGuideArray[0] isKindOfClass:[UIView class]]) {
            UIView *leftOrTopView=viewsOrGuideArray[0];
            topOrLeftConstraint = isVertical?leftOrTopView.mas_bottom
            :leftOrTopView.mas_right;
        }else{
            topOrLeftConstraint = (id<UILayoutSupport>)viewsOrGuideArray[0];
        }
        isVertical?make.top.equalTo(topOrLeftConstraint)//只有vertical可能是UILayoutSupport
        :make.left.equalTo(topOrLeftConstraint);
        
        //viewsOrGuideArray中第一个元素（0index）肯定UIView，所以top
        UIView * rightOrBottomView=(UIView *)viewsOrGuideArray[1];
        isVertical?make.bottom.equalTo(rightOrBottomView.mas_top)
        :make.right.equalTo(rightOrBottomView.mas_left);
        
    }];
    
    //给每个spacer加约束
    for (NSInteger spacerToProcessIndex =1; spacerToProcessIndex < viewOrGuideCount-1; spacerToProcessIndex++) {
        [ma[spacerToProcessIndex] mas_makeConstraints:^(MASConstraintMaker *make) {
            //第一个item只可能是UIView
            UIView *leftOrTopView=viewsOrGuideArray[spacerToProcessIndex];
            isVertical?make.top.equalTo(leftOrTopView.mas_bottom)
            :make.left.equalTo(leftOrTopView.mas_right);
            //第二个可能是UILayoutGuide
            id rightOrBottomConstraint;
            if ([viewsOrGuideArray[spacerToProcessIndex+1] isKindOfClass:[UIView class]]) {
                UIView *rightOrBottomView=viewsOrGuideArray[spacerToProcessIndex+1];
                rightOrBottomConstraint = isVertical?rightOrBottomView.mas_top
                :rightOrBottomView.mas_left;
            }else{
                rightOrBottomConstraint = (id<UILayoutSupport>)viewsOrGuideArray[spacerToProcessIndex+1];
            }
            isVertical?make.bottom.equalTo(rightOrBottomConstraint)
            :make.right.equalTo(rightOrBottomConstraint);
            isVertical?make.height.equalTo(firstSpacer)
            :make.width.equalTo(firstSpacer);
        }];
    }

}

-(void)addSpacerIn:(NSArray *)viewsOrGuideArray ForAxis:(UILayoutConstraintAxis)axis thickNess:(NSUInteger)thickNess{
    [self addSpacerIn:viewsOrGuideArray ForAxis:axis thickNess:thickNess hidden:YES color:nil];
}

-(void)addSpacerIn:(NSArray *)viewsOrGuideArray forAxis:(UILayoutConstraintAxis)axis{
    return [self addSpacerIn:viewsOrGuideArray ForAxis:axis thickNess:0];
}
@end