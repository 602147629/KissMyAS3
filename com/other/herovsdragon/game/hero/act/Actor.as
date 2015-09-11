package herovsdragon.game.hero.act
{
    import Box2D.Dynamics.*;
    import com.dango_itimi.box2d.material.*;
    import com.dango_itimi.events.core.*;
    import com.dango_itimi.events.mouse.*;
    import flash.display.*;
    import herovsdragon.game.se.*;

    public class Actor extends Object
    {
        protected var mainFunction:Function;
        protected var chunk:Chunk;
        protected var view:MovieClip;
        private var reservedDirectionOfMovement:int;
        private var reservedAttack:Boolean;
        private var reservedDefense:Boolean;
        static var gravityY:Number;
        static var box2dScale:uint;
        static var world:b2World;
        static var framelate:uint;
        static var dragChecker:DragChecker;
        static var dragCheckerForRight:DragChecker;
        static var keyChecker:KeyChecker;
        static var soundEffectMap:SoundEffectMap;
        private static var container:Sprite;
        private static var halfWidth:uint;
        private static const KEY_ATTACK:int = 90;
        private static const KEY_DEFENSE:int = 88;

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
            this.view.gotoAndStop(1);
            this.view.visible = true;
            this.mainFunction = this.action;
            this.initializeActFree();
            return;
        }// end function

        public function initializeActForContinuedView() : void
        {
            this.view.visible = true;
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
            this.reservedAttack = false;
            this.reservedDefense = false;
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
            if (this.view.currentFrame == this.view.totalFrames)
            {
                this.view.gotoAndStop(1);
            }
            return;
        }// end function

        protected function reserveNextDirectionOfMovement() : void
        {
            var _loc_1:* = this.getChunkPositionX();
            this.reservedDirectionOfMovement = container.mouseX < _loc_1 - halfWidth ? (-1) : (container.mouseX > _loc_1 + halfWidth ? (1) : (0));
            return;
        }// end function

        protected function reserveNextAttack() : void
        {
            if (!keyChecker.checkSelected(KEY_ATTACK))
            {
                keyChecker.checkSelected(KEY_ATTACK);
            }
            this.reservedAttack = dragChecker._draggedTarget;
            return;
        }// end function

        protected function reserveNextDefense() : void
        {
            if (!keyChecker.checkSelected(KEY_DEFENSE))
            {
                keyChecker.checkSelected(KEY_DEFENSE);
                if (dragCheckerForRight)
                {
                }
            }
            this.reservedDefense = dragCheckerForRight._draggedTarget;
            return;
        }// end function

        private function getChunkPositionX() : Number
        {
            return this.chunk._body.GetPosition().x * box2dScale;
        }// end function

        public function isFinished() : Boolean
        {
            return this.mainFunction == this.end;
        }// end function

        public function currentFrameIsTotalFrame() : Boolean
        {
            return this.view.currentFrame == this.view.totalFrames;
        }// end function

        protected function end() : void
        {
            trace("attention", this);
            return;
        }// end function

        public function isReservedMove() : Boolean
        {
            return this.reservedDirectionOfMovement != 0;
        }// end function

        public function get _view() : MovieClip
        {
            return this.view;
        }// end function

        public function get _reservedDirectionOfMovement() : int
        {
            return this.reservedDirectionOfMovement;
        }// end function

        public function get _reservedAttack() : Boolean
        {
            return this.reservedAttack;
        }// end function

        public function get _reservedDefense() : Boolean
        {
            return this.reservedDefense;
        }// end function

        public static function initializeStatic(param1:b2World, param2:uint, param3:uint, param4:Number, param5:Sprite, param6:KeyChecker, param7:DragChecker, param8:DragChecker, param9:SoundEffectMap) : void
        {
            Actor.gravityY = param4;
            Actor.keyChecker = param6;
            Actor.dragCheckerForRight = param8;
            Actor.dragChecker = param7;
            Actor.framelate = param3;
            Actor.container = param5;
            Actor.world = param1;
            Actor.box2dScale = param2;
            Actor.soundEffectMap = param9;
            return;
        }// end function

        public static function setNeutralWidth(param1:uint) : void
        {
            Actor.halfWidth = Math.floor(param1 / 2);
            return;
        }// end function

    }
}
