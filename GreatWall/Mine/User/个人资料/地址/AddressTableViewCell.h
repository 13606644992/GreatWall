//
//  AddressTableViewCell.h
//  GreatWall
//
//  Created by GJ on 2017/1/20.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressTableViewCell : UITableViewCell
@property (nonatomic, strong)UILabel *name;
@property (nonatomic, strong)UILabel *phoneNum;
@property (nonatomic, strong)UILabel *address;
@property (nonatomic, copy)NSString *addressString;
@property (nonatomic, strong)UILabel *moren;
@property (nonatomic, strong)UILabel *bianji;
@property (nonatomic, strong)UILabel *shanchu;
@property (nonatomic, strong)UIImageView *selectIMG;
@property (nonatomic, strong)UIButton *selectBtn;
@property (nonatomic, strong)UIImageView *bianjiIMG;
@property (nonatomic, strong)UIImageView *shanchuIMG;
@property (nonatomic, strong)NSString *cneeId;

@property (nonatomic, strong)UIView *line;
@property (nonatomic, strong)UIButton *shanchuBtn;
@property (nonatomic, strong)UIButton *bianjiBtn;

@end
