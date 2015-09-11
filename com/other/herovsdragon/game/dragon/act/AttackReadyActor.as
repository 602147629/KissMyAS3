package herovsdragon.game.dragon.act
{
    import Box2D.Common.Math.*;

    public class AttackReadyActor extends Actor
    {

        public function AttackReadyActor()
        {
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
