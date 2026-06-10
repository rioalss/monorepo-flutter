/// Country calling-code entry for phone-input pickers.
class CountryCodeData {
  const CountryCodeData({
    required this.code,
    required this.country,
    required this.flag,
  });

  /// E.164 prefix including `+`.
  final String code;
  final String country;

  /// Display emoji flag.
  final String flag;
}

/// Static reference data shared across features (phone codes, regions, etc.).
abstract final class AppConstant {
  AppConstant._();

  /// Common international dialing codes for phone country pickers.
  static const List<CountryCodeData> phoneCountryCodes = [
    CountryCodeData(
      code: '+1',
      country: 'United States/Canada',
      flag: '🇺🇸',
    ),
    CountryCodeData(
      code: '+7',
      country: 'Russia',
      flag: '🇷🇺',
    ),
    CountryCodeData(
      code: '+20',
      country: 'Egypt',
      flag: '🇪🇬',
    ),
    CountryCodeData(
      code: '+27',
      country: 'South Africa',
      flag: '🇿🇦',
    ),
    CountryCodeData(
      code: '+30',
      country: 'Greece',
      flag: '🇬🇷',
    ),
    CountryCodeData(
      code: '+31',
      country: 'Netherlands',
      flag: '🇳🇱',
    ),
    CountryCodeData(
      code: '+32',
      country: 'Belgium',
      flag: '🇧🇪',
    ),
    CountryCodeData(
      code: '+33',
      country: 'France',
      flag: '🇫🇷',
    ),
    CountryCodeData(
      code: '+34',
      country: 'Spain',
      flag: '🇪🇸',
    ),
    CountryCodeData(
      code: '+36',
      country: 'Hungary',
      flag: '🇭🇺',
    ),
    CountryCodeData(
      code: '+39',
      country: 'Italy',
      flag: '🇮🇹',
    ),
    CountryCodeData(
      code: '+40',
      country: 'Romania',
      flag: '🇷🇴',
    ),
    CountryCodeData(
      code: '+41',
      country: 'Switzerland',
      flag: '🇨🇭',
    ),
    CountryCodeData(
      code: '+44',
      country: 'United Kingdom',
      flag: '🇬🇧',
    ),
    CountryCodeData(
      code: '+49',
      country: 'Germany',
      flag: '🇩🇪',
    ),
    CountryCodeData(
      code: '+52',
      country: 'Mexico',
      flag: '🇲🇽',
    ),
    CountryCodeData(
      code: '+55',
      country: 'Brazil',
      flag: '🇧🇷',
    ),
    CountryCodeData(
      code: '+61',
      country: 'Australia',
      flag: '🇦🇺',
    ),
    CountryCodeData(
      code: '+63',
      country: 'Philippines',
      flag: '🇵🇭',
    ),
    CountryCodeData(
      code: '+62',
      country: 'Indonesia',
      flag: '🇮🇩',
    ),
    CountryCodeData(
      code: '+64',
      country: 'New Zealand',
      flag: '🇳🇿',
    ),
    CountryCodeData(
      code: '+65',
      country: 'Singapore',
      flag: '🇸🇬',
    ),
    CountryCodeData(
      code: '+66',
      country: 'Thailand',
      flag: '🇹🇭',
    ),
    CountryCodeData(
      code: '+81',
      country: 'Japan',
      flag: '🇯🇵',
    ),
    CountryCodeData(
      code: '+82',
      country: 'South Korea',
      flag: '🇰🇷',
    ),
    CountryCodeData(
      code: '+84',
      country: 'Vietnam',
      flag: '🇻🇳',
    ),
    CountryCodeData(
      code: '+86',
      country: 'China',
      flag: '🇨🇳',
    ),
    CountryCodeData(
      code: '+91',
      country: 'India',
      flag: '🇮🇳',
    ),
    CountryCodeData(
      code: '+92',
      country: 'Pakistan',
      flag: '🇵🇰',
    ),
    CountryCodeData(
      code: '+94',
      country: 'Sri Lanka',
      flag: '🇱🇰',
    ),
    CountryCodeData(
      code: '+95',
      country: 'Myanmar',
      flag: '🇲🇲',
    ),
    CountryCodeData(
      code: '+98',
      country: 'Iran',
      flag: '🇮🇷',
    ),
    CountryCodeData(
      code: '+351',
      country: 'Portugal',
      flag: '🇵🇹',
    ),
    CountryCodeData(
      code: '+352',
      country: 'Luxembourg',
      flag: '🇱🇺',
    ),
    CountryCodeData(
      code: '+353',
      country: 'Ireland',
      flag: '🇮🇪',
    ),
    CountryCodeData(
      code: '+354',
      country: 'Iceland',
      flag: '🇮🇸',
    ),
    CountryCodeData(
      code: '+355',
      country: 'Albania',
      flag: '🇦🇱',
    ),
    CountryCodeData(
      code: '+358',
      country: 'Finland',
      flag: '🇫🇮',
    ),
    CountryCodeData(
      code: '+359',
      country: 'Bulgaria',
      flag: '🇧🇬',
    ),
    CountryCodeData(
      code: '+855',
      country: 'Cambodia',
      flag: '🇰🇭',
    ),
    CountryCodeData(
      code: '+856',
      country: 'Laos',
      flag: '🇱🇦',
    ),
    CountryCodeData(
      code: '+880',
      country: 'Bangladesh',
      flag: '🇧🇩',
    ),
    CountryCodeData(
      code: '+965',
      country: 'Kuwait',
      flag: '🇰🇼',
    ),
    CountryCodeData(
      code: '+966',
      country: 'Saudi Arabia',
      flag: '🇸🇦',
    ),
    CountryCodeData(
      code: '+971',
      country: 'United Arab Emirates',
      flag: '🇦🇪',
    ),
    CountryCodeData(
      code: '+972',
      country: 'Israel',
      flag: '🇮🇱',
    ),
    CountryCodeData(
      code: '+974',
      country: 'Qatar',
      flag: '🇶🇦',
    ),
    CountryCodeData(
      code: '+975',
      country: 'Bhutan',
      flag: '🇧🇹',
    ),
    CountryCodeData(
      code: '+976',
      country: 'Mongolia',
      flag: '🇲🇳',
    ),
    CountryCodeData(
      code: '+977',
      country: 'Nepal',
      flag: '🇳🇵',
    ),
    CountryCodeData(
      code: '+880',
      country: 'Bangladesh',
      flag: '🇧🇩',
    ),
    CountryCodeData(
      code: '+67',
      country: 'Brunei (legacy)',
      flag: '🇧🇳',
    ),
    CountryCodeData(
      code: '+68',
      country: 'Timor-Leste (legacy)',
      flag: '🇹🇱',
    ),
  ];

  /// US state names for address forms.
  static const List<String> states = [
    'Alabama',
    'Alaska',
    'Arizona',
    'Arkansas',
    'California',
    'Colorado',
    'Connecticut',
    'Delaware',
    'Florida',
    'Georgia',
    'Hawaii',
    'Idaho',
    'Illinois',
    'Indiana',
    'Iowa',
    'Kansas',
    'Kentucky',
    'Louisiana',
    'Maine',
    'Maryland',
    'Massachusetts',
    'Michigan',
    'Minnesota',
    'Mississippi',
    'Missouri',
    'Montana',
    'Nebraska',
    'Nevada',
    'New Hampshire',
    'New Jersey',
    'New Mexico',
    'New York',
    'North Carolina',
    'North Dakota',
    'Ohio',
    'Oklahoma',
    'Oregon',
    'Pennsylvania',
    'Rhode Island',
    'South Carolina',
    'South Dakota',
    'Tennessee',
    'Texas',
    'Utah',
    'Vermont',
    'Virginia',
    'Washington',
    'West Virginia',
    'Wisconsin',
    'Wyoming',
  ];
}
