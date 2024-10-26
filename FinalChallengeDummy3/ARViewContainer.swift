//
//  ARViewContainer.swift
//  FinalChallengeDummy3
//
//  Created by Farid Andika on 22/10/24.
//

import SwiftUI
import RealityKit
import ARKit

struct ARViewContainer: UIViewRepresentable {
    @Binding var arView: ARView

    func makeUIView(context: Context) -> ARView {
        // Memeriksa izin kamera saat memulai sesi
        checkCameraPermission()
        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {
    }

    // Fungsi untuk memeriksa izin kamera
    private func checkCameraPermission() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            startARSession() // Langsung mulai sesi jika izin diberikan
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    DispatchQueue.main.async {
                        self.startARSession()
                    }
                } else {
                    print("Camera access denied.")
                }
            }
        default:
            print("Camera access restricted or denied.")
        }
    }

    // Fungsi untuk memulai atau mereset sesi AR
    private func startARSession() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal] // Menambahkan deteksi permukaan horizontal
        arView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors]) // Reset tracking dan hapus anchor lama
    }
}

