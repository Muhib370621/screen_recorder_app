import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screen_record_app/core/utils/app_text_styles.dart';

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

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Video saved at: ${file.path}"),
    ));
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Record video", style: AppTextStyles.w600Style(18.sp)),
      ),
      body: _controller == null || !_controller!.value.isInitialized
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          AspectRatio(
            aspectRatio: _controller!.value.aspectRatio,
            child: CameraPreview(_controller!),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _isRecording ? null : _startRecording,
                child: Text("Start"),
              ),
              ElevatedButton(
                onPressed: _isRecording && !_isPaused ? _pauseRecording : null,
                child: Text("Pause"),
              ),
              ElevatedButton(
                onPressed: _isRecording && _isPaused ? _resumeRecording : null,
                child: Text("Resume"),
              ),
              ElevatedButton(
                onPressed: _isRecording ? _stopRecording : null,
                child: Text("Stop"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
