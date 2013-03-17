//
//  NextLayer.m
//  Cocos2dSceneTransSample
//
//  Created by inukai on 2013/03/17.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "NextLayer.h"
#import "SampleLayer.h"

@implementation NextLayer

+(CCScene *)scene{
    CCScene     *scene = [CCScene node];
    NextLayer   *layer = [NextLayer node];
    [scene addChild:layer];
    
    return scene;
}

-(id)init{
    
    if( self = [super init] ){
        CCLabelTTF *label= [CCLabelTTF labelWithString:@"ここはNextLayerです"
                                              fontName:@"AppleGothic"
                                              fontSize:40];
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        label.position = ccp( winSize.width/2, winSize.height/3 );
        [self addChild:label];

        [CCMenuItemFont setFontSize:30];
        CCMenuItemFont *menu1 = [CCMenuItemFont itemWithString:@"戻る" block:^(id sender){
            [[CCDirector sharedDirector] replaceScene:[SampleLayer scene]];
        }];
        
        CCMenu *menu = [CCMenu menuWithItems:menu1, nil];
        
        [self addChild:menu];

    }
    return self;
}

@end
