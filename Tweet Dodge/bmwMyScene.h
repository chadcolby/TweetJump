//
//  bmwMyScene.h
//  Tweet Dodge
//

//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "bmwTweetNode.h"

@interface bmwMyScene : SKScene <SKPhysicsContactDelegate>

@property (strong, nonatomic) SKSpriteNode *mainTweeter;
@property (strong, nonatomic) SKSpriteNode *animatedTweeter;
@property (strong, nonatomic) NSMutableArray *notificationsArray;
@property (strong, nonatomic) NSArray *animatinArray;

@property (strong, nonatomic) bmwTweetNode *notificaion;

@end
