
import Foundation
import UIKit

@available(iOS 9.0, *)
public class HMEmoticonView : UIView{
    
    open var items = ["tongue-out", "tongue-out", "tongue-out","cool", "tongue-out", "wink","cool", "tongue-out", "wink","cool", "tongue-out", "wink","cool", "tongue-out", "wink","cool", "tongue-out", "wink","cool", "tongue-out", "wink","cool", "tongue-out", "wink","cool", "tongue-out", "wink"]
    
    lazy open var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        //If you set it false, you have to add constraints.
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.dataSource = self
        cv.delegate = self
        cv.isPagingEnabled = true
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.bounces = false
        let bundle = Bundle(for: HMEmoticonView.self)
        let nib = UINib(nibName: "HMEmoticonCollectionViewCell", bundle: bundle)
        cv.register(nib, forCellWithReuseIdentifier: "HMEmoticonCollectionViewCell")
        cv.backgroundColor = .white
        pageControl.hidesForSinglePage = true
        pageControl.pageIndicatorTintColor = UIColor(hexString: "#bdbdbd")
        pageControl.currentPageIndicatorTintColor = UIColor(hexString: "#7461f2")
        return cv
    }()
    
    var pageControl: UIPageControl = UIPageControl()
    
    var emoticonBtnClick: ((Int) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(collectionView)
        addSubview(pageControl)
        
        //Add constraint
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        // perform the deinitialization
    }
    
    
    
    @objc func buttonAction(sender: UIButton!) {
        if self.emoticonBtnClick != nil {
            self.emoticonBtnClick!(sender.tag)
        }
    }
    
    open func WithEmoticon(btn1Handler: @escaping (Int) -> Void) {
        self.emoticonBtnClick = btn1Handler
    }
    
}

@available(iOS 9.0, *)
extension HMEmoticonView:UICollectionViewDataSource, UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout{
    
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        print("HMEmoticonView : numberOfSections")
        if items.count % 12 == 0{
            pageControl.numberOfPages = items.count / 12
            return items.count / 12
        }else{
            pageControl.numberOfPages = (items.count / 12) + 1
            return (items.count / 12) + 1
        }
    }
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:HMEmoticonCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HMEmoticonCollectionViewCell", for: indexPath) as! HMEmoticonCollectionViewCell
        cell.emoticonBtn.tag =  (indexPath.section * 10000) + indexPath.item//indexPath.item
        cell.emoticonImg.image = UIImage(named: "\(items[indexPath.item])")
        cell.emoticonBtn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        cell.backgroundColor = .white
        return cell
    }
    
    open func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageControl.currentPage = indexPath.section
    }
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.size.width/4, height: self.collectionView.frame.size.height/3)
    }
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: 0.0 , bottom: 0.0, right: 0.0)
    }
    
    //위아래 간격
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    //옆 라인 간격
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
