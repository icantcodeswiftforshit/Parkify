import SwiftUI

struct ListView: View {
    @ObservedObject var parkingSpotViewModel: ParkingSpotViewModel

    var body: some View {
        List(parkingSpotViewModel.parkingSpots) { parkingSpot in
            NavigationLink(destination: DetailsView(parkingSpot: parkingSpot)) {
                Text(parkingSpot.name)
            }
        }
        .onAppear {
            parkingSpotViewModel.fetchNearbyParkingSpots()
        }
    }
}
