// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'InvestHelper';

  @override
  String get aboutAppText => 'InvestHelper is an application designed to make managing your investments easier. With it, you can track your investments, manage your transactions, and set goals and reminders to achieve your investment objectives.';

  @override
  String get developedBy => 'Developed by';

  @override
  String get welcomeText1 => 'Welcome to your new ally in achieving your financial goals! Start on the path to a successful investment journey with our app.';

  @override
  String get welcomeText2 => 'Our app is here to simplify your financial life, allowing you to track your transactions with ease and generate accurate, detailed reports when you need them.';

  @override
  String get welcomeText3 => 'Save time and eliminate stress when managing your investments. With our intuitive app, you can accomplish tasks in minutes that used to take hours, freeing up valuable time to enjoy other life activities.';

  @override
  String get back => 'Back';

  @override
  String get next => 'Next';

  @override
  String get letsStart => 'Let\'s Start';

  @override
  String get authPageLoginTitle => 'Log in with your account';

  @override
  String get authPageLoginSubtitle => 'Fill in the fields below to log in';

  @override
  String get authPageRegisterTitle => 'Create your account';

  @override
  String get authPageRegisterSubtitle => 'Fill in the fields below to register on our app';

  @override
  String get authPageRecoveryTitle => 'Password Reset';

  @override
  String get authPageRecoverySubtitle => 'Enter your email below and we will send you a link to reset your password.';

  @override
  String get name => 'Name';

  @override
  String get nameHint => 'What do you want to be called?';

  @override
  String get email => 'Email';

  @override
  String get emailHint => 'login@example.com';

  @override
  String get password => 'Password';

  @override
  String get passwordHint => 'Enter your password...';

  @override
  String get passwordConfirmation => 'Password confirmation';

  @override
  String get passwordConfirmationHint => 'Repeat the previously entered password...';

  @override
  String get makeLogin => 'Login';

  @override
  String get login => 'Login';

  @override
  String get makeRegister => 'Complete Registration';

  @override
  String get register => 'Register';

  @override
  String get sendRecoveryEmail => 'Send recovery email';

  @override
  String get forgotMyPassword => 'I forgot my password';

  @override
  String get dontHaveAnAccountYet => 'Don\'t have an account yet?';

  @override
  String get alreadyHaveAnAccount => 'Already have an account?';

  @override
  String get myInvestments => 'My investments';

  @override
  String get totalInvestment => 'Total investments';

  @override
  String get monthsOperations => 'Operations performed this month';

  @override
  String get purchaseOperations => 'Purchase operations';

  @override
  String get salesOperations => 'Sales operations';

  @override
  String get seeMyOperations => 'See my operations';

  @override
  String get myGoals => 'My goals';

  @override
  String get diversity => 'Diversity';

  @override
  String get tips => 'Tips';

  @override
  String get quickActions => 'Quick Actions';

  @override
  String get insertPurchaseOperation => 'Insert purchase operation';

  @override
  String get insertSaleOperation => 'Insert sale operation';

  @override
  String get editMyGoals => 'Edit my goals';

  @override
  String get overview => 'Overview';

  @override
  String get investments => 'Investments';

  @override
  String hiUser(String name) {
    return 'Hi, $name.';
  }

  @override
  String get accessMyInvestments => 'Access my investments';

  @override
  String get categories => 'Categories';

  @override
  String get productsAndServices => 'Products and services';

  @override
  String custodialPositionDisplay(String value) {
    return 'Custodial position: $value';
  }

  @override
  String amountInvestedDisplay(String value) {
    return 'Amount invested: $value';
  }

  @override
  String averagePriceDisplay(String value) {
    return 'Average price: $value';
  }

  @override
  String get operationsHistoryPerformed => 'History of operations performed';

  @override
  String get settings => 'Settings';

  @override
  String get myProfile => 'My Profile';

  @override
  String get changePersonalData => 'Change personal data';

  @override
  String get endSession => 'End session';

  @override
  String get protection => 'Protection';

  @override
  String get enableBiometrics => 'Enable Biometrics';

  @override
  String get enableBiometricsHint => 'Protect your data using your biometrics to access the app.';

  @override
  String get personalization => 'Personalization';

  @override
  String get appTheme => 'App theme';

  @override
  String get appLanguage => 'App language';

  @override
  String get system => 'System';

  @override
  String get lightMode => 'Light Mode';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get english => 'English';

  @override
  String get portuguese => 'Portuguese';

  @override
  String get others => 'Others';

  @override
  String get aboutThisApp => 'About this app';

  @override
  String get close => 'Close';

  @override
  String get genericErrorTitle => 'Unexpected error';

  @override
  String get genericErrorMessage => 'A communication error occurred, please try again in a few seconds.';

  @override
  String get emptyFieldsErrorTitle => 'One or more empty fields';

  @override
  String get emptyFieldsErrorMessage => 'Some required information is pending, please check the form and try again.';

  @override
  String get incorrectUserOrPasswordErrorTitle => 'User not found';

  @override
  String get incorrectUserOrPasswordErrorMessage => 'The email and/or password entered may be incorrect.';

  @override
  String get incorrectPasswordErrorTitle => 'Incorrect password';

  @override
  String get incorrectPasswordErrorMessage => 'The current password entered is incorrect.';

  @override
  String get userAlreadyExistsErrorTitle => 'User already registered';

  @override
  String get userAlreadyExistsErrorMessage => 'An account associated with this email address already exists.';

  @override
  String get invalidEmailErrorTitle => 'Invalid Email';

  @override
  String get invalidEmailErrorMessage => 'Please enter a valid email address.';

  @override
  String get invalidPasswordErrorTitle => 'Invalid password';

  @override
  String get invalidPasswordErrorMessage => 'Your password cannot contain less than 8 characters.';

  @override
  String get passwordsDontMatchErrorTitle => 'Invalid password confirmation';

  @override
  String get passwordsDontMatchErrorMessage => 'Password confirmation must be exactly the same as your password.';

  @override
  String get invalidRecoveryEmailErrorTitle => 'Invalid Email';

  @override
  String get invalidRecoveryEmailErrorMessage => 'There is no account associated with this email address.';

  @override
  String get recoveryEmailSentTitle => 'Recovery email sent';

  @override
  String get recoveryEmailSentMessage => 'If there is an account registered with this email address, you will receive a link to reset your password.\n\nAfter resetting, log in normally using your new password.';

  @override
  String get connectionErrorTitle => 'Connection error';

  @override
  String get connectionErrorMessage => 'There was a problem connecting to the server, please check your connection and try again.';

  @override
  String get endSessionMessage => 'Do you really want to log out of your account?';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get emptyDiversityGraphText => 'Add your investments and operations to display the diversity graph.';

  @override
  String get emptyMyGoalsText => 'There are no goals set. Add goals or reminders and they will appear here.';

  @override
  String get emptyInvestmentsText => 'No investments added. Add your investments to start using the app.';

  @override
  String get cantEnableBiometrics => 'To enable the app\'s biometric protection, please activate biometrics on your device.';

  @override
  String get authRequired => 'Authentication Required';

  @override
  String continueAs(String name) {
    return 'Continue as: $name';
  }

  @override
  String get unlock => 'Unlock';

  @override
  String get stocks => 'Stocks';

  @override
  String get mutualFunds => 'Mutual Funds';

  @override
  String get fixedIncome => 'Fixed Income';

  @override
  String get reits => 'Real Estate Investment Trusts (REITs)';

  @override
  String get treasuryBonds => 'Treasury Bonds';

  @override
  String get savingsAccount => 'Savings Account';

  @override
  String get privatePensionPlans => 'Private Pension Plans';

  @override
  String get commodities => 'Commodities';

  @override
  String get etfs => 'Exchange Traded Funds (ETFs)';

  @override
  String get cryptocurrencies => 'Cryptocurrencies';

  @override
  String get exportInvestmentReport => 'Export investment report';

  @override
  String get emptyManageMyGoalsListing => 'You have no goals added yet, use the floating button to add new goals.';

  @override
  String get emptyManageMyInvestmentsListing => 'You don\'t have investments added yet, use the floating button to add your investments.';

  @override
  String get addNewGoal => 'Add new goal';

  @override
  String get description => 'Description';

  @override
  String get goalDescriptionHint => 'Use this field to describe your goal or leave a note...';

  @override
  String get send => 'Send';

  @override
  String get cancel => 'Cancel';

  @override
  String get remove => 'Remove';

  @override
  String removeMessage(String name) {
    return 'Do you really want to remove: $name?\n\nThis change cannot be undone.';
  }

  @override
  String get editGoal => 'Edit goal';

  @override
  String get save => 'Save';

  @override
  String get addNewInvestment => 'Add new investment';

  @override
  String get investmentNameHint => 'Enter investment name or ticker';

  @override
  String get category => 'Category';

  @override
  String get selectCategory => 'Select category...';

  @override
  String get addInvestmentsValuesAdvise => 'The information below is optional. Only fill in if you do not wish to manually enter your previous operations.\n\nAttention: Use data from your bank/investment brokerage. These values will be used along with your future operations to update your data.';

  @override
  String get addInvestmentsValuesAdvise2 => 'When entering this data, you can only add more recent operations, the operations must be added in chronological order.';

  @override
  String get startCustodialPosition => 'Start position';

  @override
  String get startAveragePrice => 'Avg start price';

  @override
  String get editInvestment => 'Edit investment';

  @override
  String get or => 'Or';

  @override
  String get amountInvested => 'Amount invested';

  @override
  String get changeName => 'Change name';

  @override
  String quantityDisplay(String value) {
    return 'Quantity: $value';
  }

  @override
  String unitPriceDisplay(String value) {
    return 'Unit price: $value';
  }

  @override
  String get emptyThisMonthOperations => 'No operations performed this month, your recent operations will appear here. To view all operations, access your operations by clicking the button below.';

  @override
  String get accessMyOperations => 'Access my operations';

  @override
  String get myOperations => 'My operations';

  @override
  String get emptyManageMyOperationsText => 'No operations found. Check the selected filters or if you still don\'t have operations, add them using the floating button below.';

  @override
  String get addNewOperation => 'Add new operation';

  @override
  String get editOperation => 'Edit operation';

  @override
  String get investment => 'Investment';

  @override
  String get investmentHint => 'Select investment...';

  @override
  String get operationType => 'Operation type';

  @override
  String get operationTypeHint => 'Select operation type...';

  @override
  String get operationDate => 'Operation date';

  @override
  String get quantity => 'Quantity';

  @override
  String get unitPrice => 'Unit price';

  @override
  String get totalPrice => 'Total price';

  @override
  String get annotation => 'Annotations';

  @override
  String get optionalHint => '(Optional)';

  @override
  String get purchase => 'Purchase';

  @override
  String get sale => 'Sale';

  @override
  String operationDescription(String operation, String value, String investment) {
    return 'Operation of $operation worth $value of investment $investment';
  }

  @override
  String positionDisplay(String value) {
    return 'Position: $value';
  }

  @override
  String totalDisplay(String value) {
    return 'Total: $value';
  }

  @override
  String get salesOperationProfit => 'Profit from sales operation';

  @override
  String profitDisplay(String value) {
    return 'Profit: $value';
  }

  @override
  String get dontHaveInvestmentsTitle => 'No investments added';

  @override
  String get dontHaveInvestmentsMessage => 'You do not have added investments yet.\n\nAdd your investments to start entering operations.';

  @override
  String get goToMyInvestments => 'Go to my investments';

  @override
  String get invalidValueErrorTitle => 'Invalid value';

  @override
  String get invalidValueErrorMessage => 'Check the values entered in the form, the values must always be greater than 0.';

  @override
  String get operationsCronologicalOrderAdvise => 'Attention: Operations are inserted in chronological order. Therefore, when adding an operation on a certain date, you will only be able to add operations from that last date of the inserted operation.\n\nThe same works to remove an operation but in descending order , it must be removed from the most recent to the oldest.\n\nThis is a security measure to ensure that the calculation is 100% accurate.';

  @override
  String averagePriceVariationDisplay(String value) {
    return 'Avg price var: $value';
  }

  @override
  String get operationsFiltersTitle => 'Filter operations';

  @override
  String get any => 'Any';

  @override
  String get all => 'All';

  @override
  String fromDisplay(String value) {
    return 'From: $value';
  }

  @override
  String toDisplay(String value) {
    return 'To: $value';
  }

  @override
  String get period => 'Period';

  @override
  String get orderByDate => 'Order by date';

  @override
  String get ascending => 'Ascending';

  @override
  String get descending => 'Descending';

  @override
  String get applyFilters => 'Apply filters';

  @override
  String get resetFilters => 'Reset filters';

  @override
  String get pastMonth => 'Last month';

  @override
  String get thisMonth => 'This month';

  @override
  String get tryAgain => 'Try again';

  @override
  String get subscription => 'Subscription';

  @override
  String subscriptionDisplay(String value) {
    return 'Subscription: $value';
  }

  @override
  String get freeSubscription => 'Free';

  @override
  String get monthlySubscription => 'Pro (Monthly)';

  @override
  String get annualSubscription => 'Pro (Annual)';

  @override
  String get unlimitedSubscription => 'Pro (unlimited)';

  @override
  String get change => 'Change';

  @override
  String get functionNotImplementedTitle => 'Coming soon';

  @override
  String get functionNotImplementedMessage => 'This functionality has not yet been implemented.\n\nPlease wait for the next versions.';

  @override
  String get termsOfUseTitle => 'Terms of use and privacy policy';

  @override
  String get termsOfUseMessage => 'By using our app, you agree to our terms of use and privacy policy. Access the full clauses below:';

  @override
  String get accept => 'I accept';

  @override
  String get notAccept => 'I do not accept';

  @override
  String get deleteMyAccountTitle => 'Delete my account and data';

  @override
  String get deleteMyAccountMessage => 'When you delete your account, if you have a subscription it will be automatically canceled and in addition, all your data entered into the app will be permanently deleted along with your account. This includes investments, operations, goals...\n \nDo you really want to delete your account permanently?\n\nThis action cannot be undone.';

  @override
  String get changePassword => 'Change password';

  @override
  String get currentPassword => 'Current password';

  @override
  String get newPassword => 'New password';

  @override
  String get newPasswordConfirmation => 'New password confirmation';

  @override
  String get newPasswordHint => 'Enter a new password';

  @override
  String get security => 'Security';

  @override
  String get continueWithGoogle => 'Continue with Google';

  @override
  String get chooseYourPlan => 'Choose your plan';

  @override
  String get choosePlanDescription => 'Choose the plan that best suits your needs. You can change or cancel at any time.';

  @override
  String get freePlanLimitWarning => 'You have reached the limit of 3 investments in the free plan. You won\'t be able to add new investments or manage operations for existing investments beyond this limit. Upgrade now to add more investments and access all features!';

  @override
  String get freeSubscriptionFeatures => 'Up to 3 investments\nBasic features';

  @override
  String get monthlySubscriptionFeatures => 'Unlimited investments\nAll features';

  @override
  String get annualSubscriptionFeatures => 'Unlimited investments\nAll features\n2 months free';

  @override
  String get unlimitedSubscriptionFeatures => 'Unlimited investments\nAll features\nLifetime access';

  @override
  String get storeNotAvailableErrorTitle => 'Store not available';

  @override
  String get storeNotAvailableErrorMessage => 'The app store is not available at the moment. Please try again later.';

  @override
  String get productNotFoundErrorTitle => 'Product not found';

  @override
  String get productNotFoundErrorMessage => 'The subscription product was not found. Please try again later.';

  @override
  String get purchaseErrorTitle => 'Purchase error';

  @override
  String get purchaseErrorMessage => 'An error occurred while processing your purchase. Please try again later.';

  @override
  String get subscriptionLimitReachedTitle => 'Subscription limit reached';

  @override
  String get subscriptionLimitReachedMessage => 'You have reached the maximum number of investments for the free plan. Please upgrade to continue adding investments.';

  @override
  String get iosSubscriptionDisclaimer => 'Payment will be charged to your Apple ID account at the confirmation of purchase. Subscription automatically renews unless it is canceled at least 24 hours before the end of the current period. Your account will be charged for renewal within 24 hours prior to the end of the current period. You can manage and cancel your subscriptions by going to your account settings on the App Store after purchase.';

  @override
  String get androidSubscriptionDisclaimer => 'To cancel your subscription, please go to the Google Play Store > Account > Subscriptions and cancel your InvestHelper subscription. Your subscription will remain active until the end of the current billing period.';

  @override
  String get error => 'Error';

  @override
  String get purchasePendingErrorTitle => 'Purchase in progress';

  @override
  String get purchasePendingErrorMessage => 'Your purchase is being processed. Please wait for the confirmation.';

  @override
  String get success => 'Success';

  @override
  String get planUpdated => 'Your subscription plan has been updated successfully.';

  @override
  String get cancelSubscriptionTitle => 'Cancel subscription';

  @override
  String cancelSubscriptionMessage(String date) {
    return 'Do you really want to cancel your subscription and return to the free plan?\n\nYour current subscription will remain valid until $date.';
  }

  @override
  String get attention => 'Attention';

  @override
  String get needPasswordToDeleteAccount => 'To delete your account, you need to have a password set up.';

  @override
  String get checkEmailForPasswordReset => 'Please check your email for instructions on how to set up a password, then log in using your email and password instead of Google Sign-In.';

  @override
  String get subscriptionProcessingTitle => 'Processing subscription';

  @override
  String get subscriptionProcessingMessage => 'Your subscription is being processed. This may take a few moments.';
}
