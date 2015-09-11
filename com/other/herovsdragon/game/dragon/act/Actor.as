package herovsdragon.game.dragon.act
{
    import Box2D.Dynamics.*;
    import com.dango_itimi.box2d.material.*;
    import flash.display.*;
    import herovsdragon.game.se.*;

    public class Actor extends Object
    {
        protected var mainFunction:Function;
        protected var chunk:Chunk;
        protected var view:MovieClip;
        private var reservedDirectionOfMovement:int;
        private var reservedAttack:int;
        static var gravityY:Number;
        static var box2dScale:uint;
        static var world:b2World;
        static var framelate:uint;
        static var soundEffectMap:SoundEffectMap;
        private static var container:Sprite;
        private static const MOVE_PROBABILITY:uint = 10;
        private static const ATTACK_PROBABILITY:uint = 15;
        public static const ATTACK_KIND:uint = 3;
        private static const ATTACK_STOMP:int = 1;
        private static const ATTACK_BREATH:int = 2;
        private static const ATTACK_CLAW:int = 3;

        public function Actor()
        {
            return;
        }// end function

        public function setChunk(param1:Chunk) : void
        {
            this.chunk = param1;
            return;
        }// end function

        public function setView(param1:MovieClip) : void
        {
            this.view = param1;
            param1.visible = false;
            param1.stop();
            return;
        }// end function

        public function initializeAct() : void
        {
            this.view.visible = true;
            this.view.gotoAndStop(1);
            this.mainFunction = this.action;
            this.initializeActFree();
            return;
        }// end function

        protected function initializeActFree() : void
        {
            return;
        }// end function

        public function destroyAct() : void
        {
            this.view.visible = false;
            this.reservedDirectionOfMovement = 0;
            return;
        }// end function

        public function run() : void
        {
            this.mainFunction();
            return;
        }// end function

        protected function action() : void
        {
            return;
        }// end function

        protected function playRoopFrame() : void
        {
            this.view.nextFrame();
            if (this.currentFrameIsTotalFrame())
            {
                this.view.gotoAndStop(1);
            }
            return;
        }// end function

        public function isFinished() : Boolean
        {
            return this.mainFunction == this.finish;
        }// end function

        public function currentFrameIsTotalFrame() : Boolean
        {
            return this.view.currentFrame == this.view.totalFrames;
        }// end function

        protected function finish() : void
        {
            trace("attention", this);
            return;
        }// end function

        protected function reserveNextDirectionOfMovement() : void
        {
            if (Math.floor(Math.random() * MOVE_PROBABILITY) != 0)
            {
                this.reservedDirectionOfMovement = 0;
                return;
            }
            var _loc_1:* = Math.floor(Math.random() * 2);
            this.reservedDirectionOfMovement = _loc_1 == 0 ? (-1) : (1);
            return;
        }// end function

        protected function reserveNextAttack() : void
        {
            if (Math.floor(Math.random() * ATTACK_PROBABILITY) != 0)
            {
                this.reservedAttack = 0;
                return;
            }
            var _loc_1:* = Math.floor(Math.random() * ATTACK_KIND);
            this.reservedAttack = _loc_1 == 0 ? (ATTACK_STOMP) : (_loc_1 == 1 ? (ATTACK_BREATH) : (ATTACK_CLAW));
            return;
        }// end function

        public function isReservedMove() : Boolean
        {
            return this.reservedDirectionOfMovement != 0;
        }// end function

        public function isReservedAttack() : Boolean
        {
            return this.reservedAttack != 0;
        }// end function

        public function reservedAttackIsStomp() : Boolean
        {
            return this.reservedAttack == ATTACK_STOMP;
        }// end function

        public function reservedAttackIsBreath() : Boolean
        {
            return this.reservedAttack == ATTACK_BREATH;
        }// end function

        public function reservedAttackIsClaw() : Boolean
        {
            return this.reservedAttack == ATTACK_CLAW;
        }// end function

        public function get _view() : MovieClip
        {
            return this.view;
        }// end function

        public function get _reservedDirectionOfMovement() : int
        {
            return this.reservedDirectionOfMovement;
        }// end function

        public static function initializeStatic(param1:b2World, param2:uint, param3:uint, param4:Number, param5:Sprite, param6:SoundEffectMap) : void
        {
            Actor.gravityY = param4;
            Actor.framelate = param3;
            Actor.container = param5;
            Actor.world = param1;
            Actor.box2dScale = param2;
            Actor.soundEffectMap = param6;
            return;
        }// end function

    }
}
