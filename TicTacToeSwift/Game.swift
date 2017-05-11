import UIKit

class Game: NSObject {
    public enum GameStatus {
        case NEXT_MOVE, PLAYER_1_WINS, PLAYER_2_WINS, DRAW
    }
    
    private var board: Board?
    private let player1: Player
    private let player2: Player
    private(set) var currentPlayer: Player?
    private var status: GameStatus
    
    init(board: Board, player1:Player, player2:Player) {
        self.board = board
        self.player1 = player1
        self.player2 = player2
        self.currentPlayer = player1
        self.status = GameStatus.NEXT_MOVE
    }
    
    public func restart() {
        self.currentPlayer = player1
        self.status = GameStatus.NEXT_MOVE
        board?.reset()
    }
    
    func isWin() -> Bool {
        return (board?.isGameFinish(playerSymbol: (currentPlayer?.symbol)!))!
    }
    
    
    func winner() -> GameStatus {
        return self.currentPlayer == player1 ? GameStatus.PLAYER_1_WINS : GameStatus.PLAYER_2_WINS
    }
    
    func checkGameStatus() -> GameStatus {
        let numberOfTurns = board?.numberOfTilesMarked
        if numberOfTurns! < 5 {
            return GameStatus.NEXT_MOVE
        }
        if isWin() {
            return winner()
        }
        if numberOfTurns == 9 {
            return GameStatus.DRAW
        }
        return GameStatus.NEXT_MOVE
    }
    
    func changePlayer() -> Player {
        return self.currentPlayer! == player1 ? player2 : player1
    }
    
    public func playMove(location: TileLocation) -> GameStatus {
        if status == GameStatus.NEXT_MOVE {
            board?.markTile(location: location, mark: (currentPlayer?.symbol)!)
            status = checkGameStatus()
            currentPlayer = changePlayer()
        }
        return status
    }
    
    public func currentStatus() -> GameStatus {
        return status
    }
}
