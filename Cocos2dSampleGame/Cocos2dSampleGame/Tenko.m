//
//  Tenko.m
//  Cocos2dSampleGame
//
//  Created by inukai on 2013/03/17.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "Tenko.h"


@implementation Tenko
@synthesize hitBoundingBox;
@synthesize hitCount;

-(id)init{
    if(self = [super init]){
        hitCount   = 0;
        
    }
    return self;
}

-(void)setPosition{
    
    // 表示位置を設定
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    self.position = ccp( winSize.width/2, winSize.height/4 );
    
    
}

-(void)setBoundingBox{
    // 一回り小さいあたり判定を設定
    hitBoundingBox = CGRectMake( self.position.x - self.contentSize.width / 4 ,
                                 self.position.y - self.contentSize.width / 4 ,
                                 self.contentSize.width / 2,
                                 self.contentSize.height / 2);
    
}

-(void)hit{
    hitCount++;
    // 被弾用画像
    CCAnimation *hit_anime = [CCAnimation animation];
    hit_anime.delayPerUnit = 0.4;
    hit_anime.loops = 1;
    [hit_anime addSpriteFrameWithFilename:@"tenko_hit.png"];
    CCAnimate *hit_animate = [CCAnimate actionWithAnimation:hit_anime];
    
    // 通常画像
    CCAnimation *normal_anime = [CCAnimation animation];
    normal_anime.delayPerUnit = 1;
    normal_anime.loops = 1;
    [normal_anime addSpriteFrameWithFilename:@"tenko.png"];
    CCAnimate *normal_animate = [CCAnimate actionWithAnimation:normal_anime];
    
    
    CCTintTo *tintReset = [CCTintTo actionWithDuration:0 red:255 green:255 blue:255];
    CCTintBy *tint = [CCTintBy actionWithDuration:0 red:255 green:180 blue:180];
    CCSpawn *hit_spawn = [CCSpawn actions:tint,hit_animate, nil];
    CCSpawn *normal_spawn = [CCSpawn actions:tintReset,normal_animate, nil];
    CCSequence *seq = [CCSequence actions:tintReset,hit_spawn,normal_spawn, nil];
    [self runAction:seq];
}

@end
