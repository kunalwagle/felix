//
//  Section.m
//  Felix
//
//  Created by Kunal Wagle on 20/12/2014.
//  Copyright (c) 2014 Felix. All rights reserved.
//

#import "Section.h"

@interface Section ()

@property int sid;
@property NSString *label;
@property NSString *cat;
@property NSString *email;
@property NSString *twitter;
@property NSMutableArray *users;

@end

@implementation Section

-(Section *)initFull: (int)sid label:(NSString*)label cat:(NSString*)cat email:(NSString*)email twitter:(NSString*)twitter users:(NSMutableArray *)users {
    self.sid = sid;
    self.label = label;
    self.cat = cat;
    self.email = email;
    self.twitter = twitter;
    self.users = users;
    return self;
}

-(int)getId {
    return self.sid;
}

-(NSString*)getLabel {
    return self.label;
}

-(NSString*)getCat {
    return self.cat;
}

-(NSString*)getEmail {
    return self.email;
}

-(NSString*)getTwitter {
    return self.twitter;
}

-(NSMutableArray*)getUser{
    return self.users;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeInt:self.sid forKey:@"sid"];
    [coder encodeObject:self.label forKey:@"label"];
    [coder encodeObject:self.cat forKey:@"cat"];
    [coder encodeObject:self.twitter forKey:@"twitter"];
    [coder encodeObject:self.email forKey:@"email"];
    [coder encodeObject:self.users forKey:@"users"];
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [self init];
    self.email = [coder decodeObjectForKey:@"email"];
    self.sid = [coder decodeIntForKey:@"sid"];
    self.twitter = [coder decodeObjectForKey:@"twitter"];
    self.label = [coder decodeObjectForKey:@"label"];
    self.cat = [coder decodeObjectForKey:@"cat"];
    self.users = [coder decodeObjectForKey:@"users"];
    return self;
}

@end
