//
//  Section.m
//  Felix
//
//  Created by Kunal Wagle on 20/12/2014.
//  Copyright (c) 2014 Felix. All rights reserved.
//

#import "Section.h"

@implementation Section

-(Section *)initFull: (int)sid label:(NSString*)label cat:(NSString*)cat email:(NSString*)email twitter:(NSString*)twitter {
    self.sid = sid;
    self.label = label;
    self.cat = cat;
    self.email = email;
    self.twitter = twitter;
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

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeInt:self.sid forKey:@"sid"];
    [coder encodeObject:self.label forKey:@"label"];
    [coder encodeObject:self.cat forKey:@"cat"];
    [coder encodeObject:self.twitter forKey:@"twitter"];
    [coder encodeObject:self.email forKey:@"email"];

}

- (id)initWithCoder:(NSCoder *)coder {
    self = [self init];
    self.email = [coder decodeObjectForKey:@"email"];
    self.sid = [coder decodeIntForKey:@"sid"];
    self.twitter = [coder decodeObjectForKey:@"twitter"];
    self.label = [coder decodeObjectForKey:@"label"];
    self.cat = [coder decodeObjectForKey:@"cat"];
    return self;
}

@end
