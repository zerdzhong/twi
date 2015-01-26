//
//  PictureListItem.m
//  微博
//
//  Created by zerd on 14-11-11.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "PictureListItem.h"
#import "HttpTool.h"


@interface PictureListItem ()

@property (nonatomic, strong) UIImageView *gifView;
@property (nonatomic, copy) TapBlock tapBlock;

@end

@implementation PictureListItem

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _gifView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timeline_image_gif.png"]];
        self.userInteractionEnabled = YES;
        [self addSubview:_gifView];
    }
    
    return self;
}


-(void)setUrl:(NSString *)url{
    
    _url = url;
    
    //加载图片
    
    [HttpTool loadImageView:self withUrl:[NSURL URLWithString: url] place:[UIImage imageNamed:@"timeline_image_loading.png"]];

    //判断图片类型
    _gifView.hidden = ![url.lowercaseString hasSuffix:@"gif"];
    
}

- (void)setFrame:(CGRect)frame{
    //设置gif frame
    
    CGRect gifFrame = _gifView.frame;
    gifFrame.origin.x = frame.size.width - gifFrame.size.width;
    gifFrame.origin.y = frame.size.height - gifFrame.size.height;
    _gifView.frame = gifFrame;
    
    [super setFrame:frame];
}

- (void)addTapBlock:(TapBlock)tapBlcok{
    _tapBlock = tapBlcok;
    if (![self gestureRecognizers]) {
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [self addGestureRecognizer:tap];
    }
}

- (void)tap{
    if (self.tapBlock) {
        self.tapBlock(self);
    }
}

@end
