//
//  Constants.h
//  Encourage
//
//  Created by Abu on 22/10/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//


typedef enum {
    
    ReportButtonTypeSoreThroat = 0,
    ReportButtonTypeTired,
    ReportButtonTypeBackPain,
    ReportButtonTypeDizziness,
    ReportButtonTypeCantSleep,
    ReportButtonTypeJointPain,
    ReportButtonTypeDrySkin,
    ReportButtonTypeNoseBleed,
    ReportButtonTypeShortnessOfBreath,
    ReportButtonTypeWorried,
    ReportButtonTypeAnxious,
    ReportButtonTypeDepressed,
    ReportButtonTypeAngry,
    ReportButtonTypeSad,
    ReportButtonTypeHappy,
    ReportButtonTypeRestless
}ReportButtonType;

/* URLs */

#define BASE_URL @"http://tryencourage.com/hwdsi/mServices/%@.php"
#define FILE_URL @"http://tryencourage.com/hwdsi/hwAttachedfile/%@/%@"
#define MAP_URL @"http://maps.googleapis.com/maps/api/staticmap?zoom=12&size=1080x1920&markers=size:mid|color:red|%@"
#define LOGIN_URL @"mUserLogin"
#define TIMELINE_URL @"mGetTimelineDetails"
#define ALERT_DETAILS_URL @"mGetUserAlertsDetails"
#define POST_REPORT_URL @"mPostReportWizardData"
#define UPDATE_CARETASK_STATUS_URL @"mUpdateCareTaskStatus"
#define UPDATE_ALERT_STATUS_URL @"mUpdateUnreadAlertStatus"
#define LOGOUT_URL @"mUserLogout"
#define REGISTRATION_URL @"mPostPersonDetails"
#define RESPONSE_DESCRIPTION_KEY @"responseDescription"


#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
/*** response class  ***/




/*.......Nib files........*/

/*.......Class Names........*/


/*......error message constants.....*/
#define AUTHENTICATION_ERROR_MSG @"Authentication_Error_Message"


/* Activity Indicator */
#define ACTIVITY_INDICATOR1_FRAME 140, 180, 30, 30
#define ACTIVITY_INDICATOR3_FRAME 160, 200, 50, 50
#define ACTIVITY_INDICATOR4_FRAME 200, 220, 50, 50
#define ACTIVITY_INDICATOR_1 @"activityIndicator1.png"
#define ACTIVITY_INDICATOR_2 @"activityIndicator2.png"
#define ACTIVITY_INDICATOR_3 @"activityIndicator3.png"
#define ACTIVITY_INDICATOR_4 @"activityIndicator4.png"
#define ACTIVITY_INDICATOR_5 @"activityIndicator5.png"
#define ACTIVITY_INDICATOR_6 @"activityIndicator6.png"
#define ACTIVITY_INDICATOR_7 @"activityIndicator7.png"
#define ACTIVITY_INDICATOR_8 @"activityIndicator8.png"

#define ACTIVITY_INDICATOR2_FRAME 130.0f, 240.0f, 60.0f, 60.0f

#define ACTIVITY_INDICATOR2_FRAME_GPS 10.0f, 10.0f, 60.0f, 60.0f
#define ACTIVITY_INDICATOR_DURATION 2
#define ACTIVITY_INDICATOR_REPEAT_COUNT 0

#define PAGE_BG_COLOR [UIColor colorWithRed:220.0/255.0 green:226.0/255.0 blue:227.0/255.0 alpha:1]

/** alert tags **/



/** DayNightNibs_plist  **/

#define CLASS_NAME @"className"

#define NOTIFICATION_TYPE_KEY @"notificationType"
#define NOTIFICATION_TYPE_ALERT @"alert"
#define NOTIFICATION_TYPE_CARETASK @"caretask"
#define NOTIFICATION_UNREAD @"unread"
#define NOTIFICATION_READ @"read"

#define CARETASK_TYPE_MEDICATION @"Medication"
#define CARETASK_TYPE_FOOD @"Diet Management"
#define CARETASK_TYPE_DOC @"Appointment"







