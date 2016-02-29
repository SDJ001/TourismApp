//
//  SignatureViewController.m
//  TourismProject
//
//  Created by 鲁东阳 on 16/1/29.
//  Copyright © 2016年 鲁东阳. All rights reserved.
//

#import "SignatureViewController.h"
#import "PlaceholderTextView.h"

#define kTextBorderColor     RGBCOLOR(227,224,216)

#undef  RGBCOLOR
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

@interface SignatureViewController ()<UITextViewDelegate>

@property (nonatomic, strong) PlaceholderTextView * textView;


@end

@implementation SignatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:229.0/255 green:229.0/255 blue:229.0/255 alpha:1.0f];
    
    [self.view addSubview:self.textView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"上传" style:(UIBarButtonItemStylePlain) target:self action:@selector(rightAction:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"iconfont-fanhui-2"] style:(UIBarButtonItemStylePlain) target:self action:@selector(returnAction:)];
    self.navigationItem.title = @"个性签名";
    
    
}
//返回页面
- (void)returnAction:(UIBarButtonItem *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}
//上传签名
- (void)rightAction:(UIBarButtonItem *)sender{
    
    NSLog(@"%@",self.textView.text);
    [[AVUser currentUser]setObject:self.textView.text forKey:@"signature"];
    [[AVUser currentUser] saveInBackground];
    
    
    
    
}
-(PlaceholderTextView *)textView{
    
    if (!_textView) {
        _textView = [[PlaceholderTextView alloc]initWithFrame:CGRectMake(20, 84,[UIScreen mainScreen].bounds.size.width - 40, 200)];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.delegate = self;
        _textView.font = [UIFont systemFontOfSize:14.f];
        _textView.textColor = [UIColor blackColor];
        _textView.textAlignment = NSTextAlignmentLeft;
        _textView.editable = YES;
        _textView.layer.cornerRadius = 4.0f;
        _textView.layer.borderColor = kTextBorderColor.CGColor;
        _textView.layer.borderWidth = 0.5;
        _textView.placeholderColor = RGBCOLOR(0x89, 0x89, 0x89);
        _textView.placeholder = @"描述一下你自己吧";
    }
    
    return _textView;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([@"\n" isEqualToString:text] == YES)
    {
        [textView resignFirstResponder];
        
        
        return NO;
    }
    
    return YES;
}



- (UIColor *)colorWithRGBHex:(UInt32)hex
{
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
