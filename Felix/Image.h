//
//  Image.h
//  Felix
//
//  Created by Kunal Wagle on 20/12/2014.
//  Copyright (c) 2014 Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Image : NSObject

-(Image *)initFull: (int)iid title:(NSString*)title url:(NSString*)url fileName:(NSString*)fileName desc:(NSString*)desc timeStamp:(int)timeStamp caption:(NSString*)caption attribution:(NSString*)attribution attr_link:(NSString*)attr_link width:(int)width height:(int)height image:(UIImage*)image;
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
-(UIImage*)getImage;



@end
