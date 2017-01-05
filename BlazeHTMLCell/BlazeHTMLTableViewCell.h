//
//  BlazeTableViewCell.h
//  Blaze
//
//  Created by Bob de Graaf on 21-01-16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

@import Blaze;
@import DTCoreText;
@import TTTAttributedLabel;

@interface BlazeHTMLTableViewCell : BlazeTableViewCell
{
    
}

@property(nonatomic,strong) IBOutlet TTTAttributedLabel *htmlLabel;

@end
