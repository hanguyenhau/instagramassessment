// DTOs (Data Transfer Objects)
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserDTO {
  final String id;
  final String name;
  final String email;

  UserDTO({required this.id, required this.name, required this.email});
}

// Data Source
class FirebaseDataSource {
  Future<List<UserDTO>> getUsers() async {
    return [
      UserDTO(id: '1', name: 'John Doe', email: 'john@example.com'),
      UserDTO(id: '2', name: 'Jane Doe', email: 'jane@example.com'),
    ];
  }
}

// Abstract Repository
abstract class AbstractRepository<T> {

  AbstractRepository();

  Future<List<T>> getAll();
}



// Repository

class UserRepository extends AbstractRepository<UserDTO> {
  final FirebaseDataSource _authDataSource;

  UserRepository(this._authDataSource) : super();

  @override
  Future<List<UserDTO>> getAll() async {
    return _authDataSource.getUsers();
  }
}

// Models
class UserModel {
  final String id;
  final String name;
  final String email;

  UserModel({required this.id, required this.name, required this.email});
}

// Services
class UserService {
  final UserRepository _userRepository;

  UserService(this._userRepository);

  Future<List<UserModel>> getUsers() async {
    final List<UserDTO> userDTOs = await _userRepository.getAll();
    return userDTOs.map((dto) => UserModel(id: dto.id, name: dto.name, email: dto.email)).toList();
  }
}

// Controller
final userController = FutureProvider<List<UserModel>>((ref) async {
  final userService = ref.read(userServiceProvider);
  return userService.getUsers();
});

// Providers
final userRepositoryProvider = Provider((ref) => UserRepository(FirebaseDataSource()));

final userServiceProvider = Provider((ref) => UserService(ref.read(userRepositoryProvider)));

// States
class UserListScreen extends ConsumerWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(userController);

    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
      ),
      body: users.when(
        data: (userModels) {
          return ListView.builder(
            itemCount: userModels.length,
            itemBuilder: (context, index) {
              final user = userModels[index];
              return ListTile(
                title: Text(user.name),
                subtitle: Text(user.email),
              );
            },
          );
        },
        loading: () => const CircularProgressIndicator(),
        error: (error, stackTrace) => Text('Error: $error'),
      ),
    );
  }
}