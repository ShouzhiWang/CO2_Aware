//
//  SFSafariViewWrapper.swift
//  CO2 Aware
//
//  Created by 王首之 on 11/21/22.
//
//  Source: https://designcode.io/swiftui-handbook-safari-inside-app

import SwiftUI
import SafariServices

struct SFSafariViewWrapper: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<Self>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SFSafariViewWrapper>) {
        return
    }
}
