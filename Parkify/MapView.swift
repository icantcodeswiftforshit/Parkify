import SwiftUI
import MapKit

struct MapView: View {
    @ObservedObject var parkingSpotViewModel: ParkingSpotViewModel
    @State private var region: MKCoordinateRegion
    
    init(parkingSpotViewModel: ParkingSpotViewModel) {
        self.parkingSpotViewModel = parkingSpotViewModel
        if let coordinate = parkingSpotViewModel.locationManager.location?.coordinate {
            _region = State(initialValue: MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)))
        } else {
            _region = State(initialValue: MKCoordinateRegion())
        }
    }

    var body: some View {
        Map(coordinateRegion: $region, annotationItems: parkingSpotViewModel.parkingSpots) { parkingSpot in
            MapMarker(coordinate: parkingSpot.coordinate, tint: .blue)
        }
        .onAppear {
            parkingSpotViewModel.fetchNearbyParkingSpots()
        }
    }
}
