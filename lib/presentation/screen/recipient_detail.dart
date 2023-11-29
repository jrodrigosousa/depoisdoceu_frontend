import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business/bloc/recipient_detail_cubit.dart';
import '../../data/model/recipient.dart';

class RecipientDetail extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _RecipientDetailState();
  }
}

class _RecipientDetailState extends State<RecipientDetail> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController whatsappController = TextEditingController();
  late RecipientDetailCubit recipientDetailCubit;

  @override
  void initState() {
    super.initState();

    recipientDetailCubit = BlocProvider.of<RecipientDetailCubit>(context);

    nameController.text = recipientDetailCubit.state.recipient.name;
    emailController.text = recipientDetailCubit.state.recipient.email;
    whatsappController.text = recipientDetailCubit.state.recipient.whatsapp;
  }

  @override
  Widget build(BuildContext context) {
    
    Recipient recipientDetails = recipientDetailCubit.state.recipient;
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhe do destinatário"),
        actions: [
          PopupMenuButton(itemBuilder: (_) {
            return [
              // PopupMenuItem(
              //     child: Text("Concluir"),
              //     value: "complete",
              //     onTap: () => completeReminder(context)),
            ];
          })
        ],
      ),
      body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                      labelText: "Name", hintText: "Digite o nome do destinatário"),
                  controller: nameController,
                  onChanged: (value) {
                    recipientDetails.name = value;
                    recipientDetailCubit.setRecipient(recipientDetails);
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: "E-mail",
                      hintText: "Digite o e-mail do destinatário"),
                  controller: emailController,
                  onChanged: (value) {
                    recipientDetails.email = value;
                    recipientDetailCubit.setRecipient(recipientDetails);
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: "Whatsapp",
                      hintText: "Digite o whatsapp do destinatário"),
                  controller: whatsappController,
                  onChanged: (value) {
                    recipientDetails.whatsapp = value;
                    recipientDetailCubit.setRecipient(recipientDetails);
                  },
                ),
              ],
            ),
          )),
      bottomNavigationBar: bottonNavigationBar(context),
    );
  }

  Widget bottonNavigationBar(BuildContext context) {
    List<BottomNavigationBarItem> botoes = [
      BottomNavigationBarItem(icon: Icon(Icons.close), label: "Cancelar"),
      BottomNavigationBarItem(icon: Icon(Icons.delete), label: "Apagar"),
      BottomNavigationBarItem(icon: Icon(Icons.save), label: "Salvar"),
    ];

    return BottomNavigationBar(
      items: botoes,
      onTap: (value) {
        onBottomBarAction(botoes[value].label, context);
      },
    );
  }

  void onBottomBarAction(String? action, BuildContext context) {
    if (action == "Cancelar") {
      Navigator.of(context).pop();
    } else if (action == "Apagar") {
      //todo: implementar
    } else if (action == "Salvar") {
      recipientDetailCubit.saveRecipient();
      Navigator.of(context).pop();
    }
  }


}