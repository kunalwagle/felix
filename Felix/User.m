//
//  User.m
//  Felix
//
//  Created by Kunal Wagle on 20/12/2014.
//  Copyright (c) 2014 Felix. All rights reserved.
//

#import "User.h"

@implementation User

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
    self = [self init];
    self.user = [coder decodeObjectForKey:@"user"];
    self.name = [coder decodeObjectForKey:@"name"];
    self.desc = [coder decodeObjectForKey:@"desc"];
    self.info = [coder decodeObjectForKey:@"info"];
    self.email = [coder decodeObjectForKey:@"email"];
    self.facebook = [coder decodeObjectForKey:@"facebook"];
    self.twitter = [coder decodeObjectForKey:@"twitter"];
    self.websitename = [coder decodeObjectForKey:@"websitename"];
    self.websiteurl = [coder decodeObjectForKey:@"websiteurl"];
    self.img = [coder decodeObjectForKey:@"image"];
    return self;
}

@end
