package herovsdragon.game.dragon.act
{
    import Box2D.Common.Math.*;

    public class StompActor extends Actor
    {

        public function StompActor()
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

        public function isStomped() : Boolean
        {
            return view.currentFrameLabel == "stomp";
        }// end function

    }
}
