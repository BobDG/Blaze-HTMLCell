//
//  BlazeTableViewCell.m
//  Blaze
//
//  Created by Bob de Graaf on 21-01-16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import <DTCoreText/DTCoreText.h>

#import "BlazeHTMLRow.h"
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
            if (@available(iOS 13, *)) {
                //For iOS13, the . replacement is necessary because the systemFontOfSize returns a non-postscript fontname that DTCoreText can't handle...
                options[DTDefaultFontName] = [row.htmlFont.fontName stringByReplacingOccurrencesOfString:@"." withString:@""];
                options[DTDefaultFontFamily] = [row.htmlFont.familyName stringByReplacingOccurrencesOfString:@"." withString:@""];
            }
            else {
                options[DTDefaultFontName] = row.htmlFont.fontName;
                options[DTDefaultFontFamily] = row.htmlFont.familyName;
            }
            
            options[DTDefaultFontSize] = @(row.htmlFont.pointSize);
            if(row.htmlLineHeightMultiplier) {
                options[DTDefaultLineHeightMultiplier] = row.htmlLineHeightMultiplier;
            }
        }
        
        //iOS6 always
        options[DTUseiOS6Attributes] = @(YES);
        
        //Base URL
        if(row.htmlBaseURL) {
            options[NSBaseURLDocumentOption] = row.htmlBaseURL;
        }
        
        //Create attributed string
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:[[NSAttributedString alloc] initWithHTMLData:htmlData options:options documentAttributes:nil]];
        
        //Remove CTForegroundColorFromContext attribute or ahref-links are not colored right @see https://github.com/Cocoanetics/DTCoreText/issues/792
        [attributedString removeAttribute:@"CTForegroundColorFromContext" range:NSMakeRange(0, attributedString.length)];
        
        //Text-checking types
        NSTextCheckingTypes textCheckingTypes = 0;
        if(row.linkTapped) {
            textCheckingTypes = textCheckingTypes|NSTextCheckingTypeLink;
        }
        if(row.phoneNumberTapped) {
            textCheckingTypes = textCheckingTypes|NSTextCheckingTypePhoneNumber;
        }
        if(row.addressTapped) {
            textCheckingTypes = textCheckingTypes|NSTextCheckingTypeAddress;
        }
        self.htmlLabel.enabledTextCheckingTypes = textCheckingTypes;
                
        //For iOS13, the . replacement fixes that it uses different fonts but the resulting fonts are still incorrect. This fixes this...
        if (@available(iOS 13, *)) {
            [self changeAttributedString:attributedString font:row.htmlFont];
        }
        
        //Finally set it
        self.htmlLabel.text = attributedString;
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

#pragma mark - Fix fonts

-(void)changeAttributedString:(NSMutableAttributedString *)string font:(UIFont *)font {
    [string enumerateAttribute:NSFontAttributeName inRange:NSMakeRange(0, string.length) options:0 usingBlock:^(id  _Nullable value, NSRange range, BOOL * _Nonnull stop) {
        UIFont *oldFont = (UIFont *)value;
        UIFontDescriptor *newFontDescriptor = [[oldFont.fontDescriptor fontDescriptorWithFamily:font.familyName] fontDescriptorWithSymbolicTraits:oldFont.fontDescriptor.symbolicTraits];
        UIFont *newFont = [UIFont fontWithDescriptor:newFontDescriptor size:oldFont.pointSize];
        if(newFont) {
            [string removeAttribute:NSFontAttributeName range:range];
            [string addAttribute:NSFontAttributeName value:newFont range:range];
        }
    }];
}


@end



















































