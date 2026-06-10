/// Curated [Icons] constants grouped by feature domain.
///
/// Outlined/filled pairs support inactive vs active navigation states.
/// Renamed from `MyAppIcons` to align with `AppSpacing`, `AppRadius`, etc.
library;

import 'package:flutter/material.dart';

/// App-wide Material icon aliases — avoids scattering raw [Icons] references.
abstract final class AppIcons {
  // ==================== Navigation ====================
  static const IconData home = Icons.home_outlined;
  static const IconData homeFilled = Icons.home;
  static const IconData search = Icons.search;
  static const IconData orders = Icons.receipt_long_outlined;
  static const IconData ordersFilled = Icons.receipt_long;
  static const IconData chat = Icons.chat_bubble_outline;
  static const IconData chatFilled = Icons.chat_bubble;
  static const IconData profile = Icons.person_outline;
  static const IconData profileFilled = Icons.person;
  static const IconData settings = Icons.settings_outlined;
  static const IconData settingsFilled = Icons.settings;
  static const IconData notifications = Icons.notifications_outlined;
  static const IconData notificationsFilled = Icons.notifications;
  static const IconData back = Icons.arrow_back;
  static const IconData forward = Icons.arrow_forward;
  static const IconData close = Icons.close;
  static const IconData menu = Icons.menu;
  static const IconData more = Icons.more_horiz;
  static const IconData moreVert = Icons.more_vert;

  // ==================== Actions ====================
  static const IconData add = Icons.add;
  static const IconData remove = Icons.remove;
  static const IconData edit = Icons.edit_outlined;
  static const IconData delete = Icons.delete_outline;
  static const IconData share = Icons.share_outlined;
  static const IconData copy = Icons.copy_outlined;
  static const IconData download = Icons.download_outlined;
  static const IconData upload = Icons.upload_outlined;
  static const IconData refresh = Icons.refresh;
  static const IconData filter = Icons.tune;
  static const IconData sort = Icons.sort;
  static const IconData bookmark = Icons.bookmark_outline;
  static const IconData bookmarkFilled = Icons.bookmark;
  static const IconData favorite = Icons.favorite_outline;
  static const IconData favoriteFilled = Icons.favorite;
  static const IconData like = Icons.thumb_up_outlined;
  static const IconData likeFilled = Icons.thumb_up;

  // ==================== Status ====================
  static const IconData success = Icons.check_circle_outline;
  static const IconData successFilled = Icons.check_circle;
  static const IconData error = Icons.error_outline;
  static const IconData errorFilled = Icons.error;
  static const IconData warning = Icons.warning_amber_outlined;
  static const IconData warningFilled = Icons.warning_amber;
  static const IconData info = Icons.info_outline;
  static const IconData infoFilled = Icons.info;
  static const IconData help = Icons.help_outline;
  static const IconData helpFilled = Icons.help;
  static const IconData pending = Icons.hourglass_empty;
  static const IconData inProgress = Icons.sync;
  static const IconData completed = Icons.task_alt;
  static const IconData cancelled = Icons.cancel_outlined;

  // ==================== Communication ====================
  static const IconData call = Icons.call_outlined;
  static const IconData callFilled = Icons.call;
  static const IconData videoCall = Icons.videocam_outlined;
  static const IconData message = Icons.message_outlined;
  static const IconData messageFilled = Icons.message;
  static const IconData email = Icons.email_outlined;
  static const IconData emailFilled = Icons.email;
  static const IconData send = Icons.send;
  static const IconData attach = Icons.attach_file;
  static const IconData mic = Icons.mic_outlined;
  static const IconData micOff = Icons.mic_off_outlined;

  // ==================== Location & Maps ====================
  static const IconData location = Icons.location_on_outlined;
  static const IconData locationFilled = Icons.location_on;
  static const IconData myLocation = Icons.my_location;
  static const IconData directions = Icons.directions;
  static const IconData navigation = Icons.navigation;
  static const IconData map = Icons.map_outlined;
  static const IconData mapFilled = Icons.map;
  static const IconData route = Icons.route;
  static const IconData nearMe = Icons.near_me_outlined;
  static const IconData explore = Icons.explore_outlined;

  // ==================== Time & Calendar ====================
  static const IconData time = Icons.access_time;
  static const IconData timeFilled = Icons.access_time_filled;
  static const IconData calendar = Icons.calendar_today_outlined;
  static const IconData calendarFilled = Icons.calendar_today;
  static const IconData schedule = Icons.schedule;
  static const IconData event = Icons.event_outlined;
  static const IconData eventFilled = Icons.event;
  static const IconData history = Icons.history;
  static const IconData timer = Icons.timer_outlined;
  static const IconData alarm = Icons.alarm;

  // ==================== Payment & Finance ====================
  static const IconData wallet = Icons.account_balance_wallet_outlined;
  static const IconData walletFilled = Icons.account_balance_wallet;
  static const IconData payment = Icons.payment;
  static const IconData creditCard = Icons.credit_card;
  static const IconData money = Icons.attach_money;
  static const IconData receipt = Icons.receipt_outlined;
  static const IconData promo = Icons.local_offer_outlined;
  static const IconData promoFilled = Icons.local_offer;
  static const IconData discount = Icons.discount_outlined;
  static const IconData loyaltyPoints = Icons.stars_outlined;

  // ==================== User & Profile ====================
  static const IconData user = Icons.person_outline;
  static const IconData userFilled = Icons.person;
  static const IconData users = Icons.people_outline;
  static const IconData usersFilled = Icons.people;
  static const IconData addUser = Icons.person_add_outlined;
  static const IconData verified = Icons.verified;
  static const IconData verifiedUser = Icons.verified_user_outlined;
  static const IconData badge = Icons.badge_outlined;
  static const IconData account = Icons.account_circle_outlined;
  static const IconData accountFilled = Icons.account_circle;

  // ==================== Services ====================
  static const IconData services = Icons.home_repair_service_outlined;
  static const IconData servicesFilled = Icons.home_repair_service;
  static const IconData cleaning = Icons.cleaning_services_outlined;
  static const IconData repair = Icons.build_outlined;
  static const IconData electrical = Icons.electrical_services;
  static const IconData plumbing = Icons.plumbing;
  static const IconData ac = Icons.ac_unit;
  static const IconData massage = Icons.spa_outlined;
  static const IconData beauty = Icons.face_outlined;
  static const IconData salon = Icons.content_cut;
  static const IconData handyman = Icons.handyman_outlined;
  static const IconData tools = Icons.construction;

  // ==================== Ratings & Reviews ====================
  static const IconData star = Icons.star_outline;
  static const IconData starFilled = Icons.star;
  static const IconData starHalf = Icons.star_half;
  static const IconData rate = Icons.rate_review_outlined;
  static const IconData review = Icons.reviews_outlined;
  static const IconData thumbsUp = Icons.thumb_up_alt_outlined;
  static const IconData thumbsDown = Icons.thumb_down_alt_outlined;

  // ==================== Media ====================
  static const IconData camera = Icons.camera_alt_outlined;
  static const IconData cameraFilled = Icons.camera_alt;
  static const IconData photo = Icons.photo_outlined;
  static const IconData photoFilled = Icons.photo;
  static const IconData gallery = Icons.photo_library_outlined;
  static const IconData video = Icons.videocam_outlined;
  static const IconData play = Icons.play_arrow;
  static const IconData pause = Icons.pause;
  static const IconData stop = Icons.stop;
  static const IconData document = Icons.description_outlined;
  static const IconData documentFilled = Icons.description;
  static const IconData file = Icons.insert_drive_file_outlined;

  // ==================== Security ====================
  static const IconData lock = Icons.lock_outline;
  static const IconData lockFilled = Icons.lock;
  static const IconData unlock = Icons.lock_open;
  static const IconData shield = Icons.shield_outlined;
  static const IconData shieldFilled = Icons.shield;
  static const IconData privacy = Icons.privacy_tip_outlined;
  static const IconData fingerprint = Icons.fingerprint;
  static const IconData faceId = Icons.face;
  static const IconData key = Icons.key;
  static const IconData password = Icons.password;

  // ==================== Forms & Input ====================
  static const IconData checkbox = Icons.check_box_outline_blank;
  static const IconData checkboxFilled = Icons.check_box;
  static const IconData radio = Icons.radio_button_unchecked;
  static const IconData radioFilled = Icons.radio_button_checked;
  static const IconData dropdown = Icons.arrow_drop_down;
  static const IconData dropup = Icons.arrow_drop_up;
  static const IconData expand = Icons.expand_more;
  static const IconData collapse = Icons.expand_less;
  static const IconData visibility = Icons.visibility_outlined;
  static const IconData visibilityOff = Icons.visibility_off_outlined;

  // ==================== Bidding ====================
  static const IconData bid = Icons.gavel;
  static const IconData auction = Icons.monetization_on_outlined;
  static const IconData offer = Icons.local_offer_outlined;
  static const IconData accept = Icons.check;
  static const IconData reject = Icons.close;
  static const IconData countdown = Icons.timer;
  static const IconData live = Icons.fiber_manual_record;

  // ==================== Miscellaneous ====================
  static const IconData qrCode = Icons.qr_code;
  static const IconData barcode = Icons.barcode_reader;
  static const IconData flash = Icons.flash_on;
  static const IconData flashOff = Icons.flash_off;
  static const IconData wifi = Icons.wifi;
  static const IconData wifiOff = Icons.wifi_off;
  static const IconData bluetooth = Icons.bluetooth;
  static const IconData battery = Icons.battery_full;
  static const IconData darkMode = Icons.dark_mode_outlined;
  static const IconData lightMode = Icons.light_mode_outlined;
  static const IconData language = Icons.language;
  static const IconData translate = Icons.translate;
  static const IconData logout = Icons.logout;
  static const IconData login = Icons.login;
}
