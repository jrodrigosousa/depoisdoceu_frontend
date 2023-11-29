import 'package:depois_do_ceu/business/bloc/message_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business/bloc/message_detail_cubit.dart';
import '../../data/model/message.dart';
import '../widget/message_list_item.dart';

class MessagesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de mensagens"),
        actions: [
          PopupMenuButton(
              itemBuilder: (_) {
                return [
                  PopupMenuItem(
                    child: Text("Cadastro de destinatários"),
                    onTap: () {
                      Navigator.of(context).pushNamed("/recipient_list");
                    },
                  ),
                ];
              },
              icon: const Icon(Icons.more_vert))
        ],
      ),
      body: Column(
        children: [
          ElevatedButton.icon(
            onPressed: ()=>newMessageAction(context),
            label: Text("Nova mensagem"),
            icon: Icon(Icons.add),
          ),
          messagesList(),
        ],
      ),
    );
  }

  Widget messagesList() {
    return Expanded(
      child: BlocBuilder<MessageListCubit, MessageListState>(
        builder: (context, state) {
          if (state is MessagesLoading) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  height: 50, width: 50, child: CircularProgressIndicator()),
            );
          } else {
            state = state as MessagesLoaded;
            List<MessageListItem> messages = state.messages.map((e) => MessageListItem(message: e)).toList();
            return ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return messages[index];
              },
            );

          }
        },
      ),
    );
  }

  newMessageAction(BuildContext context) {
    BlocProvider.of<MessageDetailCubit>(context).setMessage(Message.empty());
    Navigator.of(context).pushNamed("/message_detail");
  }

}
