import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:peer_instruction_student/apis/class_api.dart';
import 'package:peer_instruction_student/utils/base_request.dart';
import 'package:toastification/toastification.dart';

class CheckInTabView extends StatefulWidget {
  const CheckInTabView({super.key, required this.courseId, required this.classId});

  final int courseId;
  final int classId;

  @override
  State<CheckInTabView> createState() => _CheckInTabViewState();
}

class _CheckInTabViewState extends State<CheckInTabView>
    with WidgetsBindingObserver {
  final MobileScannerController controller = MobileScannerController();
  StreamSubscription<Object?>? _subscription;

  bool? _attended;

  @override
  void initState() {
    super.initState();
    // Start listening to lifecycle changes.
    WidgetsBinding.instance.addObserver(this);
    // Start listening to the barcode events.
    _subscription = controller.barcodes.listen(_handleBarcode);
    // Finally, start the scanner itself.
    unawaited(controller.stop());
    // unawaited(controller.start());
    _checkIn();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // If the controller is not ready, do not try to start or stop it.
    // Permission dialogs can trigger lifecycle changes before the controller is ready.
    if (!controller.value.hasCameraPermission) {
      return;
    }

    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        return;
      case AppLifecycleState.resumed:
        // Restart the scanner when the app is resumed.
        // Don't forget to resume listening to the barcode events.
        _subscription = controller.barcodes.listen(_handleBarcode);

        unawaited(controller.stop());
      case AppLifecycleState.inactive:
        // Stop the scanner when the app is paused.
        // Also stop the barcode events subscription.
        unawaited(_subscription?.cancel());
        _subscription = null;
        unawaited(controller.stop());
    }
  }

  @override
  Future<void> dispose() async {
    // Stop listening to lifecycle changes.
    WidgetsBinding.instance.removeObserver(this);
    // Stop listening to the barcode events.
    unawaited(_subscription?.cancel());
    _subscription = null;
    // Dispose the widget itself.
    super.dispose();
    // Finally, dispose of the controller.
    await controller.dispose();
  }

  // 互斥锁，防止重复处理二维码
  bool _isHandling = false;
  void _handleBarcode(BarcodeCapture barcode) async {
    if (_isHandling) {
      return;
    }
    _isHandling = true;

    var res = await ClassApi().checkIn(widget.courseId, widget.classId,
        barcode.barcodes.first.displayValue ?? "");
    if (res) {
      if (mounted) {
        setState(() {
          _attended = true;
        });
        toastification.show(
          showProgressBar: false,
          autoCloseDuration: const Duration(seconds: 3),
          alignment: Alignment.topCenter,
          title: const Text('签到成功'),
          type: ToastificationType.success,
        );
        controller.stop();
      } else {
        toastification.show(
          showProgressBar: false,
          autoCloseDuration: const Duration(seconds: 3),
          alignment: Alignment.topCenter,
          title: const Text('签到失败'),
          type: ToastificationType.error,
        );
        _isHandling = false;
      }
    }
  }

  void _checkIn() async {
    // BaseRequest().openLog(requestBody: true, responseBody: true);
    var res = await ClassApi().isAttended(widget.courseId, widget.classId);
    if (mounted) {
      setState(() {
        _attended = res;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _attended == null
        ? const Center(child: CircularProgressIndicator())
        : _attended!
            ? _buildCheckedIn(context)
            : _buildCheckingIn(context);
  }

  double _zoomFactor = 0.0;

  Widget _buildCheckingIn(BuildContext context) {
    controller.start();
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 100),
          SizedBox(
              height: 300,
              width: 300,
              child: MobileScanner(
                controller: controller,
                fit: BoxFit.cover,
                errorBuilder: (context, error, child) => Center(
                  child: Center(
                    child: Text(
                      error.toString(),
                      style: const TextStyle(
                        color: Color(0xff181818),
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              )),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Slider(
                value: _zoomFactor,
                onChanged: (value) {
                  setState(() {
                    _zoomFactor = value;
                    controller.setZoomScale(_zoomFactor);
                  });
                }),
          ),
          const SizedBox(height: 20),
          const Text(
            "请将二维码置于摄像头范围内",
            style: TextStyle(
              color: Color(0xff181818),
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckedIn(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Icon(
            Icons.check_circle,
            size: 150,
            color: Color(0xff27AE60),
          ),
          SizedBox(
            height: 100,
          ),
          Text(
            "签到成功",
            style: TextStyle(
              color: Color(0xff181818),
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
