//
//  LiveView.m
//  FuelgasApp
//
//  Created by 斯敬之 on 2023/5/20.
//

#import "LiveView.h"

#import "IJKCommon.h"
#import "IJKMoviePlayerViewController.h"


@implementation LiveView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
   
    }
    return self;
}

-(void)backMethod:(UIButton*)btn{
  self.onBackBlock(@{@"key":@"good-天气真好"});
 
}
//重写属性 RN的部分属性赋值后会调用这个方法传递参数
-(void)setTitle:(NSString *)title{
  NSLog(@"RN传过来的title：%@",title);
  
}
//重写属性 RN的部分属性赋值后会调用这个方法传递参数
-(void)setTotalColumns:(NSNumber *)totalColumns{
  self.columns = totalColumns;
  NSLog(@"columns:%@",_columns);
  
  [self createUI];
  
  

}
//重写属性 RN的部分属性赋值后会调用这个方法传递参数
-(void)setDataMap:(NSDictionary *)dataMap{
  self.dataList = [dataMap objectForKey:@"data"];

}

-(void)createUI{
 
  int totalColumns = [self.columns intValue];
  int  W =  [UIScreen mainScreen].bounds.size.width/totalColumns-20;
  int  H = W;
  
  
  self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height)];
  [self addSubview:self.scrollView];
  //超出范围是否剪切
  self.scrollView.clipsToBounds = YES;
  //设置显示范围
  //注意：当滚动范围大于scrollView的宽高的时候才能够滚动。
  self.scrollView.contentSize = CGSizeMake(0, W*self.dataList.count/totalColumns+200);
  //YES:能滚动  NO:不能滚动
  self.scrollView.scrollEnabled = YES;
  //YES:能交互  NO:不能交互
  self.scrollView.userInteractionEnabled = YES;
  /*scrollView不可滚动的原因:1.没有设置scrollView的contentSize2.scrollEnabled  设置为NO3.userInteractionEnabled  设置为NO*/

  //是否显示垂直滚动条
  self.scrollView.showsVerticalScrollIndicator = YES;

  //设置内容的偏移量
  self.scrollView.contentOffset = CGPointMake(0, 0);
  

  

  CGFloat margin = ([UIScreen mainScreen].bounds.size.width - totalColumns*W)/(totalColumns + 1);
  [ self.dataList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    
    //自定义按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:[NSString stringWithFormat:@"%@", [self.dataList[idx] objectForKey:@"name"]] forState:UIControlStateNormal];
    button.tag = 1000+idx;
    long row = idx / totalColumns;
    int col = idx %totalColumns;
    button.backgroundColor = [UIColor redColor];
    CGFloat X = margin + col *(W + margin);
    CGFloat Y = 20 + row*(H + margin);
    button.frame = CGRectMake(X, Y, W, H);
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:button];

  }];
  
  
  
  
}

-(void)btnClick:(UIButton*)btn{
  
  //回传给rn
  self.onBackBlock(@{@"key":[NSString stringWithFormat:@"%ld",(long)btn.tag]});

  NSLog(@"%ld",(long)btn.tag);
  NSDictionary *dic = self.dataList[btn.tag-1000];
  NSString *type = [dic objectForKey:@"type"];
  NSString *urlStr = [dic objectForKey:@"url"];
  NSURL *url = [NSURL URLWithString:urlStr];
  
  self.onBackBlock(@{@"key":[NSString stringWithFormat:@"%@",urlStr]});
  
//  NSLog(@"选择类型：%@,选择视频/流地址：%@",type,urlStr);
//  UIViewController *vc = (UIViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//  vc.modalPresentationStyle = UIModalPresentationFullScreen;
//  if([type isEqualToString:@"video"])  {
//    [vc presentViewController:[[IJKVideoViewController alloc] initWithURL:url] animated:YES completion:^{}];
//    return;
//  }
//  if([type isEqualToString:@"stream"])  {
//    NSString *scheme = [[url scheme] lowercaseString];
//    if ([scheme isEqualToString :@"http"]
//        || [scheme isEqualToString:@"https"]
//        || [scheme isEqualToString:@"rtmp"]) {
//        [IJKVideoViewController presentFromViewController:vc withTitle:[NSString stringWithFormat:@"URL: %@", url] URL:url completion:^{
//        }];
//    }
//    return;
//
//  }
 
}
  






@end
