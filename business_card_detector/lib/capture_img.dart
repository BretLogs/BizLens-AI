import 'dart:convert';
import 'dart:io';
import 'package:business_card_detector/widgets/main_btn.dart';
import 'package:business_card_detector/widgets/main_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class CaptureImg extends StatefulWidget {
  const CaptureImg({super.key});

  @override
  _CaptureImgState createState() => _CaptureImgState();
}

class _CaptureImgState extends State<CaptureImg> {
  File? _image;

  final ImagePicker _picker = ImagePicker();

  Future<void> _captureImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_image == null) return;

    // Replace with your Flask API endpoint
    String apiUrl = 'http://192.168.1.44:5000/process-image';

    // Create multipart request
    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.files.add(await http.MultipartFile.fromPath('image', _image!.path));
    print('waiting for response....');

    // Send request
    http.StreamedResponse response = await request.send();
    print('Here we go....');

    if (response.statusCode == 200) {
      http.Response responseBody = await http.Response.fromStream(response);
      var data = json.decode(responseBody.body);
      print('Response: $data');
    } else {
      print('Failed to upload image. Status Code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController companyName = TextEditingController(text: 'company_name_placeholder');
    final TextEditingController fullName = TextEditingController(text: 'full_name_placeholder');
    final TextEditingController email = TextEditingController(text: 'email_placeholder');
    final TextEditingController phoneNum = TextEditingController(text: 'phone_number_placeholder');
    final TextEditingController website = TextEditingController(text: 'website_placeholder');
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Text(
              'BizLens',
              style: GoogleFonts.pixelifySans(fontSize: 16),
            ),
            const SizedBox(width: 4),
            Text(
              'AI',
              style: GoogleFonts.pixelifySans(
                color: const Color(0xff0067EB),
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _image == null
                  ? Container(
                      height: MediaQuery.sizeOf(context).height / 4,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.black,
                        ),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        splashColor: Colors.blueAccent,
                        onTap: _captureImage,
                        child: const Center(
                          child: Icon(
                            Icons.camera_alt_outlined,
                            size: 40,
                            color: Color(0xffD9D9D9),
                          ),
                        ),
                      ),
                    )
                  : Column(
                      children: <Widget>[
                        Image.file(_image!, height: 200),
                        IconButton(
                          onPressed: _captureImage,
                          icon: const Icon(Icons.image),
                        ),
                      ],
                    ),
              const SizedBox(
                height: 20,
              ),
              const MainTextField(labelTxt: 'Company name'),
              MainTextField(labelTxt: 'Full Name', controller: fullName),
              MainTextField(labelTxt: 'email', controller: email),
              MainTextField(labelTxt: 'Phone number', controller: phoneNum),
              MainTextField(labelTxt: 'Website', controller: website),
              const SizedBox(height: 12),
              MainBtn(
                btnText: 'Proceed',
                btnFunction: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (BuildContext context) => const CaptureImg()),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
