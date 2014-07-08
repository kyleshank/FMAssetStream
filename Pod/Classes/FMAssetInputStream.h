//
//  FMAssetInputStream.h
//  Pods
//
//  Created by Kyle Shank on 7/8/14.
//
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "FMAssetInputStreamDelegate.h"

@interface FMAssetInputStream : NSInputStream <NSStreamDelegate>
-(id)initWithAsset:(ALAsset*)asset;
@property (nonatomic, retain) id <FMAssetInputStreamDelegate> progressDelegate;
@end
