//
//  Encryption.m
//  CRAPP
//
//  Created by David Huynh on 12-06-05.
//  Copyright (c) 2012 EOM. All rights reserved.
//

#import "Encryption.h"

@implementation Encryption
+(NSString *)decrypt:(NSString *)str{
    NSString *actualStr = [[[NSString alloc]init]autorelease];
    NSString *validChar = [@",ÍQw` âRÀhzPì*SïY|BT1fë!Ê%ÈèkD\\ÚxúU&\"ÙLJ6u#5y}Ümîv3íKW7pljE08iÉqNt9Ì+2rZ[FabIüùÎ>-(]Xs@MÏ:æV{gAGo~Âû/.=ncÛ?^Hdê4Ë_;O<)eé$ÛCôà'" autorelease];
    NSMutableArray *letters = [[[NSMutableArray alloc]init]autorelease];
    for(int i=0; i<[str length]; i++){
        if([self isNumber:[NSString stringWithFormat:@"%c",[str characterAtIndex:i]]]==YES){
            NSString *num = [@"" autorelease];
            while ([self isNumber:[NSString stringWithFormat:@"%c",[str characterAtIndex:i]]]==YES) {
                num = [num stringByAppendingString:[NSString stringWithFormat:@"%c",[str characterAtIndex:i]]];
                i++;
            }
            [letters addObject:num];
        }
    }
    int strLength =[letters count];
    for (int i=0; i<[letters count]-1; i++) {
        actualStr = [actualStr stringByAppendingString:[NSString stringWithFormat:@"%c",[validChar characterAtIndex:([[letters objectAtIndex:i]integerValue]/strLength-7-strLength)/strLength]]];
    }
    return actualStr;
}

+(BOOL)isNumber:(NSString*)charac{
    NSString *alphabet = [@"0123456789" autorelease];
    for (int i=0; i<[alphabet length]; i++){
        if([charac isEqualToString:[NSString stringWithFormat:@"%c",[alphabet characterAtIndex:i]]]){
            return YES;
        }
    }
    return NO;
}

+(NSString*)encrypt:(NSString*)str{
    NSString *encrypted =[[[NSString alloc]init]autorelease];
    NSString *validChar = [@",ÍQw` âRÀhzPì*SïY|BT1fë!Ê%ÈèkD\\ÚxúU&\"ÙLJ6u#5y}Ümîv3íKW7pljE08iÉqNt9Ì+2rZ[FabIüùÎ>-(]Xs@MÏ:æV{gAGo~Âû/.=ncÛ?^Hdê4Ë_;O<)eé$ÛCôà'" autorelease];
    int ranLetters = arc4random_uniform(5)+5;
    for(int i=0; i<[str length]; i++){
        for(int j=0; j<ranLetters; j++){
            encrypted = [encrypted stringByAppendingFormat:[self getRandomChar:arc4random_uniform(52)]];  
        }
        encrypted = [encrypted stringByAppendingString:[NSString stringWithFormat:@"%i",([validChar rangeOfString:[NSString stringWithFormat:@"%c",[str characterAtIndex:i]]].location*[str length]+[str length]+7)*[str length]]];
    }
    ranLetters = arc4random_uniform(5)+5;
    for(int i=0; i<ranLetters; i++){
        encrypted = [encrypted stringByAppendingFormat:[self getRandomChar:arc4random_uniform(52)]];
    }
    return encrypted;
}

+(NSString*)getRandomChar:(int)ran{
    return [NSString stringWithFormat:@"%c",[@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" characterAtIndex:ran]];
}
@end
