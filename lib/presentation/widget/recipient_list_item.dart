import 'package:depois_do_ceu/business/bloc/recipient_detail_cubit.dart';
import 'package:depois_do_ceu/data/model/recipient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class RecipientListItem extends StatelessWidget {
  Recipient recipient;

  RecipientListItem({required this.recipient});
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<RecipientDetailCubit>(context).setRecipient(recipient);
        Navigator.of(context).pushNamed("/recipient_detail");
      },
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text("${recipient.name}")],
              )),
              Icon(Icons.chevron_right)
            ],
          ),
        ),
      ),
    );
  }


}