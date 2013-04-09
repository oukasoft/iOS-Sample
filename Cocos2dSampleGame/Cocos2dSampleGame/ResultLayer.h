//
//  ResultLayer.h
//  Cocos2dSampleGame
//
//  Created by inukai on 2013/03/17.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ResultLayer : CCLayer {
    
}
@property (nonatomic, assign ) int    hitCount;
+(CCScene *) scene;
@end
