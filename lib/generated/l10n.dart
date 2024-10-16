// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Your Connection is Lost!`
  String get your_Connection_is_Lost {
    return Intl.message(
      'Your Connection is Lost!',
      name: 'your_Connection_is_Lost',
      desc: '',
      args: [],
    );
  }

  /// `Please check your internet connection and try again!`
  String get check_internet_message {
    return Intl.message(
      'Please check your internet connection and try again!',
      name: 'check_internet_message',
      desc: '',
      args: [],
    );
  }

  /// `Try Again`
  String get try_again {
    return Intl.message(
      'Try Again',
      name: 'try_again',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Welcome back!`
  String get welcome_back {
    return Intl.message(
      'Welcome back!',
      name: 'welcome_back',
      desc: '',
      args: [],
    );
  }

  /// `Glad to see you, Again!`
  String get glad_message {
    return Intl.message(
      'Glad to see you, Again!',
      name: 'glad_message',
      desc: '',
      args: [],
    );
  }

  /// `Mobile Number*`
  String get mobile_number {
    return Intl.message(
      'Mobile Number*',
      name: 'mobile_number',
      desc: '',
      args: [],
    );
  }

  /// `Enter Here`
  String get enter_here {
    return Intl.message(
      'Enter Here',
      name: 'enter_here',
      desc: '',
      args: [],
    );
  }

  /// `This field must not remain empty`
  String get empty_field_message {
    return Intl.message(
      'This field must not remain empty',
      name: 'empty_field_message',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Full Name*`
  String get full_name {
    return Intl.message(
      'Full Name*',
      name: 'full_name',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number*`
  String get phone_number_ {
    return Intl.message(
      'Phone Number*',
      name: 'phone_number_',
      desc: '',
      args: [],
    );
  }

  /// `By continuing you agree to Sahab`
  String get by_continuing_you_agree_to_sahab {
    return Intl.message(
      'By continuing you agree to Sahab',
      name: 'by_continuing_you_agree_to_sahab',
      desc: '',
      args: [],
    );
  }

  /// `Terms & Conditions`
  String get terms_conditions {
    return Intl.message(
      'Terms & Conditions',
      name: 'terms_conditions',
      desc: '',
      args: [],
    );
  }

  /// `and`
  String get and {
    return Intl.message(
      'and',
      name: 'and',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacy_policy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacy_policy',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get Home {
    return Intl.message(
      'Home',
      name: 'Home',
      desc: '',
      args: [],
    );
  }

  /// `Bookings`
  String get Bookings {
    return Intl.message(
      'Bookings',
      name: 'Bookings',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get Account {
    return Intl.message(
      'Account',
      name: 'Account',
      desc: '',
      args: [],
    );
  }

  /// `Find Here`
  String get find_here {
    return Intl.message(
      'Find Here',
      name: 'find_here',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categories {
    return Intl.message(
      'Categories',
      name: 'categories',
      desc: '',
      args: [],
    );
  }

  /// `We have sent an OTP to Mobile number`
  String get first_OTP_message {
    return Intl.message(
      'We have sent an OTP to Mobile number',
      name: 'first_OTP_message',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the code received`
  String get second_OTP_message {
    return Intl.message(
      'Please enter the code received',
      name: 'second_OTP_message',
      desc: '',
      args: [],
    );
  }

  /// `below`
  String get below {
    return Intl.message(
      'below',
      name: 'below',
      desc: '',
      args: [],
    );
  }

  /// `OTP code entered is wrong. Try Again!`
  String get OTP_error_message {
    return Intl.message(
      'OTP code entered is wrong. Try Again!',
      name: 'OTP_error_message',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get Verify {
    return Intl.message(
      'Verify',
      name: 'Verify',
      desc: '',
      args: [],
    );
  }

  /// `Didn’t get the code?`
  String get Did_not_get_the_code {
    return Intl.message(
      'Didn’t get the code?',
      name: 'Did_not_get_the_code',
      desc: '',
      args: [],
    );
  }

  /// `Resend code`
  String get resend_code {
    return Intl.message(
      'Resend code',
      name: 'resend_code',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get Welcome {
    return Intl.message(
      'Welcome',
      name: 'Welcome',
      desc: '',
      args: [],
    );
  }

  /// `Lets get You Registered`
  String get lets_get_you_registered {
    return Intl.message(
      'Lets get You Registered',
      name: 'lets_get_you_registered',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get Register {
    return Intl.message(
      'Register',
      name: 'Register',
      desc: '',
      args: [],
    );
  }

  /// `Where you want to\nadd post ad?`
  String get choose_type_of_add_post {
    return Intl.message(
      'Where you want to\nadd post ad?',
      name: 'choose_type_of_add_post',
      desc: '',
      args: [],
    );
  }

  /// `Place`
  String get place {
    return Intl.message(
      'Place',
      name: 'place',
      desc: '',
      args: [],
    );
  }

  /// `Services`
  String get services {
    return Intl.message(
      'Services',
      name: 'services',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Tittle Here`
  String get tittle_here {
    return Intl.message(
      'Tittle Here',
      name: 'tittle_here',
      desc: '',
      args: [],
    );
  }

  /// `Select Category*`
  String get select_category {
    return Intl.message(
      'Select Category*',
      name: 'select_category',
      desc: '',
      args: [],
    );
  }

  /// `please select`
  String get please_select {
    return Intl.message(
      'please select',
      name: 'please_select',
      desc: '',
      args: [],
    );
  }

  /// `Place Type*`
  String get place_type_ {
    return Intl.message(
      'Place Type*',
      name: 'place_type_',
      desc: '',
      args: [],
    );
  }

  /// `Amenities*`
  String get amenities_ {
    return Intl.message(
      'Amenities*',
      name: 'amenities_',
      desc: '',
      args: [],
    );
  }

  /// `Amenities`
  String get amenities {
    return Intl.message(
      'Amenities',
      name: 'amenities',
      desc: '',
      args: [],
    );
  }

  /// `error fetch`
  String get error_fetch {
    return Intl.message(
      'error fetch',
      name: 'error_fetch',
      desc: '',
      args: [],
    );
  }

  /// `Area*`
  String get area_ {
    return Intl.message(
      'Area*',
      name: 'area_',
      desc: '',
      args: [],
    );
  }

  /// `Address*`
  String get address_ {
    return Intl.message(
      'Address*',
      name: 'address_',
      desc: '',
      args: [],
    );
  }

  /// `About Place*`
  String get about_place {
    return Intl.message(
      'About Place*',
      name: 'about_place',
      desc: '',
      args: [],
    );
  }

  /// `Upload Images`
  String get upload_images {
    return Intl.message(
      'Upload Images',
      name: 'upload_images',
      desc: '',
      args: [],
    );
  }

  /// `Max 5 Photos ,jpg, jpeg, png format only`
  String get note_about_images {
    return Intl.message(
      'Max 5 Photos ,jpg, jpeg, png format only',
      name: 'note_about_images',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Add Post`
  String get add_post {
    return Intl.message(
      'Add Post',
      name: 'add_post',
      desc: '',
      args: [],
    );
  }

  /// `Note:`
  String get note {
    return Intl.message(
      'Note:',
      name: 'note',
      desc: '',
      args: [],
    );
  }

  /// ` Commission rate 10% will be detected from price amount.`
  String get commission {
    return Intl.message(
      ' Commission rate 10% will be detected from price amount.',
      name: 'commission',
      desc: '',
      args: [],
    );
  }

  /// `By Posting ad, you agree to our`
  String get by_posting_ad_you_agree_to_our {
    return Intl.message(
      'By Posting ad, you agree to our',
      name: 'by_posting_ad_you_agree_to_our',
      desc: '',
      args: [],
    );
  }

  /// ` Term & Conditions`
  String get term_Conditions {
    return Intl.message(
      ' Term & Conditions',
      name: 'term_Conditions',
      desc: '',
      args: [],
    );
  }

  /// `Special days (Optional)`
  String get special_days_Optional {
    return Intl.message(
      'Special days (Optional)',
      name: 'special_days_Optional',
      desc: '',
      args: [],
    );
  }

  /// `Add Dates`
  String get add_dates {
    return Intl.message(
      'Add Dates',
      name: 'add_dates',
      desc: '',
      args: [],
    );
  }

  /// `Select Service*`
  String get select_service {
    return Intl.message(
      'Select Service*',
      name: 'select_service',
      desc: '',
      args: [],
    );
  }

  /// `About Service*`
  String get about_service_ {
    return Intl.message(
      'About Service*',
      name: 'about_service_',
      desc: '',
      args: [],
    );
  }

  /// `Service Duration*`
  String get service_duration_ {
    return Intl.message(
      'Service Duration*',
      name: 'service_duration_',
      desc: '',
      args: [],
    );
  }

  /// `Service Duration`
  String get service_duration {
    return Intl.message(
      'Service Duration',
      name: 'service_duration',
      desc: '',
      args: [],
    );
  }

  /// `Service Price*`
  String get service_price {
    return Intl.message(
      'Service Price*',
      name: 'service_price',
      desc: '',
      args: [],
    );
  }

  /// `Notice period*`
  String get notice_period {
    return Intl.message(
      'Notice period*',
      name: 'notice_period',
      desc: '',
      args: [],
    );
  }

  /// `Capacity*`
  String get capacity {
    return Intl.message(
      'Capacity*',
      name: 'capacity',
      desc: '',
      args: [],
    );
  }

  /// `Rate Booking`
  String get rate_booking {
    return Intl.message(
      'Rate Booking',
      name: 'rate_booking',
      desc: '',
      args: [],
    );
  }

  /// `Thank you in advance for you feedback.`
  String get feedback_message {
    return Intl.message(
      'Thank you in advance for you feedback.',
      name: 'feedback_message',
      desc: '',
      args: [],
    );
  }

  /// `Overall Satisfaction`
  String get overall_satisfaction {
    return Intl.message(
      'Overall Satisfaction',
      name: 'overall_satisfaction',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Excellent`
  String get excellent {
    return Intl.message(
      'Excellent',
      name: 'excellent',
      desc: '',
      args: [],
    );
  }

  /// `Good`
  String get good {
    return Intl.message(
      'Good',
      name: 'good',
      desc: '',
      args: [],
    );
  }

  /// `Bad`
  String get bad {
    return Intl.message(
      'Bad',
      name: 'bad',
      desc: '',
      args: [],
    );
  }

  /// `My Bookings`
  String get my_bookings {
    return Intl.message(
      'My Bookings',
      name: 'my_bookings',
      desc: '',
      args: [],
    );
  }

  /// `Location Name`
  String get location_name {
    return Intl.message(
      'Location Name',
      name: 'location_name',
      desc: '',
      args: [],
    );
  }

  /// `View All`
  String get viewAll {
    return Intl.message(
      'View All',
      name: 'viewAll',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Search Results`
  String get search_results {
    return Intl.message(
      'Search Results',
      name: 'search_results',
      desc: '',
      args: [],
    );
  }

  /// `Search Failed`
  String get search_failed {
    return Intl.message(
      'Search Failed',
      name: 'search_failed',
      desc: '',
      args: [],
    );
  }

  /// `Search Here`
  String get search_here {
    return Intl.message(
      'Search Here',
      name: 'search_here',
      desc: '',
      args: [],
    );
  }

  /// `Locations`
  String get locations {
    return Intl.message(
      'Locations',
      name: 'locations',
      desc: '',
      args: [],
    );
  }

  /// `Results found`
  String get results_found {
    return Intl.message(
      'Results found',
      name: 'results_found',
      desc: '',
      args: [],
    );
  }

  /// `About Sahab`
  String get about_sahab {
    return Intl.message(
      'About Sahab',
      name: 'about_sahab',
      desc: '',
      args: [],
    );
  }

  /// `Contact us`
  String get contact_us {
    return Intl.message(
      'Contact us',
      name: 'contact_us',
      desc: '',
      args: [],
    );
  }

  /// `Name*`
  String get name_ {
    return Intl.message(
      'Name*',
      name: 'name_',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phone_number {
    return Intl.message(
      'Phone Number',
      name: 'phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Email*`
  String get email_ {
    return Intl.message(
      'Email*',
      name: 'email_',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Message*`
  String get message_ {
    return Intl.message(
      'Message*',
      name: 'message_',
      desc: '',
      args: [],
    );
  }

  /// `Message`
  String get message {
    return Intl.message(
      'Message',
      name: 'message',
      desc: '',
      args: [],
    );
  }

  /// `Reach Out to Us`
  String get reach_out_to_us {
    return Intl.message(
      'Reach Out to Us',
      name: 'reach_out_to_us',
      desc: '',
      args: [],
    );
  }

  /// `Hello, Guest`
  String get hello_guest {
    return Intl.message(
      'Hello, Guest',
      name: 'hello_guest',
      desc: '',
      args: [],
    );
  }

  /// `Login / Sign Up`
  String get Login_Sign_Up {
    return Intl.message(
      'Login / Sign Up',
      name: 'Login_Sign_Up',
      desc: '',
      args: [],
    );
  }

  /// `My Account`
  String get my_account {
    return Intl.message(
      'My Account',
      name: 'my_account',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get change_language {
    return Intl.message(
      'Change Language',
      name: 'change_language',
      desc: '',
      args: [],
    );
  }

  /// `choose language`
  String get choose_language {
    return Intl.message(
      'choose language',
      name: 'choose_language',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get notification {
    return Intl.message(
      'Notification',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `Support`
  String get support {
    return Intl.message(
      'Support',
      name: 'support',
      desc: '',
      args: [],
    );
  }

  /// `Terms & Condition`
  String get Terms_Condition {
    return Intl.message(
      'Terms & Condition',
      name: 'Terms_Condition',
      desc: '',
      args: [],
    );
  }

  /// `Contacts us`
  String get contacts_us {
    return Intl.message(
      'Contacts us',
      name: 'contacts_us',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Terminate Account`
  String get terminate_account {
    return Intl.message(
      'Terminate Account',
      name: 'terminate_account',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to terminate your account?`
  String get terminate_account_message {
    return Intl.message(
      'Do you want to terminate your account?',
      name: 'terminate_account_message',
      desc: '',
      args: [],
    );
  }

  /// `By terminating account your personal details, addresses, orders will be removed from Sahab.You will not be able to recover your account.`
  String get confirm_terminate_account_message {
    return Intl.message(
      'By terminating account your personal details, addresses, orders will be removed from Sahab.You will not be able to recover your account.',
      name: 'confirm_terminate_account_message',
      desc: '',
      args: [],
    );
  }

  /// `Terminate my account`
  String get terminate_my_account {
    return Intl.message(
      'Terminate my account',
      name: 'terminate_my_account',
      desc: '',
      args: [],
    );
  }

  /// `Edit Account`
  String get edit_account {
    return Intl.message(
      'Edit Account',
      name: 'edit_account',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get edit_profile {
    return Intl.message(
      'Edit Profile',
      name: 'edit_profile',
      desc: '',
      args: [],
    );
  }

  /// `Profile Photo`
  String get profile_photo {
    return Intl.message(
      'Profile Photo',
      name: 'profile_photo',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `My Post`
  String get my_post {
    return Intl.message(
      'My Post',
      name: 'my_post',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Post Status`
  String get post_status {
    return Intl.message(
      'Post Status',
      name: 'post_status',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get active {
    return Intl.message(
      'Active',
      name: 'active',
      desc: '',
      args: [],
    );
  }

  /// `inactive`
  String get in_active {
    return Intl.message(
      'inactive',
      name: 'in_active',
      desc: '',
      args: [],
    );
  }

  /// `Booking Status`
  String get booking_status {
    return Intl.message(
      'Booking Status',
      name: 'booking_status',
      desc: '',
      args: [],
    );
  }

  /// `Open For booking`
  String get open_for_booking {
    return Intl.message(
      'Open For booking',
      name: 'open_for_booking',
      desc: '',
      args: [],
    );
  }

  /// `Closed For booking`
  String get closed_for_booking {
    return Intl.message(
      'Closed For booking',
      name: 'closed_for_booking',
      desc: '',
      args: [],
    );
  }

  /// `Details`
  String get details {
    return Intl.message(
      'Details',
      name: 'details',
      desc: '',
      args: [],
    );
  }

  /// `Manage`
  String get manage {
    return Intl.message(
      'Manage',
      name: 'manage',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `My Posts`
  String get my_posts {
    return Intl.message(
      'My Posts',
      name: 'my_posts',
      desc: '',
      args: [],
    );
  }

  /// `Places`
  String get places {
    return Intl.message(
      'Places',
      name: 'places',
      desc: '',
      args: [],
    );
  }

  /// `Mobile Number*`
  String get mobile_number_ {
    return Intl.message(
      'Mobile Number*',
      name: 'mobile_number_',
      desc: '',
      args: [],
    );
  }

  /// `No Bookings`
  String get no_bookings {
    return Intl.message(
      'No Bookings',
      name: 'no_bookings',
      desc: '',
      args: [],
    );
  }

  /// `Payment Details`
  String get payment_details {
    return Intl.message(
      'Payment Details',
      name: 'payment_details',
      desc: '',
      args: [],
    );
  }

  /// `Payment Method`
  String get payment_method {
    return Intl.message(
      'Payment Method',
      name: 'payment_method',
      desc: '',
      args: [],
    );
  }

  /// `Transaction ID`
  String get transaction_id {
    return Intl.message(
      'Transaction ID',
      name: 'transaction_id',
      desc: '',
      args: [],
    );
  }

  /// `Reference ID`
  String get reference_id {
    return Intl.message(
      'Reference ID',
      name: 'reference_id',
      desc: '',
      args: [],
    );
  }

  /// `Invoice reference`
  String get invoice_reference {
    return Intl.message(
      'Invoice reference',
      name: 'invoice_reference',
      desc: '',
      args: [],
    );
  }

  /// `Booking Amount`
  String get booking_amount {
    return Intl.message(
      'Booking Amount',
      name: 'booking_amount',
      desc: '',
      args: [],
    );
  }

  /// `Discount`
  String get discount {
    return Intl.message(
      'Discount',
      name: 'discount',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Starting From`
  String get starting_from {
    return Intl.message(
      'Starting From',
      name: 'starting_from',
      desc: '',
      args: [],
    );
  }

  /// `NoResult`
  String get no_result {
    return Intl.message(
      'NoResult',
      name: 'no_result',
      desc: '',
      args: [],
    );
  }

  /// `Unknown Location`
  String get unknown_location {
    return Intl.message(
      'Unknown Location',
      name: 'unknown_location',
      desc: '',
      args: [],
    );
  }

  /// `checkout`
  String get checkout {
    return Intl.message(
      'checkout',
      name: 'checkout',
      desc: '',
      args: [],
    );
  }

  /// `Proceed to payment`
  String get proceed_to_payment {
    return Intl.message(
      'Proceed to payment',
      name: 'proceed_to_payment',
      desc: '',
      args: [],
    );
  }

  /// `Contact Details`
  String get contact_details {
    return Intl.message(
      'Contact Details',
      name: 'contact_details',
      desc: '',
      args: [],
    );
  }

  /// `Promo Code`
  String get promo_code {
    return Intl.message(
      'Promo Code',
      name: 'promo_code',
      desc: '',
      args: [],
    );
  }

  /// `Enter Promo code Here`
  String get enter_promo_code_here {
    return Intl.message(
      'Enter Promo code Here',
      name: 'enter_promo_code_here',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get apply {
    return Intl.message(
      'Apply',
      name: 'apply',
      desc: '',
      args: [],
    );
  }

  /// `Code applied successfully!`
  String get code_applied_successfully {
    return Intl.message(
      'Code applied successfully!',
      name: 'code_applied_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Sorry!`
  String get sorry {
    return Intl.message(
      'Sorry!',
      name: 'sorry',
      desc: '',
      args: [],
    );
  }

  /// `Your booking could not been placed...`
  String get your_booking_could_not_been_placed {
    return Intl.message(
      'Your booking could not been placed...',
      name: 'your_booking_could_not_been_placed',
      desc: '',
      args: [],
    );
  }

  /// `Sorry! An error occurred while we were Processing your payment, please try again! The order was not placed!`
  String get error_occurred_while_Processing_payment {
    return Intl.message(
      'Sorry! An error occurred while we were Processing your payment, please try again! The order was not placed!',
      name: 'error_occurred_while_Processing_payment',
      desc: '',
      args: [],
    );
  }

  /// `Thank you!`
  String get thank_you {
    return Intl.message(
      'Thank you!',
      name: 'thank_you',
      desc: '',
      args: [],
    );
  }

  /// `Your booking has been placed.`
  String get your_booking_has_been_placed {
    return Intl.message(
      'Your booking has been placed.',
      name: 'your_booking_has_been_placed',
      desc: '',
      args: [],
    );
  }

  /// `Back to Home`
  String get back_to_home {
    return Intl.message(
      'Back to Home',
      name: 'back_to_home',
      desc: '',
      args: [],
    );
  }

  /// `Popular`
  String get popular {
    return Intl.message(
      'Popular',
      name: 'popular',
      desc: '',
      args: [],
    );
  }

  /// `we Provide`
  String get we_provide {
    return Intl.message(
      'we Provide',
      name: 'we_provide',
      desc: '',
      args: [],
    );
  }

  /// `Featured`
  String get featured {
    return Intl.message(
      'Featured',
      name: 'featured',
      desc: '',
      args: [],
    );
  }

  /// `view All`
  String get view_all {
    return Intl.message(
      'view All',
      name: 'view_all',
      desc: '',
      args: [],
    );
  }

  /// `Find the best`
  String get find_the_best {
    return Intl.message(
      'Find the best',
      name: 'find_the_best',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get location {
    return Intl.message(
      'Location',
      name: 'location',
      desc: '',
      args: [],
    );
  }

  /// `Area`
  String get area {
    return Intl.message(
      'Area',
      name: 'area',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message(
      'All',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `Area name`
  String get area_name {
    return Intl.message(
      'Area name',
      name: 'area_name',
      desc: '',
      args: [],
    );
  }

  /// `booking now`
  String get booking_now {
    return Intl.message(
      'booking now',
      name: 'booking_now',
      desc: '',
      args: [],
    );
  }

  /// `Proceed to checkout`
  String get proceed_to_checkout {
    return Intl.message(
      'Proceed to checkout',
      name: 'proceed_to_checkout',
      desc: '',
      args: [],
    );
  }

  /// `Range Date Picker (With default value)`
  String get range_date_picker_message {
    return Intl.message(
      'Range Date Picker (With default value)',
      name: 'range_date_picker_message',
      desc: '',
      args: [],
    );
  }

  /// `Filter by`
  String get filter_by {
    return Intl.message(
      'Filter by',
      name: 'filter_by',
      desc: '',
      args: [],
    );
  }

  /// `Sort By`
  String get sort_by {
    return Intl.message(
      'Sort By',
      name: 'sort_by',
      desc: '',
      args: [],
    );
  }

  /// `Newest`
  String get newest {
    return Intl.message(
      'Newest',
      name: 'newest',
      desc: '',
      args: [],
    );
  }

  /// `Highest Rating`
  String get highest_rating {
    return Intl.message(
      'Highest Rating',
      name: 'highest_rating',
      desc: '',
      args: [],
    );
  }

  /// `High to low`
  String get high_to_low {
    return Intl.message(
      'High to low',
      name: 'high_to_low',
      desc: '',
      args: [],
    );
  }

  /// `low to high`
  String get low_to_high {
    return Intl.message(
      'low to high',
      name: 'low_to_high',
      desc: '',
      args: [],
    );
  }

  /// `Girls Only`
  String get girls_only {
    return Intl.message(
      'Girls Only',
      name: 'girls_only',
      desc: '',
      args: [],
    );
  }

  /// `Family Only`
  String get family_only {
    return Intl.message(
      'Family Only',
      name: 'family_only',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Book Now`
  String get book_now {
    return Intl.message(
      'Book Now',
      name: 'book_now',
      desc: '',
      args: [],
    );
  }

  /// `Featured Locations`
  String get featured_locations {
    return Intl.message(
      'Featured Locations',
      name: 'featured_locations',
      desc: '',
      args: [],
    );
  }

  /// `No Results Found`
  String get no_results_found {
    return Intl.message(
      'No Results Found',
      name: 'no_results_found',
      desc: '',
      args: [],
    );
  }

  /// `Reservation`
  String get reservation {
    return Intl.message(
      'Reservation',
      name: 'reservation',
      desc: '',
      args: [],
    );
  }

  /// `Service Details`
  String get service_details {
    return Intl.message(
      'Service Details',
      name: 'service_details',
      desc: '',
      args: [],
    );
  }

  /// `Hour`
  String get hour {
    return Intl.message(
      'Hour',
      name: 'hour',
      desc: '',
      args: [],
    );
  }

  /// `About Service`
  String get about_service {
    return Intl.message(
      'About Service',
      name: 'about_service',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Address*`
  String get enter_your_address_ {
    return Intl.message(
      'Enter Your Address*',
      name: 'enter_your_address_',
      desc: '',
      args: [],
    );
  }

  /// `Booking ID`
  String get booking_ID {
    return Intl.message(
      'Booking ID',
      name: 'booking_ID',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get status {
    return Intl.message(
      'Status',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `Cancel Booking`
  String get cancel_booking {
    return Intl.message(
      'Cancel Booking',
      name: 'cancel_booking',
      desc: '',
      args: [],
    );
  }

  /// `ok`
  String get ok {
    return Intl.message(
      'ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get title {
    return Intl.message(
      'Title',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Eid Prices`
  String get eid_prices {
    return Intl.message(
      'Eid Prices',
      name: 'eid_prices',
      desc: '',
      args: [],
    );
  }

  /// `Price/Day`
  String get price_day {
    return Intl.message(
      'Price/Day',
      name: 'price_day',
      desc: '',
      args: [],
    );
  }

  /// `startDate`
  String get startDate {
    return Intl.message(
      'startDate',
      name: 'startDate',
      desc: '',
      args: [],
    );
  }

  /// `start Date`
  String get start_date {
    return Intl.message(
      'start Date',
      name: 'start_date',
      desc: '',
      args: [],
    );
  }

  /// `end Date`
  String get end_date {
    return Intl.message(
      'end Date',
      name: 'end_date',
      desc: '',
      args: [],
    );
  }

  /// `endDate`
  String get endDate {
    return Intl.message(
      'endDate',
      name: 'endDate',
      desc: '',
      args: [],
    );
  }

  /// `Booking Details`
  String get booking_details {
    return Intl.message(
      'Booking Details',
      name: 'booking_details',
      desc: '',
      args: [],
    );
  }

  /// `Booking Durations`
  String get booking_durations {
    return Intl.message(
      'Booking Durations',
      name: 'booking_durations',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while deleting`
  String get an_error_occurred_while_deleting {
    return Intl.message(
      'An error occurred while deleting',
      name: 'an_error_occurred_while_deleting',
      desc: '',
      args: [],
    );
  }

  /// `Hours`
  String get hours {
    return Intl.message(
      'Hours',
      name: 'hours',
      desc: '',
      args: [],
    );
  }

  /// `There is no reservations`
  String get there_is_no_reservations {
    return Intl.message(
      'There is no reservations',
      name: 'there_is_no_reservations',
      desc: '',
      args: [],
    );
  }

  /// `there was an error, please try later!`
  String get general_error {
    return Intl.message(
      'there was an error, please try later!',
      name: 'general_error',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category {
    return Intl.message(
      'Category',
      name: 'category',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get amount {
    return Intl.message(
      'Amount',
      name: 'amount',
      desc: '',
      args: [],
    );
  }

  /// `Booking Date`
  String get booking_date {
    return Intl.message(
      'Booking Date',
      name: 'booking_date',
      desc: '',
      args: [],
    );
  }

  /// `Booking Time`
  String get booking_time {
    return Intl.message(
      'Booking Time',
      name: 'booking_time',
      desc: '',
      args: [],
    );
  }

  /// `User Address`
  String get user_address {
    return Intl.message(
      'User Address',
      name: 'user_address',
      desc: '',
      args: [],
    );
  }

  /// `User Details`
  String get user_details {
    return Intl.message(
      'User Details',
      name: 'user_details',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure want to Delete This Reservation`
  String get first_delete_reservation_message {
    return Intl.message(
      'Are you sure want to Delete This Reservation',
      name: 'first_delete_reservation_message',
      desc: '',
      args: [],
    );
  }

  /// `deleting post will not effect on any previous bookings`
  String get second_delete_reservation_message {
    return Intl.message(
      'deleting post will not effect on any previous bookings',
      name: 'second_delete_reservation_message',
      desc: '',
      args: [],
    );
  }

  /// `Delete Reservation`
  String get delete_reservation {
    return Intl.message(
      'Delete Reservation',
      name: 'delete_reservation',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure want to Delete This Post`
  String get first_delete_post_message {
    return Intl.message(
      'Are you sure want to Delete This Post',
      name: 'first_delete_post_message',
      desc: '',
      args: [],
    );
  }

  /// `Delete Post`
  String get delete_post {
    return Intl.message(
      'Delete Post',
      name: 'delete_post',
      desc: '',
      args: [],
    );
  }

  /// `No Post added`
  String get no_post_added {
    return Intl.message(
      'No Post added',
      name: 'no_post_added',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Promo Code!`
  String get invalid_promo_code {
    return Intl.message(
      'Invalid Promo Code!',
      name: 'invalid_promo_code',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure want to cancel booking?`
  String get are_you_sure_want_to_cancel_booking {
    return Intl.message(
      'Are you sure want to cancel booking?',
      name: 'are_you_sure_want_to_cancel_booking',
      desc: '',
      args: [],
    );
  }

  /// `you are rating`
  String get you_are_rating {
    return Intl.message(
      'you are rating',
      name: 'you_are_rating',
      desc: '',
      args: [],
    );
  }

  /// `Duration`
  String get duration {
    return Intl.message(
      'Duration',
      name: 'duration',
      desc: '',
      args: [],
    );
  }

  /// `Choose Date`
  String get choose_date {
    return Intl.message(
      'Choose Date',
      name: 'choose_date',
      desc: '',
      args: [],
    );
  }

  /// `Booking Time*`
  String get booking_time_ {
    return Intl.message(
      'Booking Time*',
      name: 'booking_time_',
      desc: '',
      args: [],
    );
  }

  /// `Please Select Date First!`
  String get please_select_date_first {
    return Intl.message(
      'Please Select Date First!',
      name: 'please_select_date_first',
      desc: '',
      args: [],
    );
  }

  /// `Select Time*`
  String get select_time_ {
    return Intl.message(
      'Select Time*',
      name: 'select_time_',
      desc: '',
      args: [],
    );
  }

  /// `Select Date*`
  String get select_date_ {
    return Intl.message(
      'Select Date*',
      name: 'select_date_',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get success {
    return Intl.message(
      'Success',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `Rate Successfully!`
  String get rate_successfully {
    return Intl.message(
      'Rate Successfully!',
      name: 'rate_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Thank you,  we have successfully posted your ad`
  String get add_post_success_message {
    return Intl.message(
      'Thank you,  we have successfully posted your ad',
      name: 'add_post_success_message',
      desc: '',
      args: [],
    );
  }

  /// `Invalid format`
  String get invalid_format {
    return Intl.message(
      'Invalid format',
      name: 'invalid_format',
      desc: '',
      args: [],
    );
  }

  /// `phone must be 8 digital`
  String get phone_must_be_digital {
    return Intl.message(
      'phone must be 8 digital',
      name: 'phone_must_be_digital',
      desc: '',
      args: [],
    );
  }

  /// `Log in as a guest`
  String get log_in_as_a_guest {
    return Intl.message(
      'Log in as a guest',
      name: 'log_in_as_a_guest',
      desc: '',
      args: [],
    );
  }

  /// `Reservations`
  String get reservations {
    return Intl.message(
      'Reservations',
      name: 'reservations',
      desc: '',
      args: [],
    );
  }

  /// `inactive`
  String get inactive {
    return Intl.message(
      'inactive',
      name: 'inactive',
      desc: '',
      args: [],
    );
  }

  /// `Account Updated Successfully!`
  String get account_updated_successfully {
    return Intl.message(
      'Account Updated Successfully!',
      name: 'account_updated_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Error in edit account`
  String get error_in_edit_account {
    return Intl.message(
      'Error in edit account',
      name: 'error_in_edit_account',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get log_out {
    return Intl.message(
      'Log out',
      name: 'log_out',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to log out?`
  String get do_you_want_to_log_out {
    return Intl.message(
      'Do you want to log out?',
      name: 'do_you_want_to_log_out',
      desc: '',
      args: [],
    );
  }

  /// `Type`
  String get type {
    return Intl.message(
      'Type',
      name: 'type',
      desc: '',
      args: [],
    );
  }

  /// `place type`
  String get place_type {
    return Intl.message(
      'place type',
      name: 'place_type',
      desc: '',
      args: [],
    );
  }

  /// `Upcoming Reservations`
  String get upcoming_reservations {
    return Intl.message(
      'Upcoming Reservations',
      name: 'upcoming_reservations',
      desc: '',
      args: [],
    );
  }

  /// `Total Reservations`
  String get total_reservations {
    return Intl.message(
      'Total Reservations',
      name: 'total_reservations',
      desc: '',
      args: [],
    );
  }

  /// `Daily Sales(KD)`
  String get daily_sales {
    return Intl.message(
      'Daily Sales(KD)',
      name: 'daily_sales',
      desc: '',
      args: [],
    );
  }

  /// `Monthly Sales`
  String get monthly_sales {
    return Intl.message(
      'Monthly Sales',
      name: 'monthly_sales',
      desc: '',
      args: [],
    );
  }

  /// `Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.`
  String get lorem_text {
    return Intl.message(
      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
      name: 'lorem_text',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get time {
    return Intl.message(
      'Time',
      name: 'time',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Manage Post`
  String get manage_post {
    return Intl.message(
      'Manage Post',
      name: 'manage_post',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Step`
  String get step {
    return Intl.message(
      'Step',
      name: 'step',
      desc: '',
      args: [],
    );
  }

  /// `placed`
  String get placed {
    return Intl.message(
      'placed',
      name: 'placed',
      desc: '',
      args: [],
    );
  }

  /// `Royal Chalet Kuwait`
  String get royal_chalet_kuwait {
    return Intl.message(
      'Royal Chalet Kuwait',
      name: 'royal_chalet_kuwait',
      desc: '',
      args: [],
    );
  }

  /// `Weekday price* (Sun to Wed)`
  String get weekday_price_sun_to_wed {
    return Intl.message(
      'Weekday price* (Sun to Wed)',
      name: 'weekday_price_sun_to_wed',
      desc: '',
      args: [],
    );
  }

  /// `Weekend price* (Thu to Sat)`
  String get weekend_price_thu_to_sat {
    return Intl.message(
      'Weekend price* (Thu to Sat)',
      name: 'weekend_price_thu_to_sat',
      desc: '',
      args: [],
    );
  }

  /// `Lorem Ipsum is simply dummy text of the printing and typesetting industry.`
  String get lormn_ipsum_small {
    return Intl.message(
      'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      name: 'lormn_ipsum_small',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a name`
  String get please_enter_a_name {
    return Intl.message(
      'Please enter a name',
      name: 'please_enter_a_name',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a phone number`
  String get please_enter_a_phone_number {
    return Intl.message(
      'Please enter a phone number',
      name: 'please_enter_a_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `The Mobile must be 8 digits`
  String get the_mobile_must_be_8_digits {
    return Intl.message(
      'The Mobile must be 8 digits',
      name: 'the_mobile_must_be_8_digits',
      desc: '',
      args: [],
    );
  }

  /// `The message be send success`
  String get the_message_be_send_success {
    return Intl.message(
      'The message be send success',
      name: 'the_message_be_send_success',
      desc: '',
      args: [],
    );
  }

  /// `Please enter an email address`
  String get please_enter_an_email_address {
    return Intl.message(
      'Please enter an email address',
      name: 'please_enter_an_email_address',
      desc: '',
      args: [],
    );
  }

  /// `E-mail must contains @`
  String get e_mail_must_contains_ {
    return Intl.message(
      'E-mail must contains @',
      name: 'e_mail_must_contains_',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a message`
  String get please_enter_a_message {
    return Intl.message(
      'Please enter a message',
      name: 'please_enter_a_message',
      desc: '',
      args: [],
    );
  }

  /// `Account has been registered!`
  String get account_has_been_registered {
    return Intl.message(
      'Account has been registered!',
      name: 'account_has_been_registered',
      desc: '',
      args: [],
    );
  }

  /// `This place is currently not available for booking`
  String get un_bookable_message {
    return Intl.message(
      'This place is currently not available for booking',
      name: 'un_bookable_message',
      desc: '',
      args: [],
    );
  }

  /// `Edit Post`
  String get edit_post {
    return Intl.message(
      'Edit Post',
      name: 'edit_post',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
