//
//  BlazeTableViewCell.m
//  Blaze
//
//  Created by Bob de Graaf on 21-01-16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import "BlazeHTMLRow.h"
#import "TTTAttributedLabel.h"
#import "DTCoreText/DTCoreText.h"
#import "BlazeHTMLTableViewCell.h"

@interface BlazeHTMLTableViewCell () <TTTAttributedLabelDelegate>
{
    
}

@end

@implementation BlazeHTMLTableViewCell

#pragma mark - Update

-(void)updateCell
{
    //Get html row
    BlazeHTMLRow *row = (BlazeHTMLRow *)self.row;
    
    //Title
    if(row.htmlString.length) {
        //Data
        NSData *htmlData = [row.htmlString dataUsingEncoding:NSUTF8StringEncoding];
        
        //Options
        NSMutableDictionary *options = [NSMutableDictionary new];
        if(row.htmlTextColor) {
            options[DTDefaultTextColor] = row.htmlTextColor;
        }
        if(row.htmlFont) {
            options[DTDefaultFontName] = row.htmlFont.fontName;
            options[DTDefaultFontFamily] = row.htmlFont.familyName;
            options[DTDefaultFontSize] = @(row.htmlFont.pointSize);
        }
        
        //iOS6 always
        options[DTUseiOS6Attributes] = @(YES);
        
        //Base URL
        if(row.htmlBaseURL) {
            options[NSBaseURLDocumentOption] = row.htmlBaseURL;
        }
        
        //Set the text
        self.htmlLabel.text = [[NSMutableAttributedString alloc] initWithAttributedString:[[NSAttributedString alloc] initWithHTMLData:htmlData options:options documentAttributes:nil]];
    }
    
    //Attributes
    if(row.htmlLinkAttributes) {
        self.htmlLabel.linkAttributes = row.htmlLinkAttributes;
    }
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    //Delegate
    self.htmlLabel.delegate = self;
    
    //Performance boost
    self.htmlLabel.extendsLinkTouchArea = FALSE;
    
    //Text checking types - only link, address & phonenumber for now
    self.htmlLabel.enabledTextCheckingTypes = NSTextCheckingTypeLink|NSTextCheckingTypeAddress|NSTextCheckingTypePhoneNumber;
}

#pragma mark - TTTAttributedLabelDelegate

-(void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url
{
    BlazeHTMLRow *row = (BlazeHTMLRow *)self.row;
    if(row.linkTapped) {
        row.linkTapped(url);
    }
}

-(void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithAddress:(NSDictionary *)addressComponents
{
    BlazeHTMLRow *row = (BlazeHTMLRow *)self.row;
    if(row.addressTapped) {
        row.addressTapped(addressComponents);
    }
}

-(void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithPhoneNumber:(NSString *)phoneNumber
{
    BlazeHTMLRow *row = (BlazeHTMLRow *)self.row;
    if(row.phoneNumberTapped) {
        row.phoneNumberTapped(phoneNumber);
    }
}


@end



















































