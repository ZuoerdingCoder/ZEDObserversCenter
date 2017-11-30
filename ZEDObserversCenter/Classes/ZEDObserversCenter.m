//
//  ZEDObserversCenter.m
//  ZEDObserversCenter
//
//  Created by 超李 on 2017/11/30.
//

#import "ZEDObserversCenter.h"

@interface ZEDObserversCenter ()
{
    NSMutableDictionary *_dicObservers;
}

@end

@implementation ZEDObserversCenter

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dicObservers = [NSMutableDictionary dictionary];
    }
    return self;
}

+ (instancetype)defaultCenter{
    static ZEDObserversCenter *center = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        center = [[self alloc] init];
    });
    return center;
}

- (PLObservers *)getObservers:(Protocol *)ptl{
    return [self getObservers:ptl forKey:@"observers.center.default.key"];
}

- (PLObservers *)getObservers:(Protocol *)ptl forKey:(NSString *)key{
    NSString *aKey = [NSString stringWithFormat:@"[%@-%@]", NSStringFromProtocol(ptl), key];
    PLObservers *observers = [_dicObservers objectForKey:aKey];
    if (nil == observers) {
        observers = [[PLObservers alloc] initWithObserverProtocol:ptl];
        [_dicObservers setObject:observers forKey:aKey];
    }
    return observers;
}

@end
