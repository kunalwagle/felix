//
//  User.h
//  Felix
//
//  Created by Kunal Wagle on 20/12/2014.
//  Copyright (c) 2014 Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

#include "Image.h"

@interface User : NSObject

-(User *)initFull: (NSString*)user name:(NSString*)name info:(NSString*)info email:(NSString*)email twitter:(NSString*)twitter desc:(NSString*)desc facebook:(NSString*)facebook websitename:(NSString*)websitename websiteurl:(NSString*)websiteurl img:(Image*)img;
-(NSString*)getUser;
-(NSString*)getName;
-(NSString*)getInfo;
-(NSString*)getDesc;
-(NSString*)getEmail;
-(NSString*)getFacebook;
-(NSString*)getTwitter;
-(NSString*)getWebsitename;
-(NSString*)getWebsiteurl;
-(Image*)getImage;

@property NSString *user;
@property NSString *name;
@property NSString *info;
@property NSString *desc;
@property NSString *email;
@property NSString *facebook;
@property NSString *twitter;
@property NSString *websitename;
@property NSString *websiteurl;
@property Image *img;


@end
