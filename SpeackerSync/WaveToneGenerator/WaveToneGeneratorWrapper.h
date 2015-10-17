//
//  WaveToneGeneratorWrapper.h
//  ToneGenerator
//
//  Created by Alex on 17/10/15.
//  Copyright © 2015 Alex Steiner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WaveToneGeneratorWrapper : NSObject
-(void)playFrequency:(int)frequency onChannel:(int)channel forDuration:(NSTimeInterval)duration;
@end
