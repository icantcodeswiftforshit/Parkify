import SwiftUI

struct LandingScreen: View {
    @StateObject var locationManager: LocationManager
    @StateObject var parkingSpotViewModel: ParkingSpotViewModel
    
    init() {
        let locManager = LocationManager()
        self._locationManager = StateObject(wrappedValue: locManager)
        self._parkingSpotViewModel = StateObject(wrappedValue: ParkingSpotViewModel(locationManager: locManager))
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Parkify")
                    .font(.largeTitle)
                    .padding(.top)
                Text("Find the perfect parking spot.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                NavigationLink("View Map", destination: MapView(parkingSpotViewModel: parkingSpotViewModel)) // Pass ParkingSpotViewModel to MapView
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                NavigationLink("View Parking List", destination: ListView(parkingSpotViewModel: parkingSpotViewModel)) // Pass ParkingSpotViewModel to ListView
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
            .navigationTitle("Welcome to Parkify")
            .background(
                // You can replace this with an actual background image or color
                Color.white
            )
        }
    }
}
