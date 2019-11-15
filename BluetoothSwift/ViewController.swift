//
//  ViewController.swift
//  BluetoothSwift
//
//  Created by Kishore on 31/10/19.
//  Copyright © 2019 Kishore. All rights reserved.
//

//https://www.kevinhoyt.com/2016/05/20/the-12-steps-of-bluetooth-swift/
//https://medium.com/@shu223/core-bluetooth-snippets-with-swift-9be8524600b2
//https://www.raywenderlich.com/231-core-bluetooth-tutorial-for-ios-heart-rate-monitor

import UIKit
import CoreBluetooth

class ViewController: UIViewController,
    CBCentralManagerDelegate,
CBPeripheralDelegate {
    
    var manager:CBCentralManager!
    var fitbagPeripheral:CBPeripheral!
         var filterUUID       : CBUUID?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        manager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {

        print("state \(central.state)")
        var state : String
               switch central.state {
               case .poweredOn:
                   state = "Powered ON"
                   central.scanForPeripherals(withServices: nil , options: nil)
                  
                 print("state \(state)")
               case .poweredOff:
                   state = "Powered OFF"
                  print("state \(state)")
               case .resetting:
                   state = "Resetting"
                   print("state \(state)")
               case .unauthorized:
                   state = "Unautthorized"
                  print("state \(state)")
               case .unsupported:
                   state = "Unsupported"
                   print("state \(state)")
               default:
                   state = "Unknown"
                   print("state \(state)")
               }

    }
    
      
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
         print("peripheral \(peripheral)")
        print("Peripheral Name :::\(String(describing: peripheral.name))")
        if((peripheral.name?.lowercased().contains("fitb"))!)
        {
            self.fitbagPeripheral = peripheral;
            central.stopScan()
            central.connect(fitbagPeripheral, options: nil)
        }
    }
    
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Connected")
    }
}

