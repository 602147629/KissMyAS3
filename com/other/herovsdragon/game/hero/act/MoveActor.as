package herovsdragon.game.hero.act
{
    import Box2D.Common.Math.*;

    public class MoveActor extends Actor
    {
        protected var BASE_SPEED:int;
        private var speedX:int;
        protected var directionOfMovement:int;
        protected var seFrame1:int;
        protected var seFrame2:int;

        public function MoveActor()
        {
            this.speedX = this.BASE_SPEED * framelate / box2dScale;
            this.speedX = this.speedX * this.directionOfMovement;
            return;
        }// end function

        override protected function initializeActFree() : void
        {
            return;
        }// end function

        override protected function action() : void
        {
            if (view.currentFrame != this.seFrame1)
            {
            }
            if (view.currentFrame == this.seFrame2)
            {
                soundEffectMap.playForWalk();
            }
            var _loc_1:* = new b2Vec2(this.speedX, 0);
            chunk._body.SetLinearVelocity(_loc_1);
            playRoopFrame();
            reserveNextDirectionOfMovement();
            reserveNextAttack();
            reserveNextDefense();
            return;
        }// end function

    }
}
