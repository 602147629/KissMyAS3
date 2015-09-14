package character
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import input.*;
    import layer.*;
    import utility.*;

    public class CharacterDisplayBase extends Object
    {
        private const _DARK_OUT:Number = 0.5;
        private const _DARK_OUT_TIME:Number = 0.2;
        private const _GRAY_SCALE_TIME:Number = 0.5;
        protected var _uniqueId:int;
        protected var _layer:LayerCharacter;
        protected var _backupParent:DisplayObjectContainer;
        protected var _backupPosition:Point;
        protected var _mc:MovieClip;
        protected var _bAnimationEnd:Boolean;
        private var _bDarkOut:Boolean;
        private var _darkOutColor:Number;
        private var _bGrayScale:Boolean;
        private var _grayScaleTime:Number;
        public static const TYPE_PLAYER:int = 0;
        public static const TYPE_ENEMY:int = 1;

        public function CharacterDisplayBase(param1:DisplayObjectContainer, param2:int)
        {
            this._mc = null;
            this._uniqueId = param2;
            this._layer = new LayerCharacter();
            if (param1 != null)
            {
                param1.addChild(this._layer);
            }
            this._bDarkOut = false;
            this._darkOutColor = 1;
            this._grayScaleTime = 0;
            return;
        }// end function

        public function get type() : int
        {
            return Constant.UNDECIDED;
        }// end function

        public function setAnimStay() : void
        {
            return;
        }// end function

        public function setAnimDamage() : void
        {
            return;
        }// end function

        public function setAnimDamageLoop() : void
        {
            return;
        }// end function

        public function setAnimDamageLoopRelease() : void
        {
            return;
        }// end function

        public function setAnimDamageDead() : void
        {
            return;
        }// end function

        public function setAnimDamageGuard() : void
        {
            return;
        }// end function

        public function setAnimCrouch() : void
        {
            return;
        }// end function

        public function setAnimDead() : void
        {
            return;
        }// end function

        public function setAnimAttack() : void
        {
            return;
        }// end function

        public function setAnimMagic() : void
        {
            return;
        }// end function

        public function setAnimBattleWait() : void
        {
            return;
        }// end function

        public function setAnimSelect() : void
        {
            return;
        }// end function

        public function setAnimSelectMagic() : void
        {
            return;
        }// end function

        public function setAnimSelected() : void
        {
            return;
        }// end function

        public function setAnimSelectedMagic() : void
        {
            return;
        }// end function

        public function setAnimSelectedGuard() : void
        {
            return;
        }// end function

        public function setAnimWin() : void
        {
            return;
        }// end function

        public function setAnimStatusUp() : void
        {
            return;
        }// end function

        public function setAnimSideDash() : void
        {
            return;
        }// end function

        public function setAnimSideDashMerge() : void
        {
            return;
        }// end function

        public function setAnimLost() : void
        {
            return;
        }// end function

        public function get uniqueId() : int
        {
            return this._uniqueId;
        }// end function

        public function get layer() : LayerCharacter
        {
            return this._layer;
        }// end function

        public function get backupPosition() : Point
        {
            return this._backupPosition.clone();
        }// end function

        public function get pos() : Point
        {
            return new Point(this._layer.x, this._layer.y);
        }// end function

        public function set pos(param1:Point) : void
        {
            this._layer.x = param1.x;
            this._layer.y = param1.y;
            return;
        }// end function

        public function get mc() : MovieClip
        {
            return this._mc;
        }// end function

        public function get bAnimationEnd() : Boolean
        {
            return this._bAnimationEnd;
        }// end function

        public function get effectNull() : MovieClip
        {
            return null;
        }// end function

        public function getEffectNullMatrix() : Matrix
        {
            return new Matrix();
        }// end function

        public function get faceNull() : MovieClip
        {
            return null;
        }// end function

        public function getfaceNullMatrix() : Matrix
        {
            return new Matrix();
        }// end function

        public function get bulletStartNullMc() : MovieClip
        {
            return null;
        }// end function

        public function getbulletStartNullMcMatrix() : Matrix
        {
            return new Matrix();
        }// end function

        public function set bDarkOut(param1:Boolean) : void
        {
            this._bDarkOut = param1;
            return;
        }// end function

        public function set bGrayScale(param1:Boolean) : void
        {
            this._bGrayScale = param1;
            return;
        }// end function

        public function release() : void
        {
            if (this._layer != null)
            {
                this._layer.release();
            }
            this._layer = null;
            if (this._mc != null)
            {
                if (this._mc.hasEventListener(Event.ENTER_FRAME))
                {
                    this._mc.removeEventListener(Event.ENTER_FRAME, this.cbEnterFrame);
                }
                if (this._mc.parent != null)
                {
                    this._mc.parent.removeChild(this._mc);
                }
            }
            this._mc = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            if (this._bDarkOut)
            {
                if (this._darkOutColor > this._DARK_OUT)
                {
                    this._darkOutColor = this._darkOutColor - this._DARK_OUT * (param1 / this._DARK_OUT_TIME);
                    if (this._darkOutColor < this._DARK_OUT)
                    {
                        this._darkOutColor = this._DARK_OUT;
                    }
                    this.setBgColorTransform(this._darkOutColor);
                }
            }
            else if (this._darkOutColor < 1)
            {
                this._darkOutColor = this._darkOutColor + 1 * (param1 / this._DARK_OUT_TIME);
                if (this._darkOutColor > 1)
                {
                    this._darkOutColor = 1;
                }
                this.setBgColorTransform(this._darkOutColor);
            }
            if (this._bGrayScale)
            {
                if (this._grayScaleTime < this._GRAY_SCALE_TIME)
                {
                    this._grayScaleTime = this._grayScaleTime + param1;
                    if (this._grayScaleTime > this._GRAY_SCALE_TIME)
                    {
                        this._grayScaleTime = this._GRAY_SCALE_TIME;
                    }
                    this._mc.filters = [ColorFilter.getGrayscaleAvg(this._grayScaleTime, this._GRAY_SCALE_TIME)];
                }
            }
            else if (this._grayScaleTime > 0)
            {
                this._grayScaleTime = this._grayScaleTime - param1;
                if (this._grayScaleTime < 0)
                {
                    this._grayScaleTime = 0;
                    this._mc.filters = [];
                }
                else
                {
                    this._mc.filters = [ColorFilter.getGrayscaleAvg(this._grayScaleTime, this._GRAY_SCALE_TIME)];
                }
            }
            return;
        }// end function

        private function setBgColorTransform(param1:Number) : void
        {
            this._mc.transform.colorTransform = new ColorTransform(param1, param1, param1);
            return;
        }// end function

        public function setAnimation(param1:String) : void
        {
            if (param1 == this._mc.currentLabel)
            {
                this._mc.gotoAndPlay(1);
            }
            this._mc.gotoAndPlay(param1);
            this._bAnimationEnd = false;
            return;
        }// end function

        public function backupParent() : void
        {
            this._backupParent = this._layer.parent;
            this._backupPosition = this.pos;
            return;
        }// end function

        public function returnParent() : void
        {
            if (this._backupParent == null)
            {
                return;
            }
            if (this._layer.parent)
            {
                this._layer.parent.removeChild(this._layer);
            }
            this._backupParent.addChild(this._layer);
            this._backupParent = null;
            this.pos = this._backupPosition;
            this._backupPosition = null;
            return;
        }// end function

        public function setReverse(param1:Boolean) : void
        {
            if (param1)
            {
                if (this._mc.scaleX > 0)
                {
                    this._mc.scaleX = this._mc.scaleX * -1;
                }
            }
            else if (this._mc.scaleX < 0)
            {
                this._mc.scaleX = this._mc.scaleX * -1;
            }
            return;
        }// end function

        public function isHitTest() : Boolean
        {
            var _loc_1:* = InputManager.getInstance().corsor;
            return this._mc.hitTestPoint(_loc_1.x, _loc_1.y);
        }// end function

        public function isHitTest2() : Boolean
        {
            var _loc_1:* = InputManager.getInstance().corsor;
            return HitTest.isObstructHitTest(this._mc, _loc_1.x, _loc_1.y);
        }// end function

        public function setTargetPoint(param1:Point, param2:Number) : void
        {
            this._layer.x = param1.x;
            this._layer.y = param1.y;
            return;
        }// end function

        protected function createResourceAfter() : void
        {
            this._mc.addEventListener(Event.ENTER_FRAME, this.cbEnterFrame);
            return;
        }// end function

        protected function cbEnterFrame(event:Event) : void
        {
            return;
        }// end function

    }
}
