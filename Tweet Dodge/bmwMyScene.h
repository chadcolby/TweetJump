//
//  bmwMyScene.h
//  Tweet Dodge
//

//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface bmwMyScene : SKScene <SKPhysicsContactDelegate>

@property (strong, nonatomic) SKSpriteNode *mainTweeter;
@property (strong, nonatomic) NSMutableArray *notificationsArray;

@end
