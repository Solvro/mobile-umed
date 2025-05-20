import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "../../models/song.dart";

final mockSongs =
    [
      const Song(name: "Jolka Jolka", author: "Budka suflera", duration: Duration(seconds: 200)),
      const Song(name: "Kwiaty we włosach", author: "Czerwone Gitary", duration: Duration(seconds: 332)),
      const Song(name: "Przeżyj to sam", author: "Lombard", duration: Duration(seconds: 260)),
      const Song(name: "Autobiografia", author: "Perfect", duration: Duration(seconds: 315)),
      const Song(name: "Nie płacz Ewka", author: "Perfect", duration: Duration(seconds: 245)),
      const Song(name: "Zawsze tam, gdzie Ty", author: "Lady Pank", duration: Duration(seconds: 228)),
      const Song(name: "Chcemy być sobą", author: "Perfect", duration: Duration(seconds: 240)),
      const Song(name: "Dni, których jeszcze nie znamy", author: "Marek Grechuta", duration: Duration(seconds: 278)),
      const Song(name: "Kocham Cię, kochanie moje", author: "Maanam", duration: Duration(seconds: 195)),
      const Song(name: "Za zdrowie pań!", author: "Edward Stachura", duration: Duration(seconds: 180)),
    ].lock;
