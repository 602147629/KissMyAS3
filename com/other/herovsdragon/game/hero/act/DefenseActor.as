package herovsdragon.game.hero.act
{
    import Box2D.Common.Math.*;
    import herovsdragon.game.hero.view.*;

    public class DefenseActor extends Actor
    {

        public function DefenseActor()
        {
            return;
        }// end function

        override protected function initializeActFree() : void
        {
            chunk._body.SetLinearVelocity(new b2Vec2());
            return;
        }// end function

        override protected function action() : void
        {
            view.nextFrame();
            if (view.currentFrame == view.totalFrames)
            {
                mainFunction = end;
            }
            return;
        }// end function

        public function isDefensing() : Boolean
        {
            return (view as Defense).defensePt != null;
        }// end function

    }
}
