//
//  SQLDB.swift
//  xmppLearning
//
//  Created by Bunny Bhargav on 20/08/18.
//  Copyright © 2018 Bunny Bhargav. All rights reserved.
//

import Foundation
import SQLite
var dataBase : Connection!
class ZWAMESSAGE
{
    let tableMessage = Table("ZWAMESSAGE")
    let Z_pk = Expression<Int>("Z_pk")
    let Z_ent = Expression<Int>("Z_ent")
    let Z_opt = Expression<Int>("Z_opt")
    let ZGROUPEVENTTYPE = Expression<String>("ZGROUPEVENTTYPE")
    let ZISFROMME = Expression<Bool>("ZISFROMME")
    let ZMESSAGESTATUS = Expression<String>("ZMESSAGESTATUS")
    let ZMESSAGETYPE = Expression<String>("ZMESSAGETYPE")
    let ZSORT = Expression<Int>("ZSORT")
    let ZCHATSESSION = Expression<Int>("ZCHATSESSION")
    let ZGROUPMEMBER = Expression<String>("ZGROUPMEMBER")
    let ZLASTSESSION = Expression<Int>("ZLASTSESSION")
    let ZMEDIAITEM = Expression<String>("ZMEDIAITEM")
    let ZMESSAGEDATE = Expression<Date>("ZMESSAGEDATE")
    let ZFROMJID = Expression<String>("ZFROMJID")
    let ZSTANZAID = Expression<String>("ZSTANZAID")
    let ZTEXT = Expression<String>("ZTEXT")
    let ZTOJID = Expression<String>("ZTOJID")
    
    
    
    func createTable()//this method has to call in the app delegate "launchingwithoptions" function
    {
        let createTbl = tableMessage.create { (T) in
            T.column(Z_pk)
            T.column(Z_ent)
            T.column(Z_opt)
            T.column(ZGROUPEVENTTYPE)
            T.column(ZISFROMME)
            T.column(ZMESSAGESTATUS)
            T.column(ZMESSAGETYPE)
            T.column(ZSORT)
            T.column(ZCHATSESSION)
            T.column(ZGROUPMEMBER)
            T.column(ZLASTSESSION)
            T.column(ZMEDIAITEM)
            T.column(ZMESSAGEDATE)
            T.column(ZFROMJID, primaryKey : true)
            T.column(ZSTANZAID)
            T.column(ZTEXT)
            T.column(ZTOJID)
       }
        do {
            try dataBase.run(createTbl)
            print("table created")
        }
        catch  {
            print("error occurred")
        }
    }
    
    
    
    
    // this method has to call in the XMPP did receive message function//
    func insertDetails(z_pk : Int,z_ent : Int,z_opt : Int, zgroupeventtype : String, zisfromme : Bool, zmessagestatus : String, zmessagetype : String, zsort : Int, zchatsession : Int, zgroupmember : String, zlastsession : Int, zmediaitem : String, zmessagedate : Date, zfromjid : String, zstanzaid : String, ztext : String, ztojid :String)
    {
    let insertDetails = tableMessage.insert(Z_pk <- z_pk, Z_ent <- z_ent, Z_opt <- z_opt, ZGROUPEVENTTYPE <- zgroupeventtype, ZISFROMME <- zisfromme, ZMESSAGESTATUS <- zmessagestatus, ZMESSAGETYPE <- zmessagetype, ZSORT <- zsort, ZCHATSESSION <- zchatsession, ZGROUPMEMBER <- zgroupmember, ZLASTSESSION <- zlastsession, ZMEDIAITEM <- zmediaitem, ZMESSAGEDATE <- zmessagedate, ZFROMJID <- zfromjid, ZSTANZAID <- zstanzaid, ZTEXT <- ztext, ZTOJID <- ztojid)
        do {
            try dataBase.run(insertDetails)
            print("items inserted")
        } catch {
            print("error occurred while insertig values : \(error)")
        }
    }
    
    
    
    func readMessages()//this method has to call in the tableview ui updation
    {
        do {
         let usermessages = try dataBase.prepare(tableMessage)
            for message in usermessages
            {
                print("messsagetext : \(message[ZTEXT]) , fromID : \(message[ZFROMJID])")
            }
        } catch {
            print("could not display messagess")
        }
    }
    
    
    
    func updatemessages(fromJid : String, newmessage : String)
   {
   let message = tableMessage.filter(ZFROMJID == fromJid)
    let updateMsg = message.update(ZTEXT <- newmessage)
    do {
        try dataBase.run(updateMsg)
    } catch {
        print("could not update values")
    }
   }
    
    
    
   func deleteMessages(fromJid : String)
   {
    let row = tableMessage.filter(ZFROMJID == fromJid)
    let deletedata = row.delete()
    do {
        try dataBase.run(deletedata)
    } catch {
        print("Deletion Failed")
    }
   }
}

