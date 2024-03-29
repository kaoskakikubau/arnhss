import 'dart:async';

import 'package:arnhss/features/authentication/login/view/index.dart';
import 'package:arnhss/common/widgets/custom_snack_bar.dart';
import 'package:arnhss/features/authentication/login/view_model/country_view_model.dart';
import 'package:arnhss/features/authentication/otp_verification/repo/verify_otp_serivce.dart';

class VerifyOtpViewModel extends ChangeNotifier {
  final _verifyOtpService = VerifyOtpService();
  int _balanceTime = 30;
  bool _isFirstReq = true;
  final ScrollController _otpScrollController = ScrollController();
  String? _otp;
  bool _isLoading = false;

  // getters
  int get balanceTime => _balanceTime;
  bool get resendAvailable => _balanceTime == 0 ? true : false;
  bool get isFirstReq => _isFirstReq;
  ScrollController get otpScrollController => _otpScrollController;
  String? get otp => _otp;
  bool get isLoading => _isLoading;

//setters
  void setOtp(String? otp) {
    _otp = otp;
    notifyListeners();
  }

  set isFirstReq(bool status) => (_isFirstReq = status);

  // functions
// reset the timer
  void resetTimer() {
    _balanceTime = 60;
    _isFirstReq = false;
    notifyListeners();
  }

  void updateLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

// the time for resend the otp
  Future<void> startTimer() async {
    const Duration lim = Duration(seconds: 1);
    Timer.periodic(lim, (timer) {
      if (_balanceTime == 0) {
        timer.cancel();
      } else {
        _balanceTime--;
        notifyListeners();
      }
    });
  }

// validate the otp by api
  Future<bool> verifyOtp(BuildContext context) async {
    if (_otp!.length == 6 && num.tryParse(_otp!) != null) {
      debugPrint("verifying otp");

      updateLoading();
      // implimentation of api call
      // try {} catch (e) {}
      var response = await _verifyOtpService.verifyOtp(
          otp: _otp!,
          phone: context.read<LoginViewModel>().mobileNumberController.text,
          countryCode:
              context.read<CountryViewModel>().selectedCountry.dialCode);
      // loading just for ui test
      // await Future.delayed(const Duration(seconds: 3));
      print(response);
      updateLoading();
      return true;
    } else {
      debugPrint("invalid otp");
      customSnackBar(content: "sorry 😞, Please enter valid OTP");
      return false;
    }
  }
}
