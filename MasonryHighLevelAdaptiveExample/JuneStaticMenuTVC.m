//
//  JuneStaticMenuTVC.m
//  MasonryHighLevelAdaptiveExample
//
//  Created by n on 15/10/23.
//  Copyright © 2015年 summerwu. All rights reserved.
//

#import "JuneStaticMenuTVC.h"
#import "JuneAdaptiveVC.h"

@interface JuneStaticMenuTVC(){
    NSMutableDictionary *_md;
}
@end
@implementation JuneStaticMenuTVC


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0==indexPath.section) {
        JuneAdaptiveVC *vc=[[JuneAdaptiveVC alloc]initWithIndexPath:indexPath];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
