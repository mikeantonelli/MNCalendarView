//
//  MNCalendarHeaderView.h
//  MNCalendarView
//
//  Created by Min Kim on 7/26/13.
//  Copyright (c) 2013 min. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MNCalendarHeaderView;

@protocol MNCalendarHeaderViewDelegate <NSObject>

@optional

- (BOOL)calendarHeaderViewShouldEnablePreviousButton:(MNCalendarHeaderView*)headerView;
- (BOOL)calendarHeaderViewShouldEnableNextButton:(MNCalendarHeaderView*)headerView;
- (UIImage *)calendarHeaderViewPreviousButtonImage:(MNCalendarHeaderView*)headerView;
- (UIImage *)calendarHeaderViewNextButtonImage:(MNCalendarHeaderView*)headerView;
- (void)calendarHeaderViewDidTouchPreviousButton:(MNCalendarHeaderView*)headerView;
- (void)calendarHeaderViewDidTouchNextButton:(MNCalendarHeaderView*)headerView;

@end

extern NSString *const MNCalendarHeaderViewIdentifier;

@interface MNCalendarHeaderView : UICollectionReusableView

@property(nonatomic,strong,readonly) UILabel *titleLabel;
@property(nonatomic,strong,readonly) UIButton *previousButton;
@property(nonatomic,strong,readonly) UIButton *nextButton;
@property(nonatomic,strong) NSDate *date;
@property(nonatomic,weak) id<MNCalendarHeaderViewDelegate> delegate;

@end
