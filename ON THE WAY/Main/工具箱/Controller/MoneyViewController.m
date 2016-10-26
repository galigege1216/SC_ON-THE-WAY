//
//  MoneyViewController.m
//  ON THE WAY
//
//  Created by Apple on 16/10/17.
//  Copyright © 2016年 qtw. All rights reserved.
//

#import "MoneyViewController.h"

@interface MoneyViewController ()<UITextFieldDelegate>

@end

@implementation MoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _CNYtextField.delegate = self;
    _DollarTextField.delegate = self;
    _EuroTextFiled.delegate = self;
    _KRWtextField.delegate = self;
    _THBtextField.delegate = self;
    
    [_CNYtextField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [_DollarTextField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [_EuroTextFiled addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [_KRWtextField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [_THBtextField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
}

- (void)textFieldChanged:(UITextField *)textField{
    CGFloat much = [textField.text floatValue];
    if (_CNYtextField == textField) {
        [self exchangeWithCNY:much];
    }else if (_DollarTextField == textField) {
        [self exchangeWithDor:much];
    }else if (_EuroTextFiled == textField) {
        [self exchangeWithEur:much];
    }else if (_KRWtextField == textField) {
        [self exchangeWithKRW:much];
    }else if (_THBtextField == textField) {
        [self exchangeWithTHB:much];
    }
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([textField.text isEqualToString:@"0.00"]) {
        textField.text = nil;
    }
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [textField becomeFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)exchangeWithCNY:(CGFloat)much {
    CGFloat dor = much * 0.1484;
    CGFloat eur = much * 0.1351;
    CGFloat krw = much * 169.1320;
    CGFloat thb = much * 5.2353;
    _DollarTextField.text = [NSString stringWithFormat:@"%.2f",dor];
    _EuroTextFiled.text = [NSString stringWithFormat:@"%.2f",eur];
    _KRWtextField.text = [NSString stringWithFormat:@"%.2f",krw];
    _THBtextField.text = [NSString stringWithFormat:@"%.2f",thb];
}
- (void)exchangeWithDor:(CGFloat)much {
    CGFloat cny = much * 6.7390;
    CGFloat eur = much * 0.9076;
    CGFloat krw = much * 1133.2700;
    CGFloat thb = much * 35.1800;
    _CNYtextField.text = [NSString stringWithFormat:@"%.2f",cny];
    _EuroTextFiled.text = [NSString stringWithFormat:@"%.2f",eur];
    _KRWtextField.text = [NSString stringWithFormat:@"%.2f",krw];
    _THBtextField.text = [NSString stringWithFormat:@"%.2f",thb];
}
- (void)exchangeWithEur:(CGFloat)much {
    CGFloat dor = much * 1.1018;
    CGFloat cny = much * 7.4250;
    CGFloat krw = much * 1248.6369;
    CGFloat thb = much * 38.7613;
    _DollarTextField.text = [NSString stringWithFormat:@"%.2f",dor];
    _CNYtextField.text = [NSString stringWithFormat:@"%.2f",cny];
    _KRWtextField.text = [NSString stringWithFormat:@"%.2f",krw];
    _THBtextField.text = [NSString stringWithFormat:@"%.2f",thb];
}
- (void)exchangeWithKRW:(CGFloat)much {
    CGFloat dor = much * 0.0009;
    CGFloat cny = much * 0.0060;
    CGFloat eur = much * 0.0008;
    CGFloat thb = much * 0.0311;
    _DollarTextField.text = [NSString stringWithFormat:@"%.2f",dor];
    _CNYtextField.text = [NSString stringWithFormat:@"%.2f",cny];
    _EuroTextFiled.text = [NSString stringWithFormat:@"%.2f",eur];
    _THBtextField.text = [NSString stringWithFormat:@"%.2f",thb];
}
- (void)exchangeWithTHB:(CGFloat)much {
    CGFloat dor = much * 0.0284;
    CGFloat cny = much * 0.1916;
    CGFloat eur = much * 0.0258;
    CGFloat krw = much * 32.1907;
    _DollarTextField.text = [NSString stringWithFormat:@"%.2f",dor];
    _CNYtextField.text = [NSString stringWithFormat:@"%.2f",cny];
    _EuroTextFiled.text = [NSString stringWithFormat:@"%.2f",eur];
    _KRWtextField.text = [NSString stringWithFormat:@"%.2f",krw];
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
