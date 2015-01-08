//
//  Image.m
//  Felix
//
//  Created by Kunal Wagle on 20/12/2014.
//  Copyright (c) 2014 Felix. All rights reserved.
//

#import "Image.h"

@interface Image ()

@property int iid;
@property NSString *title;
@property NSString *url;
@property NSString *fileName;
@property NSString *desc;
@property int timeStamp;
@property NSString *caption;
@property NSString *attribution;
@property NSString *attr_link;
@property int width;
@property int height;

@end

@implementation Image

-(Image *)initFull: (int)iid title:(NSString*)title url:(NSString*)url fileName:(NSString*)fileName desc:(NSString*)desc timeStamp:(int)timeStamp caption:(NSString*)caption attribution:(NSString*)attribution attr_link:(NSString*)attr_link width:(int)width height:(int)height {
    self.iid = iid;
    self.title = title;
    self.url = url;
    self.fileName = fileName;
    self.desc = desc;
    self.timeStamp = timeStamp;
    self.caption = caption;
    self.attribution = attribution;
    self.attr_link = attr_link;
    self.width = width;
    self.height = height;
    return self;
}

-(int)getId {
    return self.iid;
}

-(NSString*)getTitle {
    return self.title;
}
-(NSString*)getUrl {
    return self.url;
}

-(NSString*)getFileName {
    return self.fileName;
}

-(NSString*)getDesc {
    return self.desc;
}

-(NSString*)getCaption {
    return self.caption;
}

-(NSString*)getAttribution {
    return self.attribution;
}

-(NSString*)getAttrlink {
    return self.attr_link;
}

-(int)getTimeStamp {
    return self.timeStamp;
}

-(int)getWidth {
    return self.width;
}

-(int)getHeight {
    return self.height;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.title forKey:@"title"];
    [coder encodeObject:self.fileName forKey:@"fileName"];
    [coder encodeInt:self.iid forKey:@"iid"];
    [coder encodeInt:self.width forKey:@"width"];
    [coder encodeInt:self.height forKey:@"height"];
    [coder encodeInt:self.timeStamp forKey:@"timeStamp"];
    [coder encodeObject:self.desc forKey:@"desc"];
    [coder encodeObject:self.caption forKey:@"caption"];
    [coder encodeObject:self.attribution forKey:@"attribution"];
    [coder encodeObject:self.attr_link forKey:@"attr_link"];
    [coder encodeObject:self.url forKey:@"url"];
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super init];
    self.title = [[coder decodeObjectForKey:@"title"] copy];
    self.fileName = [[coder decodeObjectForKey:@"fileName"] copy];
    self.iid = [coder decodeIntForKey:@"iid"];
    self.width = [coder decodeIntForKey:@"width"];
    self.height = [coder decodeIntForKey:@"height"];
    self.timeStamp = [coder decodeIntForKey:@"timeStamp"];
    self.desc = [[coder decodeObjectForKey:@"desc"] copy];
    self.caption = [[coder decodeObjectForKey:@"caption"] copy];
    self.attribution = [[coder decodeObjectForKey:@"attribution"] copy];
    self.attr_link = [[coder decodeObjectForKey:@"attr_link"] copy];
    self.url = [[coder decodeObjectForKey:@"url"] copy];
    return self;
}

@end
