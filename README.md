# HMEmoticonView
EmoticonView Library


USE ful 

pod 'HMEmoticonView'


---

    lazy var emoticonView: HMEmoticonView? = {
        let tv = HMEmoticonView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.items = ["image.png","image.png"]
        return tv
    }()

---

---

viewDidLoad()

    emoticonView?.WithEmoticon { [unowned self] eNumber in
        print(eNumber)
    }

---
