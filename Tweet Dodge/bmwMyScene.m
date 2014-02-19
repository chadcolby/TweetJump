//
//  bmwMyScene.m
//  Tweet Dodge
//
//  Created by Chad D Colby on 2/19/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "bmwMyScene.h"

@implementation bmwMyScene

- (id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        

    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */

    
}

- (void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
