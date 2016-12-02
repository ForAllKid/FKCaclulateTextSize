//
//  ViewController.m
//  FKJianShuDemo_caclulateTextSize
//
//  Created by 周宏辉 on 2016/12/2.
//  Copyright © 2016年 ForKid. All rights reserved.
//

#import "ViewController.h"

#ifndef FK_W_H_
#define kWidth  [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#endif


@interface ViewController ()

@property (nonatomic, strong) UILabel *testLabel1;

@property (nonatomic, strong) UILabel *testLabel2;

@property (nonatomic, strong) UILabel *testLabel3;

@end

static NSString *const kTestString1 = @"我的发小苏禾是兜兜转转一圈后嫁给梁凯的我的发小苏禾是兜兜转转一圈后，嫁给梁凯的。";

static NSString *const kTestString2 = @"我的发小苏禾是兜兜转转一圈后，嫁给梁凯的。读书的时候，梁凯暗恋苏禾。可苏禾是班花呀，身边围着一堆男生，梁凯有点不起眼。关于喜欢的话，梁凯从来没敢说出口。毕业后，苏禾考了公务员。工作稳定，人又漂亮，走到哪都是风景。遗憾的是，她始终没有遇到可以尘埃落定的良人。谈了一场又一场恋爱后，渐渐有些心灰意冷";


static NSString *const kTestTitle = @"这是一个测试标题\n\n";

static NSString *const kTestString3 = @"我的发小苏禾是兜兜转转一圈后，嫁给梁凯的。读书的时候，梁凯暗恋苏禾。可苏禾是班花呀，身边围着一堆男生，梁凯有点不起眼。关于喜欢的话，梁凯从来没敢说出口。毕业后，苏禾考了公务员。工作稳定，人又漂亮，走到哪都是风景。遗憾的是，她始终没有遇到可以尘埃落定的良人。谈了一场又一场恋爱后，渐渐有些心灰意冷\n\n我的发小苏禾是兜兜转转一圈后，嫁给梁凯的。读书的时候，梁凯暗恋苏禾。可苏禾是班花呀，身边围着一堆男生，梁凯有点不起眼。关于喜欢的话，梁凯从来没敢说出口。毕业后，苏禾考了公务员。工作稳定，人又漂亮，走到哪都是风景。遗憾的是，她始终没有遇到可以尘埃落定的良人。谈了一场又一场恋爱后，渐渐有些心灰意冷";


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    [self caclulateWithRichText];

}


#pragma mark -- functions

-(void)calulateWithSizeWithFont{
    CGSize textSize1 = [kTestString1 sizeWithAttributes:@{NSFontAttributeName:self.testLabel1.font}];
    self.testLabel1.text = kTestString1;
    self.testLabel1.frame = CGRectMake(0, 100, textSize1.width, textSize1.height);
    [self.view addSubview:self.testLabel1];
}

-(void)caclulateWithBoundingRect{
    CGSize textSize2 = [kTestString2 boundingRectWithSize:CGSizeMake(kWidth - 20, CGFLOAT_MAX)
                                                  options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                                               attributes:@{NSFontAttributeName:self.testLabel2.font}
                                                  context:nil].size;
    self.testLabel2.text = kTestString2;
    self.testLabel2.frame = CGRectMake(10, 200, textSize2.width, textSize2.height);
    [self.view addSubview:self.testLabel2];
}


-(void)caclulateWithRichText{
    //1 创建一个attributeString
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] init];
    
    //标题
    NSRange titleRange = NSMakeRange(0, kTestTitle.length);
    
    NSMutableAttributedString *titleAttributeString = [[NSMutableAttributedString alloc] initWithString:kTestTitle];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    [titleAttributeString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:titleRange];
    [titleAttributeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:18.f] range:titleRange];

    [attributeString appendAttributedString:titleAttributeString];
    
    
    
    //内容
    NSRange contentRange = NSMakeRange(0, kTestString3.length);
    
    NSMutableAttributedString *contentAttributeString = [[NSMutableAttributedString alloc] initWithString:kTestString3];

    NSMutableParagraphStyle *contentParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    contentParagraphStyle.lineSpacing = 10.f;
    
    [contentAttributeString addAttribute:NSParagraphStyleAttributeName value:contentParagraphStyle range:contentRange];
    [contentAttributeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.f] range:contentRange];
    [contentAttributeString addAttribute:NSKernAttributeName value:@(1) range:contentRange];
    
    [attributeString appendAttributedString:contentAttributeString];
    
    
    //计算标题size
    
    CGSize size = CGSizeMake(kWidth - 20, CGFLOAT_MAX);
    NSDictionary *titleAttribute = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:18.f], NSParagraphStyleAttributeName:paragraphStyle};
    CGSize titleSize = [kTestTitle boundingRectWithSize:size
                                                options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                                             attributes:titleAttribute
                                                context:nil].size;
    
    
    //计算内容size
    NSDictionary *contentAttribute = @{NSFontAttributeName:[UIFont systemFontOfSize:14.f],
                                       NSParagraphStyleAttributeName:contentParagraphStyle,
                                       NSKernAttributeName:@(1)};
    CGSize contentSize = [kTestString3 boundingRectWithSize:size
                                                options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                                             attributes:contentAttribute
                                                context:nil].size;
    

    self.testLabel3.attributedText = attributeString;
    self.testLabel3.frame = CGRectMake(10, 100, size.width, titleSize.height + contentSize.height);
    [self.view addSubview:self.testLabel3];
    
    
}



-(UILabel *)testLabel1{
    if (!_testLabel1) {
        _testLabel1 = [[UILabel alloc] init];
        _testLabel1.numberOfLines = 0;
        _testLabel1.backgroundColor = [UIColor lightGrayColor];
        _testLabel1.font = [UIFont systemFontOfSize:14.f];
    }
    return _testLabel1;
}


-(UILabel *)testLabel2{
    if (!_testLabel2) {
        _testLabel2 = [[UILabel alloc] init];
        _testLabel2.numberOfLines = 0;
        _testLabel2.backgroundColor = [UIColor lightGrayColor];
        _testLabel2.font = [UIFont systemFontOfSize:14.f];
    }
    return _testLabel2;
}


-(UILabel *)testLabel3{
    if (!_testLabel3) {
        _testLabel3 = [[UILabel alloc] init];
        _testLabel3.numberOfLines = 0;
        _testLabel3.backgroundColor = [UIColor lightGrayColor];
    }
    return _testLabel3;
}







@end
