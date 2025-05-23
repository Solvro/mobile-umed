import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:latlong2/latlong.dart";

import "../../models/landmark.dart";
import "../../models/route.dart";

final mockData = [
  Route(
    id: 1,
    name: "Mountain Trail",
    description: "A scenic mountain trail with beautiful views.",
    calories: 500,
    distance: 10.5,
    requiredWater: 400,
    estimatedTime: 130,
    landmarks:
        [
          const Landmark(
            id: 1,
            name: "Summit",
            description: "The peak of the trail",
            type: LandmarkType.checkpoint,
            location: LatLng(51.1079, 17.0385),
          ),
          const Landmark(
            id: 6,
            name: "Old Town",
            description: "Historic center of Wrocław",
            type: LandmarkType.checkpoint,
            location: LatLng(51.1094, 17.0325),
          ),
          const Landmark(
            id: 7,
            name: "Centennial Hall",
            description: "A historic building in Wrocław",
            type: LandmarkType.checkpoint,
            location: LatLng(51.1066, 17.0777),
          ),
          const Landmark(
            id: 8,
            name: "Wrocław Zoo",
            description: "A popular zoo in Wrocław",
            type: LandmarkType.checkpoint,
            location: LatLng(51.1045, 17.0748),
          ),
          const Landmark(
            id: 9,
            name: "Japanese Garden",
            description: "A serene garden in Wrocław",
            type: LandmarkType.checkpoint,
            location: LatLng(51.1054, 17.0782),
          ),
        ].lock,
  ),
  Route(
    id: 2,
    name: "Forest Path",
    description: "A peaceful walk through dense forest.",
    calories: 600,
    distance: 5.2,
    requiredWater: 500,
    estimatedTime: 200,
    landmarks:
        [
          const Landmark(
            id: 2,
            name: "Creek",
            description: "A small creek",
            type: LandmarkType.checkpoint,
            location: LatLng(51.1079, 17.0385),
          ),
          const Landmark(
            id: 10,
            name: "Market Square",
            description: "The main square in Wrocław",
            type: LandmarkType.checkpoint,
            location: LatLng(51.1102, 17.0316),
          ),
          const Landmark(
            id: 11,
            name: "Ostrów Tumski",
            description: "The oldest part of Wrocław",
            type: LandmarkType.pulsometer,
            location: LatLng(51.1142, 17.0465),
          ),
          const Landmark(
            id: 12,
            name: "Hydropolis",
            description: "A water knowledge center",
            type: LandmarkType.checkpoint,
            location: LatLng(51.1027, 17.0465),
          ),
          const Landmark(
            id: 13,
            name: "Botanical Garden",
            description: "A beautiful garden in Wrocław",
            type: LandmarkType.checkpoint,
            location: LatLng(51.1140, 17.0460),
          ),
        ].lock,
  ),
  Route(
    id: 3,
    name: "Coastal Walk",
    description: "A refreshing walk along the coastline.",
    calories: 140,
    distance: 8,
    requiredWater: 150,
    estimatedTime: 120,
    landmarks:
        [
          const Landmark(
            id: 4,
            name: "Lighthouse",
            description: "A tall lighthouse",
            type: LandmarkType.checkpoint,
            location: LatLng(51.1079, 17.0385),
          ),
          const Landmark(
            id: 14,
            name: "National Museum",
            description: "A museum in Wrocław",
            type: LandmarkType.checkpoint,
            location: LatLng(51.1091, 17.0439),
          ),
          const Landmark(
            id: 15,
            name: "Wrocław Fountain",
            description: "A multimedia fountain",
            type: LandmarkType.pulsometer,
            location: LatLng(51.1063, 17.0767),
          ),
          const Landmark(
            id: 16,
            name: "Sky Tower",
            description: "A skyscraper in Wrocław",
            type: LandmarkType.checkpoint,
            location: LatLng(51.0965, 17.0240),
          ),
          const Landmark(
            id: 17,
            name: "Grunwald Bridge",
            description: "A historic bridge in Wrocław",
            type: LandmarkType.checkpoint,
            location: LatLng(51.1097, 17.0489),
          ),
        ].lock,
  ),
];
