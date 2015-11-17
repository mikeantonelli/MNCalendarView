//
//  MNCalendarHeaderView.m
//  MNCalendarView
//
//  Created by Min Kim on 7/26/13.
//  Copyright (c) 2013 min. All rights reserved.
//

#import "MNCalendarHeaderView.h"
#define kMNCalendarHeaderViewButtonWidth 44.0f

NSString *const MNCalendarHeaderViewIdentifier = @"MNCalendarHeaderViewIdentifier";

@interface MNCalendarHeaderView()

@property(nonatomic,strong,readwrite) UILabel *titleLabel;
@property(nonatomic,strong,readwrite) UIButton *previousButton;
@property(nonatomic,strong,readwrite) UIButton *nextButton;

@end

@implementation MNCalendarHeaderView

- (id)initWithFrame:(CGRect)frame
{
  if (self = [super initWithFrame:frame])
  {
      [self prepareUI:frame];
  }
  return self;
}

- (void)setDate:(NSDate *)date {
  _date = date;

    [self setupButtons:self.bounds];
}

- (void)setDelegate:(id<MNCalendarHeaderViewDelegate>)delegate
{
    _delegate = delegate;
    
    [self prepareUI:self.bounds];
}

- (void)prepareUI:(CGRect)frame
{
    [self setupTitleLabel:frame];
    [self setupButtons:frame];
}

- (void)setupTitleLabel:(CGRect)frame
{
    if (self.titleLabel)
    {
        [self.titleLabel removeFromSuperview];
        self.titleLabel = nil;
    }
    
    CGRect titleFrame = frame;
    titleFrame.size.width -= kMNCalendarHeaderViewButtonWidth*2;
    titleFrame.origin.x += kMNCalendarHeaderViewButtonWidth;
    
    self.titleLabel = [[UILabel alloc] initWithFrame:titleFrame];
    self.titleLabel.backgroundColor = UIColor.clearColor;
    self.titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.titleLabel.font = [UIFont systemFontOfSize:16.f];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:self.titleLabel];
}

- (void)setupButtons:(CGRect)frame
{
    [self setupPreviousButton:frame];
    [self setupNextButton:frame];
}

- (void)setupPreviousButton:(CGRect)frame
{
    if (self.previousButton)
    {
        [self.previousButton removeFromSuperview];
        self.previousButton = nil;
    }
    
    CGRect previousButtonFrame = frame;
    previousButtonFrame.origin.x = kMNCalendarHeaderViewButtonWidth;
    previousButtonFrame.size.width = kMNCalendarHeaderViewButtonWidth;
    
    self.previousButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.previousButton.frame = previousButtonFrame;
    self.previousButton.backgroundColor = UIColor.clearColor;
    [self.previousButton setImage:[self imageForPreviousButton] forState:UIControlStateNormal];
    self.previousButton.enabled = [self shouldEnablePreviousButton];
    
    [self.previousButton addTarget:self
                        action:@selector(didPressPrevious:)
              forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.previousButton];
}

- (void)setupNextButton:(CGRect)frame
{
    if (self.nextButton)
    {
        [self.nextButton removeFromSuperview];
        self.nextButton = nil;
    }

    CGRect nextButtonFrame = frame;
    nextButtonFrame.origin.x = nextButtonFrame.size.width - kMNCalendarHeaderViewButtonWidth*2;
    nextButtonFrame.size.width = kMNCalendarHeaderViewButtonWidth;
    
    self.nextButton = [[UIButton alloc] initWithFrame:nextButtonFrame];
    self.nextButton.backgroundColor = UIColor.clearColor;
    [self.nextButton setImage:[self imageForNextButton] forState:UIControlStateNormal];
    self.nextButton.enabled = [self shouldEnableNextButton];
    
    [self.nextButton addTarget:self
                        action:@selector(didPressNext:)
              forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.nextButton];
}

- (BOOL)shouldEnablePreviousButton
{
    if ([self.delegate respondsToSelector:@selector(calendarHeaderViewShouldEnablePreviousButton:)]) {
        return [self.delegate calendarHeaderViewShouldEnablePreviousButton:self];
    }
    
    return YES;
}

- (BOOL)shouldEnableNextButton
{
    if ([self.delegate respondsToSelector:@selector(calendarHeaderViewShouldEnableNextButton:)]) {
        return [self.delegate calendarHeaderViewShouldEnableNextButton:self];
    }
    
    return YES;
}

- (UIImage *)imageForNextButton
{
    if ([self.delegate respondsToSelector:@selector(calendarHeaderViewNextButtonImage:)]) {
        return [self.delegate calendarHeaderViewNextButtonImage:self];
    }
    
    static UIImage *nextButtonImage = nil;
    
    if (!nextButtonImage)
    {
        nextButtonImage = [UIImage imageNamed:@"_mnNextButtonImage"];
    }
    
    return nextButtonImage;
}

- (UIImage *)imageForPreviousButton
{
    if ([self.delegate respondsToSelector:@selector(calendarHeaderViewPreviousButtonImage:)]) {
        return [self.delegate calendarHeaderViewPreviousButtonImage:self];
    }
    
    static UIImage *previousButtonImage = nil;
    
    if (!previousButtonImage)
    {
        previousButtonImage = [UIImage imageNamed:@"_mnPreviousButtonImage"];
    }
    
    return previousButtonImage;
}

- (void)didPressPrevious:(id)sender
{
    [self.delegate calendarHeaderViewDidTouchPreviousButton:self];
}

- (void)didPressNext:(id)sender
{
    [self.delegate calendarHeaderViewDidTouchNextButton:self];
}

@end
