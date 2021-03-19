import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app/services/auth.dart';



class MockUser extends Mock implements User {}

final MockUser _mockUser = MockUser();
class MockFirebaseAuth extends Mock implements FirebaseAuth {

  @override
  Stream<User> authStateChanges() {
   return Stream.fromIterable([
     _mockUser
   ]);
  }
}
void main(){
  final MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
  final Auth auth = Auth(auth: mockFirebaseAuth);
  setUp(() {});
  tearDown(() {});
  test("emit occurs", () async {
    expectLater(auth.user, emitsInOrder([_mockUser]));
  });

  test("create account", () async {
    when(mockFirebaseAuth.createUserWithEmailAndPassword(email: "nitin@123", password: "123"),).thenAnswer((realInvocation) => null);

    expect(
        // await auth.createaccount(email: "nitin@123", password: "123"),
        await auth.createaccount(email: "tadas@gmail.com", password: "123456"),
        "Success");
  });

  test("create account exception", () async {
    when(
      mockFirebaseAuth.createUserWithEmailAndPassword(
          email: "tadas@gmail.com", password: "123456"),
    ).thenAnswer((realInvocation) =>
    throw FirebaseAuthException(message: "You screwed up"));

    expect(
        await auth.createaccount(email: "tadas@gmail.com", password: "123456"),
        "You screwed up");
  });
}
