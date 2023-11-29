import '../model/message.dart';
import '../provider/message_provider.dart';

class MessageRepository {

  MessageProvider provider;

  MessageRepository({required this.provider});

  Future<List<Message>> getAll() async {    
    List<dynamic> jsonList = await provider.fetchMessages();
    List<Message> retorno = [];
    for(Map<String, dynamic> json in jsonList){
      Message message = Message.fromJson(json);
      retorno.add(message);
    }
    
    return retorno;
  }

  Future<Message> save(Message message) async {
    Map<String, dynamic> result;
    if(message.id == null){
      result = await provider.saveNewMessage(message);
    } else {
      result = await provider.updateMessage(message);
    }

    return Message.fromJson(result);
  }
}