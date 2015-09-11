package herovsdragon.game.dragon.act
{
    import Box2D.Common.Math.*;

    public class AttackBlusterActor extends Actor
    {
        private var ROOP_MAX:int = 30;
        private var ROOP_MIN:int = 10;
        private var roopCount:int = 0;

        public function AttackBlusterActor()
        {
            return;
        }// end function

        override protected function initializeActFree() : void
        {
            this.roopCount = Math.floor(Math.random() * this.ROOP_MAX);
            if (this.roopCount < this.ROOP_MIN)
            {
                this.roopCount = this.ROOP_MIN;
            }
            return;
        }// end function

        override protected function action() : void
        {
            chunk._body.SetLinearVelocity(new b2Vec2(0, 0));
            if (!currentFrameIsTotalFrame())
            {
                view.nextFrame();
                return;
            }
            var _loc_1:* = this;
            _loc_1.roopCount = this.roopCount - 1;
            if (--this.roopCount > 0)
            {
                view.gotoAndStop(1);
            }
            else
            {
                mainFunction = finish;
            }
            return;
        }// end function

    }
}
