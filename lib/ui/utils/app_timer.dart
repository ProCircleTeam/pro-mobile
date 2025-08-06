import 'dart:async';

class AppTimer {
  Timer? _timer;
  void startTimer({required int countDown, required Function onChange}) {
    _timer?.cancel();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (countDown > 0) {
        print("CountDown =====> $countDown");
        onChange();
      } else {
        timer.cancel();
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }
}
