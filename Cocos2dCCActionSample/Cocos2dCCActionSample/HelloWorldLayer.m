//
//  HelloWorldLayer.m
//  Cocos2dCCActionSample
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
        CCMenuItemFont *menu1 = [CCMenuItemFont itemWithString:@"rotateBy"
                                                        target:self
                                                      selector:@selector(rotateByAction:)];
        CCMenuItemFont *menu2 = [CCMenuItemFont itemWithString:@"rotateTo"
                                                        target:self
                                                      selector:@selector(rotateToAction:)];
        CCMenuItemFont *menu3 = [CCMenuItemFont itemWithString:@"moveBy"
                                                        target:self
                                                      selector:@selector(moveByAction:)];
        CCMenuItemFont *menu4 = [CCMenuItemFont itemWithString:@"moveTo"
                                                        target:self
                                                      selector:@selector(moveToAction:)];
        CCMenuItemFont *menu5 = [CCMenuItemFont itemWithString:@"fadeIn"
                                                        target:self
                                                      selector:@selector(fadeInAction:)];
        CCMenuItemFont *menu6 = [CCMenuItemFont itemWithString:@"fadeOut"
                                                        target:self
                                                      selector:@selector(fadeoutAction:)];
        CCMenuItemFont *menu7 = [CCMenuItemFont itemWithString:@"stop"
                                                        target:self
                                                      selector:@selector(stopAction:)];

        CCMenu *menu = [CCMenu menuWithItems:menu1,menu2,menu3,menu4,menu5,menu6,menu7, nil];
        [menu alignItemsVerticallyWithPadding:10];
        menu.position = ccp( 100, winSize.height/2  );
        
        [self addChild:menu];


	}
	return self;
}

-(void)rotateByAction:(id)sender{
    CCRotateBy *rotateBy = [CCRotateBy actionWithDuration:1 angle:180];
    [tenko runAction:rotateBy];
}
-(void)rotateToAction:(id)sender{
    CCRotateBy *rotateTo = [CCRotateTo actionWithDuration:1 angle:180];
    [tenko runAction:rotateTo];
}
-(void)moveByAction:(id)sender{
    CCMoveBy *moveBy = [CCMoveBy actionWithDuration:1 position:ccp( 100, 0 )];
    [tenko runAction:moveBy];
}
-(void)moveToAction:(id)sender{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    CCMoveBy *moveTo = [CCMoveTo actionWithDuration:1 position:ccp( winSize.width/2, winSize.height/2 )];
    [tenko runAction:moveTo];
}
-(void)fadeInAction:(id)sender{
    CCFadeIn *fadeIn = [CCFadeIn actionWithDuration:1];
    [tenko runAction:fadeIn];
}
-(void)fadeoutAction:(id)sender{
    CCMoveBy *fadeOut = [CCFadeOut actionWithDuration:1];
    [tenko runAction:fadeOut];
}
-(void)stopAction:(id)sender{
    // すべてのActionを停止
    [tenko stopAllActions];
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
