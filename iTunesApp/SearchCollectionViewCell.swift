import UIKit
import Kingfisher

class SearchCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }

    func configure(with item: SearchItem) {
        titleLabel.text = item.title
        priceLabel.text = item.priceText
        dateLabel.text = item.releaseDateText

        if let url = URL(string: item.imageURL!) {
            
            imageView.kf.setImage(with: url,placeholder: UIImage(systemName: "photo"),options: [.transition(.fade(0.2)),.cacheOriginalImage]
                                  
            )
        } else {
            imageView.image = UIImage(systemName: "photo")
        }
    }
}
