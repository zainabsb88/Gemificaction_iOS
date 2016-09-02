//
//  ISAPIManager.h
//  Antilog Vacations
//
//  Created by Arshdeep Singh on 15/06/15.
//  Copyright (c) 2015 Rootfly Infotech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ISAPIManager : NSObject


+ (id)sharedInstance;

- (void)POST:(NSString *)apiUrl parameters:(NSDictionary *)dicttionary success:(void (^)(id responseObject, NSError *error))success failure:(void(^)(id responseObject, NSError *error))failure;

- (void)GET:(NSString *)apiUrl parameters:(NSDictionary *)dicttionary success:(void (^)(id responseObject, NSError *error))success failure:(void(^)(id responseObject, NSError *error))failure;

- (void)multistagePOST:(NSString *)apiUrl parameters:(NSDictionary *)dictionary attachImage:(UIImage *)image success:(void (^)(id responseObject, NSError *error))success failure:(void(^)(id responseObject, NSError *error))failure;

@end
