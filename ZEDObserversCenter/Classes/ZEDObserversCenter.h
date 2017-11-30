//
//  ZEDObserversCenter.h
//  ZEDObserversCenter
//
//  Created by 超李 on 2017/11/30.
//

#import <Foundation/Foundation.h>
#import <PLObservers/PLObservers.h>

///
// 这个类主要用于观察者与被观察者之间的解耦,将PLObservers的创建过程分割过来，提供了方便简易的宏用于项目中的使用
//
// 使用步骤:
//
// 1. 定义协议protocol
// @protocal IDemoNotify
//
// 2. 注册观察者,在需要的时间抛出协议中定义的方法,通知观察者
// ADD_OBSERVER(ptl, observer)
// REMOVE_OBSERVER(ptl, observer)
// NOTIFY_OBSERVERS(ptl, func)

// ADD_OBSERVER_WITH_KEY(ptl, key, observer)
// REMOVE_OBSERVER_WITH_KEY(ptl, key, observer)
// NOTIFY_OBSERVERS_WITH_KEY(ptl, key, func)
//
///

@interface ZEDObserversCenter : NSObject

+ (instancetype)defaultCenter;

- (PLObservers *)getObservers:(Protocol *)ptl;
- (PLObservers *)getObservers:(Protocol *)ptl forKey:(NSString *)key;

@end

#define ADD_OBSERVER(ptl, observer) {[[[ZEDObserversCenter defaultCenter] getObservers:@protocol(ptl)] addObserver:observer];}
#define REMOVE_OBSERVER(ptl, observer) {[[[ZEDObserversCenter defaultCenter] getObservers:@protocol(ptl)] removeObserver:observer];}
#define NOTIFY_OBSERVERS(ptl, func) do{if (![NSThread isMainThread]) {dispatch_sync(dispatch_get_main_queue(), ^{[(id<ptl>)[[ZEDObserversCenter defaultCenter] getObservers:@protocol(ptl)] func];});}else{[(id<ptl>)[[ZEDObserversCenter defaultCenter] getObservers:@protocol(ptl)] func];}}while(0);

#define ADD_OBSERVER_WITH_KEY(ptl, key, observer) {[[[ZEDObserversCenter defaultCenter] getObservers:@protocol(ptl) forKey:key] addObserver:observer];}
#define REMOVE_OBSERVER_WITH_KEY(ptl, key, observer) {[[[ZEDObserversCenter defaultCenter] getObservers:@protocol(ptl) forKey:key] removeObserver:observer];}
#define NOTIFY_OBSERVERS_WITH_KEY(ptl, key, func) do{if (![NSThread isMainThread]) {dispatch_sync(dispatch_get_main_queue(), ^{[(id<ptl>)[[ZEDObserversCenter defaultCenter] getObservers:@protocol(ptl) forKey:key] func];});}else{[(id<ptl>)[[ZEDObserversCenter defaultCenter] getObservers:@protocol(ptl) forKey:key] func];}}while(0);
