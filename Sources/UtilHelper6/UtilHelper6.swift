
import SwiftUI

@available(iOS 14.0, *)
public struct UtilSix: View {
    @State var please_wait_six = true
    @State var tenMinuteCheck = false
    @State var tenMinuteShow = true
    public init(listData: [String: String], pushToSeven: @escaping () -> Void, pushToEight: @escaping (Bool) -> Void) {
        self.listData = listData
        self.pushToSeven = pushToSeven
        self.pushToEight = pushToEight
    }

    var pushToSeven: () -> Void
    var pushToEight: (Bool) -> Void
    var listData: [String: String] = [:]

    public var body: some View {
        ZStack{  Color.white.ignoresSafeArea()
                    if please_wait_six {
                        ProgressView("")
                    }else{
                        Color.clear.onAppear {
                            if tenMinuteCheck {
                                self.pushToEight(tenMinuteShow)
                            } else{
                                self.pushToSeven()
                            }
                        }
                        
                    }
                    ZStack{
                        SixCoor(url: URL(string: listData[RemoKey.rmlink14.rawValue] ?? ""), tenMinuteCheck: $tenMinuteCheck, listData: self.listData).opacity(0)//Hide Sceen
                    }.zIndex(1.0)
                }
                .foregroundColor(Color.black)
                .background(Color.white)
                .onAppear{ timeRnSix() }

    }
    
    func timeRnSix() {
        please_wait_six = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            please_wait_six = false
        }
    }
}
