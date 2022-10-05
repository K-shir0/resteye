//
//  ContentView.swift
//  resteye
//
//  Created by K-shiro on 2022/09/28.
//

import SwiftUI
import UIKit
import UIPiPView

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Resteye")
            SampleViewControllerWrapper().frame(maxHeight: 80)
            Button("使い方(?)") {
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

/// ViewController を SwiftUI に書くコード
struct SampleViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ViewController {
        return ViewController()
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context)
    {}
}

class ViewController: UIViewController {
    
    private let pipView = UIPiPView()
    private let startButton = UIButton()
    private let timeLabel = UILabel()
    
    private var timer: Timer!
    private let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        view.backgroundColor = .black
        let width = CGFloat(240)
        
        let margin = ((self.view.bounds.width - width) / 2)
        pipView.frame = .init(x: margin, y: 0, width: width, height: 100)
        pipView.backgroundColor = .red
        self.view.addSubview(pipView)
        
        /// Start Button
        startButton.frame = .init(x: margin, y: 40, width: width, height: 40)
        startButton.addTarget(self, action: #selector(ViewController.toggle), for: .touchUpInside)
        startButton.setTitle("Resteyeをはじめる", for: .normal)
        startButton.setTitleColor(.systemBlue, for: .normal)
        //        startButton.backgroundColor = .white
        //        startButton.layer.cornerRadius = 10
        self.view.addSubview(startButton)
        
        /// Time Label on PiPView
        timeLabel.frame = .init(x: 10, y: 0, width: width - 20, height: 40)
        timeLabel.textColor = .white
        pipView.addSubview(timeLabel)
        
        if #available(iOS 13.0, *) {
            timeLabel.font = .monospacedSystemFont(ofSize: 30, weight: .medium)
            timeLabel.adjustsFontSizeToFitWidth = true
        }
        
        let calendar = Calendar.current
        
        /// Time Label  shows now.
        //        formatter.dateFormat = "y-MM-dd H:mm:ss.SSSS"
        timer = Timer(timeInterval: (0.1 / 60.0), repeats: true) { [weak self] _ in
            guard let self = self else { return }
            //                        self.timeLabel.text = self.formatter.string(from: Date())
            
            let second = calendar.component(.second, from: Date())
            
            /// 6秒に一回
            if (second % 3 == 0) {
                self.timeLabel.text = "まばたき"
            } else {
                self.timeLabel.text = ""
            }
        }
        RunLoop.main.add(timer, forMode: .default)
    }
    
    @objc func toggle() {
        if (!pipView.isPictureInPictureActive()) {
            pipView.startPictureInPicture(withRefreshInterval: (0.1 / 60.0))
            
            startButton.setTitle("Resteyeを停止", for: .normal)
        } else {
            pipView.stopPictureInPicture()
            
            startButton.setTitle("Resteyeをはじめる", for: .normal)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
