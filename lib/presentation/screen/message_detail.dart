import 'package:depois_do_ceu/business/bloc/recipient_list_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:flutter/src/widgets/notification_listener.dart' as notif;

import '../../business/bloc/message_detail_cubit.dart';
import '../../data/model/message.dart';
import '../../data/model/recipient.dart';
import '../../data/model/notification.dart' as modelNotification;
import '../widget/notification_edit_popup.dart';

class MessageDetail extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MessageDetailState();
  }
}

class _MessageDetailState extends State<MessageDetail> {
  TextEditingController tituloController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  TextEditingController delayController = TextEditingController();
  late MessageDetailCubit messageDetailCubit;
  late RecipientListCubit recipientListCubit;
  late Message messageDetails;

  @override
  void initState() {
    super.initState();

    messageDetailCubit = BlocProvider.of<MessageDetailCubit>(context);
    recipientListCubit = BlocProvider.of<RecipientListCubit>(context);

    messageDetails = messageDetailCubit.state.message;

    tituloController.text = messageDetails.title;
    contentController.text = messageDetails.text;
    delayController.text = messageDetails.toSendDelayInHours.toString();
  }

  @override
  Widget build(BuildContext context) {
    List<Recipient> allRecipients = [];
    if(recipientListCubit.state is RecipientsLoaded)
      allRecipients = (recipientListCubit.state as RecipientsLoaded).recipients;

    List<MultiSelectItem<int>> allRecipientsSelector = [];
    for (var recipient in allRecipients) {
      allRecipientsSelector.add(MultiSelectItem(recipient.id!, recipient.name));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhe da mensagem"),
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
                      labelText: "Título", hintText: "Digite o título da mensagem"),
                  controller: tituloController,
                  onChanged: (value) {
                    messageDetails.title = value;
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: "Conteúdo",
                      hintText: "Digite o conteúdo da mensagem"),
                  maxLines: null,
                  controller: contentController,
                  onChanged: (value) {
                    messageDetails.text = value;
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: "Intervalo de envio",
                      hintText: "Quanto tempo esperar para enviar depois de resetado"),
                  controller: delayController,
                  onChanged: (value) {
                    messageDetails.toSendDelayInHours = int.parse(value);
                  },
                ),
                Row(children: [
                  Text("Ativo"),
                  Checkbox(
                      value: messageDetails.active,
                      onChanged: (newValue)=>setState(() {
                        messageDetails.active = newValue!;
                      })
                  )
                ]),
                MultiSelectDialogField(
                  buttonText: Text("Destinatários"),
                  items: allRecipientsSelector,
                  initialValue: messageDetails.recipientIds,
                  chipDisplay: MultiSelectChipDisplay(),
                  onConfirm: (List recipients) {
                    onRecipientsSelected(recipients.cast<int>(), context);
                  },
                ),
                notificationTable(context, messageDetails.notifications)
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
      messageDetailCubit.saveMessage(messageDetails);
      Navigator.of(context).pop();
    }
  }

  void onRecipientsSelected(List<int> ids, context) {
    messageDetails.recipientIds = ids;
  }

  notificationTable(BuildContext context, List<modelNotification.Notification> notifications) {

      return Column(children: [
        ElevatedButton.icon(
          onPressed: ()async{
            int? minutes = await TimeDecompositionPopup.showTimeDecompositionDialog(context, 0);
            if(minutes !=null)
              setState(() {
                modelNotification.Notification newNotification = modelNotification.Notification();
                newNotification.minutesBefore = minutes;
                newNotification.date = null;
                messageDetails.notifications.add(newNotification);
              });
          },
          label: Text("Nova notificação"),
          icon: Icon(Icons.add),
        ),
        DataTable(
          columns: const <DataColumn>[
            DataColumn(label: Text('Antecedência (minutos)')),
            DataColumn(label: Text('Horário Previsto')),
          ],
          rows: List<DataRow>.generate(
            notifications.length, // Replace with your data length
                (int index) => DataRow(
              cells: <DataCell>[
                DataCell(Text(notifications[index].minutesBefore.toString())), // Replace with actual data
                DataCell(Text(notifications[index].date!=null?notifications[index].date!.toIso8601String():"")), // Replace with actual data
              ],
              onSelectChanged: (bool? selected) async {
                if (selected != null && selected) {
                  int? minutes = await TimeDecompositionPopup.showTimeDecompositionDialog(context, notifications[index].minutesBefore);
                  if(minutes !=null)
                    setState(() {
                      notifications[index].minutesBefore = minutes;
                      notifications[index].date = null;
                    });
                }
              },
            ),
          ),
        )
      ],);

  }


}