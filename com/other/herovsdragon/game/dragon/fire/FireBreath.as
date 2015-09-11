package herovsdragon.game.dragon.fire
{
    import Box2D.Common.Math.*;
    import Box2D.Dynamics.*;
    import com.dango_itimi.box2d.material.*;
    import flash.display.*;
    import herovsdragon.game.dragon.view.*;

    public class FireBreath extends Object
    {
        private var speed:b2Vec2;
        private var mainFunction:Function;
        private var chunk:Chunk;
        private const ADJUST_X:int = 40;
        private var bodyView:FireBreathBody;
        private var defaultPositionX:Number;
        private var defaultPositionY:Number;
        private static var gravityY:Number;
        private static var world:b2World;
        private static var box2dScale:uint;
        private static var framelate:uint;
        private static const BASE_SPEED_PIXEL:uint = 15;

        public function FireBreath(param1:Chunk)
        {
            this.chunk = param1;
            var _loc_2:* = param1._body.GetPosition();
            this.defaultPositionX = _loc_2.x;
            this.defaultPositionY = _loc_2.y;
            param1._body.SetSleepingAllowed(false);
            this.speed = new b2Vec2((-BASE_SPEED_PIXEL) * framelate / box2dScale, 0);
            this.bodyView = new FireBreathBody();
            this.bodyView.stop();
            this.bodyView.visible = false;
            this.mainFunction = this.stop;
            return;
        }// end function

        public function initialiseAfterGameOver() : void
        {
            this.bodyView.visible = false;
            this.erase();
            return;
        }// end function

        public function addChild(param1:Sprite) : void
        {
            param1.addChild(this.bodyView);
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

        public function view(param1:b2Vec2) : void
        {
            this.chunk._body.SetPosition(new b2Vec2(param1.x - this.ADJUST_X / box2dScale, param1.y));
            this.chunk._body.SetLinearVelocity(this.speed);
            this.bodyView.visible = true;
            this.mainFunction = this.move;
            return;
        }// end function

        private function move() : void
        {
            this.chunk.applyImpulseForAntiGravity(gravityY);
            this.bodyView.nextFrame();
            if (this.bodyView.currentFrame == this.bodyView.totalFrames)
            {
                this.bodyView.gotoAndStop(1);
            }
            return;
        }// end function

        public function draw() : void
        {
            var _loc_1:* = this.chunk._body.GetPosition();
            this.bodyView.x = _loc_1.x * box2dScale;
            this.bodyView.y = _loc_1.y * box2dScale;
            return;
        }// end function

        public function erase() : void
        {
            this.chunk._body.SetPosition(new b2Vec2(this.defaultPositionX, this.defaultPositionY));
            this.chunk._body.SetLinearVelocity(new b2Vec2());
            this.bodyView.visible = false;
            this.mainFunction = this.stop;
            return;
        }// end function

        public function getChunkPosition() : b2Vec2
        {
            return this.chunk._body.GetPosition();
        }// end function

        public static function initializeStatic(param1:b2World, param2:uint, param3:uint, param4:Number) : void
        {
            FireBreath.box2dScale = param2;
            FireBreath.gravityY = param4;
            FireBreath.framelate = param3;
            FireBreath.world = param1;
            FireBreath.box2dScale = param2;
            return;
        }// end function

    }
}
