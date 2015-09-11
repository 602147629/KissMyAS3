package herovsdragon.game.hero.act
{
    import Box2D.Common.Math.*;
    import __AS3__.vec.*;

    public class DamageActor extends Actor
    {
        private var MOVED_DISTANCES:Vector.<int>;
        private var count:uint;

        public function DamageActor()
        {
            this.MOVED_DISTANCES = this.Vector.<int>([7, 6, 5, 4, 3, 1]);
            return;
        }// end function

        override protected function initializeActFree() : void
        {
            chunk._body.SetLinearVelocity(new b2Vec2());
            this.count = 0;
            return;
        }// end function

        override protected function action() : void
        {
            var _loc_1:* = chunk._body.GetPosition();
            chunk._body.SetPosition(new b2Vec2(_loc_1.x - this.MOVED_DISTANCES[this.count] / box2dScale, _loc_1.y));
            var _loc_2:* = this;
            _loc_2.count = this.count + 1;
            if (++this.count < this.MOVED_DISTANCES.length)
            {
                return;
            }
            mainFunction = end;
            return;
        }// end function

    }
}
