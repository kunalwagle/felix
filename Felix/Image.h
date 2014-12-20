//
//  Image.h
//  Felix
//
//  Created by Kunal Wagle on 20/12/2014.
//  Copyright (c) 2014 Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Image : NSObject

-(int)getId;
-(NSString*)getTitle;
-(NSString*)getUrl;
-(NSString*)getFileName;
-(NSString*)getDesc;
-(NSString*)getCaption;
-(NSString*)getAttribution;
-(NSString*)getAttrlink;
-(int)getTimeStamp;
-(int)getWidth;
-(int)getHeight;

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
