import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    var pageControl: UIPageControl!
    var scrollView: UIScrollView!
    
    // 表示する画像の名前のリスト
    let imageArray = ["memoruntyo", "dc_dentaku", "fx_sp", "check_imikotoba", "patata_talk", "patata_wiq", "shiftter"]
    
    override func viewDidLoad() {
        // 画面の横のサイズを取得する
        let scWidth = self.view.frame.width
        // 画面の縦のサイズを取得する
        let scHeight = self.view.frame.height
        
        // ScrollViewを取得する
        scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 0, width: scWidth, height: scHeight)
        // 横方向のスクロールバーを非表示にする
        scrollView.showsHorizontalScrollIndicator = false;
        // 縦方向のスクロールバーを非表示にする
        scrollView.showsVerticalScrollIndicator = false
        // ページングを許可する（中途半端な位置でスクロールが止まらないように設定）
        scrollView.isPagingEnabled = true
        // ScrollViewのデリゲートを設定する
        scrollView.delegate = self
        // スクロールの画面サイズを指定する
        scrollView.contentSize = CGSize(width: CGFloat(imageArray.count) * scWidth, height: 0)
        // ScrollViewをViewに追加する
        self.view.addSubview(scrollView)
        
        // 画像をページ数分設定する
        for i in 0 ..< imageArray.count {
            let imgView = UIImageView()
            imgView.frame = CGRect(x: CGFloat(i) * scWidth, y: 0, width: scWidth, height: scHeight)
            imgView.image = UIImage(named: imageArray[i])
            scrollView.addSubview(imgView)
        }
        
        // PageControlを作成する
        pageControl = UIPageControl(frame: CGRect(x: 0, y: scHeight - 50, width: scWidth, height: 50))
        // PageControlするページ数を設定する
        pageControl.numberOfPages = imageArray.count
        // 現在ページを設定する
        pageControl.currentPage = 0
        // 「pageControl」のタップイベントを止める
        pageControl.isUserInteractionEnabled = false
        // pageControlをViewに追加する
        self.view.addSubview(pageControl)
    }
    
    
    /// スクロール終了後の処理
    /// - Parameter scrollView: scrollView description
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // スクロール数が1ページ分になったら時
        if fmod(scrollView.contentOffset.x, scrollView.frame.maxX) == 0 {
            // ページの場所を切り替える
            pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.maxX)
        }
    }
}

