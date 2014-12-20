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

@end
