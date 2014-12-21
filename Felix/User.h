//
//  User.h
//  Felix
//
//  Created by Kunal Wagle on 20/12/2014.
//  Copyright (c) 2014 Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Image.h"

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




@end
