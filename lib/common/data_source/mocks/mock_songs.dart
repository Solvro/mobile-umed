import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "../../models/song.dart";

final mockSongs =
    [
      const Song(id: 1, title: "Jolka Jolka", author: "Budka suflera", duration: Duration(seconds: 200)),
      const Song(id: 2, title: "Kwiaty we włosach", author: "Czerwone Gitary", duration: Duration(seconds: 332)),
      const Song(id: 3, title: "Przeżyj to sam", author: "Lombard", duration: Duration(seconds: 260)),
      const Song(id: 4, title: "Autobiografia", author: "Perfect", duration: Duration(seconds: 315)),
      const Song(id: 5, title: "Nie płacz Ewka", author: "Perfect", duration: Duration(seconds: 245)),
      const Song(id: 6, title: "Zawsze tam, gdzie Ty", author: "Lady Pank", duration: Duration(seconds: 228)),
      const Song(id: 7, title: "Chcemy być sobą", author: "Perfect", duration: Duration(seconds: 240)),
      const Song(
        id: 8,
        title: "Dni, których jeszcze nie znamy",
        author: "Marek Grechuta",
        duration: Duration(seconds: 278),
      ),
      const Song(id: 9, title: "Kocham Cię, kochanie moje", author: "Maanam", duration: Duration(seconds: 195)),
      const Song(id: 10, title: "Za zdrowie pań!", author: "Edward Stachura", duration: Duration(seconds: 180)),
    ].lock;
