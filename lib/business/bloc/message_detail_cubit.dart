import 'package:bloc/bloc.dart';
import 'package:depois_do_ceu/data/repository/message_repository.dart';
import 'package:meta/meta.dart';

import '../../constants/enum.dart';
import '../../data/model/message.dart';
import '../../data/provider/message_provider.dart';

part 'message_detail_state.dart';

class MessageDetailCubit extends Cubit<MessageDetailState> {
  MessageDetailCubit() : super(MessageDetailState(message: Message.empty(), operation: MessageOperation.NEW));
  MessageRepository repository = MessageRepository(provider: MessageProvider());

  void setMessage(Message message){
    emit(MessageDetailState(message: message, operation: MessageOperation.EDIT));
  }

  void saveMessage(Message message) async {
    message = await repository.save(message);
    emit(MessageDetailState(message: message, operation: MessageOperation.UPDATE));
  }
}
