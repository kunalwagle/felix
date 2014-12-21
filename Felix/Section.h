//
//  Section.h
//  Felix
//
//  Created by Kunal Wagle on 20/12/2014.
//  Copyright (c) 2014 Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Section : NSObject <NSCoding>

-(Section *)initFull: (int)sid label:(NSString*)label cat:(NSString*)cat email:(NSString*)email twitter:(NSString*)twitter;
-(int)getId;
-(NSString*)getLabel;
-(NSString*)getCat;
-(NSString*)getEmail;
-(NSString*)getTwitter;


@end
