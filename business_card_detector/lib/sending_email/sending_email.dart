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
              SecondaryTextField(btnText: 'From', btnFunction: () {}),
              SecondaryTextField(btnText: 'To', btnFunction: () {}),
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
              const AdjustableTextField(maxLines: 12, txt: 'email message')
            ],
          ),
        ),
      ),
    );
  }
}
