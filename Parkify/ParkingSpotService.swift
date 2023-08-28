import Foundation

class ParkingSpotService {
    
    let apiKey = "KmOwGeOLyyGrp9gsalJzvLFQL3NpiH9W"
    
    func fetchNearbyParkingSpots(latitude: Double, longitude: Double, completion: @escaping (TomTomResponse?) -> Void) {
        let urlString = "https://api.tomtom.com/search/2/nearbySearch/.json?key=KmOwGeOLyyGrp9gsalJzvLFQL3NpiH9W&lat=\(latitude)&lon=\(longitude)&category=parking"
        print("fetchNearbyParkingSpots function called")
        print("URL: \(urlString)") // Printing the URL
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error)") // Printing any error
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("Data not found")
                completion(nil)
                return
            }
            
            do {
                let tomTomResponse = try JSONDecoder().decode(TomTomResponse.self, from: data)
                print("Response: \(tomTomResponse)") // Printing the decoded response
                completion(tomTomResponse)
            } catch {
                print("JSON Decoding Error: \(error)") // Printing decoding error
                completion(nil)
            }
        }
        
        task.resume()
    }
}
