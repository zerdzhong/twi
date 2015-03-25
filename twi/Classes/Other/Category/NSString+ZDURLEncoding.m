//
//  NSString+ZDURLEncoding.m
//  twi_iOS
//
//  Created by zerd on 15-2-4.
//  Copyright (c) 2015年 zerd. All rights reserved.
//

#import "NSString+ZDURLEncoding.h"

@implementation NSString (ZDURLEncoding)

- (NSString *)URLEncodedString
{
    
    static NSString * const kAFCharactersToBeEscaped = @":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`";
    static NSString * const kAFCharactersToLeaveUnescaped = @"[].";
    
//    return (__bridge_transfer  NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)self, (__bridge CFStringRef)kAFCharactersToLeaveUnescaped, (__bridge CFStringRef)kAFCharactersToBeEscaped, CFStringConvertNSStringEncodingToEncoding(kCFStringEncodingUTF8));
    
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)self,
                                                              (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                              NULL,
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
    
}

- (NSString*)URLDecodedString
{
    

    
    NSString *result = (NSString *)
    CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                            (CFStringRef)self,
                                                            CFSTR(""),
                                                            kCFStringEncodingUTF8));
    return result;  
}

@end
