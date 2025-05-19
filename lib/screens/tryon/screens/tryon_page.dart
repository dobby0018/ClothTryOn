// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';

// class TryOnPage extends StatefulWidget {
//   const TryOnPage({super.key});

//   @override
//   State<TryOnPage> createState() => _TryOnPageState();
// }

// class _TryOnPageState extends State<TryOnPage> {
  
//     File? _imageFile;
//   bool _isUploading = false;

//   Future<void> _requestCameraPermissionAndTakePicture() async {
//     var status = await Permission.camera.request();

//     if (status.isGranted) {
//       final pickedImage = await ImagePicker().pickImage(
//         source: ImageSource.camera,
//         preferredCameraDevice: CameraDevice.rear,
//       );

//       if (pickedImage != null) {
//         setState(() {
//           _imageFile = File(pickedImage.path);
//         });
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Camera permission is required")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Virtual Try-On")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             const Text(
//               '📸 Please take a full-body picture in a well-lit area.',
//               style: TextStyle(fontSize: 16),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 20),
//             if (_imageFile == null)
//               ElevatedButton.icon(
//                 icon: const Icon(Icons.camera_alt, color: Colors.black87),
//                 label: const Text(
//                   'Take Picture',
//                   style: TextStyle(
//                     color: Colors.black87,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 onPressed: _requestCameraPermissionAndTakePicture,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.grey[200],
//                   foregroundColor: Colors.black87,
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 24.0,
//                     vertical: 14.0,
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30.0),
//                   ),
//                   elevation: 3,
//                   shadowColor: Colors.grey[700],
//                 ),
//               ),
//             const SizedBox(height: 20),
//             _imageFile != null
//                 ? Expanded(
//                   child: Column(
//                     children: [
//                       const Text(
//                         'Captured Image:',
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: 20),
//                       Expanded(
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(16),
//                           child: Image.file(
//                             _imageFile!,
//                             fit: BoxFit.contain,
//                             width: double.infinity,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//                 : const Text("No image captured yet."),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../services/api_service.dart';

class TryOnPage extends StatefulWidget {
  const TryOnPage({super.key});

  @override
  State<TryOnPage> createState() => _TryOnPageState();
}

class _TryOnPageState extends State<TryOnPage> {
  File? _imageFile;
  bool _isUploading = false;

  Future<void> _requestCameraPermissionAndTakePicture() async {
    var status = await Permission.camera.request();

    if (status.isGranted) {
      final pickedImage = await ImagePicker().pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.rear,
      );

      if (pickedImage != null) {
        setState(() {
          _imageFile = File(pickedImage.path);
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Camera permission is required")),
      );
    }
  }

  Future<void> _uploadImage() async {
    if (_imageFile == null) return;

    setState(() => _isUploading = true);
    
    try {
      final fileId = await ApiService.uploadImage(_imageFile!);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('✅ Upload successful! File ID: $fileId')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ Upload failed: ${e.toString()}')),
      );
    } finally {
      setState(() => _isUploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Virtual Try-On")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              '📸 Please take a full-body picture in a well-lit area.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            if (_imageFile == null)
              ElevatedButton.icon(
                icon: const Icon(Icons.camera_alt, color: Colors.black87),
                label: const Text(
                  'Take Picture',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: _requestCameraPermissionAndTakePicture,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200],
                  foregroundColor: Colors.black87,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 14.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  elevation: 3,
                  shadowColor: Colors.grey[700],
                ),
              ),
            const SizedBox(height: 20),
            _imageFile != null
                ? Expanded(
                    child: Column(
                      children: [
                        const Text(
                          'Captured Image:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.file(
                              _imageFile!,
                              fit: BoxFit.contain,
                              width: double.infinity,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        _isUploading
                            ? const CircularProgressIndicator()
                            : ElevatedButton.icon(
                                icon: const Icon(Icons.cloud_upload, 
                                    color: Colors.white),
                                label: const Text('Upload Image'),
                                onPressed: _uploadImage,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue[700],
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  )
                : const Text("No image captured yet."),
          ],
        ),
      ),
    );
  }
}