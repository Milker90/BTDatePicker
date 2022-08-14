// BTDatePicker.m

#import "BTDatePickerFabric.h"
#import "BTDatePicker.h"
#import <React/RCTConvert.h>

#import <react/renderer/components/BTDatePickerComponents/ComponentDescriptors.h>
#import <react/renderer/components/BTDatePickerComponents/Props.h>
#import <react/renderer/components/BTDatePickerComponents/RCTComponentViewHelpers.h>
#import <react/renderer/components/BTDatePickerComponents/ShadowNodes.h>

#import "RCTFabricComponentsPlugins.h"

using namespace facebook::react;

@implementation RCTConvert (UIDatePicker)

//RCT_ENUM_CONVERTER(
//    UIDatePickerMode,
//    (@{
//      @"time" : @(UIDatePickerModeTime),
//      @"date" : @(UIDatePickerModeDate),
//      @"datetime" : @(UIDatePickerModeDateAndTime),
//      @"countdown" : @(UIDatePickerModeCountDownTimer), // not supported yet
//    }),
//    UIDatePickerModeDate,
//    integerValue)

+ (UIDatePickerMode)convertDateMode:(BTDatePickerViewMode)mode {
    switch (mode) {
        case facebook::react::BTDatePickerViewMode::Date:
            return UIDatePickerModeDate;
            break;
        case facebook::react::BTDatePickerViewMode::Time:
            return UIDatePickerModeTime;
            break;
        case facebook::react::BTDatePickerViewMode::Datetime:
            return UIDatePickerModeDateAndTime;
            break;
        default:
            return UIDatePickerModeDate;
            break;
    }
}

@end

@interface BTDatePickerFabric()<RCTComponentViewProtocol>

@property (nonatomic, strong) BTDatePicker *datePicker;

@end

@implementation BTDatePickerFabric

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        static const auto defaultProps = std::make_shared<const BTDatePickerViewProps>();
        _props = defaultProps;
    }
    return self;
}

- (void)didChange {
    auto payload = (BTDatePickerViewEventEmitter::OnChange){
        .timestamp =  _datePicker.date.timeIntervalSince1970 * 1000.0
    };
    std::static_pointer_cast<BTDatePickerViewEventEmitter const>(_eventEmitter)->onChange(payload);
}

- (BTDatePicker *)datePicker {
    if (!_datePicker) {
        _datePicker = [[BTDatePicker alloc] init];
        [_datePicker addTarget:self action:@selector(didChange)
                   forControlEvents:UIControlEventValueChanged];
    }
    return _datePicker;
}

#pragma - RCTComponentViewProtocol
+ (ComponentDescriptorProvider)componentDescriptorProvider {
    return concreteComponentDescriptorProvider<BTDatePickerViewComponentDescriptor>();
}

- (void)updateProps:(facebook::react::Props::Shared const &)props
           oldProps:(facebook::react::Props::Shared const &)oldProps {
    
    if (!self.datePicker.superview) {
        self.contentView = self.datePicker;
    }
    
    const auto &oldViewProps = *std::static_pointer_cast<BTDatePickerViewProps const>(_props);
    const auto &newViewProps = *std::static_pointer_cast<BTDatePickerViewProps const>(props);
    
    UIDatePickerMode mode = [RCTConvert convertDateMode:newViewProps.mode];
    if (oldViewProps.mode != newViewProps.mode || mode != _datePicker.datePickerMode) {
        _datePicker.datePickerMode = [RCTConvert convertDateMode:newViewProps.mode];
    }

    if (oldViewProps.date != newViewProps.date) {
        _datePicker.date = [NSDate dateWithTimeIntervalSince1970:newViewProps.date];
    }

    if (oldViewProps.minimumDate != newViewProps.minimumDate) {
        _datePicker.minimumDate = [NSDate dateWithTimeIntervalSince1970:newViewProps.minimumDate];
    }
    
    if (oldViewProps.maximumDate != newViewProps.maximumDate) {
        _datePicker.maximumDate = [NSDate dateWithTimeIntervalSince1970:newViewProps.maximumDate];
    }
    
    if (oldViewProps.minuteInterval != newViewProps.minuteInterval) {
        _datePicker.minuteInterval = newViewProps.minuteInterval;
    }
    
    [super updateProps:props oldProps:oldProps];
}

- (void)mountChildComponentView:(UIView<RCTComponentViewProtocol> *)childComponentView index:(NSInteger)index {
    self.contentView = self.datePicker;
}

- (void)unmountChildComponentView:(UIView<RCTComponentViewProtocol> *)childComponentView index:(NSInteger)index {
    
}

- (void)prepareForRecycle {
    [super prepareForRecycle];
    self.contentView = nil;
    self.datePicker = nil;
    static const auto defaultProps = std::make_shared<const BTDatePickerViewProps>();
    _props = defaultProps;
}


@end

Class<RCTComponentViewProtocol> BTDatePickerViewCls(void)
{
  return BTDatePickerFabric.class;
}
