package herovsdragon.game.hero.act
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
            chunk._body.SetLinearVelocity(new b2Vec2(0, 0));
            return;
        }// end function

        override protected function action() : void
        {
            playRoopFrame();
            reserveNextDirectionOfMovement();
            reserveNextAttack();
            reserveNextDefense();
            return;
        }// end function

    }
}
