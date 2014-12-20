//
//  Section.m
//  Felix
//
//  Created by Kunal Wagle on 20/12/2014.
//  Copyright (c) 2014 Felix. All rights reserved.
//

#import "Section.h"

@implementation Section

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

@end
