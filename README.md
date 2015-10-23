#MasonryHighLevelAdaptive
masonry可以非常快速简便地添加约束。

但是有一些常见的**相等间距**用masonry中要写很多代码。

UIView+MasonryHighLevelAdaptive是我在日常开发中用到的category，可以方便地实现**相等间距**。

#示例
<img src="https://cloud.githubusercontent.com/assets/2476434/10684568/5bcce420-7981-11e5-9b63-9bfbe23e2b55.png" alt="horizon" width=200px height=300px />
<img src="https://cloud.githubusercontent.com/assets/2476434/10684657/74b0c316-7982-11e5-9a27-b6989a2eaba9.jpg" alt="vertical" width=200px height=300px  />
<img src="https://cloud.githubusercontent.com/assets/2476434/10694641/e4a99a22-79d1-11e5-9063-f8a0219ba73b.png" alt="portrait" width=200px height=300px  />
<img src="https://cloud.githubusercontent.com/assets/2476434/10694642/e503a0e4-79d1-11e5-9818-6c635d57af5e.png" alt="land" width=333px height=187px  />


#下载
`git clone https://github.com/summer-wu/MasonryHighLevelAdaptive.git`

#使用

把UIView+MasonryHighLevelAdaptive.h{.m} 拖进工程。

```
-(void)viewDidLoad{
    [super viewDidLoad];
    [self add3ImageViews];
    [self leftAlign40pt];
    [self addVerticalAdaptiveConstraints];   
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
-(void)leftAlign40pt{
    [_iv30x10 mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(@40);
        make.left.equalTo(_iv100x10);
        make.left.equalTo(_iv200x10);
    }];
}
-(void)addVerticalAdaptiveConstraints{
    UIView * topV=[self.view addEdgeViewAtEdge:UIRectEdgeTop];
    UIView * bottomV=[self.view addEdgeViewAtEdge:UIRectEdgeBottom];
    NSArray * stationViews=@[topV,_iv30x10,_iv100x10,_iv200x10,bottomV];
    [self.view addSpacerIn:stationViews forAxis:UILayoutConstraintAxisVertical];
}
```

欢迎fork和issue
