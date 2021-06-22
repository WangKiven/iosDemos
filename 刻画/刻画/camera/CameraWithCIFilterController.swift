//
//  CameraWithCIFilterController.swift
//  刻画
//
//  Created by 王小林 on 2021/6/22.
//  Copyright © 2021 suin. All rights reserved.
//

import UIKit
import AVFoundation

class CameraWithCIFilterController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    
    @IBOutlet weak var rotateBtn: UIButton!
    @IBOutlet weak var flashBtn: UIButton!
    @IBOutlet weak var torchBtn: UIButton!
    
    
    @IBOutlet weak var thumbView: UIImageView!
    @IBOutlet weak var coverView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    
    var captureSession = AVCaptureSession()
    var backCamera: AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    var currentCamera: AVCaptureDevice?
    
    var photoOutput: AVCapturePhotoOutput?
    var orientation: AVCaptureVideoOrientation = .portrait
    
    let context = CIContext()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDevice()
        setupInputOutput()
    }
    
    func setupDevice() {
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        let devices = deviceDiscoverySession.devices
        
        for device in devices {
            if device.position == AVCaptureDevice.Position.back {
                backCamera = device
            }
            else if device.position == AVCaptureDevice.Position.front {
                frontCamera = device
            }
        }
        
        currentCamera = backCamera
    }
    
    func setupInputOutput() {
        do {
            setupCorrectFramerate(currentCamera: currentCamera!)
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera!)
            captureSession.sessionPreset = AVCaptureSession.Preset.hd1280x720
            if captureSession.canAddInput(captureDeviceInput) {
                captureSession.addInput(captureDeviceInput)
            }
            let videoOutput = AVCaptureVideoDataOutput()
            
            videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "sample buffer delegate", attributes: []))
            if captureSession.canAddOutput(videoOutput) {
                captureSession.addOutput(videoOutput)
            }
            captureSession.startRunning()
        } catch {
            print(error)
        }
    }
    
    func setupCorrectFramerate(currentCamera: AVCaptureDevice) {
        for vFormat in currentCamera.formats {
            //see available types
            //print("\(vFormat) \n")
            
            let ranges = vFormat.videoSupportedFrameRateRanges as [AVFrameRateRange]
            let frameRates = ranges[0]
            
            do {
                //set to 240fps - available types are: 30, 60, 120 and 240 and custom
                // lower framerates cause major stuttering
                if frameRates.maxFrameRate == 240 {
                    try currentCamera.lockForConfiguration()
                    currentCamera.activeFormat = vFormat as AVCaptureDevice.Format
                    //for custom framerate set min max activeVideoFrameDuration to whatever you like, e.g. 1 and 180
                    currentCamera.activeVideoMinFrameDuration = frameRates.minFrameDuration
                    currentCamera.activeVideoMaxFrameDuration = frameRates.maxFrameDuration
                }
            }
            catch {
                print("Could not set active format")
                print(error)
            }
        }
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        connection.videoOrientation = orientation
        
        
        let comicEffect = CIFilter(name: "CIComicEffect")
        
        let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
        let cameraImage = CIImage(cvImageBuffer: pixelBuffer!)
        
        comicEffect!.setValue(cameraImage, forKey: kCIInputImageKey)
        
        let cgImage = self.context.createCGImage(comicEffect!.outputImage!, from: cameraImage.extent)!
        
        DispatchQueue.main.async {
            let filteredImage = UIImage(cgImage: cgImage)
            (self.view as! UIImageView).image = filteredImage
        }
    }
    
    // MARK: - 事件
    
    @IBAction func changeFlash(_ sender: Any) {
    }
    
    @IBAction func changeTorchAction(_ sender: Any) {
    }
    
    @IBAction func takePhoto(_ sender: Any) {
    }
    
    @IBAction func backToPhotoAlumAction(_ sender: Any) {
    }
    
    @IBAction func changeCameraDevice(_ sender: Any) {
    }
    
    @IBAction func selectedImage(_ sender: Any) {
    }
}
