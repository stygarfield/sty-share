import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth


struct WalkView: View {

    @EnvironmentObject var firestoreManager: FirestoreManager
    
    @State var tappedFlight: Flight = Flight(id: "", flightNumber: "", depDate: "", conList: [], numCons: 0)
    
    let db = Firestore.firestore()
    let dateFormatter = DateFormatter()
    
    var body: some View {
        NavigationStack {
            ZStack {
                List(flightModel.flights) { flight in 
                  // This is looping through Collection A, and works as intended
                }.sheet(isPresented: self.$showPopup) {
                    ListedSheet(flight: $tappedFlight) // When user taps on a cell, new sheet appears
                }
              }
            }
        }
    }
}

struct ListedSheet: View {
    @Binding var flight: Flight
    
    let firestoreManager = FirestoreManager()

    var body: some View {
        VStack {
            Text("Listed Travellers").font(.title)
            
            List(flight.conList, id: \.self) { con in
                // This is where I'm having issues - I've been googling for a few days now, and have
                // not had any luck with a solution. If I uncomment the line below, I get an error
                // type() cannot conform to View, but I can not think of any way to pass the con variable
                // to the getCon function in firestoreManager(), so that it can retrive the requested data.
                //firestoreManager.docID = con
                HStack {
                    //Text(firestoreManager.userName)
                    //Text(firestoreManager.userEmail)
                    Text(con)
                    
                }
            }
        }
    }
}


