package herovsdragon.game.dragon.stomp
{
    import flash.display.*;
    import herovsdragon.game.dragon.view.*;

    public class StompEffect extends Object
    {
        private var mainFunction:Function;
        private var body:StompEffectBody;
        private static const ADJUST_X:int = 140;
        private static const ADJUST_Y:int = 50;

        public function StompEffect()
        {
            this.body = new StompEffectBody();
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
            this.body.x = param1 - ADJUST_X;
            this.body.y = param2 + ADJUST_Y;
            this.body.visible = true;
            this.body.gotoAndStop(1);
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

        public function hitTest(param1:Sprite) : Boolean
        {
            if (this.body.visible)
            {
            }
            if (!this.body.attackHitArea)
            {
                return false;
            }
            return this.body.attackHitArea.hitTestObject(param1);
        }// end function

        public function getAttackHitArea() : Sprite
        {
            return this.body.attackHitArea;
        }// end function

    }
}
