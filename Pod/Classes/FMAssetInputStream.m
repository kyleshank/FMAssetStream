//
//  FMAssetInputStream.m
//  Pods
//
//  Created by Kyle Shank on 7/8/14.
//
//

#import "FMAssetInputStream.h"

@interface FMAssetInputStream () {
    long long size;
    long long read;
    NSStreamStatus streamStatus;
    
    id <NSStreamDelegate> delegate;
}
@property (nonatomic, retain) ALAsset* asset;
@property (nonatomic, retain) ALAssetRepresentation* assetRepresentation;
@end

@implementation FMAssetInputStream

-(id)initWithAsset:(ALAsset*)asset{
    self = [super init];
    if(self){
        self.asset = asset;
        self.assetRepresentation = [asset defaultRepresentation];
        size = [self.assetRepresentation size];
        read = 0;
    }
    return self;
}

#pragma mark - NSStream subclass overrides

- (void)open {
    streamStatus = NSStreamStatusOpen;
}

- (void)close {
    streamStatus = NSStreamStatusClosed;
}

- (id<NSStreamDelegate>)delegate {
    return delegate;
}

- (void)setDelegate:(id<NSStreamDelegate>)aDelegate {
    delegate = aDelegate;
    if (delegate == nil) {
    	delegate = self;
    }
}

- (void)scheduleInRunLoop:(NSRunLoop *)aRunLoop forMode:(NSString *)mode {
    // Nothing to do here, because this stream does not need a run loop to produce its data.
}

- (void)removeFromRunLoop:(NSRunLoop *)aRunLoop forMode:(NSString *)mode {
    // Nothing to do here, because this stream does not need a run loop to produce its data.
}

- (id)propertyForKey:(NSString *)key {
    return nil;
}

- (BOOL)setProperty:(id)property forKey:(NSString *)key {
    return NO;
}

- (NSStreamStatus)streamStatus {
    return streamStatus;
}

- (NSError *)streamError {
    return nil;
}

- (BOOL)getBuffer:(uint8_t **)buffer length:(NSUInteger *)len{
    return NO;
}

- (BOOL)hasBytesAvailable{
    if(read < size){
        return YES;
    }else{
        return NO;
    }
}

- (NSInteger)read:(uint8_t *)buffer maxLength:(NSUInteger)len {
    if(read >= size) {
        return 0;
    }

    NSUInteger bytesRead = [self.assetRepresentation getBytes:buffer fromOffset:read length:len error:nil];
    read += bytesRead;
    
    // Update stream status when it's consumed
    if(read >= size) {
        streamStatus = NSStreamStatusAtEnd;
    }
    
    if(self.progressDelegate) {
        [self.progressDelegate progressBytes:read totalBytes:size];
    }
    
    return bytesRead;
}

@end
