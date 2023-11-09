import 'package:flutter/material.dart';

import '../../config/custom_colors.dart';

class QuantityWidget extends StatelessWidget {
    final int itemQuantity;
    final String uniy;
    final Function(int quantity) value;
    final bool removable;
    
  const QuantityWidget({
    Key? key,
    required this.itemQuantity,
    required this.uniy,
    required this.value,
    this.removable = false

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     
     int resultCount;

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          boxShadow: const [
            BoxShadow(color: Colors.grey, spreadRadius: 1, blurRadius: 2)
          ]),
      child:  Row(
        mainAxisSize: MainAxisSize.min,
        children: [
        
          _QuantityWidget(
            color: itemQuantity > 1 || !removable ? Colors.grey : Colors.red, 
            icon:  itemQuantity > 1 || !removable ? Icons.remove : Icons.delete_forever, 
            onTap: () {  

              if(itemQuantity == 1 && !removable) return;

              resultCount = itemQuantity - 1;
              value(resultCount);
              
            },
            
          ),

           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 5),
             child: Text(
              "$itemQuantity$uniy",
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                     ),
           ),

           _QuantityWidget(
            color: CustomColors.customSwatchColor, 
            icon: Icons.add, 
            onTap: () { 
               
               resultCount = itemQuantity + 1;
               value(resultCount);

             },
          ),
        ],
      ),
    );
  }
}

class _QuantityWidget extends StatelessWidget {
  final Color color;
  final IconData icon;
  final VoidCallback onTap;

  const _QuantityWidget({
    super.key, 
    required this.color, 
    required this.icon, 
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        onTap: onTap,
        child: Ink(
          height: 25,
          width: 25,
          decoration:
               BoxDecoration(color: color, shape: BoxShape.circle),
          child:  Icon(
            icon,
            size: 12,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
