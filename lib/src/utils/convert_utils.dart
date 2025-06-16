import 'package:barcode_widget/barcode_widget.dart' as barcode_widget;
import 'package:intl/intl.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ConvertUtils {
  static final Map<BarcodeFormat, barcode_widget.BarcodeType>
  _barcodeFormatMap = {
    BarcodeFormat.code128: barcode_widget.BarcodeType.Code128,
    BarcodeFormat.code39: barcode_widget.BarcodeType.Code39,
    BarcodeFormat.code93: barcode_widget.BarcodeType.Code93,
    BarcodeFormat.codabar: barcode_widget.BarcodeType.Codabar,
    BarcodeFormat.dataMatrix: barcode_widget.BarcodeType.DataMatrix,
    BarcodeFormat.ean13: barcode_widget.BarcodeType.CodeEAN13,
    BarcodeFormat.ean8: barcode_widget.BarcodeType.CodeEAN8,
    BarcodeFormat.itf: barcode_widget.BarcodeType.Itf,
    BarcodeFormat.qrCode: barcode_widget.BarcodeType.QrCode,
    BarcodeFormat.upcA: barcode_widget.BarcodeType.CodeUPCA,
    BarcodeFormat.upcE: barcode_widget.BarcodeType.CodeUPCE,
    BarcodeFormat.pdf417: barcode_widget.BarcodeType.PDF417,
    BarcodeFormat.aztec: barcode_widget.BarcodeType.Aztec,
  };

  static barcode_widget.BarcodeType getBarcodeType(int typeId) {
    final format = BarcodeFormat.fromRawValue(typeId);
    final type = _barcodeFormatMap[format];

    if (type == null) {
      throw UnimplementedError('BarcodeFormat $format is not supported.');
    }

    return type;
  }

  static String getExpiryText(DateTime? expiresAt, bool shortDate) {
    if (expiresAt == null) {
      return "Geen verloopdatum";
    }

    final formattedDate = (shortDate
            ? DateFormat.yMd('nl')
            : DateFormat.yMMMMd('nl'))
        .format(expiresAt);
    final isExpired = DateTime.now().isAfter(expiresAt);

    return "${isExpired ? 'Verlopen' : 'Verloopt'} op $formattedDate";
  }
}
