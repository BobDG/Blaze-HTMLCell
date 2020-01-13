//
//  ViewController.m
//  Example
//
//  Created by Bob de Graaf on 05-01-17.
//  Copyright © 2017 GraafICT. All rights reserved.
//

#import "BDGMacros.h"
#import "BlazeHTMLRow.h"
#import "ViewController.h"

#define XIBHTMLCell             @"HTMLTableViewCell"

@interface ViewController ()
{
    
}

@property(nonatomic,strong) NSString *htmlString;

@end

@implementation ViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    /*
    self.htmlString = @"<h1>Html cells are awesome</h1><p>This is an awesome feature. HTML-string generated wih high speed, rich text formatting such as <b>Bold</b>, <u>underlined</u>, <i>italic</i>.</p></br>"
    "<p>Of course, bullet lists as well</p><ul><li>Bullet list 1 with a lot of text to show the automatic indent will also work perfectly :)</li><li>Bullet list 2</li><li>Bullet list 3</li><br/>"
    "<h2>Least but not last, links work! (with custom colors)</h2>"
    "Websites: www.github.com/BobDG/Blaze<br/>"
    "Phone-numbers: +31624645787<br/>"
    "Addresses: Apple Campus, Cupertino, CA 95014, USA";
     */
    
    self.navigationItem.title = @"Blaze HTML Cell";    
    self.htmlString = @"<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\" \"http://www.w3.org/TR/REC-html40/loose.dtd\"><html><body><p><strong>How to use it?</strong></p><p>1: Open the bike entrance on the Oude Achtergracht with your white pass. How to use it?</p><p>2: Walk with that iron beast to -1 on the right side.</p><p>3: Park your bike into one of the parking spots.</p><p><br>Easy does it!</p><p><strong>Want to leave your second home a.k.a. Capital C?</strong></p><p>1: Get your bike and place your front wheel on the assembly line.</p><p>2: The system is activated once the front wheel is on assembly line.</p><p>3: Squeeze your brake and walk with your bike up.</p><p>Driiiive towards freedom!&nbsp;</p></body></html>";

    [self loadTableContent];
}

-(void)loadTableContent
{
    //Clear
    [self.tableArray removeAllObjects];
    
    //Section
    BlazeSection *section = [BlazeSection new];
    [self.tableArray addObject:section];
    
    //Row Label
    BlazeHTMLRow *htmlRow = [BlazeHTMLRow rowWithXibName:XIBHTMLCell];
    htmlRow.htmlString = self.htmlString;
    //htmlRow.htmlFont = [UIFont systemFontOfSize:17.0f weight:UIFontWeightRegular];
    htmlRow.htmlFont = [UIFont systemFontOfSize:15.0f];
    htmlRow.htmlTextColor = UIColorFromRGB(0x4A4A4A);
    //htmlRow.htmlTextColor = [UIColor grayColor];
    htmlRow.htmlLinkAttributes = @{NSForegroundColorAttributeName:UIColorFromRGB(0xf8a19a)};
    [htmlRow setLinkTapped:^(NSURL *url) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    }];
    [htmlRow setPhoneNumberTapped:^(NSString *phoneNumber) {
        [self showMessage:phoneNumber];
    }];
    [htmlRow setAddressTapped:^(NSDictionary *address) {
        [self showMessage:[NSString stringWithFormat:@"%@", address]];
    }];
    [section addRow:htmlRow];
    
    //Reload
    [self.tableView reloadData];
}

-(void)showMessage:(NSString *)message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Do something" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {}]];
    [self presentViewController:alertController animated:TRUE completion:nil];
    CFRunLoopWakeUp(CFRunLoopGetCurrent());
}


@end










