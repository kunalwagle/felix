//
//  Image.m
//  Felix
//
//  Created by Kunal Wagle on 20/12/2014.
//  Copyright (c) 2014 Felix. All rights reserved.
//

#import "Image.h"

@implementation Image

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
