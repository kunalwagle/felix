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
@property UIImage *image;

@end

@implementation Image

-(Image *)initFull: (int)iid title:(NSString*)title url:(NSString*)url fileName:(NSString*)fileName desc:(NSString*)desc timeStamp:(int)timeStamp caption:(NSString*)caption attribution:(NSString*)attribution attr_link:(NSString*)attr_link width:(int)width height:(int)height image:(UIImage*)image {
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
    self.image = image;
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

-(UIImage*)getImage {
    return self.image;
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
    [coder encodeObject:self.image forKey:@"image"];
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [self init];
    self.title = [coder decodeObjectForKey:@"title"];
    self.fileName = [coder decodeObjectForKey:@"fileName"];
    self.iid = [coder decodeIntForKey:@"iid"];
    self.width = [coder decodeIntForKey:@"width"];
    self.height = [coder decodeIntForKey:@"height"];
    self.timeStamp = [coder decodeIntForKey:@"timeStamp"];
    self.desc = [coder decodeObjectForKey:@"desc"];
    self.caption = [coder decodeObjectForKey:@"caption"];
    self.attribution = [coder decodeObjectForKey:@"attribution"];
    self.attr_link = [coder decodeObjectForKey:@"attr_link"];
    self.url = [coder decodeObjectForKey:@"url"];
    self.image = [coder decodeObjectForKey:@"image"];
    return self;
}

@end
