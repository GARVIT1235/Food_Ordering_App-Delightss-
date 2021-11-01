import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/smtp_server/gmail.dart';

class Email {
  sendMail(String dest, String name) async {
    String username = 'minorproject597@gmail.com';
    String password = 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
    // String domainSmtp = 'mail.domain.com';

    //also use for gmail smtp
    final smtpServer = gmail(username, password);

    // //user for your own domain
    // final smtpServer = SmtpServer(domainSmtp,
    //     username: username, password: password, port: 587);

    final message = Message()
      ..from = Address(username, name)
      ..recipients.add(dest)
      //..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
      //..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = 'Dart Mailer library :: 😀 :: ${DateTime.now()}'
      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html = "<h1>Shawon</h1>\n<p>Hey! Here's some HTML content</p>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }
}
