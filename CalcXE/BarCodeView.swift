//
//  BarCodeView.swift
//  CalcXE
//
//  Created by Genuine on 08.02.2024.
//



import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    let url: URL
    
    class Coordinator: NSObject, WKNavigationDelegate, WKScriptMessageHandler {
        var webView: WKWebView?
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            self.webView = webView
        }
        
        // receive message from wkwebview
        func userContentController(
            _ userContentController: WKUserContentController,
            didReceive message: WKScriptMessage
        ) {
            print(message.body)
            let date = Date()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.messageToWebview(msg: "hello, I got your messsage: \(message.body) at \(date)")
            }
        }
        
        func messageToWebview(msg: String) {
            self.webView?.evaluateJavaScript("webkit.messageHandlers.bridge.onMessage('\(msg)')")
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let coordinator = makeCoordinator()
        let userContentController = WKUserContentController()
        userContentController.add(coordinator, name: "bridge")
        
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = userContentController
        
        let _wkwebview = WKWebView(frame: .zero, configuration: configuration)
        _wkwebview.navigationDelegate = coordinator
        
        return _wkwebview
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {

        let request = URLRequest(url: url)
        webView.load(request)
    }
}

struct BarCodeView: View {
    // 1
    @State private var isPresentWebView = false

    
    var body: some View {
        Button("Open WebView") {
            // 2
            isPresentWebView = true

        }
        .sheet(isPresented: $isPresentWebView) {
            if #available(iOS 16.0, *) {
                NavigationStack {
                    // 3
                    WebView(url: URL(string: "https://gepir.gs1ua.org/search/gtin")!)
                    
                        .ignoresSafeArea()
                        .navigationTitle("GS1")
                        .navigationBarTitleDisplayMode(.inline)
                        
                }
            } else {
                // Fallback on earlier versions
            }
        }
    }
}



#Preview {
    BarCodeView()
}


