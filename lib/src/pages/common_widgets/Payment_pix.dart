
import 'package:app_quitamda_virtual/src/services/UtilServices.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../models/orderModels.dart';

// ignore: must_be_immutable
class PaymentPix extends StatelessWidget {
  OrderModels orderModel;
  PaymentPix({super.key, required this.orderModel});

  UtilServices utilServices = UtilServices();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.black),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                //Titulo
                const Text(
                  "Pagamente com Pix",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 8),

                //código para apresentar o Qr-Code proveniente do Back-End
                Image.memory( utilServices.decodeQrCodeImage(orderModel.qrCodeImage),
                 height: 200,
                 width: 200,
                ),

                // Coódigo para apresentar o QR-CODE aleatório
                // QrImageView(
                //   data: '0987654321',
                //   version: QrVersions.auto,
                //   size: 200.0,
                // ),

                //Data de vencimento
                Text(
                 // "Vencimento: ${utilServices.formatDateTime(orderModel.createdDateTime)}",
                 "Vencimento",
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),

                //Total
                Text(
                  "Tolal: ${utilServices.priceToCurrency(orderModel.total)}",
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                //Botao
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    side: const BorderSide(color: Colors.green, width: 2),
                  ),
                  onPressed: () {
                    FlutterClipboard.copy(orderModel.copiaecola);
                  },
                  icon: const Icon(Icons.copy, color: Colors.green),
                  label: const Text(
                    "Copiar QR Code Pix",
                    style: TextStyle(color: Colors.green),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
