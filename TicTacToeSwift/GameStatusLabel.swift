import UIKit

class GameStatusLabel: UILabel {
    public func setText(contant:String, name: String){
        self.text = contant + " " + name
    }
    
    public func drawCondition() {
        self.text = "It's a draw"
    }
}
