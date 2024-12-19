import 'package:business_card_detector/widgets/adjustable_text_field.dart';
import 'package:business_card_detector/widgets/main_icon_btn.dart';
import 'package:business_card_detector/widgets/secondary_text_field.dart';
import 'package:flutter/material.dart';

class SendingEmail extends StatefulWidget {
  const SendingEmail({super.key});

  @override
  State<SendingEmail> createState() => _SendingEmailState();
}

class _SendingEmailState extends State<SendingEmail> {
  int ccCount = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: const MainIconBtn(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SecondaryTextField(
                btnText: 'From',
                btnFunction: () {},
                controller: TextEditingController(text: 'joshuajoy27@gmail.com'),
              ),
              SecondaryTextField(
                btnText: 'To',
                btnFunction: () {},
                controller: TextEditingController(text: 'ismabreta@gmail.com'),
              ),
              for (int i = 0; i < ccCount; i++)
                Row(
                  children: <Widget>[
                    Expanded(child: SecondaryTextField(btnText: 'cc', btnFunction: () {})),
                    if (i == ccCount - 1)
                      IconButton(
                        onPressed: () {
                          setState(() {
                            ccCount++;
                          });
                        },
                        icon: const Icon(Icons.add),
                      )
                    else
                      IconButton(
                        onPressed: () {
                          setState(() {
                            ccCount--;
                          });
                        },
                        icon: const Icon(Icons.remove),
                      )
                  ],
                ),
              AdjustableTextField(
                maxLines: 12,
                txtTitle: 'email message',
                message: TextEditingController(text: '''
I hope this message finds you well. My name is Joshua Joy Crucis and I am CEO at Stappl Inc. I recently came across your work with and was genuinely impressed by your goals

At Stappl Inc., we specialize in Artificial Intelligence and Software Development. I believe there’s significant potential for collaboration between our organizations, particularly in aiming to be staple of Technology.

I would love the opportunity to discuss how we can work together to benefit our partnership. Please let me know a time that works best for you to connect, or feel free to suggest an alternative.

Thank you for considering this opportunity. I look forward to hearing from you!

Best regards,
Joshua Joy Crucis
CEO
Stappl Inc.
+63 998 356 6406'''),
              )
            ],
          ),
        ),
      ),
    );
  }
}
