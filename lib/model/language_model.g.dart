// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LanguageAdapter extends TypeAdapter<Language> {
  @override
  final int typeId = 132;

  @override
  Language read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Language(
      knawNews: fields[1] as String,
      dashboard: fields[2] as String,
      account: fields[3] as String,
      name: fields[5] as String,
      language: fields[6] as String,
      settings: fields[7] as String,
      manageProfile: fields[4] as String,
      changePassword: fields[8] as String,
      newPassword: fields[9] as String,
      confirmNewPassword: fields[10] as String,
      signIn: fields[11] as String,
      signUp: fields[12] as String,
      signInWithEmail: fields[13] as String,
      signInWithFacebook: fields[14] as String,
      signInWithGoogle: fields[15] as String,
      hey: fields[16] as String,
      signupNow: fields[17] as String,
      userName: fields[18] as String,
      email: fields[19] as String,
      password: fields[20] as String,
      confirmPassword: fields[21] as String,
      signup: fields[22] as String,
      login: fields[23] as String,
      loginNow: fields[25] as String,
      alreadyMember: fields[24] as String,
      enterNameAndPass: fields[26] as String,
      rememberMe: fields[27] as String,
      forgotPassword: fields[28] as String,
      iAmNewUser: fields[29] as String,
      forgot: fields[30] as String,
      enterEmailToResetPass: fields[31] as String,
      send: fields[32] as String,
      enter4DigitCodeForwardedOn: fields[33] as String,
      next: fields[34] as String,
      enterNewAndConfirmPass: fields[35] as String,
      reset: fields[36] as String,
      inbox: fields[37] as String,
      bookmarkPosts: fields[38] as String,
      myKnawNews: fields[39] as String,
      about: fields[40] as String,
      contactUs: fields[41] as String,
      logout: fields[42] as String,
      join: fields[43] as String,
      yesterday: fields[44] as String,
      thisWeek: fields[45] as String,
      follow: fields[46] as String,
      unfollow: fields[47] as String,
      subject: fields[48] as String,
      whatsYourMessageAbout: fields[49] as String,
      changeUsername: fields[50] as String,
      activeYourAccount: fields[51] as String,
      deleteYourAccount: fields[52] as String,
      keywordAlerts: fields[53] as String,
      legalAndComplaints: fields[54] as String,
      bugOrFeatureRequest: fields[55] as String,
      contactModeratorTeam: fields[56] as String,
      b2bPROtherProblem: fields[57] as String,
      yourName: fields[58] as String,
      markMood: fields[59] as String,
      yourEmailAddress: fields[60] as String,
      gmailHint: fields[61] as String,
      message: fields[62] as String,
      writeTheMessage: fields[63] as String,
      sendMessage: fields[64] as String,
      search: fields[65] as String,
      typeTopicToSearchNews: fields[66] as String,
      recent: fields[67] as String,
      viewAll: fields[68] as String,
      filters: fields[69] as String,
      dateFilter: fields[70] as String,
      anyTime: fields[71] as String,
      pastHour: fields[72] as String,
      past24Hour: fields[73] as String,
      pastWeek: fields[74] as String,
      pastMonth: fields[75] as String,
      pastYear: fields[76] as String,
      customRange: fields[77] as String,
      mostCommented: fields[78] as String,
      gloomiest: fields[79] as String,
      trending: fields[80] as String,
      happiest: fields[81] as String,
      orderBy: fields[82] as String,
      ascending: fields[83] as String,
      descending: fields[84] as String,
      location: fields[85] as String,
      apply: fields[86] as String,
      post: fields[87] as String,
      addAPhoto: fields[88] as String,
      title: fields[89] as String,
      yourDescription: fields[90] as String,
      category: fields[91] as String,
      indefinitRemain: fields[92] as String,
      addLocationOrCountry: fields[96] as String,
      eventExpires: fields[94] as String,
      eventStarts: fields[93] as String,
      link: fields[95] as String,
      ok: fields[97] as String,
      profile: fields[98] as String,
      joined: fields[99] as String,
      followers: fields[100] as String,
      posts: fields[101] as String,
      bookmarks: fields[102] as String,
      stats: fields[103] as String,
      setting: fields[116] as String,
      accountSetting: fields[107] as String,
      changeEmail: fields[108] as String,
      changeYourPassword: fields[109] as String,
      mutedMembers: fields[110] as String,
      notifications: fields[111] as String,
      update: fields[112] as String,
      change: fields[113] as String,
      enterNewEmail: fields[114] as String,
      oldPassword: fields[115] as String,
      comments: fields[105] as String,
      views: fields[104] as String,
      following: fields[106] as String,
      happy: fields[117] as String,
      gloomy: fields[118] as String,
      yourNewsFeed: fields[119] as String,
      globalNews: fields[120] as String,
      events: fields[121] as String,
      business: fields[122] as String,
      opinion: fields[123] as String,
      technology: fields[124] as String,
      entertainment: fields[125] as String,
      sports: fields[126] as String,
      beauty: fields[127] as String,
      science: fields[128] as String,
      health: fields[129] as String,
      readMore: fields[130] as String,
      share: fields[131] as String,
      source: fields[132] as String,
      reportThread: fields[133] as String,
      expired: fields[138] as String,
      violentRepulsive: fields[134] as String,
      hatefulAbusive: fields[135] as String,
      sexualContent: fields[136] as String,
      spamMisleading: fields[137] as String,
      addComment: fields[139] as String,
      addReply: fields[142] as String,
      replyingTo: fields[143] as String,
      cancel: fields[144] as String,
      reply: fields[140] as String,
      viewReplies: fields[141] as String,
      mute: fields[145] as String,
      unmute: fields[146] as String,
      select: fields[147] as String,
      selected: fields[148] as String,
      currentLanguage: fields[149] as String,
      recentPosts: fields[150] as String,
      home: fields[151] as String,
      copyright: fields[152] as String,
      privacyPolicy: fields[153] as String,
      termsConditions: fields[154] as String,
      howKnawNewsWorks: fields[155] as String,
      oR: fields[156] as String,
      languageCode: fields[157] as String,
      followingAccounts: fields[158] as String,
      suggestedAccounts: fields[159] as String,
      createPost: fields[160] as String,
      loadMore: fields[161] as String,
      myProfileSetting: fields[162] as String,
      Save: fields[163] as String,
      loading: fields[164] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Language obj) {
    writer
      ..writeByte(164)
      ..writeByte(1)
      ..write(obj.knawNews)
      ..writeByte(2)
      ..write(obj.dashboard)
      ..writeByte(3)
      ..write(obj.account)
      ..writeByte(4)
      ..write(obj.manageProfile)
      ..writeByte(5)
      ..write(obj.name)
      ..writeByte(6)
      ..write(obj.language)
      ..writeByte(7)
      ..write(obj.settings)
      ..writeByte(8)
      ..write(obj.changePassword)
      ..writeByte(9)
      ..write(obj.newPassword)
      ..writeByte(10)
      ..write(obj.confirmNewPassword)
      ..writeByte(11)
      ..write(obj.signIn)
      ..writeByte(12)
      ..write(obj.signUp)
      ..writeByte(13)
      ..write(obj.signInWithEmail)
      ..writeByte(14)
      ..write(obj.signInWithFacebook)
      ..writeByte(15)
      ..write(obj.signInWithGoogle)
      ..writeByte(16)
      ..write(obj.hey)
      ..writeByte(17)
      ..write(obj.signupNow)
      ..writeByte(18)
      ..write(obj.userName)
      ..writeByte(19)
      ..write(obj.email)
      ..writeByte(20)
      ..write(obj.password)
      ..writeByte(21)
      ..write(obj.confirmPassword)
      ..writeByte(22)
      ..write(obj.signup)
      ..writeByte(23)
      ..write(obj.login)
      ..writeByte(24)
      ..write(obj.alreadyMember)
      ..writeByte(25)
      ..write(obj.loginNow)
      ..writeByte(26)
      ..write(obj.enterNameAndPass)
      ..writeByte(27)
      ..write(obj.rememberMe)
      ..writeByte(28)
      ..write(obj.forgotPassword)
      ..writeByte(29)
      ..write(obj.iAmNewUser)
      ..writeByte(30)
      ..write(obj.forgot)
      ..writeByte(31)
      ..write(obj.enterEmailToResetPass)
      ..writeByte(32)
      ..write(obj.send)
      ..writeByte(33)
      ..write(obj.enter4DigitCodeForwardedOn)
      ..writeByte(34)
      ..write(obj.next)
      ..writeByte(35)
      ..write(obj.enterNewAndConfirmPass)
      ..writeByte(36)
      ..write(obj.reset)
      ..writeByte(37)
      ..write(obj.inbox)
      ..writeByte(38)
      ..write(obj.bookmarkPosts)
      ..writeByte(39)
      ..write(obj.myKnawNews)
      ..writeByte(40)
      ..write(obj.about)
      ..writeByte(41)
      ..write(obj.contactUs)
      ..writeByte(42)
      ..write(obj.logout)
      ..writeByte(43)
      ..write(obj.join)
      ..writeByte(44)
      ..write(obj.yesterday)
      ..writeByte(45)
      ..write(obj.thisWeek)
      ..writeByte(46)
      ..write(obj.follow)
      ..writeByte(47)
      ..write(obj.unfollow)
      ..writeByte(48)
      ..write(obj.subject)
      ..writeByte(49)
      ..write(obj.whatsYourMessageAbout)
      ..writeByte(50)
      ..write(obj.changeUsername)
      ..writeByte(51)
      ..write(obj.activeYourAccount)
      ..writeByte(52)
      ..write(obj.deleteYourAccount)
      ..writeByte(53)
      ..write(obj.keywordAlerts)
      ..writeByte(54)
      ..write(obj.legalAndComplaints)
      ..writeByte(55)
      ..write(obj.bugOrFeatureRequest)
      ..writeByte(56)
      ..write(obj.contactModeratorTeam)
      ..writeByte(57)
      ..write(obj.b2bPROtherProblem)
      ..writeByte(58)
      ..write(obj.yourName)
      ..writeByte(59)
      ..write(obj.markMood)
      ..writeByte(60)
      ..write(obj.yourEmailAddress)
      ..writeByte(61)
      ..write(obj.gmailHint)
      ..writeByte(62)
      ..write(obj.message)
      ..writeByte(63)
      ..write(obj.writeTheMessage)
      ..writeByte(64)
      ..write(obj.sendMessage)
      ..writeByte(65)
      ..write(obj.search)
      ..writeByte(66)
      ..write(obj.typeTopicToSearchNews)
      ..writeByte(67)
      ..write(obj.recent)
      ..writeByte(68)
      ..write(obj.viewAll)
      ..writeByte(69)
      ..write(obj.filters)
      ..writeByte(70)
      ..write(obj.dateFilter)
      ..writeByte(71)
      ..write(obj.anyTime)
      ..writeByte(72)
      ..write(obj.pastHour)
      ..writeByte(73)
      ..write(obj.past24Hour)
      ..writeByte(74)
      ..write(obj.pastWeek)
      ..writeByte(75)
      ..write(obj.pastMonth)
      ..writeByte(76)
      ..write(obj.pastYear)
      ..writeByte(77)
      ..write(obj.customRange)
      ..writeByte(78)
      ..write(obj.mostCommented)
      ..writeByte(79)
      ..write(obj.gloomiest)
      ..writeByte(80)
      ..write(obj.trending)
      ..writeByte(81)
      ..write(obj.happiest)
      ..writeByte(82)
      ..write(obj.orderBy)
      ..writeByte(83)
      ..write(obj.ascending)
      ..writeByte(84)
      ..write(obj.descending)
      ..writeByte(85)
      ..write(obj.location)
      ..writeByte(86)
      ..write(obj.apply)
      ..writeByte(87)
      ..write(obj.post)
      ..writeByte(88)
      ..write(obj.addAPhoto)
      ..writeByte(89)
      ..write(obj.title)
      ..writeByte(90)
      ..write(obj.yourDescription)
      ..writeByte(91)
      ..write(obj.category)
      ..writeByte(92)
      ..write(obj.indefinitRemain)
      ..writeByte(93)
      ..write(obj.eventStarts)
      ..writeByte(94)
      ..write(obj.eventExpires)
      ..writeByte(95)
      ..write(obj.link)
      ..writeByte(96)
      ..write(obj.addLocationOrCountry)
      ..writeByte(97)
      ..write(obj.ok)
      ..writeByte(98)
      ..write(obj.profile)
      ..writeByte(99)
      ..write(obj.joined)
      ..writeByte(100)
      ..write(obj.followers)
      ..writeByte(101)
      ..write(obj.posts)
      ..writeByte(102)
      ..write(obj.bookmarks)
      ..writeByte(103)
      ..write(obj.stats)
      ..writeByte(104)
      ..write(obj.views)
      ..writeByte(105)
      ..write(obj.comments)
      ..writeByte(106)
      ..write(obj.following)
      ..writeByte(107)
      ..write(obj.accountSetting)
      ..writeByte(108)
      ..write(obj.changeEmail)
      ..writeByte(109)
      ..write(obj.changeYourPassword)
      ..writeByte(110)
      ..write(obj.mutedMembers)
      ..writeByte(111)
      ..write(obj.notifications)
      ..writeByte(112)
      ..write(obj.update)
      ..writeByte(113)
      ..write(obj.change)
      ..writeByte(114)
      ..write(obj.enterNewEmail)
      ..writeByte(115)
      ..write(obj.oldPassword)
      ..writeByte(116)
      ..write(obj.setting)
      ..writeByte(117)
      ..write(obj.happy)
      ..writeByte(118)
      ..write(obj.gloomy)
      ..writeByte(119)
      ..write(obj.yourNewsFeed)
      ..writeByte(120)
      ..write(obj.globalNews)
      ..writeByte(121)
      ..write(obj.events)
      ..writeByte(122)
      ..write(obj.business)
      ..writeByte(123)
      ..write(obj.opinion)
      ..writeByte(124)
      ..write(obj.technology)
      ..writeByte(125)
      ..write(obj.entertainment)
      ..writeByte(126)
      ..write(obj.sports)
      ..writeByte(127)
      ..write(obj.beauty)
      ..writeByte(128)
      ..write(obj.science)
      ..writeByte(129)
      ..write(obj.health)
      ..writeByte(130)
      ..write(obj.readMore)
      ..writeByte(131)
      ..write(obj.share)
      ..writeByte(132)
      ..write(obj.source)
      ..writeByte(133)
      ..write(obj.reportThread)
      ..writeByte(134)
      ..write(obj.violentRepulsive)
      ..writeByte(135)
      ..write(obj.hatefulAbusive)
      ..writeByte(136)
      ..write(obj.sexualContent)
      ..writeByte(137)
      ..write(obj.spamMisleading)
      ..writeByte(138)
      ..write(obj.expired)
      ..writeByte(139)
      ..write(obj.addComment)
      ..writeByte(140)
      ..write(obj.reply)
      ..writeByte(141)
      ..write(obj.viewReplies)
      ..writeByte(142)
      ..write(obj.addReply)
      ..writeByte(143)
      ..write(obj.replyingTo)
      ..writeByte(144)
      ..write(obj.cancel)
      ..writeByte(145)
      ..write(obj.mute)
      ..writeByte(146)
      ..write(obj.unmute)
      ..writeByte(147)
      ..write(obj.select)
      ..writeByte(148)
      ..write(obj.selected)
      ..writeByte(149)
      ..write(obj.currentLanguage)
      ..writeByte(150)
      ..write(obj.recentPosts)
      ..writeByte(151)
      ..write(obj.home)
      ..writeByte(152)
      ..write(obj.copyright)
      ..writeByte(153)
      ..write(obj.privacyPolicy)
      ..writeByte(154)
      ..write(obj.termsConditions)
      ..writeByte(155)
      ..write(obj.howKnawNewsWorks)
      ..writeByte(156)
      ..write(obj.oR)
      ..writeByte(157)
      ..write(obj.languageCode)
      ..writeByte(158)
      ..write(obj.followingAccounts)
      ..writeByte(159)
      ..write(obj.suggestedAccounts)
      ..writeByte(160)
      ..write(obj.createPost)
      ..writeByte(161)
      ..write(obj.loadMore)
      ..writeByte(162)
      ..write(obj.myProfileSetting)
      ..writeByte(163)
      ..write(obj.Save)
      ..writeByte(164)
      ..write(obj.loading);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LanguageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Language _$LanguageFromJson(Map<String, dynamic> json) => Language(
      knawNews: json['knaw_news'] as String? ?? "",
      dashboard: json['dashboard'] as String? ?? "",
      account: json['account'] as String? ?? "",
      name: json['name'] as String? ?? "",
      language: json['language'] as String? ?? "",
      settings: json['settings'] as String? ?? "",
      manageProfile: json['manage_profile'] as String? ?? "",
      changePassword: json['change_password'] as String? ?? "",
      newPassword: json['new_password'] as String? ?? "",
      confirmNewPassword: json['confirm_new_password'] as String? ?? "",
      signIn: json['sign_in'] as String? ?? "",
      signUp: json['sign_up'] as String? ?? "",
      signInWithEmail: json['sign_in_with_email'] as String? ?? "",
      signInWithFacebook: json['sign_in_with_facebook'] as String? ?? "",
      signInWithGoogle: json['sign_in_with_google'] as String? ?? "",
      hey: json['hey'] as String? ?? "",
      signupNow: json['signup_now'] as String? ?? "",
      userName: json['user_name'] as String? ?? "",
      email: json['email'] as String? ?? "",
      password: json['password'] as String? ?? "",
      confirmPassword: json['confirm_password'] as String? ?? "",
      signup: json['signup'] as String? ?? "",
      login: json['login'] as String? ?? "",
      loginNow: json['login_now'] as String? ?? "",
      alreadyMember: json['already_a_member'] as String? ?? "",
      enterNameAndPass: json['enter_name_and_pass'] as String? ?? "",
      rememberMe: json['remember_me'] as String? ?? "",
      forgotPassword: json['forgot_password'] as String? ?? "",
      iAmNewUser: json['i_am_new_user'] as String? ?? "",
      forgot: json['forgot'] as String? ?? "",
      enterEmailToResetPass: json['enter_email_to_reset_pass'] as String? ?? "",
      send: json['send'] as String? ?? "",
      enter4DigitCodeForwardedOn:
          json['enter_4_digit_code_forwarded_on'] as String? ?? "",
      next: json['next'] as String? ?? "",
      enterNewAndConfirmPass:
          json['enter_new_and_confirm_pass'] as String? ?? "",
      reset: json['reset'] as String? ?? "",
      inbox: json['inbox'] as String? ?? "",
      bookmarkPosts: json['bookmark_posts'] as String? ?? "",
      myKnawNews: json['my_knaw_news'] as String? ?? "",
      about: json['about'] as String? ?? "",
      contactUs: json['contact_us'] as String? ?? "",
      logout: json['logout'] as String? ?? "",
      join: json['join'] as String? ?? "",
      yesterday: json['yesterday'] as String? ?? "",
      thisWeek: json['this_week'] as String? ?? "",
      follow: json['follow'] as String? ?? "",
      unfollow: json['unfollow'] as String? ?? "",
      subject: json['subject'] as String? ?? "",
      whatsYourMessageAbout: json['whats_your_message_about'] as String? ?? "",
      changeUsername: json['change_username'] as String? ?? "",
      activeYourAccount: json['active_your_account'] as String? ?? "",
      deleteYourAccount: json['delete_your_account'] as String? ?? "",
      keywordAlerts: json['keyword_alerts'] as String? ?? "",
      legalAndComplaints: json['legal_and_complaints'] as String? ?? "",
      bugOrFeatureRequest: json['bug_or_feature_request'] as String? ?? "",
      contactModeratorTeam: json['contact_moderator_team'] as String? ?? "",
      b2bPROtherProblem: json['b2b_PR_other_problem'] as String? ?? "",
      yourName: json['your_name'] as String? ?? "",
      markMood: json['mark_wood'] as String? ?? "",
      yourEmailAddress: json['your_email_address'] as String? ?? "",
      gmailHint: json['gmail_hint'] as String? ?? "",
      message: json['message'] as String? ?? "",
      writeTheMessage: json['write_the_message'] as String? ?? "",
      sendMessage: json['send_message'] as String? ?? "",
      search: json['search'] as String? ?? "",
      typeTopicToSearchNews: json['type_topic_to_search_news'] as String? ?? "",
      recent: json['recent'] as String? ?? "",
      viewAll: json['view_all'] as String? ?? "",
      filters: json['filters'] as String? ?? "",
      dateFilter: json['date_filter'] as String? ?? "",
      anyTime: json['any_time'] as String? ?? "",
      pastHour: json['past_hour'] as String? ?? "",
      past24Hour: json['past_24_hour'] as String? ?? "",
      pastWeek: json['past_week'] as String? ?? "",
      pastMonth: json['past_month'] as String? ?? "",
      pastYear: json['past_year'] as String? ?? "",
      customRange: json['custom_range'] as String? ?? "",
      mostCommented: json['most_commented'] as String? ?? "",
      gloomiest: json['gloomiest'] as String? ?? "",
      trending: json['trending'] as String? ?? "",
      happiest: json['happiest'] as String? ?? "",
      orderBy: json['order_by'] as String? ?? "",
      ascending: json['ascending'] as String? ?? "",
      descending: json['descending'] as String? ?? "",
      location: json['location'] as String? ?? "",
      apply: json['apply'] as String? ?? "",
      post: json['post'] as String? ?? "",
      addAPhoto: json['add_a_photo'] as String? ?? "",
      title: json['title'] as String? ?? "",
      yourDescription: json['your_description'] as String? ?? "",
      category: json['category'] as String? ?? "",
      indefinitRemain: json['indefinit_remain'] as String? ?? "",
      addLocationOrCountry: json['add_location_or_country'] as String? ?? "",
      eventExpires: json['event_expires'] as String? ?? "",
      eventStarts: json['event_starts'] as String? ?? "",
      link: json['link'] as String? ?? "",
      ok: json['ok'] as String? ?? "",
      profile: json['profile'] as String? ?? "",
      joined: json['joined'] as String? ?? "",
      followers: json['followers'] as String? ?? "",
      posts: json['posts'] as String? ?? "",
      bookmarks: json['bookmarks'] as String? ?? "",
      stats: json['stats'] as String? ?? "",
      setting: json['setting'] as String? ?? "",
      accountSetting: json['account_setting'] as String? ?? "",
      changeEmail: json['change_email'] as String? ?? "",
      changeYourPassword: json['change_your_password'] as String? ?? "",
      mutedMembers: json['muted_members'] as String? ?? "",
      notifications: json['notifications'] as String? ?? "",
      update: json['update'] as String? ?? "",
      change: json['change'] as String? ?? "",
      enterNewEmail: json['enter_new_email'] as String? ?? "",
      oldPassword: json['old_password'] as String? ?? "",
      comments: json['comments'] as String? ?? "",
      views: json['views'] as String? ?? "",
      following: json['following'] as String? ?? "",
      happy: json['happy'] as String? ?? "",
      gloomy: json['gloomy'] as String? ?? "",
      yourNewsFeed: json['your_news_feed'] as String? ?? "",
      globalNews: json['global_news'] as String? ?? "",
      events: json['events'] as String? ?? "",
      business: json['business'] as String? ?? "",
      opinion: json['opinion'] as String? ?? "",
      technology: json['technology'] as String? ?? "",
      entertainment: json['entertainment'] as String? ?? "",
      sports: json['sports'] as String? ?? "",
      beauty: json['beauty'] as String? ?? "",
      science: json['science'] as String? ?? "",
      health: json['health'] as String? ?? "",
      readMore: json['read_more'] as String? ?? "",
      share: json['share'] as String? ?? "",
      source: json['source'] as String? ?? "",
      reportThread: json['report_thread'] as String? ?? "",
      expired: json['expired'] as String? ?? "",
      violentRepulsive: json['violent_repulsive'] as String? ?? "",
      hatefulAbusive: json['hateful_abusive'] as String? ?? "",
      sexualContent: json['sexual_content'] as String? ?? "",
      spamMisleading: json['spam_misleading'] as String? ?? "",
      addComment: json['add_comment'] as String? ?? "",
      addReply: json['add_reply'] as String? ?? "",
      replyingTo: json['replying_to'] as String? ?? "",
      cancel: json['cancel'] as String? ?? "",
      reply: json['reply'] as String? ?? "",
      viewReplies: json['view_replies'] as String? ?? "",
      mute: json['mute'] as String? ?? "",
      unmute: json['unmute'] as String? ?? "",
      select: json['select'] as String? ?? "",
      selected: json['selected'] as String? ?? "",
      currentLanguage: json['current_language'] as String? ?? "",
      recentPosts: json['recent_posts'] as String? ?? "",
      home: json['home'] as String? ?? "",
      copyright: json['copyright'] as String? ?? "",
      privacyPolicy: json['privacy_policy'] as String? ?? "",
      termsConditions: json['terms_&_conditions'] as String? ?? "",
      howKnawNewsWorks: json['how_knawnews_works'] as String? ?? "",
      oR: json['oR'] as String? ?? "",
      languageCode: json['language_code'] as String? ?? "",
      followingAccounts: json['following_accounts'] as String? ?? "",
      suggestedAccounts: json['suggested_accounts'] as String? ?? "",
      createPost: json['create_post'] as String? ?? "",
      loadMore: json['load_more'] as String? ?? "",
      myProfileSetting: json['my_profile_setting'] as String? ?? "",
      Save: json['Save'] as String? ?? "",
      loading: json['loading'] as String? ?? "",
    );

Map<String, dynamic> _$LanguageToJson(Language instance) => <String, dynamic>{
      'knaw_news': instance.knawNews,
      'dashboard': instance.dashboard,
      'account': instance.account,
      'manage_profile': instance.manageProfile,
      'name': instance.name,
      'language': instance.language,
      'settings': instance.settings,
      'change_password': instance.changePassword,
      'new_password': instance.newPassword,
      'confirm_new_password': instance.confirmNewPassword,
      'sign_in': instance.signIn,
      'sign_up': instance.signUp,
      'sign_in_with_email': instance.signInWithEmail,
      'sign_in_with_facebook': instance.signInWithFacebook,
      'sign_in_with_google': instance.signInWithGoogle,
      'hey': instance.hey,
      'signup_now': instance.signupNow,
      'user_name': instance.userName,
      'email': instance.email,
      'password': instance.password,
      'confirm_password': instance.confirmPassword,
      'signup': instance.signup,
      'login': instance.login,
      'already_a_member': instance.alreadyMember,
      'login_now': instance.loginNow,
      'enter_name_and_pass': instance.enterNameAndPass,
      'remember_me': instance.rememberMe,
      'forgot_password': instance.forgotPassword,
      'i_am_new_user': instance.iAmNewUser,
      'forgot': instance.forgot,
      'enter_email_to_reset_pass': instance.enterEmailToResetPass,
      'send': instance.send,
      'enter_4_digit_code_forwarded_on': instance.enter4DigitCodeForwardedOn,
      'next': instance.next,
      'enter_new_and_confirm_pass': instance.enterNewAndConfirmPass,
      'reset': instance.reset,
      'inbox': instance.inbox,
      'bookmark_posts': instance.bookmarkPosts,
      'my_knaw_news': instance.myKnawNews,
      'about': instance.about,
      'contact_us': instance.contactUs,
      'logout': instance.logout,
      'join': instance.join,
      'yesterday': instance.yesterday,
      'this_week': instance.thisWeek,
      'follow': instance.follow,
      'unfollow': instance.unfollow,
      'subject': instance.subject,
      'whats_your_message_about': instance.whatsYourMessageAbout,
      'change_username': instance.changeUsername,
      'active_your_account': instance.activeYourAccount,
      'delete_your_account': instance.deleteYourAccount,
      'keyword_alerts': instance.keywordAlerts,
      'legal_and_complaints': instance.legalAndComplaints,
      'bug_or_feature_request': instance.bugOrFeatureRequest,
      'contact_moderator_team': instance.contactModeratorTeam,
      'b2b_PR_other_problem': instance.b2bPROtherProblem,
      'your_name': instance.yourName,
      'mark_wood': instance.markMood,
      'your_email_address': instance.yourEmailAddress,
      'gmail_hint': instance.gmailHint,
      'message': instance.message,
      'write_the_message': instance.writeTheMessage,
      'send_message': instance.sendMessage,
      'search': instance.search,
      'type_topic_to_search_news': instance.typeTopicToSearchNews,
      'recent': instance.recent,
      'view_all': instance.viewAll,
      'filters': instance.filters,
      'date_filter': instance.dateFilter,
      'any_time': instance.anyTime,
      'past_hour': instance.pastHour,
      'past_24_hour': instance.past24Hour,
      'past_week': instance.pastWeek,
      'past_month': instance.pastMonth,
      'past_year': instance.pastYear,
      'custom_range': instance.customRange,
      'most_commented': instance.mostCommented,
      'gloomiest': instance.gloomiest,
      'trending': instance.trending,
      'happiest': instance.happiest,
      'order_by': instance.orderBy,
      'ascending': instance.ascending,
      'descending': instance.descending,
      'location': instance.location,
      'apply': instance.apply,
      'post': instance.post,
      'add_a_photo': instance.addAPhoto,
      'title': instance.title,
      'your_description': instance.yourDescription,
      'category': instance.category,
      'indefinit_remain': instance.indefinitRemain,
      'event_starts': instance.eventStarts,
      'event_expires': instance.eventExpires,
      'link': instance.link,
      'add_location_or_country': instance.addLocationOrCountry,
      'ok': instance.ok,
      'profile': instance.profile,
      'joined': instance.joined,
      'followers': instance.followers,
      'posts': instance.posts,
      'bookmarks': instance.bookmarks,
      'stats': instance.stats,
      'views': instance.views,
      'comments': instance.comments,
      'following': instance.following,
      'account_setting': instance.accountSetting,
      'change_email': instance.changeEmail,
      'change_your_password': instance.changeYourPassword,
      'muted_members': instance.mutedMembers,
      'notifications': instance.notifications,
      'update': instance.update,
      'change': instance.change,
      'enter_new_email': instance.enterNewEmail,
      'old_password': instance.oldPassword,
      'setting': instance.setting,
      'happy': instance.happy,
      'gloomy': instance.gloomy,
      'your_news_feed': instance.yourNewsFeed,
      'global_news': instance.globalNews,
      'events': instance.events,
      'business': instance.business,
      'opinion': instance.opinion,
      'technology': instance.technology,
      'entertainment': instance.entertainment,
      'sports': instance.sports,
      'beauty': instance.beauty,
      'science': instance.science,
      'health': instance.health,
      'read_more': instance.readMore,
      'share': instance.share,
      'source': instance.source,
      'report_thread': instance.reportThread,
      'violent_repulsive': instance.violentRepulsive,
      'hateful_abusive': instance.hatefulAbusive,
      'sexual_content': instance.sexualContent,
      'spam_misleading': instance.spamMisleading,
      'expired': instance.expired,
      'add_comment': instance.addComment,
      'reply': instance.reply,
      'view_replies': instance.viewReplies,
      'add_reply': instance.addReply,
      'replying_to': instance.replyingTo,
      'cancel': instance.cancel,
      'mute': instance.mute,
      'unmute': instance.unmute,
      'select': instance.select,
      'selected': instance.selected,
      'current_language': instance.currentLanguage,
      'recent_posts': instance.recentPosts,
      'home': instance.home,
      'copyright': instance.copyright,
      'privacy_policy': instance.privacyPolicy,
      'terms_&_conditions': instance.termsConditions,
      'how_knawnews_works': instance.howKnawNewsWorks,
      'oR': instance.oR,
      'language_code': instance.languageCode,
      'following_accounts': instance.followingAccounts,
      'suggested_accounts': instance.suggestedAccounts,
      'create_post': instance.createPost,
      'load_more': instance.loadMore,
      'my_profile_setting': instance.myProfileSetting,
      'Save': instance.Save,
      'loading': instance.loading,
    };
