import 'dart:io';

import 'package:image/image.dart';
import 'dart:typed_data';
import 'package:esc_pos_utils/esc_pos_utils.dart';

Future<void> main() async {
  final profile = await CapabilityProfile.load();
  final generator = Generator(PaperSize.mm80, profile);
  List<int> bytes = [];

  bytes += generator.reset();

  bytes += generator.text(
      'Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ');
  // bytes += generator.text('Special 1: àÀ èÈ éÉ ûÛ üÜ çÇ ôÔ',
  //     styles: PosStyles(codeTable: 'CP1252'));
  // bytes += generator.text('Special 2: blåbærgrød',
  //     styles: PosStyles(codeTable: 'CP1252'));
  bytes += generator.reset();
  bytes += generator.text('Bold text', styles: PosStyles(bold: true));
  bytes += generator.reset();
  bytes += generator.text('Reverse text', styles: PosStyles(reverse: true));
  bytes += generator.reset();
  bytes += generator.text('Underlined text',
      styles: PosStyles(underline: true), linesAfter: 1);
  bytes += generator.reset();
  bytes += generator.hr();
  bytes +=
      generator.text('Align left', styles: PosStyles(align: PosAlign.left));
  bytes += generator.reset();
  bytes +=
      generator.text('Align center', styles: PosStyles(align: PosAlign.center));
  bytes += generator.reset();
  bytes += generator.text('Align right',
      styles: PosStyles(align: PosAlign.right), linesAfter: 1);
  bytes += generator.reset();

  bytes += generator.row([
    PosColumn(
      text: 'col3',
      width: 3,
      styles: PosStyles(align: PosAlign.left, underline: true),
    ),
    PosColumn(
      text: 'col3',
      width: 3,
      styles: PosStyles(align: PosAlign.left, underline: true),
    ),
    PosColumn(
      text: 'col3',
      width: 3,
      styles: PosStyles(align: PosAlign.left, underline: true),
    ),
    PosColumn(
      text: 'col3',
      width: 3,
      styles: PosStyles(align: PosAlign.left, underline: true),
    ),
  ]);
  bytes += generator.reset();

  bytes += generator.text('ESCALAVEL2',
      styles: PosStyles(
        height: PosTextSize.size2,
        width: PosTextSize.size2,
      ));
  bytes += generator.reset();
  bytes += generator.text('ESCALAVEL3',
      styles: PosStyles(
        height: PosTextSize.size3,
        width: PosTextSize.size3,
      ));
  bytes += generator.reset();
  bytes += generator.text('ESCALAVEL4',
      styles: PosStyles(
        height: PosTextSize.size4,
        width: PosTextSize.size4,
      ));
  bytes += generator.reset();
  bytes += generator.text('ESCALAVEL5',
      styles: PosStyles(
        height: PosTextSize.size5,
        width: PosTextSize.size5,
      ));
  bytes += generator.reset();
  bytes += generator.text('ESCALAVEL6',
      styles: PosStyles(
        height: PosTextSize.size6,
        width: PosTextSize.size6,
      ));
  bytes += generator.reset();

  // Print image:
  final Uint8List imgBytes =
      await File('/home/everton/Downloads/4print_test.png').readAsBytes();
  final Image image = decodeImage(imgBytes)!;
  bytes += generator.image(image);
  //Print image using an alternative (obsolette) command
  //bytes += generator.imageRaster(image);

  bytes += generator.reset();

  // Print barcode
  final List<int> barData = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 4];
  bytes += generator.barcode(Barcode.upcA(barData));
  bytes += generator.reset();

  // Print mixed (chinese + latin) text. Only for printers supporting Kanji mode
  // ticket.text(
  //   'hello ! 中文字 # world @ éphémère &',
  //   styles: PosStyles(codeTable: PosCodeTable.westEur),
  //   containsChinese: true,
  // );

  bytes += generator.feed(2);
  bytes += generator.cut();
  bytes += generator.reset();

  final file = File('/dev/usb/lp0');
  file.writeAsBytes(bytes);

  print('end');
}

Future addUserToLpGroup() async {
  final whoami = (await Process.run('whoami', [])).stdout.toString().trim();
  final result =
      await Process.run('pkexec', ['usermod', '-a', '-G', 'lp', whoami]);

  print('result::. ${result.stdout}');
}

Future<bool> hasLpPermission() async {
  final whoami = (await Process.run('whoami', [])).stdout.toString().trim();

  print('whoami $whoami');

  final result = await Process.run('cat', ['/etc/group']);
  final groups = result.stdout.toString().split('\n');

  for (var line in groups) {
    if (line.startsWith('lp:')) {
      if (line.contains(whoami)) {
        print('has permission');
        return true;
      } else {
        print('no has permission');
        return false;
      }
    }
  }
  print('group lp not found');
  return false;
}
