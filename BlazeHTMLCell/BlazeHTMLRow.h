//
//  BlazeRow.h
//  Blaze
//
//  Created by Bob de Graaf on 16-04-15.
//  Copyright (c) 2015 GraafICT. All rights reserved.
//

@import Blaze;

@interface BlazeHTMLRow : BlazeRow
{
    
}

@property(nonatomic,strong) UIFont *htmlFont;
@property(nonatomic,strong) NSURL *htmlBaseURL;
@property(nonatomic,strong) NSString *htmlString;
@property(nonatomic,strong) UIColor *htmlTextColor;
@property(nonatomic,strong) NSDictionary *htmlLinkAttributes;

@property(nonatomic,copy) void (^linkTapped)(NSURL *url);
@property(nonatomic,copy) void (^addressTapped)(NSDictionary *addressComponents);
@property(nonatomic,copy) void (^phoneNumberTapped)(NSString *phoneNumber);

@end
