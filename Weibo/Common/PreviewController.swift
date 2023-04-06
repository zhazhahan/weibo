import SwiftUI


struct ContentViewLL: View {
    @State private var show = false
    var body: some View {
        VStack{
            if !show {
                RootView(show: $show)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.blue)
                    .transition(AnyTransition.move(edge: .leading)).animation(.default)
            }
            if show {
                NextView(show: $show)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.green)
                    .transition(AnyTransition.move(edge: .trailing)).animation(.default)
            }
        }
    }
}

struct RootView: View {
    @Binding var show: Bool
    var body: some View {
        VStack{
            Button("Next") {
                self.show = true
            }
            Text("This is the first view")
        }
    }
}

struct NextView: View {
    @Binding var show: Bool
    var body: some View {
        VStack{
            Button("Back") {
                self.show = false
            }
            Text("This is the second view")
        }
    }
}
