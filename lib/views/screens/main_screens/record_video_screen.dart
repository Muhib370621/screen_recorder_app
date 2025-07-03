import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screen_record_app/views/components/blinking_text.dart';

import '../../../core/utils/app_colors.dart';

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
      setState(() {});
    }
  }

  Future<String> _getVideoFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/${DateTime
        .now()
        .millisecondsSinceEpoch}.mp4';
  }

  Future<void> _startRecording() async {
    if (_controller == null || _controller!.value.isRecordingVideo) return;
    final path = await _getVideoFilePath();
    await _controller!.startVideoRecording();
    _videoPath = path;
    setState(() {
      _isRecording = true;
    });
  }

  Future<void> _pauseRecording() async {
    if (_controller != null && _controller!.value.isRecordingVideo && !_isPaused) {
      await _controller!.pauseVideoRecording();
      setState(() {
        _isPaused = true;
      });
    }
  }

  Future<void> _resumeRecording() async {
    if (_controller != null && _controller!.value.isRecordingVideo && _isPaused) {
      await _controller!.resumeVideoRecording();
      setState(() {
        _isPaused = false;
      });
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

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Video saved at: ${file.path}")));
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Record video", style: AppTextStyles.w600Style(18.sp)),
      // ),
      body:
      _controller == null || !_controller!.value.isInitialized
          ? Center(child: CircularProgressIndicator())
          : Stack(
        fit: StackFit.loose,
        children: [
          SizedBox(
            height: 1.sh,
            child: AspectRatio(aspectRatio: _controller!.value.aspectRatio, child: CameraPreview(_controller!)),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Left floating button
                if (_isRecording)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {
                        if (_isRecording && !_isPaused) {
                          _pauseRecording();
                        } else {
                          _resumeRecording();
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10.h, left: 40.w),
                        // adjust left margin as needed
                        height: 40.h,
                        width: 40.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.pureWhite, width: 2.5.w),
                        ),
                        child: Center(
                          child: Icon(
                            _isRecording && !_isPaused ? Icons.pause : Icons.play_arrow,
                            color: AppColors.pureWhite,
                          ),
                        ),
                      ),
                    ),
                  ),
                // Center main button
                InkWell(
                  onTap: () {
                    if (!_isRecording) {
                      _startRecording();
                    } else {
                      _stopRecording();
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10.h),
                    height: 55.h,
                    width: 55.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.kRed,
                      border: Border.all(color: AppColors.pureWhite, width: 2.5.w),
                    ),
                    child: Center(
                      child: Icon(
                        _isRecording ? Icons.stop : Icons.fiber_manual_record_sharp,
                        color: AppColors.pureWhite,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _isRecording ? BlinkingRecordingText(text: "RECORDING").paddingOnly(top: 25.h,left: 20.w):SizedBox()

        ],
      ),
    );
  }
}
