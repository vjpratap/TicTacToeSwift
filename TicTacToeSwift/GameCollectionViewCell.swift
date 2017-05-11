import UIKit

class GameCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var playerSymbolImage: UIImageView!
    
    override func prepareForReuse() {
        playerSymbolImage.image = Optional.none
        isUserInteractionEnabled = true
    }
    
    public func setImage(image: String) {
        playerSymbolImage.image = UIImage(named: image)
    }
}
