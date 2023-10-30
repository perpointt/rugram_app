abstract class DatabaseClient<T> {
  T get instance;

  Future<T> open(String path);
}
