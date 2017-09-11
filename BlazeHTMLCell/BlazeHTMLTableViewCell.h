//
//  BlazeTableViewCell.h
//  Blaze
//
//  Created by Bob de Graaf on 21-01-16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import <Blaze/BlazeTableViewCell.h>
#import <TTTAttributedLabel/TTTAttributedLabel.h>

@interface BlazeHTMLTableViewCell : BlazeTableViewCell
{
    
}

@property(nonatomic,strong) IBOutlet TTTAttributedLabel *htmlLabel;

@end
