//
//  ViewController.swift
//  HMEmoticonView
//
//  Created by johyunmin on 02/10/2020.
//  Copyright (c) 2020 johyunmin. All rights reserved.
//

import UIKit
import Foundation
import HMEmoticonView

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    /** **선택된 이모티콘 뷰 */
    @IBOutlet weak var emoticonSelectView: UIView!
    /** **이모티콘 이미지뷰 */
    @IBOutlet weak var emoticonImg: UIImageView!
    
    @IBOutlet weak var replyEmoticonBtn: UIButton!
    
    /** **댓글 입력창 감싸는 뷰*/
    @IBOutlet weak var replySendView: UIView!
    /** **댓글 입력 텍스트뷰 */
    @IBOutlet weak var replyTextView: UITextView!
    
    /** **댓글 입력 전 PlaceHolder용 라벨 */
    @IBOutlet weak var replyTextViewLbl: UILabel!
    
    var customView: UIView?
    /** **키보드 사이즈 */
    var keyBoardSize:CGRect?
    
    lazy var emoticonView: HMEmoticonView? = {
        let tv = HMEmoticonView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.items = ["c1", "c2", "c3","c1", "c2", "c3","c1", "c2", "c3","c1", "c2", "c3","c1", "c2", "c3","c1", "c2", "c3"]
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        replyTextView.autocorrectionType = .no
        
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
        
        emoticonView?.WithEmoticon { [unowned self] eNumber in
            self.emoticonSelectView.isHidden = false
            print(eNumber)
        }
    }
    
    /** **이모티콘 클릭 > 이모티콘셀렉 뷰에 이미지 보이기 */
    @IBAction func replyEmoticonBtnClicked(_ sender: UIButton) {
        replyTextView.becomeFirstResponder()
        DispatchQueue.main.async {
            if self.customView == nil {
                self.customView = UIView.init(frame: CGRect.init(x: 0, y: (self.keyBoardSize?.origin.y)!, width: self.view.frame.width, height: self.keyBoardSize!.height))
                self.customView?.addSubview(self.emoticonView ?? UIView.init(frame: CGRect.zero))

                self.emoticonView?.leadingAnchor.constraint(equalTo: self.customView!.leadingAnchor).isActive = true
                self.emoticonView?.trailingAnchor.constraint(equalTo: self.customView!.trailingAnchor).isActive = true
                self.emoticonView?.topAnchor.constraint(equalTo: self.customView!.topAnchor).isActive = true
                self.emoticonView?.bottomAnchor.constraint(equalTo: self.customView!.bottomAnchor).isActive = true

                let tapOut: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.textViewTab))
                self.replyTextView.addGestureRecognizer(tapOut)
                UIApplication.shared.windows.last?.addSubview(self.customView ?? UIView.init(frame: CGRect.zero))
            }else {
                self.customView?.removeFromSuperview()
                self.customView = nil
            }
        }
    }

    /**
    **파라미터가 없고 반환값이 없는 메소드 > 텍스트뷰를 탭한경우 이모티콘 뷰를 숨기는 함수
     
     - Throws: `Error` 이모티콘뷰가 이미 없는 경우 `Error`
     */
    @objc func textViewTab(){
        if self.customView != nil {
            self.customView?.removeFromSuperview()
            self.customView = nil
        }
        self.replyTextView.becomeFirstResponder()
    }
    
/**
    **파라미터가 있고 반환값이 없는 메소드 > 키보드가 보일때 함수
     
     - Parameters:
        - notification: 키보드가 넘어옴
     
     - Throws: `Error` 오브젝트 값이 제대로 안넘어 오는경우 `Error`
     */
    @objc func keyboardWillShow(notification: Notification) {
        print("키보드보임 부름?")
        if let kbSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.keyBoardSize = kbSize
            UIView.animate(withDuration: 0.5, animations: {
                if #available(iOS 11.0, *) {
                    let window = UIApplication.shared.keyWindow
                    let bottomPadding = window?.safeAreaInsets.bottom
                    self.tableView.contentInset = UIEdgeInsets.init(top: kbSize.height , left: 0, bottom: 0, right: 0)
                    self.view.frame.origin.y = (self.view.frame.origin.y - kbSize.height) + (bottomPadding!)+23
                }else{
                    self.tableView.contentInset = UIEdgeInsets.init(top: kbSize.height , left: 0, bottom: 0, right: 0)
                    self.view.frame.origin.y = (self.view.frame.origin.y - kbSize.height)
                }
            }) { success in
                
            }
        }
        
    }
    
    /**
    **파라미터가 있고 반환값이 없는 메소드 > 키보드가 보이지 않을때 함수
     
     - Parameters:
        - notification: 키보드가 넘어옴
     
     - Throws: `Error` 오브젝트 값이 제대로 안넘어 오는경우 `Error`
     */
    @objc func keyboardWillHide(notification: Notification) {
        print("키보드숨김 부름?")
        if let kbSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.keyBoardSize = nil
            if self.customView != nil {
                self.customView?.removeFromSuperview()
                self.customView = nil
                self.replyTextView.gestureRecognizers?.removeLast()
            }
            UIView.animate(withDuration: 0.5, animations: {
                if #available(iOS 11.0, *) {
                    let window = UIApplication.shared.keyWindow
                    let bottomPadding = window?.safeAreaInsets.bottom
                    self.tableView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
                    self.view.frame.origin.y = self.view.frame.origin.y + kbSize.height - bottomPadding!
                }else{
                    self.tableView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
                    self.view.frame.origin.y = self.view.frame.origin.y + kbSize.height
                }
                self.view.layoutIfNeeded()
            }) { success in
                
            }
        }
    }
}

extension ViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
    }
}
 


