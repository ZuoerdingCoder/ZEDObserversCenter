//
//  ZEDManagerCenter.h
//  ZEDObserversCenter
//
//  Created by 超李 on 2017/11/30.
//

#import <Foundation/Foundation.h>

@protocol ZEDManagerProtocol <NSObject>
/**
 如果为YES,这个Manager将不会在用户登录之后被销毁,反之则会被销毁,默认值为NO
 */
@property (nonatomic, assign) BOOL isKeepLiveAlways;

@optional
// 提供给子类去实现的方法
- (void)onManagerInit;
- (void)onManagerDidEnterBackground;
- (void)onManagerWillEnterForeground;
- (void)onManagerUserDidLogin;
- (void)onManagerDidLogout;
- (void)onManagerMemoryWarning;

@end

@interface ZEDManagerCenter : NSObject

+ (instancetype)defaultCenter;

- (id<ZEDManagerProtocol>)getManager:(Class)class;

- (void)applicationDidEnterBackground;
- (void)applicationWillEnterForeground;
- (void)applicationDidReceiveMemoryWarning;
- (void)onUserDidLogin;
- (void)onUserDidLogout;

@end

#define GET_MANAGER(mgrClass) ((mgrClass *)[[ZEDManagerCenter defaultCenter] getManager:[mgrClass class]])
