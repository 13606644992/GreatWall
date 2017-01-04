//
//  PersonalViewController.h
//  GreatWall
//
//  Created by GJ on 2016/12/21.
//  Copyright © 2016年 GJ. All rights reserved.
//

#import "RootViewController.h"

@interface PersonalViewController : RootViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong)UIImage *headerIMG;
@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UILabel *sexLabel;
@property (nonatomic, strong)UILabel *numberLabel;
@property (nonatomic, strong)UILabel *emailLabel;
@property (nonatomic, strong)UIImagePickerController *pickerImage ;
@property (nonatomic, strong)UILabel *renzhengLabel;
@end
