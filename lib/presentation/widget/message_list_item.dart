import 'package:depois_do_ceu/business/bloc/message_detail_cubit.dart';
import 'package:depois_do_ceu/data/model/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class MessageListItem extends StatelessWidget {
  Message message;

  MessageListItem({required this.message});
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<MessageDetailCubit>(context).setMessage(message);
        Navigator.of(context).pushNamed("/message_detail");
      },
      child: Container(
        color: message.toSendDate.isBefore(DateTime.now()) ? Color.fromRGBO(235, 161, 177, 1) : Color.fromARGB(255, 161, 235, 192),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Column(
                children: [Text(DateFormat('dd/MM/yyyy HH:mm').format(message.toSendDate))],
              ),
              SizedBox(width: 20,),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text("${message.title}")],
              )),
              Icon(Icons.chevron_right)
            ],
          ),
        ),
      ),
    );
  }


}