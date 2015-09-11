package herovsdragon.game.dragon.act
{
    import Box2D.Common.Math.*;

    public class AttackFireActor extends Actor
    {

        public function AttackFireActor()
        {
            return;
        }// end function

        override protected function initializeActFree() : void
        {
            chunk._body.SetLinearVelocity(new b2Vec2(5, 0));
            return;
        }// end function

        override protected function action() : void
        {
            chunk._body.SetLinearVelocity(new b2Vec2(0, 0));
            view.nextFrame();
            if (currentFrameIsTotalFrame())
            {
                mainFunction = finish;
            }
            return;
        }// end function

    }
}
