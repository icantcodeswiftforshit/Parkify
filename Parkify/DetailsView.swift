import SwiftUI
import MapKit

struct DetailsView: View {
    let parkingSpot: ParkingSpot
    @State private var region: MKCoordinateRegion

    init(parkingSpot: ParkingSpot) {
        self.parkingSpot = parkingSpot
        self._region = State(initialValue: MKCoordinateRegion(center: parkingSpot.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)))
    }

    var body: some View {
        VStack {
            Text(parkingSpot.name)
                .font(.headline)
            Map(coordinateRegion: $region)
        }
    }
}
