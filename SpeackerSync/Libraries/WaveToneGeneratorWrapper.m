//
//  WaveToneGeneratorWrapper.m
//  ToneGenerator
//
//  Created by Alex on 17/10/15.
//  Copyright © 2015 Alex Steiner. All rights reserved.
//  I had to write this Objective-C wrapper to bridge the TGSSineWaveToneGenerator which is written in C to Swift.
//  This also makes it easier to play frequencies.
//

#import "WaveToneGeneratorWrapper.h"
#import "TGSineWaveToneGenerator.h"

@interface WaveToneGeneratorWrapper ()
@property TGSineWaveToneGenerator * generator;
@property int maxFrequency;
@property int minFrequency;
@end

@implementation WaveToneGeneratorWrapper


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.maxFrequency = 20000;
        self.minFrequency = 10;
        self.generator = [[TGSineWaveToneGenerator alloc]initWithChannels:1];
    }
    return self;
}

-(void)playFrequency:(int)frequency onChannel:(int)channel forDuration:(NSTimeInterval)duration {
    
    // Break playing if frequency is out of range
    if (frequency > self.maxFrequency && frequency < self.minFrequency) {
        return;
    }
    self.generator->_channels[channel].frequency = frequency;
    self.generator->_channels[channel].amplitude = 0.08;
    
    [self.generator playForDuration:duration];
}

@end
