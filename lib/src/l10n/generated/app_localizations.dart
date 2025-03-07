import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'InvestHelper'**
  String get appName;

  /// No description provided for @aboutAppText.
  ///
  /// In en, this message translates to:
  /// **'InvestHelper is an application designed to make managing your investments easier. With it, you can track your investments, manage your transactions, and set goals and reminders to achieve your investment objectives.'**
  String get aboutAppText;

  /// No description provided for @developedBy.
  ///
  /// In en, this message translates to:
  /// **'Developed by'**
  String get developedBy;

  /// No description provided for @welcomeText1.
  ///
  /// In en, this message translates to:
  /// **'Welcome to your new ally in achieving your financial goals! Start on the path to a successful investment journey with our app.'**
  String get welcomeText1;

  /// No description provided for @welcomeText2.
  ///
  /// In en, this message translates to:
  /// **'Our app is here to simplify your financial life, allowing you to track your transactions with ease and generate accurate, detailed reports when you need them.'**
  String get welcomeText2;

  /// No description provided for @welcomeText3.
  ///
  /// In en, this message translates to:
  /// **'Save time and eliminate stress when managing your investments. With our intuitive app, you can accomplish tasks in minutes that used to take hours, freeing up valuable time to enjoy other life activities.'**
  String get welcomeText3;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @letsStart.
  ///
  /// In en, this message translates to:
  /// **'Let\'s Start'**
  String get letsStart;

  /// No description provided for @authPageLoginTitle.
  ///
  /// In en, this message translates to:
  /// **'Log in with your account'**
  String get authPageLoginTitle;

  /// No description provided for @authPageLoginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Fill in the fields below to log in'**
  String get authPageLoginSubtitle;

  /// No description provided for @authPageRegisterTitle.
  ///
  /// In en, this message translates to:
  /// **'Create your account'**
  String get authPageRegisterTitle;

  /// No description provided for @authPageRegisterSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Fill in the fields below to register on our app'**
  String get authPageRegisterSubtitle;

  /// No description provided for @authPageRecoveryTitle.
  ///
  /// In en, this message translates to:
  /// **'Password Reset'**
  String get authPageRecoveryTitle;

  /// No description provided for @authPageRecoverySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your email below and we will send you a link to reset your password.'**
  String get authPageRecoverySubtitle;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @nameHint.
  ///
  /// In en, this message translates to:
  /// **'What do you want to be called?'**
  String get nameHint;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'login@example.com'**
  String get emailHint;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your password...'**
  String get passwordHint;

  /// No description provided for @passwordConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Password confirmation'**
  String get passwordConfirmation;

  /// No description provided for @passwordConfirmationHint.
  ///
  /// In en, this message translates to:
  /// **'Repeat the previously entered password...'**
  String get passwordConfirmationHint;

  /// No description provided for @makeLogin.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get makeLogin;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @makeRegister.
  ///
  /// In en, this message translates to:
  /// **'Complete Registration'**
  String get makeRegister;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @sendRecoveryEmail.
  ///
  /// In en, this message translates to:
  /// **'Send recovery email'**
  String get sendRecoveryEmail;

  /// No description provided for @forgotMyPassword.
  ///
  /// In en, this message translates to:
  /// **'I forgot my password'**
  String get forgotMyPassword;

  /// No description provided for @dontHaveAnAccountYet.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account yet?'**
  String get dontHaveAnAccountYet;

  /// No description provided for @alreadyHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAnAccount;

  /// No description provided for @myInvestments.
  ///
  /// In en, this message translates to:
  /// **'My investments'**
  String get myInvestments;

  /// No description provided for @totalInvestment.
  ///
  /// In en, this message translates to:
  /// **'Total investments'**
  String get totalInvestment;

  /// No description provided for @monthsOperations.
  ///
  /// In en, this message translates to:
  /// **'Operations performed this month'**
  String get monthsOperations;

  /// No description provided for @purchaseOperations.
  ///
  /// In en, this message translates to:
  /// **'Purchase operations'**
  String get purchaseOperations;

  /// No description provided for @salesOperations.
  ///
  /// In en, this message translates to:
  /// **'Sales operations'**
  String get salesOperations;

  /// No description provided for @seeMyOperations.
  ///
  /// In en, this message translates to:
  /// **'See my operations'**
  String get seeMyOperations;

  /// No description provided for @myGoals.
  ///
  /// In en, this message translates to:
  /// **'My goals'**
  String get myGoals;

  /// No description provided for @diversity.
  ///
  /// In en, this message translates to:
  /// **'Diversity'**
  String get diversity;

  /// No description provided for @tips.
  ///
  /// In en, this message translates to:
  /// **'Tips'**
  String get tips;

  /// No description provided for @quickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get quickActions;

  /// No description provided for @insertPurchaseOperation.
  ///
  /// In en, this message translates to:
  /// **'Insert purchase operation'**
  String get insertPurchaseOperation;

  /// No description provided for @insertSaleOperation.
  ///
  /// In en, this message translates to:
  /// **'Insert sale operation'**
  String get insertSaleOperation;

  /// No description provided for @editMyGoals.
  ///
  /// In en, this message translates to:
  /// **'Edit my goals'**
  String get editMyGoals;

  /// No description provided for @overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// No description provided for @investments.
  ///
  /// In en, this message translates to:
  /// **'Investments'**
  String get investments;

  /// No description provided for @hiUser.
  ///
  /// In en, this message translates to:
  /// **'Hi, {name}.'**
  String hiUser(String name);

  /// No description provided for @accessMyInvestments.
  ///
  /// In en, this message translates to:
  /// **'Access my investments'**
  String get accessMyInvestments;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @productsAndServices.
  ///
  /// In en, this message translates to:
  /// **'Products and services'**
  String get productsAndServices;

  /// No description provided for @custodialPositionDisplay.
  ///
  /// In en, this message translates to:
  /// **'Custodial position: {value}'**
  String custodialPositionDisplay(String value);

  /// No description provided for @amountInvestedDisplay.
  ///
  /// In en, this message translates to:
  /// **'Amount invested: {value}'**
  String amountInvestedDisplay(String value);

  /// No description provided for @averagePriceDisplay.
  ///
  /// In en, this message translates to:
  /// **'Average price: {value}'**
  String averagePriceDisplay(String value);

  /// No description provided for @operationsHistoryPerformed.
  ///
  /// In en, this message translates to:
  /// **'History of operations performed'**
  String get operationsHistoryPerformed;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @myProfile.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get myProfile;

  /// No description provided for @changePersonalData.
  ///
  /// In en, this message translates to:
  /// **'Change personal data'**
  String get changePersonalData;

  /// No description provided for @endSession.
  ///
  /// In en, this message translates to:
  /// **'End session'**
  String get endSession;

  /// No description provided for @protection.
  ///
  /// In en, this message translates to:
  /// **'Protection'**
  String get protection;

  /// No description provided for @enableBiometrics.
  ///
  /// In en, this message translates to:
  /// **'Enable Biometrics'**
  String get enableBiometrics;

  /// No description provided for @enableBiometricsHint.
  ///
  /// In en, this message translates to:
  /// **'Protect your data using your biometrics to access the app.'**
  String get enableBiometricsHint;

  /// No description provided for @personalization.
  ///
  /// In en, this message translates to:
  /// **'Personalization'**
  String get personalization;

  /// No description provided for @appTheme.
  ///
  /// In en, this message translates to:
  /// **'App theme'**
  String get appTheme;

  /// No description provided for @appLanguage.
  ///
  /// In en, this message translates to:
  /// **'App language'**
  String get appLanguage;

  /// No description provided for @system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// No description provided for @lightMode.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lightMode;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @portuguese.
  ///
  /// In en, this message translates to:
  /// **'Portuguese'**
  String get portuguese;

  /// No description provided for @others.
  ///
  /// In en, this message translates to:
  /// **'Others'**
  String get others;

  /// No description provided for @aboutThisApp.
  ///
  /// In en, this message translates to:
  /// **'About this app'**
  String get aboutThisApp;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @genericErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Unexpected error'**
  String get genericErrorTitle;

  /// No description provided for @genericErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'A communication error occurred, please try again in a few seconds.'**
  String get genericErrorMessage;

  /// No description provided for @emptyFieldsErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'One or more empty fields'**
  String get emptyFieldsErrorTitle;

  /// No description provided for @emptyFieldsErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Some required information is pending, please check the form and try again.'**
  String get emptyFieldsErrorMessage;

  /// No description provided for @incorrectUserOrPasswordErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'User not found'**
  String get incorrectUserOrPasswordErrorTitle;

  /// No description provided for @incorrectUserOrPasswordErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'The email and/or password entered may be incorrect.'**
  String get incorrectUserOrPasswordErrorMessage;

  /// No description provided for @incorrectPasswordErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Incorrect password'**
  String get incorrectPasswordErrorTitle;

  /// No description provided for @incorrectPasswordErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'The current password entered is incorrect.'**
  String get incorrectPasswordErrorMessage;

  /// No description provided for @userAlreadyExistsErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'User already registered'**
  String get userAlreadyExistsErrorTitle;

  /// No description provided for @userAlreadyExistsErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'An account associated with this email address already exists.'**
  String get userAlreadyExistsErrorMessage;

  /// No description provided for @invalidEmailErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Invalid Email'**
  String get invalidEmailErrorTitle;

  /// No description provided for @invalidEmailErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address.'**
  String get invalidEmailErrorMessage;

  /// No description provided for @invalidPasswordErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Invalid password'**
  String get invalidPasswordErrorTitle;

  /// No description provided for @invalidPasswordErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Your password cannot contain less than 8 characters.'**
  String get invalidPasswordErrorMessage;

  /// No description provided for @passwordsDontMatchErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Invalid password confirmation'**
  String get passwordsDontMatchErrorTitle;

  /// No description provided for @passwordsDontMatchErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Password confirmation must be exactly the same as your password.'**
  String get passwordsDontMatchErrorMessage;

  /// No description provided for @invalidRecoveryEmailErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Invalid Email'**
  String get invalidRecoveryEmailErrorTitle;

  /// No description provided for @invalidRecoveryEmailErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'There is no account associated with this email address.'**
  String get invalidRecoveryEmailErrorMessage;

  /// No description provided for @recoveryEmailSentTitle.
  ///
  /// In en, this message translates to:
  /// **'Recovery email sent'**
  String get recoveryEmailSentTitle;

  /// No description provided for @recoveryEmailSentMessage.
  ///
  /// In en, this message translates to:
  /// **'If there is an account registered with this email address, you will receive a link to reset your password.\n\nAfter resetting, log in normally using your new password.'**
  String get recoveryEmailSentMessage;

  /// No description provided for @connectionErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Connection error'**
  String get connectionErrorTitle;

  /// No description provided for @connectionErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'There was a problem connecting to the server, please check your connection and try again.'**
  String get connectionErrorMessage;

  /// No description provided for @endSessionMessage.
  ///
  /// In en, this message translates to:
  /// **'Do you really want to log out of your account?'**
  String get endSessionMessage;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @emptyDiversityGraphText.
  ///
  /// In en, this message translates to:
  /// **'Add your investments and operations to display the diversity graph.'**
  String get emptyDiversityGraphText;

  /// No description provided for @emptyMyGoalsText.
  ///
  /// In en, this message translates to:
  /// **'There are no goals set. Add goals or reminders and they will appear here.'**
  String get emptyMyGoalsText;

  /// No description provided for @emptyInvestmentsText.
  ///
  /// In en, this message translates to:
  /// **'No investments added. Add your investments to start using the app.'**
  String get emptyInvestmentsText;

  /// No description provided for @cantEnableBiometrics.
  ///
  /// In en, this message translates to:
  /// **'To enable the app\'s biometric protection, please activate biometrics on your device.'**
  String get cantEnableBiometrics;

  /// No description provided for @authRequired.
  ///
  /// In en, this message translates to:
  /// **'Authentication Required'**
  String get authRequired;

  /// No description provided for @continueAs.
  ///
  /// In en, this message translates to:
  /// **'Continue as: {name}'**
  String continueAs(String name);

  /// No description provided for @unlock.
  ///
  /// In en, this message translates to:
  /// **'Unlock'**
  String get unlock;

  /// No description provided for @stocks.
  ///
  /// In en, this message translates to:
  /// **'Stocks'**
  String get stocks;

  /// No description provided for @mutualFunds.
  ///
  /// In en, this message translates to:
  /// **'Mutual Funds'**
  String get mutualFunds;

  /// No description provided for @fixedIncome.
  ///
  /// In en, this message translates to:
  /// **'Fixed Income'**
  String get fixedIncome;

  /// No description provided for @reits.
  ///
  /// In en, this message translates to:
  /// **'Real Estate Investment Trusts (REITs)'**
  String get reits;

  /// No description provided for @treasuryBonds.
  ///
  /// In en, this message translates to:
  /// **'Treasury Bonds'**
  String get treasuryBonds;

  /// No description provided for @savingsAccount.
  ///
  /// In en, this message translates to:
  /// **'Savings Account'**
  String get savingsAccount;

  /// No description provided for @privatePensionPlans.
  ///
  /// In en, this message translates to:
  /// **'Private Pension Plans'**
  String get privatePensionPlans;

  /// No description provided for @commodities.
  ///
  /// In en, this message translates to:
  /// **'Commodities'**
  String get commodities;

  /// No description provided for @etfs.
  ///
  /// In en, this message translates to:
  /// **'Exchange Traded Funds (ETFs)'**
  String get etfs;

  /// No description provided for @cryptocurrencies.
  ///
  /// In en, this message translates to:
  /// **'Cryptocurrencies'**
  String get cryptocurrencies;

  /// No description provided for @exportInvestmentReport.
  ///
  /// In en, this message translates to:
  /// **'Export investment report'**
  String get exportInvestmentReport;

  /// No description provided for @emptyManageMyGoalsListing.
  ///
  /// In en, this message translates to:
  /// **'You have no goals added yet, use the floating button to add new goals.'**
  String get emptyManageMyGoalsListing;

  /// No description provided for @emptyManageMyInvestmentsListing.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have investments added yet, use the floating button to add your investments.'**
  String get emptyManageMyInvestmentsListing;

  /// No description provided for @addNewGoal.
  ///
  /// In en, this message translates to:
  /// **'Add new goal'**
  String get addNewGoal;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @goalDescriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Use this field to describe your goal or leave a note...'**
  String get goalDescriptionHint;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @removeMessage.
  ///
  /// In en, this message translates to:
  /// **'Do you really want to remove: {name}?\n\nThis change cannot be undone.'**
  String removeMessage(String name);

  /// No description provided for @editGoal.
  ///
  /// In en, this message translates to:
  /// **'Edit goal'**
  String get editGoal;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @addNewInvestment.
  ///
  /// In en, this message translates to:
  /// **'Add new investment'**
  String get addNewInvestment;

  /// No description provided for @investmentNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter investment name or ticker'**
  String get investmentNameHint;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @selectCategory.
  ///
  /// In en, this message translates to:
  /// **'Select category...'**
  String get selectCategory;

  /// No description provided for @addInvestmentsValuesAdvise.
  ///
  /// In en, this message translates to:
  /// **'The information below is optional. Only fill in if you do not wish to manually enter your previous operations.\n\nAttention: Use data from your bank/investment brokerage. These values will be used along with your future operations to update your data.'**
  String get addInvestmentsValuesAdvise;

  /// No description provided for @addInvestmentsValuesAdvise2.
  ///
  /// In en, this message translates to:
  /// **'When entering this data, you can only add more recent operations, the operations must be added in chronological order.'**
  String get addInvestmentsValuesAdvise2;

  /// No description provided for @startCustodialPosition.
  ///
  /// In en, this message translates to:
  /// **'Start position'**
  String get startCustodialPosition;

  /// No description provided for @startAveragePrice.
  ///
  /// In en, this message translates to:
  /// **'Avg start price'**
  String get startAveragePrice;

  /// No description provided for @editInvestment.
  ///
  /// In en, this message translates to:
  /// **'Edit investment'**
  String get editInvestment;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'Or'**
  String get or;

  /// No description provided for @amountInvested.
  ///
  /// In en, this message translates to:
  /// **'Amount invested'**
  String get amountInvested;

  /// No description provided for @changeName.
  ///
  /// In en, this message translates to:
  /// **'Change name'**
  String get changeName;

  /// No description provided for @quantityDisplay.
  ///
  /// In en, this message translates to:
  /// **'Quantity: {value}'**
  String quantityDisplay(String value);

  /// No description provided for @unitPriceDisplay.
  ///
  /// In en, this message translates to:
  /// **'Unit price: {value}'**
  String unitPriceDisplay(String value);

  /// No description provided for @emptyThisMonthOperations.
  ///
  /// In en, this message translates to:
  /// **'No operations performed this month, your recent operations will appear here. To view all operations, access your operations by clicking the button below.'**
  String get emptyThisMonthOperations;

  /// No description provided for @accessMyOperations.
  ///
  /// In en, this message translates to:
  /// **'Access my operations'**
  String get accessMyOperations;

  /// No description provided for @myOperations.
  ///
  /// In en, this message translates to:
  /// **'My operations'**
  String get myOperations;

  /// No description provided for @emptyManageMyOperationsText.
  ///
  /// In en, this message translates to:
  /// **'No operations found. Check the selected filters or if you still don\'t have operations, add them using the floating button below.'**
  String get emptyManageMyOperationsText;

  /// No description provided for @addNewOperation.
  ///
  /// In en, this message translates to:
  /// **'Add new operation'**
  String get addNewOperation;

  /// No description provided for @editOperation.
  ///
  /// In en, this message translates to:
  /// **'Edit operation'**
  String get editOperation;

  /// No description provided for @investment.
  ///
  /// In en, this message translates to:
  /// **'Investment'**
  String get investment;

  /// No description provided for @investmentHint.
  ///
  /// In en, this message translates to:
  /// **'Select investment...'**
  String get investmentHint;

  /// No description provided for @operationType.
  ///
  /// In en, this message translates to:
  /// **'Operation type'**
  String get operationType;

  /// No description provided for @operationTypeHint.
  ///
  /// In en, this message translates to:
  /// **'Select operation type...'**
  String get operationTypeHint;

  /// No description provided for @operationDate.
  ///
  /// In en, this message translates to:
  /// **'Operation date'**
  String get operationDate;

  /// No description provided for @quantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantity;

  /// No description provided for @unitPrice.
  ///
  /// In en, this message translates to:
  /// **'Unit price'**
  String get unitPrice;

  /// No description provided for @totalPrice.
  ///
  /// In en, this message translates to:
  /// **'Total price'**
  String get totalPrice;

  /// No description provided for @annotation.
  ///
  /// In en, this message translates to:
  /// **'Annotations'**
  String get annotation;

  /// No description provided for @optionalHint.
  ///
  /// In en, this message translates to:
  /// **'(Optional)'**
  String get optionalHint;

  /// No description provided for @purchase.
  ///
  /// In en, this message translates to:
  /// **'Purchase'**
  String get purchase;

  /// No description provided for @sale.
  ///
  /// In en, this message translates to:
  /// **'Sale'**
  String get sale;

  /// No description provided for @operationDescription.
  ///
  /// In en, this message translates to:
  /// **'Operation of {operation} worth {value} of investment {investment}'**
  String operationDescription(String operation, String value, String investment);

  /// No description provided for @positionDisplay.
  ///
  /// In en, this message translates to:
  /// **'Position: {value}'**
  String positionDisplay(String value);

  /// No description provided for @totalDisplay.
  ///
  /// In en, this message translates to:
  /// **'Total: {value}'**
  String totalDisplay(String value);

  /// No description provided for @salesOperationProfit.
  ///
  /// In en, this message translates to:
  /// **'Profit from sales operation'**
  String get salesOperationProfit;

  /// No description provided for @profitDisplay.
  ///
  /// In en, this message translates to:
  /// **'Profit: {value}'**
  String profitDisplay(String value);

  /// No description provided for @dontHaveInvestmentsTitle.
  ///
  /// In en, this message translates to:
  /// **'No investments added'**
  String get dontHaveInvestmentsTitle;

  /// No description provided for @dontHaveInvestmentsMessage.
  ///
  /// In en, this message translates to:
  /// **'You do not have added investments yet.\n\nAdd your investments to start entering operations.'**
  String get dontHaveInvestmentsMessage;

  /// No description provided for @goToMyInvestments.
  ///
  /// In en, this message translates to:
  /// **'Go to my investments'**
  String get goToMyInvestments;

  /// No description provided for @invalidValueErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Invalid value'**
  String get invalidValueErrorTitle;

  /// No description provided for @invalidValueErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Check the values entered in the form, the values must always be greater than 0.'**
  String get invalidValueErrorMessage;

  /// No description provided for @operationsCronologicalOrderAdvise.
  ///
  /// In en, this message translates to:
  /// **'Attention: Operations are inserted in chronological order. Therefore, when adding an operation on a certain date, you will only be able to add operations from that last date of the inserted operation.\n\nThe same works to remove an operation but in descending order , it must be removed from the most recent to the oldest.\n\nThis is a security measure to ensure that the calculation is 100% accurate.'**
  String get operationsCronologicalOrderAdvise;

  /// No description provided for @averagePriceVariationDisplay.
  ///
  /// In en, this message translates to:
  /// **'Avg price var: {value}'**
  String averagePriceVariationDisplay(String value);

  /// No description provided for @operationsFiltersTitle.
  ///
  /// In en, this message translates to:
  /// **'Filter operations'**
  String get operationsFiltersTitle;

  /// No description provided for @any.
  ///
  /// In en, this message translates to:
  /// **'Any'**
  String get any;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @fromDisplay.
  ///
  /// In en, this message translates to:
  /// **'From: {value}'**
  String fromDisplay(String value);

  /// No description provided for @toDisplay.
  ///
  /// In en, this message translates to:
  /// **'To: {value}'**
  String toDisplay(String value);

  /// No description provided for @period.
  ///
  /// In en, this message translates to:
  /// **'Period'**
  String get period;

  /// No description provided for @orderByDate.
  ///
  /// In en, this message translates to:
  /// **'Order by date'**
  String get orderByDate;

  /// No description provided for @ascending.
  ///
  /// In en, this message translates to:
  /// **'Ascending'**
  String get ascending;

  /// No description provided for @descending.
  ///
  /// In en, this message translates to:
  /// **'Descending'**
  String get descending;

  /// No description provided for @applyFilters.
  ///
  /// In en, this message translates to:
  /// **'Apply filters'**
  String get applyFilters;

  /// No description provided for @resetFilters.
  ///
  /// In en, this message translates to:
  /// **'Reset filters'**
  String get resetFilters;

  /// No description provided for @pastMonth.
  ///
  /// In en, this message translates to:
  /// **'Last month'**
  String get pastMonth;

  /// No description provided for @thisMonth.
  ///
  /// In en, this message translates to:
  /// **'This month'**
  String get thisMonth;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get tryAgain;

  /// No description provided for @subscription.
  ///
  /// In en, this message translates to:
  /// **'Subscription'**
  String get subscription;

  /// No description provided for @subscriptionDisplay.
  ///
  /// In en, this message translates to:
  /// **'Subscription: {value}'**
  String subscriptionDisplay(String value);

  /// No description provided for @freeWithAdsSubscription.
  ///
  /// In en, this message translates to:
  /// **'Free (with ads)'**
  String get freeWithAdsSubscription;

  /// No description provided for @monthlySubscription.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get monthlySubscription;

  /// No description provided for @annualSubscription.
  ///
  /// In en, this message translates to:
  /// **'Annual'**
  String get annualSubscription;

  /// No description provided for @unlimitedSubscription.
  ///
  /// In en, this message translates to:
  /// **'Pro (unlimited)'**
  String get unlimitedSubscription;

  /// No description provided for @change.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get change;

  /// No description provided for @functionNotImplementedTitle.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get functionNotImplementedTitle;

  /// No description provided for @functionNotImplementedMessage.
  ///
  /// In en, this message translates to:
  /// **'This functionality has not yet been implemented.\n\nPlease wait for the next versions.'**
  String get functionNotImplementedMessage;

  /// No description provided for @termsOfUseTitle.
  ///
  /// In en, this message translates to:
  /// **'Terms of use and privacy policy'**
  String get termsOfUseTitle;

  /// No description provided for @termsOfUseMessage.
  ///
  /// In en, this message translates to:
  /// **'Welcome to InvestHelper!\n\nBy using our application, you agree to the following terms and conditions:\n\n1. Purpose of the Application: InvestHelper is a tool designed to assist in managing your investments. We do not provide investment advice or recommendations. The application is intended for informational and personal record-keeping purposes only.\n\n2. User Responsibility: You are solely responsible for the accuracy and integrity of the data entered into InvestHelper. We are not responsible for any errors or incorrect information provided by the user.\n\n3. Investment Risks: It is important to understand that financial investments are subject to risks. InvestHelper does not guarantee specific financial results and does not offer profitability guarantees. We recommend seeking professional financial advice before making investment decisions.\n\n4. Privacy and Data Protection: By using InvestHelper, we collect and store your name, email address, and password for user authentication. We also collect and store information about your investments, operations, and goals entered within the application. We are committed to protecting your personal information and using this data only for the purposes described in this terms of use and in accordance with our privacy policy.\n\n5. Data Security: We implement appropriate technical and organizational security measures to protect your data against unauthorized access, misuse, or unauthorized disclosure.\n\n6. User Consent: By using InvestHelper, you consent to the collection, use, and storage of your personal information in accordance with the terms of this terms of use and our privacy policy.\n\n7. Data Deletion: You have total freedom to delete your personal data directly from the application, including the option to delete your account. Please contact us if you need assistance or have any questions about the data deletion process.\n\n8. Updates to the Terms of Use and Privacy Policy: We may revise and update these terms of use and our privacy policy periodically. We will notify users of any significant changes and request their consent, when applicable.\n\nBy clicking \"I accept\" or continuing to use the application, you agree to these terms of use and our privacy policy. If you do not agree to these terms, please do not use InvestHelper.\n\nLast updated: April 13, 2024.'**
  String get termsOfUseMessage;

  /// No description provided for @accept.
  ///
  /// In en, this message translates to:
  /// **'I accept'**
  String get accept;

  /// No description provided for @notAccept.
  ///
  /// In en, this message translates to:
  /// **'I do not accept'**
  String get notAccept;

  /// No description provided for @deleteMyAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete my account and data'**
  String get deleteMyAccountTitle;

  /// No description provided for @deleteMyAccountMessage.
  ///
  /// In en, this message translates to:
  /// **'When you delete your account, if you have a subscription it will be automatically canceled and in addition, all your data entered into the app will be permanently deleted along with your account. This includes investments, operations, goals...\n \nDo you really want to delete your account permanently?\n\nThis action cannot be undone.'**
  String get deleteMyAccountMessage;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get changePassword;

  /// No description provided for @currentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current password'**
  String get currentPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get newPassword;

  /// No description provided for @newPasswordConfirmation.
  ///
  /// In en, this message translates to:
  /// **'New password confirmation'**
  String get newPasswordConfirmation;

  /// No description provided for @newPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter a new password'**
  String get newPasswordHint;

  /// No description provided for @security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get security;

  /// No description provided for @continueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueWithGoogle;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'pt': return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
