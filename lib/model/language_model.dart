import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'language_model.g.dart';

@HiveType(typeId: 132)
@JsonSerializable(includeIfNull: false)
class Language extends HiveObject{
  @JsonKey(name: 'knaw_news',)
  @HiveField(1)
  String knawNews;
  @HiveField(2)
  String dashboard;
  @HiveField(3)
  String account;
  @JsonKey(name: 'manage_profile',)
  @HiveField(4)
  String manageProfile;
  @HiveField(5)
  String name;
  @HiveField(6)
  String language;
  @HiveField(7)
  String settings;
  @JsonKey(name: 'change_password',)
  @HiveField(8)
  String changePassword;
  @JsonKey(name: 'new_password',)
  @HiveField(9)
  String newPassword;
  @JsonKey(name: 'confirm_new_password',)
  @HiveField(10)
  String confirmNewPassword;
  @JsonKey(name: 'sign_in',)
  @HiveField(11)
  String signIn;
  @JsonKey(name: 'sign_up',)
  @HiveField(12)
  String signUp;
  @JsonKey(name: 'sign_in_with_email',)
  @HiveField(13)
  String signInWithEmail;
  @JsonKey(name: 'sign_in_with_facebook',)
  @HiveField(14)
  String signInWithFacebook;
  @JsonKey(name: 'sign_in_with_google',)
  @HiveField(15)
  String signInWithGoogle;
  @HiveField(16)
  String hey;
  @JsonKey(name: 'signup_now',)
  @HiveField(17)
  String signupNow;
  @JsonKey(name: 'user_name',)
  @HiveField(18)
  String userName;
  @HiveField(19)
  String email;
  @HiveField(20)
  String password;
  @JsonKey(name: 'confirm_password',)
  @HiveField(21)
  String confirmPassword;
  @HiveField(22)
  String signup;
  @HiveField(23)
  String login;
  @JsonKey(name: 'already_a_member',)
  @HiveField(24)
  String alreadyMember;
  @JsonKey(name: 'login_now',)
  @HiveField(25)
  String loginNow;
  @JsonKey(name: 'enter_name_and_pass',)
  @HiveField(26)
  String enterNameAndPass;
  @JsonKey(name: 'remember_me',)
  @HiveField(27)
  String rememberMe;
  @JsonKey(name: 'forgot_password',)
  @HiveField(28)
  String forgotPassword;
  @JsonKey(name: 'i_am_new_user',)
  @HiveField(29)
  String iAmNewUser;
  @HiveField(30)
  String forgot;
  @JsonKey(name: 'enter_email_to_reset_pass',)
  @HiveField(31)
  String enterEmailToResetPass;
  @HiveField(32)
  String send;
  @JsonKey(name: 'enter_4_digit_code_forwarded_on',)
  @HiveField(33)
  String enter4DigitCodeForwardedOn;
  @HiveField(34)
  String next;
  @JsonKey(name: 'enter_new_and_confirm_pass',)
  @HiveField(35)
  String enterNewAndConfirmPass;
  @HiveField(36)
  String reset;
  @HiveField(37)
  String inbox;
  @JsonKey(name: 'bookmark_posts',)
  @HiveField(38)
  String bookmarkPosts;
  @JsonKey(name: 'my_knaw_news',)
  @HiveField(39)
  String myKnawNews;
  @HiveField(40)
  String about;
  @JsonKey(name: 'contact_us',)
  @HiveField(41)
  String contactUs;
  @HiveField(42)
  String logout;
  @HiveField(43)
  String join;
  @HiveField(44)
  String yesterday;
  @JsonKey(name: 'this_week',)
  @HiveField(45)
  String thisWeek;
  @HiveField(46)
  String follow;
  @HiveField(47)
  String unfollow;
  @HiveField(48)
  String subject;
  @JsonKey(name: 'whats_your_message_about',)
  @HiveField(49)
  String whatsYourMessageAbout;
  @JsonKey(name: 'change_username',)
  @HiveField(50)
  String changeUsername;
  @JsonKey(name: 'active_your_account',)
  @HiveField(51)
  String activeYourAccount;
  @JsonKey(name: 'delete_your_account',)
  @HiveField(52)
  String deleteYourAccount;
  @JsonKey(name: 'keyword_alerts',)
  @HiveField(53)
  String keywordAlerts;
  @JsonKey(name: 'legal_and_complaints',)
  @HiveField(54)
  String legalAndComplaints;
  @JsonKey(name: 'bug_or_feature_request',)
  @HiveField(55)
  String bugOrFeatureRequest;
  @JsonKey(name: 'contact_moderator_team',)
  @HiveField(56)
  String contactModeratorTeam;
  @JsonKey(name: 'b2b_PR_other_problem',)
  @HiveField(57)
  String b2bPROtherProblem;
  @JsonKey(name: 'your_name',)
  @HiveField(58)
  String yourName;
  @JsonKey(name: 'mark_wood',)
  @HiveField(59)
  String markMood;
  @JsonKey(name: 'your_email_address',)
  @HiveField(60)
  String yourEmailAddress;
  @JsonKey(name: 'gmail_hint',)
  @HiveField(61)
  String gmailHint;
  @HiveField(62)
  String message;
  @JsonKey(name: 'write_the_message',)
  @HiveField(63)
  String writeTheMessage;
  @JsonKey(name: 'send_message',)
  @HiveField(64)
  String sendMessage;
  @HiveField(65)
  String search;
  @JsonKey(name: 'type_topic_to_search_news',)
  @HiveField(66)
  String typeTopicToSearchNews;
  @HiveField(67)
  String recent;
  @JsonKey(name: 'view_all',)
  @HiveField(68)
  String viewAll;
  @HiveField(69)
  String filters;
  @JsonKey(name: 'date_filter',)
  @HiveField(70)
  String dateFilter;
  @JsonKey(name: 'any_time',)
  @HiveField(71)
  String anyTime;
  @JsonKey(name: 'past_hour',)
  @HiveField(72)
  String pastHour;
  @JsonKey(name: 'past_24_hour',)
  @HiveField(73)
  String past24Hour;
  @JsonKey(name: 'past_week',)
  @HiveField(74)
  String pastWeek;
  @JsonKey(name: 'past_month',)
  @HiveField(75)
  String pastMonth;
  @JsonKey(name: 'past_year',)
  @HiveField(76)
  String pastYear;
  @JsonKey(name: 'custom_range',)
  @HiveField(77)
  String customRange;
  @JsonKey(name: 'most_commented',)
  @HiveField(78)
  String mostCommented;
  @HiveField(79)
  String gloomiest;
  @HiveField(80)
  String trending;
  @HiveField(81)
  String happiest;
  @JsonKey(name: 'order_by',)
  @HiveField(82)
  String orderBy;
  @HiveField(83)
  String ascending;
  @HiveField(84)
  String descending;
  @HiveField(85)
  String location;
  @HiveField(86)
  String apply;
  @HiveField(87)
  String post;
  @JsonKey(name: 'add_a_photo',)
  @HiveField(88)
  String addAPhoto;
  @HiveField(89)
  String title;
  @JsonKey(name: 'your_description',)
  @HiveField(90)
  String yourDescription;
  @HiveField(91)
  String category;
  @JsonKey(name: 'indefinit_remain',)
  @HiveField(92)
  String indefinitRemain;
  @JsonKey(name: 'event_starts',)
  @HiveField(93)
  String eventStarts;
  @JsonKey(name: 'event_expires',)
  @HiveField(94)
  String eventExpires;
  @HiveField(95)
  String link;
  @JsonKey(name: 'add_location_or_country',)
  @HiveField(96)
  String addLocationOrCountry;
  @HiveField(97)
  String ok;
  @HiveField(98)
  String profile;
  @HiveField(99)
  String joined;
  @HiveField(100)
  String followers;
  @HiveField(101)
  String posts;
  @HiveField(102)
  String bookmarks;
  @HiveField(103)
  String stats;
  @HiveField(104)
  String views;
  @HiveField(105)
  String comments;
  @HiveField(106)
  String following;
  @JsonKey(name: 'account_setting',)
  @HiveField(107)
  String accountSetting;
  @JsonKey(name: 'change_email',)
  @HiveField(108)
  String changeEmail;
  @JsonKey(name: 'change_your_password',)
  @HiveField(109)
  String changeYourPassword;
  @JsonKey(name: 'muted_members',)
  @HiveField(110)
  String mutedMembers;
  @HiveField(111)
  String notifications;
  @HiveField(112)
  String update;
  @HiveField(113)
  String change;
  @JsonKey(name: 'enter_new_email',)
  @HiveField(114)
  String enterNewEmail;
  @JsonKey(name: 'old_password',)
  @HiveField(115)
  String oldPassword;
  @HiveField(116)
  String setting;
  @HiveField(117)
  String happy;
  @HiveField(118)
  String gloomy;
  @JsonKey(name: 'your_news_feed',)
  @HiveField(119)
  String yourNewsFeed;
  @JsonKey(name: 'global_news',)
  @HiveField(120)
  String globalNews;
  @HiveField(121)
  String events;
  @HiveField(122)
  String business;
  @HiveField(123)
  String opinion;
  @HiveField(124)
  String technology;
  @HiveField(125)
  String entertainment;
  @HiveField(126)
  String sports;
  @HiveField(127)
  String beauty;
  @HiveField(128)
  String science;
  @HiveField(129)
  String health;
  @JsonKey(name: 'read_more',)
  @HiveField(130)
  String readMore;
  @HiveField(131)
  String share;
  @HiveField(132)
  String source;
  @JsonKey(name: 'report_thread',)
  @HiveField(133)
  String reportThread;
  @JsonKey(name: 'violent_repulsive',)
  @HiveField(134)
  String violentRepulsive;
  @JsonKey(name: 'hateful_abusive',)
  @HiveField(135)
  String hatefulAbusive;
  @JsonKey(name: 'sexual_content',)
  @HiveField(136)
  String sexualContent;
  @JsonKey(name: 'spam_misleading',)
  @HiveField(137)
  String spamMisleading;
  @HiveField(138)
  String expired;
  @JsonKey(name: 'add_comment',)
  @HiveField(139)
  String addComment;
  @HiveField(140)
  String reply;
  @JsonKey(name: 'view_replies',)
  @HiveField(141)
  String viewReplies;
  @JsonKey(name: 'add_reply',)
  @HiveField(142)
  String addReply;
  @JsonKey(name: 'replying_to',)
  @HiveField(143)
  String replyingTo;
  @HiveField(144)
  String cancel;
  @HiveField(145)
  String mute;
  @HiveField(146)
  String unmute;
  @HiveField(147)
  String select;
  @HiveField(148)
  String selected;
  @JsonKey(name: 'current_language',)
  @HiveField(149)
  String currentLanguage;
  @JsonKey(name: 'recent_posts',)
  @HiveField(150)
  String recentPosts;
  @HiveField(151)
  String home;
  @HiveField(152)
  String copyright;
  @JsonKey(name: 'privacy_policy',)
  @HiveField(153)
  String privacyPolicy;
  @JsonKey(name: 'terms_&_conditions',)
  @HiveField(154)
  String termsConditions;
  @JsonKey(name: 'how_knawnews_works',)
  @HiveField(155)
  String howKnawNewsWorks;
  @HiveField(156)
  String oR;
  @JsonKey(name: 'language_code',)
  @HiveField(157)
  String languageCode;
  @JsonKey(name: 'following_accounts',)
  @HiveField(158)
  String followingAccounts;
  @JsonKey(name: 'suggested_accounts',)
  @HiveField(159)
  String suggestedAccounts;
  @JsonKey(name: 'create_post',)
  @HiveField(160)
  String createPost;
  @JsonKey(name: 'load_more',)
  @HiveField(161)
  String loadMore;
  @JsonKey(name: 'my_profile_setting',)
  @HiveField(162)
  String myProfileSetting;
  @HiveField(163)
  String Save;
  @HiveField(164)
  String loading;
  Language({
    this.knawNews="",this.dashboard="",this.account="",this.name="",this.language="",this.settings="",
    this.manageProfile="",this.changePassword="",this.newPassword="",this.confirmNewPassword="",
    this.signIn="",this.signUp="",this.signInWithEmail="",this.signInWithFacebook="",this.signInWithGoogle="",
    this.hey="",this.signupNow="",this.userName="",this.email="",this.password="",this.confirmPassword="",
    this.signup="",this.login="",this.loginNow="",this.alreadyMember="",this.enterNameAndPass="",
    this.rememberMe="",this.forgotPassword="",this.iAmNewUser="",this.forgot="",this.enterEmailToResetPass="",
    this.send="",this.enter4DigitCodeForwardedOn="",this.next="",this.enterNewAndConfirmPass="",
    this.reset="",this.inbox="",this.bookmarkPosts="",this.myKnawNews="",this.about="",this.contactUs="",
    this.logout="",this.join="",this.yesterday="",this.thisWeek="",this.follow="",this.unfollow="",
    this.subject="",this.whatsYourMessageAbout="",this.changeUsername="",this.activeYourAccount="",
    this.deleteYourAccount="",this.keywordAlerts="",this.legalAndComplaints="",this.bugOrFeatureRequest="",
    this.contactModeratorTeam="",this.b2bPROtherProblem="",this.yourName="",this.markMood="",
    this.yourEmailAddress="",this.gmailHint="",this.message="",this.writeTheMessage="",this.sendMessage="",
    this.search="",this.typeTopicToSearchNews="",this.recent="",this.viewAll="",this.filters="",
    this.dateFilter="",this.anyTime="",this.pastHour="",this.past24Hour="",this.pastWeek="",
    this.pastMonth="",this.pastYear="",this.customRange="",this.mostCommented="",this.gloomiest="",
    this.trending="",this.happiest="",this.orderBy="",this.ascending="",this.descending="",this.location="",
    this.apply="",this.post="",this.addAPhoto="",this.title="",this.yourDescription="",this.category="",
    this.indefinitRemain="",this.addLocationOrCountry="",this.eventExpires="",this.eventStarts="",
    this.link="",this.ok="",this.profile="",this.joined="",this.followers="",this.posts="",
    this.bookmarks="",this.stats="",this.setting="",this.accountSetting="",this.changeEmail="",
    this.changeYourPassword="",this.mutedMembers="",this.notifications="",this.update="",this.change="",
    this.enterNewEmail="",this.oldPassword="",this.comments="",this.views="",this.following="",
    this.happy="",this.gloomy="",this.yourNewsFeed="",this.globalNews="",this.events="",this.business="",
    this.opinion="",this.technology="",this.entertainment="",this.sports="",this.beauty="",this.science="",
    this.health="",this.readMore="",this.share="",this.source="",this.reportThread="",this.expired="",
    this.violentRepulsive="",this.hatefulAbusive="",this.sexualContent="",this.spamMisleading="",
    this.addComment="",this.addReply="",this.replyingTo="",this.cancel="",this.reply="",this.viewReplies="",
    this.mute="",this.unmute="",this.select="",this.selected="",this.currentLanguage="",this.recentPosts="",
    this.home="",this.copyright="",this.privacyPolicy="",this.termsConditions="",this.howKnawNewsWorks="",
    this.oR="",this.languageCode="",this.followingAccounts="",this.suggestedAccounts="",this.createPost="",
    this.loadMore="",this.myProfileSetting="",this.Save="",this.loading=""
  });

  Map<String, dynamic> toJson() => _$LanguageToJson(this);
  factory Language.fromJson(json) => _$LanguageFromJson(json);
}