//
//  Tenko.h
//  Cocos2dSampleGame
//
//  Created by inukai on 2013/03/17.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Tenko : CCSprite {
}

@property (nonatomic, assign ) CGRect hitBoundingBox;
@property (nonatomic, assign ) int    hitCount;
-(void)setPosition;
-(void)setBoundingBox;
-(void)hit;

@end
