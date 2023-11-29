import 'package:depois_do_ceu/business/bloc/recipient_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business/bloc/recipient_detail_cubit.dart';
import '../../data/model/recipient.dart';
import '../widget/recipient_list_item.dart';

class RecipientsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Destinatários"),
        actions: [
        ],
      ),
      body: Column(
        children: [
          ElevatedButton.icon(
            onPressed: ()=>newRecipientAction(context),
            label: Text("Novo Destinatário"),
            icon: Icon(Icons.add),
          ),
          recipientsList(),
        ],
      ),
    );
  }

  void newRecipientAction(BuildContext context) {
    BlocProvider.of<RecipientDetailCubit>(context).setRecipient(Recipient(email: "", name: "", whatsapp: ""));
    Navigator.of(context).pushNamed("/recipient_detail");
  }

  Widget recipientsList() {
    return Expanded(
      child: BlocBuilder<RecipientListCubit, RecipientListState>(
        builder: (context, state) {
          if (state is RecipientsLoading) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  height: 50, width: 50, child: CircularProgressIndicator()),
            );
          } else {
            state = state as RecipientsLoaded;
            List<RecipientListItem> recipients = state.recipients.map((e) => RecipientListItem(recipient: e)).toList();
            return ListView.builder(
              itemCount: recipients.length,
              itemBuilder: (context, index) {
                return recipients[index];
              },
            );

          }
        },
      ),
    );
  }

}
