import UIKit
import Kingfisher


class DetailVC: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var item : SearchItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Detail"
        configure()

    }
    
    private func configure() {
        titleLabel.text = item.title
        priceLabel.text = item.priceText
        dateLabel.text = item.releaseDateText

        if let url = URL(string: item.imageURL!) {
            
            imageView.kf.setImage(with: url,placeholder: UIImage(systemName: "photo"))
            
        }
    }


}
