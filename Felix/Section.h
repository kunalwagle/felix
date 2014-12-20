//
//  Section.h
//  Felix
//
//  Created by Kunal Wagle on 20/12/2014.
//  Copyright (c) 2014 Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Section : NSObject

-(int)getId;
-(NSString*)getLabel;
-(NSString*)getCat;
-(NSString*)getEmail;
-(NSString*)getTwitter;

@property int sid;
@property NSString *label;
@property NSString *cat;
@property NSString *email;
@property NSString *twitter;

@end
