import UIKit
import Toast_Swift

class GameViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var gameStatusLabel: GameStatusLabel?
    @IBOutlet weak var gameProgressLabel: UILabel?
    
    @IBOutlet weak var gameCollectionView: UICollectionView!
    let board = Board(tiles: Array(repeatElement(Array(repeatElement("empty", count: 3)), count: 3)))
    var tileLocation: TileLocation?
    var game: Game?
    var firstPlayer = Player(name: "Mark", symbol: "cross")
    var secondPlayer = Player(name: "Antony", symbol: "zero")
    override func viewDidLoad() {
        super.viewDidLoad()
        self.gameCollectionView.delegate = self
        self.gameCollectionView.dataSource = self
        self.game = Game(board: board, player1:firstPlayer, player2:secondPlayer)
        gameStatusLabel?.setText(contant: "your turn", name: (game?.currentPlayer?.name)!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = gameCollectionView.dequeueReusableCell(withReuseIdentifier: "GameCollectionViewCell", for: indexPath) as! GameCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let location = TileLocation(row:indexPath.section, column: indexPath.item)
        let status = game?.currentStatus()
        if board.isTileNotMarked(location: location) && status == Game.GameStatus.NEXT_MOVE {
            let cell = collectionView.cellForItem(at: indexPath) as! GameCollectionViewCell
            let player = game?.currentPlayer
            cell.setImage(image: (player?.symbol)!)
            cell.isUserInteractionEnabled = false
            let status = game?.playMove(location: location)
            updateViewAfterMoves(gameStatus: status!)
        }
    }
    
    func showToast(text: String) {
        self.view.makeToast("\(text), Click reset button to play next game", duration: 10.0, position: .center)
        
    }
    
    @IBAction func resetGame(_ sender: Any) {
        gameStatusLabel?.setText(contant: "your turn", name: (game?.currentPlayer?.name)!)
        gameCollectionView.reloadData()
        gameCollectionView.isUserInteractionEnabled = true
        game?.restart()
    }
    
    func updateViewAfterMoves(gameStatus: Game.GameStatus) {
        switch gameStatus {
        case .NEXT_MOVE:
            gameStatusLabel?.setText(contant: "your turn", name: (game?.currentPlayer?.name)!)
            break
        case .DRAW:
            gameStatusLabel?.drawCondition()
            showToast(text: "match draw")
            break
        default:
            gameStatusLabel?.setText(contant: "wins", name: (game?.currentPlayer?.name)!)
            let text = (game?.currentPlayer?.name)! + " wins"
            showToast(text: text)
        }

    }
}
