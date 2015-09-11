package herovsdragon.game.dragon.act
{
    import Box2D.Common.Math.*;

    public class NeutralActor extends Actor
    {

        public function NeutralActor()
        {
            return;
        }// end function

        override protected function initializeActFree() : void
        {
            return;
        }// end function

        override protected function action() : void
        {
            chunk._body.SetLinearVelocity(new b2Vec2(0, 0));
            playRoopFrame();
            reserveNextAttack();
            reserveNextDirectionOfMovement();
            return;
        }// end function

    }
}
