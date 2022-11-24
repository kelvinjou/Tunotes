//
//  File.swift
//  CorrectSwiftPMFormat
//
//  Created by Kelvin J on 11/23/22.
//

import Foundation
import SwiftUI

struct V2CALayer: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.height / 2))
        let scrollView: UIScrollView = {
            let scrollView = UIScrollView()
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            return scrollView
        }()

        let scrollViewContainer: UIStackView = {
            let view = UIStackView()

            view.axis = .vertical
            view.spacing = 10

            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()

        let redView: UIView = {
            let view = UIView()
            view.heightAnchor.constraint(equalToConstant: 500).isActive = true
            view.backgroundColor = .red
            return view
        }()

        let blueView: UIView = {
            let view = UIView()
            view.heightAnchor.constraint(equalToConstant: 200).isActive = true
            view.backgroundColor = .blue
            return view
        }()

        let greenView: UIView = {
            let view = UIView()
            view.heightAnchor.constraint(equalToConstant: 1200).isActive = true
            view.backgroundColor = .green
            return view
        }()
        
        view.addSubview(scrollView)
                scrollView.addSubview(scrollViewContainer)
                scrollViewContainer.addArrangedSubview(redView)
                scrollViewContainer.addArrangedSubview(blueView)
                scrollViewContainer.addArrangedSubview(greenView)

                scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
                scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
                scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
                scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

                scrollViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
                scrollViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
                scrollViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
                scrollViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
                // this is important for scrolling
                scrollViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
            

        return view
           
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
