package herovsdragon.game.scene
{
    import herovsdragon.game.scene.view.*;

    public class GameOverScene extends GameScene
    {

        public function GameOverScene()
        {
            viewClass = GameOver;
            retryBtn = (view as GameOver).retryBtn;
            return;
        }// end function

    }
}
