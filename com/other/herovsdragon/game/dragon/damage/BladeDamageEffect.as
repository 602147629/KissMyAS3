package herovsdragon.game.dragon.damage
{
    import flash.display.*;
    import herovsdragon.game.dragon.view.*;

    public class BladeDamageEffect extends Object
    {
        private var mainFunction:Function;
        private var body:BladeDamageEffectBody;
        private var ROTATION_MAX:int = 15;
        private static const ADJUST_X:int = 0;
        private static const ADJUST_Y:int = 0;
        private static const RANDOM_ADJUST:uint = 10;

        public function BladeDamageEffect()
        {
            this.body = new BladeDamageEffectBody();
            this.body.stop();
            this.erase();
            return;
        }// end function

        public function initialiseAfterGameOver() : void
        {
            this.erase();
            return;
        }// end function

        public function addChild(param1:Sprite) : void
        {
            param1.addChild(this.body);
            return;
        }// end function

        public function run() : void
        {
            this.mainFunction();
            return;
        }// end function

        private function stop() : void
        {
            return;
        }// end function

        public function view(param1:int, param2:int) : void
        {
            var _loc_3:* = Math.floor(Math.random() * RANDOM_ADJUST);
            var _loc_4:* = Math.floor(Math.random() * RANDOM_ADJUST);
            if (Math.floor(Math.random() * 2) == 0)
            {
                _loc_3 = _loc_3 * -1;
            }
            if (Math.floor(Math.random() * 2) == 0)
            {
                _loc_4 = _loc_4 * -1;
            }
            this.body.x = param1 - ADJUST_X;
            this.body.y = param2 + ADJUST_Y;
            this.body.visible = true;
            this.body.gotoAndStop(1);
            var _loc_5:* = Math.floor(Math.random() * this.ROTATION_MAX);
            if (Math.floor(Math.random() * 2) == 0)
            {
                _loc_5 = _loc_5 * -1;
            }
            this.body.rotation = _loc_5;
            this.mainFunction = this.move;
            return;
        }// end function

        private function move() : void
        {
            this.body.nextFrame();
            if (this.body.currentFrame == this.body.totalFrames)
            {
                this.erase();
            }
            return;
        }// end function

        private function erase() : void
        {
            this.body.visible = false;
            this.mainFunction = this.stop;
            return;
        }// end function

    }
}
