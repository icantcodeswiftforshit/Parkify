import CoreLocation

struct TomTomResponse: Decodable {
    let results: [TomTomResult]
}

struct TomTomResult: Decodable {
    let position: TomTomPosition
    let poi: TomTomPoi
}

struct TomTomPosition: Decodable {
    let lat: Double
    let lon: Double
}

struct TomTomPoi: Decodable {
    let name: String
}

struct ParkingSpot: Identifiable {
    let id = UUID() // Unique identifier
    let name: String
    let coordinate: CLLocationCoordinate2D

    init(from result: TomTomResult) {
        self.name = result.poi.name
        self.coordinate = CLLocationCoordinate2D(latitude: result.position.lat, longitude: result.position.lon)
    }
}
