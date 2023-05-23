//
//  LiveView.h
//  FuelgasApp
//
//  Created by 斯敬之 on 2023/5/20.
//

#import <UIKit/UIKit.h>
#import <React/RCTComponent.h>


NS_ASSUME_NONNULL_BEGIN

@interface LiveView : UIView

//rn组件传来的属性
@property (nonatomic, copy) NSString *title;
//rn组件传来的属性
@property (nonatomic, copy) NSNumber *totalColumns;
//rn组件传来的属性
@property (nonatomic, copy) NSDictionary *dataMap;
//回调方法
@property(nonatomic, copy) RCTBubblingEventBlock onBackBlock;


//全局
@property (nonatomic, copy) NSArray *dataList;
@property (nonatomic, copy) NSNumber *columns;

//底层滚动
@property (nonatomic, strong) UIScrollView *scrollView;

@end

NS_ASSUME_NONNULL_END
