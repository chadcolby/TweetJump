//
//  bmwMyScene.m
//  Tweet Dodge
//
//  Created by Chad D Colby on 2/19/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "bmwMyScene.h"
#import "bmwViewController.h"
#import "bmwTweetNode.h"

#define kNumNotification 8

@interface bmwMyScene()
{

    int _nextNotification;
    double _nextNotificationSpawn;
    
}
@end

static inline CGPoint rwAdd(CGPoint a, CGPoint b) {
    return CGPointMake(a.x + b.x, a.y + b.y);
}

static inline CGPoint rwSub(CGPoint a, CGPoint b) {
    return CGPointMake(a.x - b.x, a.y - b.y);
}

static inline CGPoint rwMult(CGPoint a, float b) {
    return CGPointMake(a.x * b, a.y * b);
}

static inline float rwLength(CGPoint a) {
    return sqrtf(a.x * a.x + a.y * a.y);
}

// Makes a vector have a length of 1
static inline CGPoint rwNormalize(CGPoint a) {
    float length = rwLength(a);
    return CGPointMake(a.x / length, a.y / length);
}

@implementation bmwMyScene

static const uint32_t tweeterCategory = 0x1 << 0;
static const uint32_t notificatoinCategory = 0x1 << 1;
static const uint32_t projectileCategory = 0x1 << 2;


- (id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {

        _nextNotification = 0;
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        
        self.physicsWorld.contactDelegate = self;
        
        [self backgroundSetUp];
        [self setUpMainCharacterWithAnimation];


    }
    return self;
}

-(void)setUpMainCharacterWithAnimation
{
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
    self.animatedTweeter.position = CGPointMake(CGRectGetMidX(self.frame)/3, CGRectGetMidY(self.frame)/2);
    [self addChild:self.animatedTweeter];
    [self flappingTweeter];
    
    self.animatedTweeter.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.animatedTweeter.size];
    self.animatedTweeter.physicsBody.dynamic = YES;
    self.animatedTweeter.physicsBody.affectedByGravity = NO;
    self.animatedTweeter.physicsBody.mass = 0.03;
    self.animatedTweeter.physicsBody.allowsRotation = NO;
    self.animatedTweeter.physicsBody.categoryBitMask = tweeterCategory;
    self.animatedTweeter.physicsBody.collisionBitMask = 0;;
    self.animatedTweeter.physicsBody.contactTestBitMask = 0;
    
    self.notificationsArray = [[NSMutableArray alloc] initWithCapacity:kNumNotification];
    
    for (int i = 0; i < kNumNotification; i ++) {
        self.notificaion = [bmwTweetNode spriteNodeWithImageNamed:@"testPost1"];
        //SKSpriteNode *notification = [SKSpriteNode spriteNodeWithImageNamed:@"testPost1"];
        self.notificaion.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.notificaion.size];
        self.notificaion.physicsBody.categoryBitMask = notificatoinCategory;
        self.notificaion.physicsBody.contactTestBitMask = projectileCategory;
        self.notificaion.physicsBody.dynamic = NO;
        self.notificaion.hidden = YES;
        self.notificaion.name = @"notificationNode";
        [self.notificationsArray addObject:self.notificaion];
        self.notificaion.position = CGPointMake(1000, 200);
        [self addChild:self.notificaion];
    }

}

- (void)flappingTweeter
{
    [self.animatedTweeter runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:self.animatinArray timePerFrame:0.1f resize:NO restore:YES]]
                            withKey:@"flappingInPlace"];
}

- (void)shootTweet
{
    
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



- (float)randomValueBetween:(float)low andValue:(float)high
{
    return ((float) arc4random() / 0xFFFFFFFFu) * (high - low) + low;
}

#pragma mark - Interaction Methods

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//    UITouch *viewTouch = [touches anyObject];
//    NSArray *currentNodes = [self nodesAtPoint:[viewTouch locationInNode:self]];
//    CGPoint location = CGPointMake(CGRectGetMidY(self.view.frame), CGRectGetMidX(self.view.frame));
//    NSLog(@"^^^^^^ %@", currentNodes);
//    for (bmwTweetNode *tweetNode in currentNodes) {
//        if ([tweetNode.name isEqualToString:@"notificationNode"]) {
//            bmwTweetNode *nodeToShow = [bmwTweetNode spriteNodeWithImageNamed:@"tweetToShow"];
//            [nodeToShow showLog];
//            nodeToShow.position = location;
//            nodeToShow.hidden = YES;
//            //[self addChild:nodeToShow];
//            SKAction *showAction = [SKAction waitForDuration:0.5f];
//
//            SKAction *pauseAction = [SKAction runBlock:^{
//                nodeToShow.hidden = NO;
//                self.view.paused = YES;
//
//            }];
//            SKAction *sequenceOfActions = [SKAction sequence:@[showAction, pauseAction]];
//            [self runAction:sequenceOfActions];
//        }
//    }
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    
    SKSpriteNode *projectile = [[SKSpriteNode alloc] initWithImageNamed:@"projectile"];
    projectile.position = self.animatedTweeter.position;
    
    CGPoint offset = rwSub(location, projectile.position);
    
    if (offset.x <= 0) return;
    
    [self addChild:projectile];
    CGPoint dircetion = rwNormalize(offset);
    
    CGPoint shootAmount = rwMult(dircetion, 500);
    
    CGPoint realDestination = rwAdd(shootAmount, projectile.position);
    
    float velocity = 568.f/1.0f;
    float realMoveDuration = self.size.width / velocity;
    
    SKAction *moveAction = [SKAction moveTo:realDestination duration:realMoveDuration];
    SKAction *moveDoneAction = [SKAction removeFromParent];
    [projectile runAction:[SKAction sequence:@[moveAction, moveDoneAction]]];
    
    projectile.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:projectile.size];
    projectile.physicsBody.dynamic = YES;
    projectile.physicsBody.categoryBitMask = projectileCategory;
    projectile.physicsBody.contactTestBitMask = notificatoinCategory;
    projectile.physicsBody.collisionBitMask = 0;
    projectile.physicsBody.usesPreciseCollisionDetection = YES;
    
    
    
}

- (void)projectile:(SKSpriteNode *)projectile didCollideWithNotification:(SKSpriteNode *)notification
{
    NSLog(@"HIT!");
    [projectile removeFromParent];
    [notification removeFromParent];
    
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
   // NSLog(@"Contact!!!");
    SKPhysicsBody *firstBody, *secondBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask)
    {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }
    else
    {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    NSLog(@"BODYA %u, BODY2 %u", contact.bodyA.categoryBitMask, contact.bodyB.categoryBitMask);
    if ((firstBody.categoryBitMask & projectileCategory) != 0 &&
        (secondBody.categoryBitMask & notificatoinCategory) != 0)
    {
        //[self projectile:(SKSpriteNode *) firstBody.node didCollideWithNotification:(SKSpriteNode *) secondBody.node];
        
    }
    [self projectile:(SKSpriteNode *) firstBody.node didCollideWithNotification:(SKSpriteNode *) secondBody.node];
    
    
}
@end
