abstract class Repository {
  signUpUser(String userName,String email,String password);
  loginUser(String email,String password);
  getUserList(String uid);
  getChatList(String senderId,String receiverId);
  sendMessage(String message,String senderId, String recieverId);
  getUser(String id);
  logout(String id);

}