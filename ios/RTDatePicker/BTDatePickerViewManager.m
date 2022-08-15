//
//  BTDatePickerViewManager.m
//  BTDatePicker
//
//  Created by milker90 on 2022/8/14.
//

#import "BTDatePickerViewManager.h"

@implementation BTDatePickerViewManager

RCT_ENUM_CONVERTER(
    UIDatePickerMode,
    (@{
      @"time" : @(UIDatePickerModeTime),
      @"date" : @(UIDatePickerModeDate),
      @"datetime" : @(UIDatePickerModeDateAndTime),
      @"countdown" : @(UIDatePickerModeCountDownTimer), // not supported yet
    }),
    UIDatePickerModeTime,
    integerValue)

RCT_EXPORT_MODULE()

RCT_EXPORT_VIEW_PROPERTY(date, double)
RCT_EXPORT_VIEW_PROPERTY(minimumDate, double)
RCT_EXPORT_VIEW_PROPERTY(maximumDate, double)
RCT_EXPORT_VIEW_PROPERTY(minuteInterval, NSInteger)
RCT_EXPORT_VIEW_PROPERTY(onChange, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(mode, UIDatePickerMode)

@end
