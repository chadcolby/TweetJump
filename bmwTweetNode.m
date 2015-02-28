//
//  bmwTweetNode.m
//  Tweet Dodge
//
//  Created by Chad D Colby on 2/23/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "bmwTweetNode.h"

@implementation bmwTweetNode

- (id)init
{
    self = [super init];

    self.name = @"tweetNODE";
    self.buttonNode = [SKSpriteNode spriteNodeWithImageNamed:@"close"];
    self.buttonNode.name = @"closeButton";
    self.buttonNode.anchorPoint = CGPointZero;
    self.buttonNode.position = CGPointMake(20, 20);
    
    [self addChild:self.buttonNode];
    
    NSLog(@"buttons: %@", [self.children lastObject]);
    
    return self;
    
}

- (void)showLog
{
    NSLog(@"<><><><><><><><");
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];

    if ([node.name isEqualToString:@"close"]) {
        NSLog(@"*^*^*^*^*^*^*^*^*^");

    }
}

@end
