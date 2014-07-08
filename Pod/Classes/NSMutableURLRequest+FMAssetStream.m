//
//  NSMutableURLRequest+FMAssetStream.m
//  Pods
//
//  Created by Kyle Shank on 7/8/14.
//
//

#import "NSMutableURLRequest+FMAssetStream.h"

@implementation NSMutableURLRequest (FMAssetStream)

-(void)setAsset:(ALAsset*)asset{
    FMAssetInputStream* stream = [[FMAssetInputStream alloc] initWithAsset:asset];
    [self setHTTPBodyStream:stream];
    [self setValue:[NSString stringWithFormat:@"%lld", [[asset defaultRepresentation] size]] forHTTPHeaderField:@"Content-Length"];
}
-(void)setAsset:(ALAsset*)asset delegate:(id<FMAssetInputStreamDelegate>) delegate{
    FMAssetInputStream* stream = [[FMAssetInputStream alloc] initWithAsset:asset];
    stream.progressDelegate = delegate;
    [self setHTTPBodyStream:stream];
    [self setValue:[NSString stringWithFormat:@"%lld", [[asset defaultRepresentation] size]] forHTTPHeaderField:@"Content-Length"];
}

@end
