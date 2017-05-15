//
//  SHA1.swift
//  OAuthSwift
//
//  Created by Dongri Jin on 1/28/15.
//  Copyright (c) 2015 Dongri Jin. All rights reserved.
//

import Foundation

struct SHA1 {
    
    var message: Data
    
    /** Common part for hash calculation. Prepare header data. */
    func prepare(_ len:Int = 64) -> Data {
        var tmpMessage: Data = self.message
        
        // Step 1. Append Padding Bits
        tmpMessage.append([0x80]) // append one bit (Byte with one bit) to message
        
        // append "0" bit until message length in bits ≡ 448 (mod 512)
        while tmpMessage.count % len != (len - 8) {
            tmpMessage.append([0x00])
        }
        
        return tmpMessage
    }

    func calculate() -> Data {

        //var tmpMessage = self.prepare()
        let len = 64
        let h: [UInt32] = [0x67452301, 0xEFCDAB89, 0x98BADCFE, 0x10325476, 0xC3D2E1F0]

        var tmpMessage: Data = self.message
        
        // Step 1. Append Padding Bits
        tmpMessage.append([0x80]) // append one bit (Byte with one bit) to message
        
        // append "0" bit until message length in bits ≡ 448 (mod 512)
        while tmpMessage.count % len != (len - 8) {
            tmpMessage.append([0x00])
        }

        // hash values
        var hh = h
        
        // append message length, in a 64-bit big-endian integer. So now the message length is a multiple of 512 bits.
        tmpMessage.append((self.message.count * 8).bytes(64 / 8))
        
        // Process the message in successive 512-bit chunks:
        let chunkSizeBytes = 512 / 8 // 64
        var leftMessageBytes = tmpMessage.count
        var i = 0;
        while i < tmpMessage.count {
            
            let chunk = tmpMessage.subdata(in: i..<i+min(chunkSizeBytes, leftMessageBytes))
            // break chunk into sixteen 32-bit words M[j], 0 ≤ j ≤ 15, big-endian
            // Extend the sixteen 32-bit words into eighty 32-bit words:
            var M = [UInt32](repeating: 0, count: 80)
            for x in 0..<M.count {
                switch (x) {
                case 0...15:
                    let le: UInt32 = chunk.withUnsafeBytes { $0[x] }
                    M[x] = le.bigEndian
                    break
                default:
                    M[x] = rotateLeft(M[x-3] ^ M[x-8] ^ M[x-14] ^ M[x-16], n: 1)
                    break
                }
            }
            
            var A = hh[0], B = hh[1], C = hh[2], D = hh[3], E = hh[4]
            
            // Main loop
            for j in 0...79 {
                var f: UInt32 = 0
                var k: UInt32 = 0
                
                switch j {
                case 0...19:
                    f = (B & C) | ((~B) & D)
                    k = 0x5A827999
                    break
                case 20...39:
                    f = B ^ C ^ D
                    k = 0x6ED9EBA1
                    break
                case 40...59:
                    f = (B & C) | (B & D) | (C & D)
                    k = 0x8F1BBCDC
                    break
                case 60...79:
                    f = B ^ C ^ D
                    k = 0xCA62C1D6
                    break
                default:
                    break
                }
                
                let temp = (rotateLeft(A,n: 5) &+ f &+ E &+ M[j] &+ k) & 0xffffffff
                E = D
                D = C
                C = rotateLeft(B, n: 30)
                B = A
                A = temp
                
            }
            
            hh[0] = (hh[0] &+ A) & 0xffffffff
            hh[1] = (hh[1] &+ B) & 0xffffffff
            hh[2] = (hh[2] &+ C) & 0xffffffff
            hh[3] = (hh[3] &+ D) & 0xffffffff
            hh[4] = (hh[4] &+ E) & 0xffffffff
			
            i = i + chunkSizeBytes
            leftMessageBytes -= chunkSizeBytes
        }
        
        // Produce the final hash value (big-endian) as a 160 bit number:
        var mutableBuff = Data()
        hh.forEach {
            var i = $0.bigEndian
            let numBytes = MemoryLayout.size(ofValue: i) / MemoryLayout<UInt8>.size
            withUnsafePointer(to: &i) { ptr in
                ptr.withMemoryRebound(to: UInt8.self, capacity: numBytes) { ptr in
                    let buffer = UnsafeBufferPointer(start: ptr,
                                                     count: numBytes)
                    mutableBuff.append(buffer)
                }
            }
        }
        
        return mutableBuff
    }
}
