//
//  SampleScene.m
//  Cocos2dSceneTransSample
//
//  Created by inukai on 2013/03/17.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "SampleLayer.h"
#import "NextLayer.h"

@implementation SampleLayer

+(CCScene *)scene{
    CCScene     *scene = [CCScene node];
    SampleLayer *layer = [SampleLayer node];
    [scene addChild:layer];
    
    return scene;
}


-(void)onEnter{
    [super onEnter];
    
    [CCMenuItemFont setFontSize:30];
    CCMenuItemFont *menu1 = [CCMenuItemFont itemWithString:@"FadeIn" block:^(id sender){
        CCTransitionFade *trans = [CCTransitionFade transitionWithDuration:1.0 scene:[NextLayer scene]];
        [self replaceScene:trans];
    }];
    CCMenuItemFont *menu2 = [CCMenuItemFont itemWithString:@"PageTurn" block:^(id sender){
        CCTransitionPageTurn *trans = [CCTransitionPageTurn transitionWithDuration:1.0 scene:[NextLayer scene]];
        [self replaceScene:trans];
    }];
    CCMenuItemFont *menu3 = [CCMenuItemFont itemWithString:@"SlideInB" block:^(id sender){
        CCTransitionSlideInB *trans = [CCTransitionSlideInB transitionWithDuration:1.0 scene:[NextLayer scene]];
        [self replaceScene:trans];
    }];
    CCMenuItemFont *menu4 = [CCMenuItemFont itemWithString:@"FlipX" block:^(id sender){
        CCTransitionFlipX *trans = [CCTransitionFlipX transitionWithDuration:1.0 scene:[NextLayer scene]];
        [self replaceScene:trans];
    }];
    CCMenu *menu = [CCMenu menuWithItems:menu1,menu2,menu3,menu4, nil];
    [menu alignItemsVerticallyWithPadding:10];
    [self addChild:menu];
    
}

-(void)replaceScene:(CCNode *)trans{
    [[CCDirector sharedDirector] replaceScene:trans];
}


@end
