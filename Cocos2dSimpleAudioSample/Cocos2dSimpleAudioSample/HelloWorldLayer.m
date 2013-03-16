//
//  HelloWorldLayer.m
//  Cocos2dSimpleAudioSample
//
//  Created by inukai on 2013/03/16.
//  Copyright __MyCompanyName__ 2013年. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#import "SimpleAudioEngine.h"

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
//
//  HelloWorldLayer.m
//  Cocos2dSimpleAudioSample
//
//  Created by inukai on 2013/03/16.
//  Copyright __MyCompanyName__ 2013年. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#import "SimpleAudioEngine.h"

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
		CGSize size = [[CCDirector sharedDirector] winSize];
        
        // 再生フラグ
        isPlay = NO;
        
        // プリロード
        [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:@"honobono_bgm.mp3"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"se.wav"];
         
		[CCMenuItemFont setFontSize:28];
		CCMenuItemFont *menu1 = [CCMenuItemFont itemWithString:@"BGM再生/再開" target:self selector:@selector(startBgm:)];
		CCMenuItemFont *menu2 = [CCMenuItemFont itemWithString:@"BGM一時停止" target:self selector:@selector(pauseBgm:)];
		CCMenuItemFont *menu3 = [CCMenuItemFont itemWithString:@"BGM停止" target:self selector:@selector(stopBgm:)];
		CCMenuItemFont *menu4 = [CCMenuItemFont itemWithString:@"SE再生" target:self selector:@selector(playSe:)];
        
		CCMenu *menu = [CCMenu menuWithItems:menu1, menu2, menu3, menu4, nil];
		
		[menu alignItemsVerticallyWithPadding:10];
		[menu setPosition:ccp( size.width/2, size.height/2)];
		
		// Add the menu to the layer
		[self addChild:menu];

	}
	return self;
}
-(void)startBgm:(id)sender{
    // 再生チェック
    if( isPlay ){
        // 再開
        [[SimpleAudioEngine sharedEngine] resumeBackgroundMusic];
    }else{
        // 始めから再生
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"honobono_bgm.mp3"];
        isPlay = YES;
    }
}
-(void)pauseBgm:(id)sender{
    // BGM一時停止
    [[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
}
-(void)stopBgm:(id)sender{
    // BGM停止
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    isPlay = NO;
}
-(void)playSe:(id)sender{
    [[SimpleAudioEngine sharedEngine] playEffect:@"se.wav"];
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
