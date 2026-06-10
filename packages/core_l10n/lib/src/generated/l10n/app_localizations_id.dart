// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get commonOk => 'OK';

  @override
  String get commonCancel => 'Batal';

  @override
  String get commonRetry => 'Coba lagi';

  @override
  String get commonClose => 'Tutup';

  @override
  String get commonSave => 'Simpan';

  @override
  String get commonDelete => 'Hapus';

  @override
  String get commonError => 'Terjadi kesalahan';

  @override
  String get commonLoading => 'Memuat...';

  @override
  String get commonSuccess => 'Berhasil';

  @override
  String get commonNoData => 'Tidak ada data';

  @override
  String get commonTryAgain => 'Coba lagi';

  @override
  String get validationRequired => 'Kolom ini wajib diisi';

  @override
  String validationMinLength(int min) {
    return 'Minimal $min karakter';
  }

  @override
  String validationMaxLength(int max) {
    return 'Maksimal $max karakter';
  }

  @override
  String validationLengthRange(int min, int max) {
    return 'Harus antara $min dan $max karakter';
  }

  @override
  String get validationPattern => 'Format tidak valid';

  @override
  String get validationEmail => 'Masukkan alamat email yang valid';

  @override
  String get validationUrl => 'Masukkan URL yang valid';

  @override
  String get validationAlpha => 'Hanya huruf yang diperbolehkan';

  @override
  String get validationAlphanumeric =>
      'Hanya huruf dan angka yang diperbolehkan';

  @override
  String get validationNumeric => 'Hanya angka yang diperbolehkan';

  @override
  String get validationNoWhitespace => 'Spasi tidak diperbolehkan';

  @override
  String get validationNoLeadingTrailingWhitespace =>
      'Spasi di awal atau akhir tidak diperbolehkan';

  @override
  String get validationFullName => 'Masukkan nama yang valid';

  @override
  String get validationUsername =>
      'Masukkan nama pengguna yang valid (3–30 karakter)';

  @override
  String get validationPassword => 'Kata sandi tidak memenuhi persyaratan';

  @override
  String get validationConfirmPassword => 'Kata sandi tidak cocok';

  @override
  String get validationMatch => 'Nilai tidak cocok';

  @override
  String get validationInteger => 'Masukkan bilangan bulat yang valid';

  @override
  String get validationDecimal => 'Masukkan angka yang valid';

  @override
  String validationMinValue(num min) {
    return 'Minimal $min';
  }

  @override
  String validationMaxValue(num max) {
    return 'Maksimal $max';
  }

  @override
  String validationRange(num min, num max) {
    return 'Harus antara $min dan $max';
  }

  @override
  String get validationPositive => 'Harus berupa angka positif';

  @override
  String get validationNonNegative => 'Harus nol atau lebih besar';

  @override
  String get validationPhoneId => 'Masukkan nomor ponsel Indonesia yang valid';

  @override
  String get validationNik => 'NIK harus tepat 16 digit';

  @override
  String validationOtp(int length) {
    return 'Masukkan kode $length digit';
  }

  @override
  String get validationLatitude => 'Latitude harus antara -90 dan 90';

  @override
  String get validationLongitude => 'Longitude harus antara -180 dan 180';

  @override
  String get validationCoordinatePair =>
      'Masukkan koordinat yang valid (latitude,longitude)';

  @override
  String get validationPostalCode => 'Masukkan kode pos yang valid';

  @override
  String get validationCreditCard => 'Masukkan nomor kartu yang valid';

  @override
  String get validationDate => 'Masukkan tanggal yang valid';

  @override
  String validationMinAge(int years) {
    return 'Anda harus berusia minimal $years tahun';
  }

  @override
  String get validationFileExtension => 'Jenis file tidak diperbolehkan';

  @override
  String get validationNotEqual => 'Nilai ini tidak diperbolehkan';

  @override
  String get validationBlacklist => 'Nilai ini tidak diperbolehkan';

  @override
  String get validationWhitelist => 'Nilai ini tidak diperbolehkan';

  @override
  String commonThemeTooltip(String mode) {
    return 'Tema: $mode';
  }

  @override
  String commonLocaleTooltip(String language) {
    return 'Bahasa: $language';
  }

  @override
  String get authLoginTitle => 'Masuk';

  @override
  String get authLoginButton => 'Masuk';

  @override
  String get authCreateAccount => 'Buat akun';

  @override
  String get authRegisterTitle => 'Daftar';

  @override
  String get authRegisterButton => 'Daftar';

  @override
  String get authUsername => 'Nama pengguna';

  @override
  String get authPassword => 'Kata sandi';

  @override
  String get authFirstName => 'Nama depan';

  @override
  String get authLastName => 'Nama belakang';

  @override
  String get authAge => 'Usia';

  @override
  String get authInvalidNumber => 'Angka tidak valid';

  @override
  String authUserCreated(String name) {
    return 'Pengguna dibuat: $name';
  }

  @override
  String get dashboardTitle => 'Dasbor';

  @override
  String get dashboardLogout => 'Keluar';

  @override
  String get dashboardLoadingProfile => 'Memuat profil...';

  @override
  String dashboardWelcome(String name) {
    return 'Selamat datang, $name';
  }

  @override
  String get dashboardViewAllUsers => 'Lihat semua pengguna';

  @override
  String get dashboardDatePicker => 'Pilih tanggal';

  @override
  String get dashboardDateRangePicker => 'Pilih rentang tanggal';

  @override
  String get dashboardPickDate => 'Pilih tanggal';

  @override
  String dashboardSelectedDate(String date) {
    return 'Dipilih: $date';
  }

  @override
  String dashboardSelectedDateRange(String start, String end) {
    return 'Dipilih: $start - $end';
  }

  @override
  String dashboardUserId(String id) {
    return 'ID: $id';
  }

  @override
  String dashboardUserEmail(String email) {
    return 'Email: $email';
  }

  @override
  String get usersTitle => 'Pengguna';

  @override
  String get usersEmpty => 'Tidak ada pengguna';
}
