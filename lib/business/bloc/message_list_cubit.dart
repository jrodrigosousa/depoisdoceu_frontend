import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:depois_do_ceu/business/bloc/message_detail_cubit.dart';
import 'package:depois_do_ceu/data/provider/message_provider.dart';
import 'package:meta/meta.dart';

import '../../data/model/message.dart';
import '../../data/repository/message_repository.dart';

part 'message_list_state.dart';

class MessageListCubit extends Cubit<MessageListState> {
  late MessageDetailCubit detailCubit;
  StreamSubscription? _messageDetailSubscription;

  MessageListCubit(MessageDetailCubit detailCubit) : super(MessagesLoading()){
    this.detailCubit = detailCubit;
    monitorMessageDetail(detailCubit);
  }

  void monitorMessageDetail(MessageDetailCubit messageDetailCubit) {
    _messageDetailSubscription = messageDetailCubit.stream.listen((state) {
      refresh();
    });
  }

  Future<void> refresh() async{
    emit(MessagesLoading());

    MessageProvider messageProvider = MessageProvider();
    MessageRepository messageRepository = MessageRepository(provider: messageProvider);
    List<Message> messages = await messageRepository.getAll();

    emit(MessagesLoaded(messages));
  }
}
