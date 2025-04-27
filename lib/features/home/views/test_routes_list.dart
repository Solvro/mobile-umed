// 1. Model trasy
class RouteItem {
  final String id;
  final String name;
  final String imageUrl;
  final String details;

  RouteItem({required this.id, required this.name, required this.imageUrl, required this.details});
}

// 2. Dane testowe
final List<RouteItem> testRoutes = [
  RouteItem(
    id: "1",
    name: "Spacer po Starym Mieście",
    imageUrl: "https://picsum.photos/seed/oldtown/300/200",
    details: "pierwsza trasa",
  ),
  RouteItem(
    id: "2",
    name: "Zielona Dolina",
    imageUrl: "https://picsum.photos/seed/valley/300/200",
    details: "druga trasa",
  ),
  RouteItem(
    id: "3",
    name: "Wzgórza Panorama",
    imageUrl: "https://picsum.photos/seed/hills/300/200",
    details: "trzecia trasa",
  ),
  RouteItem(
    id: "4",
    name: "Nadbrzeżny Szlak",
    imageUrl: "https://picsum.photos/seed/coast/300/200",
    details: "czwarta trasa",
  ),
  RouteItem(
    id: "5",
    name: "Leśna Ścieżka",
    imageUrl: "https://picsum.photos/seed/forest/300/200",
    details: "piąta trasa",
  ),
];
