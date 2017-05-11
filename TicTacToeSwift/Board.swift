import UIKit

class Board: NSObject {
    private var tiles: Array<Array<String>>?
    private(set) var numberOfTilesMarked: Int = 0
    static let EMPTY = "empty"
    public let boardSize = 3
    
    init(tiles: Array<Array<String>>) {
        self.tiles = tiles
        for row in tiles{
            for mark in row {
                if Board.EMPTY != mark{
                    self.numberOfTilesMarked += 1
                }
            }
        }
    }
    
    public func reset() {
        self.tiles = Array(repeatElement(Array(repeatElement("empty", count: 3)), count: 3))
        self.numberOfTilesMarked = 0
    }
    
    public func markTile(location: TileLocation, mark:String) {
        if isTileNotMarked(location: location) {
            tiles?[location.row][location.column] = mark
            numberOfTilesMarked += 1
        }
    }
    
    func isTileNotMarked(location: TileLocation) -> Bool {
        return tiles?[location.row][location.column] == Board.EMPTY
    }
    
    public func numberOfChances() -> Int {
        return self.numberOfTilesMarked
    }

    
    public func isGameFinish(playerSymbol: String) -> Bool {
        return checkRightDiognal(playerSymbol: playerSymbol) || checkLeftDiognal(playerSymbol:playerSymbol) || checkRow(playerSymbol: playerSymbol) || checkColomn(playerSymbol: playerSymbol)
    }
    
    func checkLeftDiognal(playerSymbol: String) -> Bool {
        var checkWin = true
        for index in 0...(boardSize - 1) {
            checkWin = tiles?[index][index] == playerSymbol
            if !checkWin {
                return false
            }
        }
        return true
    }
    
    func checkRightDiognal(playerSymbol: String) -> Bool {
        var checkWin = true
        for index in 0...(boardSize - 1) {
            checkWin = tiles![index][boardSize - 1 - index] == playerSymbol
            if !checkWin {
                return false
            }
        }
        return true
    }
    
    func checkRow(playerSymbol: String) -> Bool {
        for row in 0...(boardSize - 1) {
            var checkWin = true
            for colomn in 0...(boardSize - 1) {
                checkWin = checkWin && tiles?[row][colomn] == playerSymbol
            }
            if checkWin {
                return true
            }
        }
        return false
    }
    
    public func checkColomn(playerSymbol: String) -> Bool {
        for row in 0...(boardSize - 1) {
            var checkWin = true
            for colomn in 0...(boardSize - 1) {
                checkWin = checkWin && tiles?[colomn][row] == playerSymbol
            }
            if checkWin {
                return true
            }
        }
        return false
    }
}
