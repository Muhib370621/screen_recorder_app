import 'dart:io';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screen_record_app/views/screens/main_screens/meta_data_form.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../../core/utils/app_colors.dart';
import '../../components/blinking_text.dart';

class RecordVideoScreen extends StatefulWidget {
  const RecordVideoScreen({super.key});

  @override
  State<RecordVideoScreen> createState() => _RecordVideoScreenState();
}

class _RecordVideoScreenState extends State<RecordVideoScreen> {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  bool _isRecording = false;
  bool _isPaused = false;
  String? _videoPath;
  late TutorialCoachMark tutorialCoachMark;
  List<TargetFocus> targets = [];
  int currentTargetIndex = 0;

  GlobalKey resumeButton = GlobalKey();
  GlobalKey pauseButton = GlobalKey();
  GlobalKey startButton = GlobalKey();
  GlobalKey stopButton = GlobalKey();

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    await Permission.camera.request();
    await Permission.microphone.request();
    _cameras = await availableCameras();

    if (_cameras != null && _cameras!.isNotEmpty) {
      _controller = CameraController(_cameras![0], ResolutionPreset.high);
      await _controller!.initialize();
      if (mounted) {
        setState(() {});
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _buildTutorial();
          // _showTutorialStep(0);
        });
      }
    }
  }

  Future<String> _getVideoFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.mp4';
  }

  Future<void> _startRecording() async {
    if (_controller == null || _controller!.value.isRecordingVideo) return;
    final path = await _getVideoFilePath();
    await _controller!.startVideoRecording();
    _videoPath = path;
    setState(() {
      _isRecording = true;
    });
    // _showTutorialStep(1);
  }

  Future<void> _pauseRecording() async {
    if (_controller != null && _controller!.value.isRecordingVideo && !_isPaused) {
      await _controller!.pauseVideoRecording();
      setState(() {
        _isPaused = true;
      });
      // _showTutorialStep(2);
    }
  }

  Future<void> _resumeRecording() async {
    if (_controller != null && _controller!.value.isRecordingVideo && _isPaused) {
      await _controller!.resumeVideoRecording();
      setState(() {
        _isPaused = false;
      });
      // _showTutorialStep(1);
    }
  }

  Future<void> _stopRecording() async {
    if (_controller == null || !_controller!.value.isRecordingVideo) return;
    final videoFile = await _controller!.stopVideoRecording();
    final file = File(_videoPath!);
    await file.writeAsBytes(await videoFile.readAsBytes());

    setState(() {
      _isRecording = false;
      _isPaused = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Video saved at: ${file.path}")),
    );
    Get.to(()=> GameSetupForm());
  }

  void _confirmStopRecording() {
    Get.defaultDialog(
      title: "End Recording",
      middleText: "Are you sure you want to stop and save the video?",
      textCancel: "No",
      textConfirm: "Yes",
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back();
        _stopRecording();
      },
      onCancel: () {},
    );
  }

  void _buildTutorial() {
    targets = [
      TargetFocus(

        identify: "Start",
        keyTarget: startButton,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Start Recording",
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text("Tap here to start game recording.", style: TextStyle(color: Colors.white, fontSize: 16)),
              ],
            ),
          ),
        ],
        shape: ShapeLightFocus.Circle,
      ),
      TargetFocus(
        identify: "Pause",
        keyTarget: pauseButton,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Pause Recording",
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text("Tap here to pause the recording.", style: TextStyle(color: Colors.white, fontSize: 16)),
              ],
            ),
          ),
        ],
        shape: ShapeLightFocus.Circle,
      ),
      TargetFocus(
        identify: "Resume",
        keyTarget: resumeButton,
        contents: [
          TargetContent(
            align: ContentAlign.top
            ,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Resume Recording",
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text("Tap here to resume the recording.", style: TextStyle(color: Colors.white, fontSize: 16)),
              ],
            ),
          ),
        ],
        shape: ShapeLightFocus.Circle,
      ),
      TargetFocus(
        identify: "Stop",
        keyTarget: stopButton,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Stop Recording",
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text("Tap here to stop and save the recording.", style: TextStyle(color: Colors.white, fontSize: 16)),
              ],
            ),
          ),
        ],
        shape: ShapeLightFocus.Circle,
      ),
    ];
  }

  // void _showTutorialStep(int index) {
  //   if (index >= targets.length) return;
  //
  //   tutorialCoachMark = TutorialCoachMark(
  //     targets: [targets[index]],
  //     colorShadow: Colors.black,
  //     paddingFocus: 10,
  //     opacityShadow: 0.8,
  //     imageFilter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
  //   );
  //
  //   tutorialCoachMark.show(context: context);
  // }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Widget _circleButton({required IconData icon, Color? color, double size = 55}) {
    return Container(
      margin: EdgeInsets.all(10.h),
      height: size.h,
      width: size.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color ?? AppColors.kRed,
        border: Border.all(color: AppColors.pureWhite, width: 2.5.w),
      ),
      child: Center(
        child: Icon(icon, color: AppColors.pureWhite),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _controller == null || !_controller!.value.isInitialized
          ? const Center(child: CircularProgressIndicator())
          : Stack(
        children: [
          SizedBox(
            height: 1.sh,
            child: AspectRatio(
              aspectRatio: _controller!.value.aspectRatio,
              child: CameraPreview(_controller!),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (!_isRecording)
                  InkWell(
                    key: startButton,
                    onTap: _startRecording,
                    child: _circleButton(icon: Icons.fiber_manual_record_sharp),
                  ),
                if (_isRecording && !_isPaused)
                  InkWell(
                    key: pauseButton,
                    onTap: _pauseRecording,
                    child: _circleButton(icon: Icons.pause),
                  ),
                if (_isPaused) ...[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      key: resumeButton,
                      onTap: _resumeRecording,
                      child: _circleButton(icon: Icons.fiber_manual_record_sharp),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      key: stopButton,
                      onTap: _confirmStopRecording,
                      child: _circleButton(icon: Icons.stop),
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (_isRecording)
            BlinkingRecordingText(text: "RECORDING")
                .paddingOnly(top: 25.h, left: 20.w),
        ],
      ),
    );
  }
}