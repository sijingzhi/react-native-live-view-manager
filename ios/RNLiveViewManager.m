

#import "RNLiveViewManager.h"
#import <React/RCTBridgeModule.h>
#import <React/RCTViewManager.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "LiveView.h"

@implementation RNLiveViewManager

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

//将模块暴露给react端
RCT_EXPORT_MODULE()

//设置属性 从RN过来入的参数title
RCT_EXPORT_VIEW_PROPERTY(title, NSString)

//设置属性 从RN过来入的参数totalColumns
RCT_EXPORT_VIEW_PROPERTY(totalColumns, NSNumber)

//设置属性 从RN过来入的参数
RCT_EXPORT_VIEW_PROPERTY(dataMap, NSDictionary)

//设置回调方法  原生回调操作RN
RCT_EXPORT_VIEW_PROPERTY(onBackBlock, RCTBubblingEventBlock)

//
//

-(UIView*)view{
  return [[LiveView alloc] initWithFrame:CGRectZero];
}

@end
  
