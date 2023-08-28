import CoreLocation

import CoreLocation

import CoreLocation

class ParkingSpotViewModel: ObservableObject {
    @Published var parkingSpots: [ParkingSpot] = []
    var locationManager: LocationManager

    init(locationManager: LocationManager) {
        self.locationManager = locationManager
    }

    func fetchNearbyParkingSpots() {
        guard let latitude = locationManager.location?.coordinate.latitude,
              let longitude = locationManager.location?.coordinate.longitude else { return }

        let urlString = "https://api.tomtom.com/search/2/nearbySearch/.json?key=YOUR_API_KEY&lat=\(latitude)&lon=\(longitude)&category=parking"
        fetchData(urlString: urlString) { (result: TomTomResponse<ParkingSpotResult>) in
            self.parkingSpots = result.results.map { ParkingSpot(from: $0) }
        }
    }

    func fetchParkingAvailability(for parkingSpot: ParkingSpot) {
        let urlString = "https://api.tomtom.com/parking/availability/.json?key=YOUR_API_KEY&lat=\(parkingSpot.coordinate.latitude)&lon=\(parkingSpot.coordinate.longitude)"
        fetchData(urlString: urlString) { (result: ParkingAvailability) in
            self.parkingAvailability = result
        }
    }

    private func fetchData<T: Decodable>(urlString: String, completion: @escaping (T) -> Void) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }

            guard let data = data else {
                print("Data not found")
                return
            }

            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(result)
                }
            } catch {
                print("Error decoding data: \(error)")
            }
        }.resume()
    }
}
