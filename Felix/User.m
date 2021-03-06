//
//  User.m
//  Felix
//
//  Created by Kunal Wagle on 20/12/2014.
//  Copyright (c) 2014 Felix. All rights reserved.
//

#import "User.h"

@interface User ()

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

@implementation User

-(User *)initFull: (NSString*)user name:(NSString*)name info:(NSString*)info email:(NSString*)email twitter:(NSString*)twitter desc:(NSString*)desc facebook:(NSString*)facebook websitename:(NSString*)websitename websiteurl:(NSString*)websiteurl img:(Image*)img {
    self.user = user;
    self.name = name;
    self.info = info;
    self.email = email;
    self.twitter = twitter;
    self.desc = desc;
    self.facebook = facebook;
    self.websitename = websitename;
    self.websiteurl = websiteurl;
    self.img = img;
    return self;
}

-(NSString*)getUser {
    return self.user;
}

-(NSString*)getName {
    return self.name;
}

-(NSString*)getInfo {
    return self.info;
}

-(NSString*)getDesc{
    return self.desc;
}

-(NSString*)getEmail{
    return self.email;
}

-(NSString*)getFacebook{
    return self.facebook;
}

-(NSString*)getTwitter{
    return self.twitter;
}

-(NSString*)getWebsitename{
    return self.websitename;
}

-(NSString*)getWebsiteurl{
    return self.websiteurl;
}

-(Image*)getImage{
    return self.img;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.user forKey:@"user"];
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeObject:self.info forKey:@"info"];
    [coder encodeObject:self.desc forKey:@"desc"];
    [coder encodeObject:self.email forKey:@"email"];
    [coder encodeObject:self.facebook forKey:@"facebook"];
    [coder encodeObject:self.twitter forKey:@"twitter"];
    [coder encodeObject:self.websitename forKey:@"websitename"];
    [coder encodeObject:self.websiteurl forKey:@"websiteurl"];
    [coder encodeObject:self.img forKey:@"image"];
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super init];
    self.user = [[coder decodeObjectForKey:@"user"] copy];
    self.name = [[coder decodeObjectForKey:@"name"] copy];
    self.desc = [[coder decodeObjectForKey:@"desc"] copy];
    self.info = [[coder decodeObjectForKey:@"info"] copy];
    self.email = [[coder decodeObjectForKey:@"email"] copy];
    self.facebook = [[coder decodeObjectForKey:@"facebook"] copy];
    self.twitter = [[coder decodeObjectForKey:@"twitter"] copy];
    self.websitename = [[coder decodeObjectForKey:@"websitename"] copy];
    self.websiteurl = [[coder decodeObjectForKey:@"websiteurl"] copy];
    self.img = [coder decodeObjectForKey:@"image"];
    return self;
}

@end
