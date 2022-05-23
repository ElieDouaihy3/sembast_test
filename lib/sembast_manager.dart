import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast_test/encryption_sembast.dart';

SemBastManager semBastInstance = SemBastManager();

class SemBastManager {
  late Database semBastDB ;


  Future<void> openDB() async {
    String dbPath = 'INTELLECT.db';
    final appDocDir = await getApplicationDocumentsDirectory();
    await databaseFactoryIo.openDatabase(
        join(appDocDir.path, dbPath),
        version: 1,
        codec:SembastCodec(
            codec:MyJsonCodec(),
            signature: 'AES'
        )
    ).then((value){
      semBastDB = value;
    });
  }

  Future<int> saveDB(String key,Map<String, Object?> valueMap) async {
    var store = intMapStoreFactory.store(key);
    return await store.add(semBastDB,valueMap);
  }

  Future<List<RecordSnapshot<int, Map<String, Object?>>>> getAllDataDB(String key) async {
    var store = intMapStoreFactory.store(key);
    return store.find(semBastDB);
  }

  Future<int> delAllDB(String key) async {
    var store = intMapStoreFactory.store(key);
    return store.delete(semBastDB);
  }

  Future<int?> delSingleDB(String key,int keyIndex) async {
    var store = intMapStoreFactory.store(key);
    return store.record(keyIndex).delete(semBastDB);
  }

}

