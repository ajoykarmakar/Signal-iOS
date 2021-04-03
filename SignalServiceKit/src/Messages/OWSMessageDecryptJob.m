//
//  Copyright (c) 2021 Open Whisper Systems. All rights reserved.
//

#import "OWSMessageDecryptJob.h"
#import "AppContext.h"
#import "AppReadiness.h"
#import "NSArray+OWS.h"
#import "NSNotificationCenter+OWS.h"
#import "NotificationsProtocol.h"
#import "OWSBackgroundTask.h"
#import "OWSQueues.h"
#import "ProfileManagerProtocol.h"
#import "SSKEnvironment.h"
#import "TSAccountManager.h"
#import "TSErrorMessage.h"
#import <SignalCoreKit/NSDate+OWS.h>
#import <SignalCoreKit/Threading.h>
#import <SignalServiceKit/SignalServiceKit-Swift.h>

NS_ASSUME_NONNULL_BEGIN

@implementation OWSMessageDecryptJob

+ (NSString *)collection
{
    return @"OWSMessageProcessingJob";
}

- (instancetype)initWithEnvelopeData:(NSData *)envelopeData serverDeliveryTimestamp:(uint64_t)serverDeliveryTimestamp
{
    OWSAssertDebug(envelopeData);

    self = [super init];
    if (!self) {
        return self;
    }

    _envelopeData = envelopeData;
    _serverDeliveryTimestamp = serverDeliveryTimestamp;
    _createdAt = [NSDate new];

    return self;
}

// --- CODE GENERATION MARKER

// This snippet is generated by /Scripts/sds_codegen/sds_generate.py. Do not manually edit it, instead run
// `sds_codegen.sh`.

// clang-format off

- (instancetype)initWithGrdbId:(int64_t)grdbId
                      uniqueId:(NSString *)uniqueId
                       createdAt:(NSDate *)createdAt
                    envelopeData:(NSData *)envelopeData
         serverDeliveryTimestamp:(uint64_t)serverDeliveryTimestamp
{
    self = [super initWithGrdbId:grdbId
                        uniqueId:uniqueId];

    if (!self) {
        return self;
    }

    _createdAt = createdAt;
    _envelopeData = envelopeData;
    _serverDeliveryTimestamp = serverDeliveryTimestamp;

    return self;
}

// clang-format on

// --- CODE GENERATION MARKER

- (nullable instancetype)initWithCoder:(NSCoder *)coder
{
    return [super initWithCoder:coder];
}

- (nullable SSKProtoEnvelope *)envelopeProto
{
    NSError *error;
    SSKProtoEnvelope *_Nullable envelope = [[SSKProtoEnvelope alloc] initWithSerializedData:self.envelopeData
                                                                                      error:&error];
    if (error || envelope == nil) {
        OWSFailDebug(@"failed to parse envelope with error: %@", error);
        return nil;
    }

    return envelope;
}

@end

NS_ASSUME_NONNULL_END
