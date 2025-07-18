import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:latlong2/latlong.dart";

import "../../models/checkpoint.dart";
import "../../models/playlist.dart";
import "../../models/route.dart";
import "../../models/song.dart";

final mockPlaylist = Playlist(
  id: 1,
  name: "Nature Sounds",
  songs:
      [const Song(id: 1, title: "Birds Chirping", author: "Nature Sounds", duration: Duration(minutes: 3, seconds: 45))]
          .lock,
  spotifyUrl: "",
  youtubeUrl: "",
  appleUrl: "",
);

final mockData = [
  Route(
    id: 1,
    name: "Mountain Trail",
    description: "A scenic mountain trail with beautiful views.",
    calories: 500,
    distance: 10.5,
    waterDemand: 400,
    estimatedTime: 130,
    checkpoints:
        [
          Checkpoint(
            id: 1,
            name: "Summit",
            description: "The peak of the trail",
            type: LandmarkType.checkpoint,
            location: const LatLng(51.1079, 17.0385),
            dateOfCreation: DateTime.utc(2025, 6, 17, 12),
            designer: "Designer 1",
          ),
          Checkpoint(
            id: 6,
            name: "Old Town",
            description: "Historic center of Wrocław",
            type: LandmarkType.checkpoint,
            location: const LatLng(51.1094, 17.0325),
            dateOfCreation: DateTime.utc(2025, 6, 17, 12),
            designer: null,
          ),
          Checkpoint(
            id: 7,
            name: "Centennial Hall",
            description: "A historic building in Wrocław",
            type: LandmarkType.checkpoint,
            location: const LatLng(51.1066, 17.0777),
            dateOfCreation: DateTime.utc(2025, 6, 17, 12),
            designer: "Designer 2",
          ),
          Checkpoint(
            id: 8,
            name: "Wrocław Zoo",
            description: "A popular zoo in Wrocław",
            type: LandmarkType.checkpoint,
            location: const LatLng(51.1045, 17.0748),
            dateOfCreation: DateTime.utc(2025, 6, 17, 12),
            designer: null,
          ),
          Checkpoint(
            id: 9,
            name: "Japanese Garden",
            description: "A serene garden in Wrocław",
            type: LandmarkType.checkpoint,
            location: const LatLng(51.1054, 17.0782),
            dateOfCreation: DateTime.utc(2025, 6, 17, 12),
            designer: null,
          ),
        ].lock,
    playlist: mockPlaylist,
    route:
        [
          const LatLng(51.1079, 17.0385),
          const LatLng(51.1094, 17.0325),
          const LatLng(51.1066, 17.0777),
          const LatLng(51.1045, 17.0748),
          const LatLng(51.1054, 17.0782),
        ].lock,
  ),
  Route(
    id: 2,
    name: "Forest Path",
    description: "A peaceful walk through dense forest.",
    calories: 300,
    distance: 5.2,
    waterDemand: 500,
    estimatedTime: 200,
    checkpoints:
        [
          Checkpoint(
            id: 2,
            name: "Creek",
            description: "A small creek",
            type: LandmarkType.checkpoint,
            location: const LatLng(51.1079, 17.0385),
            dateOfCreation: DateTime.utc(2025, 6, 17, 12),
            designer: null,
          ),
          Checkpoint(
            id: 10,
            name: "Market Square",
            description: "The main square in Wrocław",
            type: LandmarkType.checkpoint,
            location: const LatLng(51.1102, 17.0316),
            dateOfCreation: DateTime.utc(2025, 6, 17, 12),
            designer: null,
          ),
          Checkpoint(
            id: 11,
            name: "Ostrów Tumski",
            description: "The oldest part of Wrocław",
            type: LandmarkType.pulsometer,
            location: const LatLng(51.1142, 17.0465),
            dateOfCreation: DateTime.utc(2025, 6, 17, 12),
            designer: null,
          ),
          Checkpoint(
            id: 12,
            name: "Hydropolis",
            description: "A water knowledge center",
            type: LandmarkType.checkpoint,
            location: const LatLng(51.1027, 17.0465),
            dateOfCreation: DateTime.utc(2025, 6, 17, 12),
            designer: null,
          ),
          Checkpoint(
            id: 13,
            name: "Botanical Garden",
            description: "A beautiful garden in Wrocław",
            type: LandmarkType.checkpoint,
            location: const LatLng(51.1140, 17.0460),
            dateOfCreation: DateTime.utc(2025, 6, 17, 12),
            designer: null,
          ),
        ].lock,
    playlist: mockPlaylist,
    route:
        [
          const LatLng(51.1079, 17.0385),
          const LatLng(51.1102, 17.0316),
          const LatLng(51.1142, 17.0465),
          const LatLng(51.1027, 17.0465),
          const LatLng(51.1140, 17.0460),
        ].lock,
  ),
  Route(
    id: 3,
    name: "Coastal Walk",
    description: "A refreshing walk along the coastline.",
    calories: 140,
    distance: 8,
    waterDemand: 150.5,
    estimatedTime: 120,
    checkpoints:
        [
          Checkpoint(
            id: 4,
            name: "Lighthouse",
            description: "A tall lighthouse",
            type: LandmarkType.checkpoint,
            location: const LatLng(51.1079, 17.0385),
            dateOfCreation: DateTime.utc(2025, 6, 17, 12),
            designer: null,
          ),
          Checkpoint(
            id: 14,
            name: "National Museum",
            description: "A museum in Wrocław",
            type: LandmarkType.checkpoint,
            location: const LatLng(51.1091, 17.0439),
            dateOfCreation: DateTime.utc(2025, 6, 17, 12),
            designer: null,
          ),
          Checkpoint(
            id: 15,
            name: "Wrocław Fountain",
            description: "A multimedia fountain",
            type: LandmarkType.pulsometer,
            location: const LatLng(51.1063, 17.0767),
            dateOfCreation: DateTime.utc(2025, 6, 17, 12),
            designer: null,
          ),
          Checkpoint(
            id: 16,
            name: "Sky Tower",
            description: "A skyscraper in Wrocław",
            type: LandmarkType.checkpoint,
            location: const LatLng(51.0965, 17.0240),
            dateOfCreation: DateTime.utc(2025, 6, 17, 12),
            designer: null,
          ),
          Checkpoint(
            id: 17,
            name: "Grunwald Bridge",
            description: "A historic bridge in Wrocław",
            type: LandmarkType.checkpoint,
            location: const LatLng(51.1097, 17.0489),
            dateOfCreation: DateTime.utc(2025, 6, 17, 12),
            designer: null,
          ),
        ].lock,
    playlist: mockPlaylist,
    route:
        [
          const LatLng(51.1079, 17.0385),
          const LatLng(51.1091, 17.0439),
          const LatLng(51.1063, 17.0767),
          const LatLng(51.0965, 17.0240),
          const LatLng(51.1097, 17.0489),
        ].lock,
  ),
];
