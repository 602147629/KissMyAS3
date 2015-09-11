package herovsdragon.game.dragon.act
{

    public class DownActor extends Actor
    {

        public function DownActor()
        {
            return;
        }// end function

        override protected function action() : void
        {
            if (view.currentFrame < view.totalFrames)
            {
                view.nextFrame();
            }
            return;
        }// end function

    }
}
