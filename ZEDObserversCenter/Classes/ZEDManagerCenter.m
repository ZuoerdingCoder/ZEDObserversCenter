//
//  ZEDManagerCenter.m
//  ZEDObserversCenter
//
//  Created by 超李 on 2017/11/30.
//

#import "ZEDManagerCenter.h"

@interface ZEDManagerCenter ()
{
    NSMutableDictionary *_dicMrgs;
    NSRecursiveLock *_lock;
}
@end

@implementation ZEDManagerCenter

+ (instancetype)defaultCenter{
    static ZEDManagerCenter *center = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        center = [[self alloc] init];
    });
    return center;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dicMrgs = [NSMutableDictionary dictionary];
        _lock = [[NSRecursiveLock alloc] init];
    }
    return self;
}

- (id<ZEDManagerProtocol>)getManager:(Class)class
{
    if (![class conformsToProtocol:@protocol(ZEDManagerProtocol)]) {
        return nil;
    }
    
    [_lock lock];
    
    NSString *key = NSStringFromClass(class);
    id<ZEDManagerProtocol> mgr = _dicMrgs[key];
    
    if (mgr) {
        [_lock unlock];
        return mgr;
    }
    
    mgr = [[class alloc] init];
    [mgr onManagerInit];
    
    _dicMrgs[key] = mgr;
    [_lock unlock];
    
    return mgr;
}

- (void)applicationDidEnterBackground
{
    NSDictionary *tmpMrgs = [NSDictionary dictionaryWithDictionary:_dicMrgs];
    for (id<ZEDManagerProtocol> mgr in [tmpMrgs allValues]) {
        if ([mgr respondsToSelector:@selector(onManagerDidEnterBackground)]) {
            [mgr onManagerDidEnterBackground];
        }
    }
}

- (void)applicationWillEnterForeground
{
    NSDictionary *tmpMrgs = [NSDictionary dictionaryWithDictionary:_dicMrgs];
    for (id<ZEDManagerProtocol> mgr in [tmpMrgs allValues]) {
        if ([mgr respondsToSelector:@selector(onManagerWillEnterForeground)]) {
            [mgr onManagerWillEnterForeground];
        }
    }
}

- (void)applicationDidReceiveMemoryWarning
{
    NSDictionary *tmpMrgs = [NSDictionary dictionaryWithDictionary:_dicMrgs];
    for (id<ZEDManagerProtocol> mgr in [tmpMrgs allValues]) {
        if ([mgr respondsToSelector:@selector(onManagerMemoryWarning)]) {
            [mgr onManagerMemoryWarning];
        }
    }
}

- (void)onUserDidLogin
{
    NSDictionary *tmpMrgs = [NSDictionary dictionaryWithDictionary:_dicMrgs];
    for (id<ZEDManagerProtocol> mgr in [tmpMrgs allValues]) {
        if ([mgr respondsToSelector:@selector(onUserDidLogin)]) {
            [mgr onManagerUserDidLogin];
        }
    }
}


- (void)onUserDidLogout
{
    NSDictionary *tmpMrgs = [NSDictionary dictionaryWithDictionary:_dicMrgs];
    for (id<ZEDManagerProtocol> mgr in [tmpMrgs allValues]) {
        if ([mgr respondsToSelector:@selector(onManagerDidLogout)]) {
            [mgr onManagerDidLogout];
        }
        if (!mgr.isKeepLiveAlways) {
            NSString *key = NSStringFromClass([mgr class]);
            [_dicMrgs removeObjectForKey:key];
        }
    }
}


@end
