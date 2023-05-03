

abstract class CacheService {
  const CacheService();
  Future<void> addBoxes<T>(List<T> items, String boxName);
  Future<List<T>> getBoxes<T>(String boxName);
}
