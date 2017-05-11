import UIKit

class TileLocation: NSObject {
    let row : Int
    let column : Int
    
    init(row: Int, column: Int) {
        self.row = row
        self.column = column
    }
}
