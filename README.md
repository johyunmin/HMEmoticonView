# HMEmoticonView
EmoticonView Library


USE ful 

Pod 'HMEmoticonView'


---

lazy var emoticonView: HMEmoticonView? = {
    let tv = HMEmoticonView()
    tv.translatesAutoresizingMaskIntoConstraints = false
    tv.items = ["tongue-out", "tongue-out", "tongue-out","cool", "tongue-out", "wink","cool", "tongue-out", "wink","cool", "tongue-out", "wink","cool", "tongue-out", "wink","cool", "tongue-out", "wink","cool", "tongue-out", "wink","cool", "tongue-out", "wink","cool", "tongue-out", "wink"]
    return tv
}()

---

---

override func viewDidLoad() {
    super.viewDidLoad()

    emoticonView?.WithEmoticon { [unowned self] eNumber in
        print(eNumber)
    }
}

---
