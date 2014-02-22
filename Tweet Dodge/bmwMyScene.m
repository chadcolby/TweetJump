//
//  bmwMyScene.m
//  Tweet Dodge
//
//  Created by Chad D Colby on 2/19/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "bmwMyScene.h"

#define kNumNotification 8

@interface bmwMyScene()
{

    int _nextNotification;
    double _nextNotificationSpawn;
    
}
@end

@implementation bmwMyScene

static const uint32_t tweeterCategory = 0x1 << 0;
static const uint32_t notificatoinCategory = 0x1 << 1;


- (id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {

        _nextNotification = 0;
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        self.physicsWorld.contactDelegate = self;
        
        [self backgroundSetUp];
        
        NSMutableArray *flappingFrames = [NSMutableArray array];
        SKTextureAtlas *tBirdAnimatedAtlas = [SKTextureAtlas atlasNamed:@"tBird"];
        
        NSInteger numberOfImages = tBirdAnimatedAtlas.textureNames.count;
            for (int i = 1; i <= numberOfImages; i++) {
                NSString *textureName = [NSString stringWithFormat:@"tBird%d", i];
                SKTexture *temp = [tBirdAnimatedAtlas textureNamed:textureName];
                [flappingFrames addObject:temp];
            }
        
        self.animatinArray = [NSArray arrayWithArray:flappingFrames];
        
        NSLog(@">>>>> %@", self.animatinArray);
        
        SKTexture *tempTexture = self.animatinArray[0];
        self.animatedTweeter = [SKSpriteNode spriteNodeWithTexture:tempTexture];
        self.animatedTweeter.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:self.animatedTweeter];
       
        [self flappingTweeter];
        
        
       // [self setUpMainCharacters];

    }
    return self;
}

- (void)flappingTweeter
{
    [self.animatedTweeter runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:self.animatinArray timePerFrame:0.05f resize:NO restore:YES]]
                            withKey:@"flappingInPlace"];
    
}

#pragma mark - Set Up Methods

- (void)backgroundSetUp
{
    for (int i = 0; i < 2; i ++) {
        SKSpriteNode *backgroundImage = [SKSpriteNode spriteNodeWithImageNamed:@"twitterBG"];
        backgroundImage.anchorPoint = CGPointZero;
        backgroundImage.position = CGPointMake(i * backgroundImage.size.width, 0);
        backgroundImage.name = @"background";
        [self addChild:backgroundImage];
        
    }
}

- (void)setUpMainCharacters
{
    self.mainTweeter = [SKSpriteNode spriteNodeWithImageNamed: @"twitterBird"];
    self.mainTweeter.position = CGPointMake(50, 100);
    [self addChild:self.mainTweeter];
    
    self.mainTweeter.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.mainTweeter.size];
    self.mainTweeter.physicsBody.dynamic = YES;
    self.mainTweeter.physicsBody.affectedByGravity = YES;
    self.mainTweeter.physicsBody.mass = 0.03;
    self.mainTweeter.physicsBody.allowsRotation = NO;
    self.mainTweeter.physicsBody.categoryBitMask = tweeterCategory;
    self.mainTweeter.physicsBody.collisionBitMask = notificatoinCategory;
    self.mainTweeter.physicsBody.contactTestBitMask = notificatoinCategory;
    
    self.notificationsArray = [[NSMutableArray alloc] initWithCapacity:kNumNotification];
    
    for (int i = 0; i < kNumNotification; i ++) {
        SKSpriteNode *notification = [SKSpriteNode spriteNodeWithImageNamed:@"testPost1"];
        notification.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:notification.size];
        notification.physicsBody.categoryBitMask = notificatoinCategory;
        notification.physicsBody.contactTestBitMask = tweeterCategory;
        notification.physicsBody.dynamic = NO;
        notification.hidden = YES;
        [self.notificationsArray addObject:notification];
        notification.position = CGPointMake(1000, 200);
        [self addChild:notification];
    }
    
}

- (float)randomValueBetween:(float)low andValue:(float)high
{
    return ((float) arc4random() / 0xFFFFFFFFu) * (high - low) + low;
}

#pragma mark - Interaction Methods

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.mainTweeter.physicsBody setVelocity:CGVectorMake(0, 0)];
    [self.mainTweeter.physicsBody applyImpulse:CGVectorMake(0, 20)];
    
}


- (void)update:(CFTimeInterval)currentTime
{
    [self enumerateChildNodesWithName:@"background" usingBlock:^(SKNode *node, BOOL *stop) {
        SKSpriteNode *bg = (SKSpriteNode *)node;
        bg.position = CGPointMake(bg.position.x - 5, bg.position.y);
        
        if (bg.position.x <= -bg.size.width) {
            bg.position = CGPointMake(bg.position.x + bg.size.width * 2, bg.position.y);
        }
    }];
    
    double curTime = CACurrentMediaTime();
    
    if (curTime > _nextNotificationSpawn) {
        
        float randSeconds = [self randomValueBetween:0.20f andValue:1.0f];
        _nextNotificationSpawn = randSeconds + curTime;
        
        float randY = [self randomValueBetween:0.0f andValue:self.frame.size.height];
        float randDuration = [self randomValueBetween:5.0f andValue:8.0f];
        SKSpriteNode *notificatoin = self.notificationsArray[_nextNotification];
        
        _nextNotification++;
        
        if (_nextNotification >= self.notificationsArray.count)
        {
            _nextNotification = 0;
        }
        
        [notificatoin removeAllActions];
        
        notificatoin.position = CGPointMake(self.frame.size.width + notificatoin.size.width / 2, randY);
        
        notificatoin.hidden = NO;
        
        CGPoint location = CGPointMake(-600, randY);
        
        SKAction *moveAction = [SKAction moveTo:location duration:randDuration];
        SKAction *doneAction = [SKAction runBlock:^{
            notificatoin.hidden = YES;
        }];
        
        SKAction *moveNotificationActionWithDone = [SKAction sequence:@[moveAction, doneAction]];
        
        
        [notificatoin runAction:moveNotificationActionWithDone];
        
 
    }

}

- (void)didBeginContact:(SKPhysicsContact *)contact
{
    NSLog(@"Contact!!!");
    
}
@end
