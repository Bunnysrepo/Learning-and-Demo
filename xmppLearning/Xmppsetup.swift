//
//  Xmppsetup.swift
//  xmppLearning
//
//  Created by Bunny Bhargav on 25/07/18.
//  Copyright © 2018 Bunny Bhargav. All rights reserved.
//

import Foundation
import XMPPFramework

enum IncorrectUserid : Error {
    case wrongId
    case wrongPASSWORD
}
class XMPPController : NSObject, XMPPStreamDelegate
{
    var XmppStream : XMPPStream
    let HostName : String
    let HostPort : UInt16
    let userID : XMPPJID
    //let password : String
    
    init(hostname : String, hostport : UInt16, useId : String) throws {
        guard let userid = XMPPJID(string: useId) else {
         throw IncorrectUserid.wrongId
        }
        
        self.XmppStream = XMPPStream()
        
        self.HostName = hostname
        self.HostPort = hostport
        self.userID = userid
        
        self.XmppStream.hostName = hostname
        self.XmppStream.hostPort = hostport
        self.XmppStream.myJID = userid
        self.XmppStream.startTLSPolicy = .allowed
    
        super.init()
        
        self.XmppStream.addDelegate(self, delegateQueue: DispatchQueue.main)
        
    }
func connection()
        {
         if self.XmppStream.isConnected
         {
            return
            }
         else
         {
         try! self.XmppStream.connect(withTimeout: XMPPStreamTimeoutNone)
            //authentication()
            }
    }
//    func registration()
//    {
//        if self.XmppStream.isConnected
//        {
//            try! self.XmppStream.register(withPassword: PASSWORD)
//        }
//    }
//func authentication()
//    {
//    if self.XmppStream.isConnected
//    {
//        try self.XmppStream.authenticate(withPassword: "92905741491234")
//
//        }
//        else
//    {
//        return
//}
//        do{
//            try! self.XmppStream.authenticate(withPassword: PASSWORD)
//        }
//       catch
//        {
//            print("Unable to authenticate")
//        }
//        try! self.XmppStream.authenticate(withPassword: PASSWORD)
   // }

func authentication()
{
    do
    {
    try self.XmppStream.authenticate(withPassword: PASSWORD)
    }
    catch
    {
        print("authentication Error")
    }
}

}









