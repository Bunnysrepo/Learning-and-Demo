//
//  ViewController.swift
//  xmppLearning
//
//  Created by Bunny Bhargav on 17/07/18.
//  Copyright © 2018 Bunny Bhargav. All rights reserved.
//

import UIKit
import XMPPFramework
import CocoaLumberjack
var PASSWORD : String = "YOURPASSWORDSTRING"
class ViewController: UIViewController {
    @IBOutlet weak var msgTxt: UITextField!
    @IBOutlet weak var JabberId: UITextField!
    @IBOutlet weak var Hostname: UITextField!
    var XmppController : XMPPController!
    let xmppRoasterStorage = XMPPRosterCoreDataStorage()
    let roomstorage = XMPPRoomCoreDataStorage()
    var xmppRoaster : XMPPRoster!
    var room : XMPPRoom!
    var xmppfiletransfer : XMPPOutgoingFileTransfer!
    let chosenImage   = UIImage(named: "image")
    override func viewDidLoad() {
        super.viewDidLoad()
        xmppRoaster = XMPPRoster(rosterStorage: xmppRoasterStorage)
        xmppRoaster.addDelegate(self, delegateQueue: DispatchQueue.main)
        //xmppfiletransfer = XMPPFileTransfer()
        xmppRoaster.autoFetchRoster = true
       // xmppRoaster.autoAcceptKnownPresenceSubscriptionRequests = true
        // Do any additional setup after loading the view, typically from a nib.
        
        connectioncCall(hostname: "YOUR HOSTNAME", hostport: YOURPORTNUMBER, userIdentity : "YOUR JID")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    @IBAction func ConnectBtn(_ sender: Any) {
//
//    }
    @IBAction func sendBtn(_ sender: Any) {


        if msgTxt.text != nil
        {
             sendmsg()
        }
    }
    func connectioncCall(hostname : String, hostport : UInt16, userIdentity : String)
{
    do{
        try self.XmppController = XMPPController(hostname: hostname, hostport : hostport, useId : userIdentity)
        self.XmppController.XmppStream.addDelegate(self, delegateQueue: DispatchQueue.main)
        self.XmppController.connection()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2)
        {
            self.XmppController.authentication()
            self.xmppRoaster.activate(self.XmppController.XmppStream)
            //self.room.activate(self.XmppController.XmppStream)
            //self.room.addDelegate(self, delegateQueue: DispatchQueue.main)
            
            
            
        }
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 6)
//        {
//           // self.createroom()
//            //self.room.activate(self.XmppController.XmppStream)
//            //self.sendmediamessage()
//
//        }
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 8)
//        {
//           // self.InvitePartner()
//        }
    }
    catch
    {
        print("Error occurred while Connecting")
    }
    }
    func sendmsg()
    {
        
        let msgStr = msgTxt.text!
        let toID = XMPPJID(string: "YOURTOID")
        let message = XMPPMessage(type: "chat", to: toID, elementID: "hfgfyg")
        message.addBody(msgStr)
        let streamobject = self.XmppController.XmppStream
        streamobject.send(message)
        let query = try? DDXMLElement(xmlString: "<query xmlns='http://jabber.org/protocol/disco#items'/>")
        //let qry = DDXMLElement(name: "query", xmlns: "http://jabber.org/protocol/disco#items")
        let iq = DDXMLElement.element(withName: "iq") as! DDXMLElement
        //iq.addAttribute(withName: "from", stringValue: "9290574149@eazi.ai/tv")
        iq.addAttribute(withName: "id", stringValue: "step_01")
        iq.addAttribute(withName: "to", stringValue: "eazi.ai")
        iq.addAttribute(withName: "type", stringValue: "get")

        if let query1 = query
        {
            iq.addChild(query1)
        }
        streamobject.send(iq)
//
//        //print(iq)
//         //self.rawxmlsending()
//        //print(iq)
//        //XmppController.XmppStream.send(iqmsg)
        //streamobject.send(message)
    }
    
//    func addingUser()
//    {
//        xmppRoaster.addUser(XMPPJID(string: "915528628523@eazi.ai")!, withNickname: "the name is kaile", groups: ["a1", "a2"], subscribeToPresence: true)
//        xmppRoaster.subscribePresence(toUser: <#T##XMPPJID#>)
////         }
    
    
    
    
    
//    func createroom()
//    {
//        guard let roomid = XMPPJID(string: "")
//            else {
//                return
//        }
//
//        room = XMPPRoom.init(roomStorage: roomstorage, jid: roomid, dispatchQueue: DispatchQueue.main)
//              room.activate(self.XmppController.XmppStream)
//              room.addDelegate(self, delegateQueue: DispatchQueue.main)
//              room.join(usingNickname: "buNNy", history: nil, password: nil)
//    }
    
    
    
    
    
    
//    func InvitePartner()
//    {
//        let jid = XMPPJID(string: "919652029798")
//        room.inviteUser(jid!, withMessage: "Hi Maru sir,Intrested to join our group")
//        print("Invitation sent")
//    }
    
    
    
    
    
    
//    func image_send_session() {
    
        
        
//        let dataimg :  Data? = UIImagePNGRepresentation(chosenImage!) as Data?
//
//
//        let boundary : NSString = "---011000010111000001101001"
//
//
//        let postData = NSMutableData(data: "\r\n--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
//        postData.append("Content-Disposition: form-data; name=\"image\"; filename=\"img.png\"\r\n".data(using: String.Encoding.utf8)!)
//
//        postData.append("Content-Type: application/octet-stream\r\n\r\n".data(using: String.Encoding.utf8)!)
//        postData.append(dataimg!)
//
//        postData.append("\r\n--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        
//        var data = UIImagePNGRepresentation(chosenImage!)
//        var imgstr = data?.base64EncodedString()
//        //let attachment = DDXMLElement(name: "attachment", stringValue: <#T##String?#>)
//
//
//        let description = "This is the first multimedia message"
//        xmppfiletransfer = XMPPOutgoingFileTransfer(dispatchQueue: DispatchQueue.main)
//        xmppfiletransfer.shouldGenerateRandomName = true
//        xmppfiletransfer.activate(self.XmppController.XmppStream)
//        xmppfiletransfer.addDelegate(self, delegateQueue: DispatchQueue.main)
//        do {
//            //try xmppfiletransfer.send(data as Data, named: "Firstfile", toRecipient: toId, description: description)
//        } catch {
//            print(error.localizedDescription)
//        }
//
        
        
//    }
//    func rawxmlsending() //-> DDXMLElement
//    {
//        let qry = DDXMLElement(name: "query", xmlns: "http://jabber.org/protocol/disco#items") as! DDXMLElement
//        //let query = try? DDXMLElement(xmlString: "<query xmlns='http://jabber.org/protocol/disco#items'/>")
//        let iq = DDXMLElement.element(withName: "iq") as! DDXMLElement//element(withName: "from", stringValue: ") as! DDXMLElement
//        iq.addAttribute(withName: "from", stringValue: "")
//        iq.addAttribute(withName: "id", stringValue: "C6CF8EEE-B74E-45C8-8881-89BD0835056E")
//        iq.addAttribute(withName: "to", stringValue: "eazi.ai")
//        iq.addAttribute(withName: "type", stringValue: "get")
//       // if let query = query
//       //{
//            iq.addChild(qry)
//        //}
//        self.XmppController.XmppStream.send(iq)
//       // return iq
//        //print(iq)
//    }
//    func sendmediamessage()
//    {
//
//        let data = UIImagePNGRepresentation(chosenImage!)
//        let imgstr = data?.base64EncodedString()
//        let fileupload = XMPPHTTPFileUpload()
//        fileupload.addDelegate(self, delegateQueue: DispatchQueue.main)
//        fileupload.activate(self.XmppController.XmppStream)
//       // XMPPSlot
//        //XMPPHTTPFileUploadErrorCode
//        //XMPPHTTPFileUploadErrorDomain
//        fileupload.requestSlot(fromService: XMPPJID(string: "9290574149@eazi.ai")!, filename: imgstr!, size: 3, contentType: "image/jpeg", completion: { (slot, iqresponse, error) in
//            guard let slot1 = slot else
//            {
//                print("error occurred\(error)")
//                return
//            }
//            print(iqresponse!)
//        }, completionQueue: DispatchQueue.main)
//
    
//        let attachment = DDXMLElement(name: "attachment", stringValue: imgstr)
//        let toId = XMPPJID(string: "919632029798@eazi.ai", resource: "HOME")
//        let message = XMPPMessage(type: "chat", to: toId, elementID: "abcd", child: attachment)
//        self.XmppController.XmppStream.send(message)

    //}
//
    
//    func send_groupmessage()
//    {
//        let messagestring = "Hi eazi "
//        let message = XMPPMessage(type: "groupchat", to: XMPPJID(string: ""), elementID: "dgfchv")
//        message.addBody(messagestring)
//        room.send(message)
//    }
}

extension ViewController : XMPPStreamDelegate, XMPPRosterDelegate, XMPPRoomDelegate, XMPPMUCDelegate, XMPPOutgoingFileTransferDelegate, XMPPHTPPFileUploadDelegate
{
    func xmppStreamDidConnect(_ sender: XMPPStream) {
        print("CONNECTION SUCCESSFUL")
        //try! sender.authenticate(withPassword: PASSWORD)
        
    }
    func xmppStreamDidRegister(_ sender: XMPPStream) {
        print("REGISTERED USER SUCCESSFULLY")
    }
    func xmppStream(_ sender: XMPPStream, didNotRegister error: DDXMLElement) {
        print("REGISTRATION UNSUCCESSFUL")
    }
    func xmppStreamDidAuthenticate(_ sender: XMPPStream) {
        print("AUTHENTICATION SUCESSFUL")
        self.XmppController.XmppStream.send(XMPPPresence())
        //self.createroom()
        //self.rawxmlsending(sender: sender)
        
    }
    func xmppStream(_ sender: XMPPStream, didSend presence: XMPPPresence) {
        print("PRESENCE SENT SUCCESSFULLY : \(presence.type!)")
        //self.rawxmlsending(sender: sender)
        
    }
    func xmppStream(_ sender: XMPPStream, didNotAuthenticate error: DDXMLElement) {
        print("AUTHENTICATION FAILURE")
    }
    func xmppStream(_ sender: XMPPStream, didSend message: XMPPMessage) {
        print("MESSAGE SENT SUCCESSFULLY : \(message)")
        //self.rawxmlsending()
    }
    func xmppStream(_ sender: XMPPStream, didReceive message: XMPPMessage) {
        print("MESSAGE RECEIVED SUCCESSFULLY : \(message)")
        
    }
//    func xmppHTTPFileUpload(_ sender: XMPPHTTPFileUpload, service: XMPPJID, didAssign slot: XMPPSlot, response: XMPPIQ, tag: Any?) {
//        print("\(service),\(slot),\(response),\(tag)")
//    }
    
//    func xmppRoomLight(_ sender: XMPPRoomLight, didCreateRoomLight iq: XMPPIQ) {
//        print("ROOM CREATED SUCCESSFULLY : \(sender.roomname) IS ROOM NAME AND \(sender.roomJID) IS ROOM ID")
//    }
//    func xmppRoomLight(_ sender: XMPPRoomLight, didFailToCreateRoomLight iq: XMPPIQ) {
//        print("COULD NOT CREATE ROOM")
//    }
//    func xmppRoomLight(_ sender: XMPPRoomLight, didReceive message: XMPPMessage) {
//        print("MESSAGE RECEIVED : \(message.body)")
//    }
//    func xmppStream(_ sender: XMPPStream, didReceive presence: XMPPPresence) {
//
//        print("This is received presence : \(presence.type!)")
//
//        }
//        guard let status = presence.status else {
//            return
//        }
//        print("this is the status : \(status)")
//        
//    }
//    func xmppRoster(_ sender: XMPPRoster, didReceiveRosterItem item: DDXMLElement) {
//        print("\(item)")
//
//    }
//    func xmppRosterDidBeginPopulating(_ sender: XMPPRoster, withVersion version: String) {
//
//    }
    func xmppRosterDidEndPopulating(_ sender: XMPPRoster) {
        var list : [XMPPJID] = xmppRoasterStorage.jids(for: self.XmppController.XmppStream)
        for i in 0..<list.count
        {
                print("list of the users : \(list[i].description)\n")
        }
        
        //self.sendmediamessage()
        
    }
//    func xmppRoomDidCreate(_ sender: XMPPRoom) {
//        //let roomsubject = "Eazi"
//        //room.changeSubject(roomsubject)
//        print("ROOM CREATED SUCCESSFULLY : \(sender.roomJID) IS THE ROOM ID AND \(sender.roomSubject) IS THE GROUP NAME")
//    }
//    func xmppRoomDidJoin(_ sender: XMPPRoom) {
//        print("ROOM JOINED SUCCESSFULLY : \(sender.myNickname!) IS THE NAME AND \(sender.myRoomJID) is your room jid")
//        //self.image_send_session()
//        //self.sendmediamessage()
//    }
//    func xmppOutgoingFileTransferDidSucceed(_ sender: XMPPOutgoingFileTransfer!) {
//        print("FILE TRANSFERED SUCCESSFULLY")
//    }
//    func xmppRoster(_ sender: XMPPRoster, didReceivePresenceSubscriptionRequest presence: XMPPPresence) {
//        print(presence.type)
//    }
    func xmppStream(_ sender: XMPPStream, didSend iq: XMPPIQ) {
        print("IQ sent successfully\(iq)")
    }
    func xmppStream(_ sender: XMPPStream, didFailToSend iq: XMPPIQ, error: Error) {
        print("IQ not sent cause of the error\(error)")
    }
}
