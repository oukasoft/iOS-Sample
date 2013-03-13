//
//  HelloWorldLayer.m
//  Cocos2dCCActionSampleEx
//
//  Created by inukai on 2013/03/12.
//  Copyright __MyCompanyName__ 2013年. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
        
		// 画面サイズを取得
		CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        // Action対象のスプライト
        tenko = [CCSprite spriteWithFile:@"tenshi.png"];
        tenko.position = ccp( winSize.width/2 , winSize.height/2);
        [self addChild:tenko];
        
        
        // CCActionを実行させる用のメニューを作成
        [CCMenuItemFont setFontName:@"AppleGothic"];
        [CCMenuItemFont setFontSize:25];
        CCMenuItemFont *menu1 = [CCMenuItemFont itemWithString:@"sequence"
                                                        target:self
                                                      selector:@selector(sequence:)];
        CCMenuItemFont *menu2 = [CCMenuItemFont itemWithString:@"spawn"
                                                        target:self
                                                      selector:@selector(spawn:)];
        CCMenuItemFont *menu3 = [CCMenuItemFont itemWithString:@"repeat"
                                                        target:self
                                                      selector:@selector(repeat:)];
        CCMenuItemFont *menu4 = [CCMenuItemFont itemWithString:@"call"
                                                        target:self
                                                      selector:@selector(call:)];
        CCMenu *menu = [CCMenu menuWithItems:menu1,menu2,menu3,menu4, nil];
        [menu alignItemsVerticallyWithPadding:10];
        menu.position = ccp( 100, winSize.height/2  );
        
        [self addChild:menu];
        
        
	}
	return self;
}

-(void)sequence:(id)sender{
    CCRotateBy *rotate = [CCRotateBy actionWithDuration:1 angle:180];
    CCMoveBy   *move = [CCMoveBy actionWithDuration:1 position:ccp( 100, 0 )];
    CCDelayTime *delay = [CCDelayTime actionWithDuration:1];
    CCActionInterval *reverseRotate = [rotate reverse];
    CCActionInterval *reverseMove   = [move reverse];
    CCSequence *sequence = [CCSequence actions:rotate,move,delay,reverseRotate,reverseMove, nil];
    [tenko runAction:sequence];
}
-(void)spawn:(id)sender{
    CCRotateBy *rotate  = [CCRotateTo actionWithDuration:1 angle:180];
    CCMoveBy   *move    = [CCMoveBy actionWithDuration:1 position:ccp( 100, 0 )];
    CCMoveBy   *fadeOut = [CCFadeOut actionWithDuration:1];
    CCSpawn *spawn = [CCSpawn actions:rotate,move,fadeOut, nil];
    [tenko runAction:spawn];
}
-(void)repeat:(id)sender{
    CCMoveBy *move = [CCMoveBy actionWithDuration:0.5 position:ccp( 50, 0 )];
    CCActionInterval *reverse = [move reverse];
    CCSequence *seq = [CCSequence actions:move,reverse, nil];
    CCRepeat * repeat = [CCRepeat actionWithAction:seq times:3];
    [tenko runAction:repeat];
}
-(void)call:(id)sender{
    CCRotateBy *rotate = [CCRotateBy actionWithDuration:1 angle:180];
    CCCallBlock *call  = [CCCallBlock actionWithBlock:^(void){
        CCLOG(@"call");
    }];
    CCSequence *seq = [CCSequence actions:rotate,call, nil];
    CCRepeatForever *repeat = [CCRepeatForever actionWithAction:seq ];
    [tenko runAction:repeat];
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}
@end
