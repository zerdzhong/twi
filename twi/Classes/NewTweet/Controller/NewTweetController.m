//
//  NewTweetController.m
//  twi_iOS
//
//  Created by zerd on 15-1-28.
//  Copyright (c) 2015年 zerd. All rights reserved.
//

#import "NewTweetController.h"
#import "TweetTool.h"

#define ACCOUNT_MAX_CHARS 140

@interface NewTweetController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *addImageButton;
@property (weak, nonatomic) IBOutlet UIButton *atFriendButton;
@property (weak, nonatomic) IBOutlet UIButton *addtopicButton;
@property (weak, nonatomic) IBOutlet UIButton *addEmojiButton;
@property (weak, nonatomic) IBOutlet UIButton *addVideoButton;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolBarBottomConstraint;
@end

@implementation NewTweetController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(onPostTweet:)];
//    rightBtnItem.tintColor = [UIColor grayColor];
    rightBtnItem.enabled = NO;
    
    self.navigationItem.rightBarButtonItem = rightBtnItem;
    
    if (self.navigationItem.leftBarButtonItem == nil) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(onCloseNewTweet)];
    }
    
    [self.textView becomeFirstResponder];
    self.textView.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onCloseNewTweet{
    if (self.closeBlock) {
        self.closeBlock();
    }
}

#pragma mark- 发送微博

- (void)onPostTweet:(id)sender{
    __weak __typeof(self)weakSelf = self;
    [TweetTool postTweetWithContent:self.textView.text success:^(NSArray *resultArray) {
        MyLog(@"success");
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (strongSelf.closeBlock) {
            strongSelf.closeBlock();
        }
    } failure:^(NSError *error) {
        MyLog(@"failure");
    }];
}

#pragma mark- 监听输入

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSString *new = [textView.text stringByReplacingCharactersInRange:range withString:text];
    NSInteger res = ACCOUNT_MAX_CHARS - [new length];
    if(res >= 0){
        self.navigationItem.rightBarButtonItem.enabled = YES;
        return YES;
    } else {
        NSRange rg = {0,[text length] + res};
        if (rg.length > 0) {
            NSString *s = [text substringWithRange:rg];
            [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
        }
        return NO;
    }
}

#pragma mark- 键盘监听

- (void)onKeyboardWillShow:(NSNotification *)notification{
    NSValue *keyboardValue = [notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect frame = [keyboardValue CGRectValue];
    float height = frame.size.height;
    
    
    self.toolBarBottomConstraint.constant = height;
    [self.view setNeedsUpdateConstraints];
    
    // update constraints now so we can animate the change
    [self.view updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:0.4 animations:^{
        [self.view layoutIfNeeded];
    }];
    
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
