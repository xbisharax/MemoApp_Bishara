//
//  NewMemoViewController.swift
//  MemoApp_Bishara
//
//  Created by Geeks on 9/19/24.
//

import UIKit

class NewMemoViewController: UIViewController {
    
    var editTarget:Memo?

    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: Any) {
        
        let notificationCenter = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "User Notification"
        content.subtitle = "CSC308"
        content.body = "Body: IOS App Development"
        content.badge = 0
        
        //timeIntervalTrigger
        let TimeIntervalTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.2, repeats: false)
        
        //requestion notification
        let request = UNNotificationRequest(identifier: "timerdone", content: content, trigger: TimeIntervalTrigger)
        
        //add requestion notification
        notificationCenter.add(request, withCompletionHandler: nil)
        
//        //calendarNotificationTrigger
//        var dateComponents = DateComponents()
//        dateComponents.calendar = Calendar.current
//        
//        dateComponents.weekday = 4 //tuesday
//        dateComponents.hour = 11
//        
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
//        
//        let uuidString = UUID().uuidString
//        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
//        
//        notificationCenter.add(request){(error) in
//            if error != nil{
//                //handle any errors
//            }
//        }
        
        
        guard let memo = memotextview.text, memo.count > 0 else{
            alert(message: "There is no text")
            return
        }
//        let newMemo = Memo(content: memo)
//        Memo.dummyMemmoList.append(newMemo)
        
        if let target = editTarget{
            target.content = memo
            DataManager.shared.saveContext()
            NotificationCenter.default.post(name: NewMemoViewController.memo_Change, object: nil)
        }else{
            DataManager.shared.saveMemo(memo)
            NotificationCenter.default.post(name: NewMemoViewController.newMemo_Insert, object: nil)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var memotextview: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let memo = editTarget{
            navigationItem.title = "Edit Memo"
            memotextview.text = memo.content
        }else{
            navigationItem.title = "New Memo"
            memotextview.text = ""
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension NewMemoViewController{
    static let newMemo_Insert = Notification.Name(rawValue: "newMemo_Insert")
    static let memo_Change = Notification.Name(rawValue: "memo_Change")
}
