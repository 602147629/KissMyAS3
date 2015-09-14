package enemy
{
    import effect.*;
    import flash.display.*;
    import flash.geom.*;
    import layer.*;

    public class EnemyDisplayAfterImage extends EnemyDisplay
    {
        private var _effectManager:EffectManager;
        private var _buraParent:Sprite;
        protected var _blurPow:Point;
        protected var _blurTime:Number;
        protected var _blurLiveTime:Number;
        protected var _blurVec:Point;
        protected var _blurColor:ColorTransform;
        protected var _blurEndColor:ColorTransform;
        protected var _blurScaleAdd:Number;
        protected var _bOldBlurPriority:Boolean = false;
        protected var _bBlurFront:Boolean;
        protected var _blendMode:String;

        public function EnemyDisplayAfterImage(param1:DisplayObjectContainer, param2:int, param3:int)
        {
            this._buraParent = new Sprite();
            super(param1, param2, param3);
            super._layer.getLayer(LayerCharacter.BACK_EFFECT).addChild(this._buraParent);
            this._blurPow = new Point(15, 10);
            this._blurTime = 0.2;
            this._blurLiveTime = 0.4;
            this._blurVec = new Point(0, -30);
            this._blurColor = new ColorTransform();
            this._blurEndColor = new ColorTransform();
            this._blurScaleAdd = 0;
            this._bOldBlurPriority = false;
            this._bBlurFront = false;
            this._blendMode = BlendMode.NORMAL;
            return;
        }// end function

        public function get blurPow() : Point
        {
            return this._blurPow;
        }// end function

        public function set blurPow(param1:Point) : void
        {
            this._blurPow = param1;
            return;
        }// end function

        public function get blurTime() : Number
        {
            return this._blurTime;
        }// end function

        public function set blurTime(param1:Number) : void
        {
            this._blurTime = param1;
            return;
        }// end function

        public function get blurLiveTime() : Number
        {
            return this._blurLiveTime;
        }// end function

        public function set blurLiveTime(param1:Number) : void
        {
            this._blurLiveTime = param1;
            return;
        }// end function

        public function get blurVec() : Point
        {
            return this._blurVec;
        }// end function

        public function set blurVec(param1:Point) : void
        {
            this._blurVec = param1;
            return;
        }// end function

        public function get blurColor() : ColorTransform
        {
            return this._blurColor;
        }// end function

        public function set blurColor(param1:ColorTransform) : void
        {
            this._blurColor = param1;
            return;
        }// end function

        public function get blurEndColor() : ColorTransform
        {
            return this._blurEndColor;
        }// end function

        public function set blurEndColor(param1:ColorTransform) : void
        {
            this._blurEndColor = param1;
            return;
        }// end function

        public function get blurScaleAdd() : Number
        {
            return this._blurScaleAdd;
        }// end function

        public function set blurScaleAdd(param1:Number) : void
        {
            this._blurScaleAdd = param1;
            return;
        }// end function

        public function get bBlurFront() : Boolean
        {
            return this._bBlurFront;
        }// end function

        public function set bBlurFront(param1:Boolean) : void
        {
            this._bBlurFront = param1;
            return;
        }// end function

        public function get blendMode() : String
        {
            return this._blendMode;
        }// end function

        public function set blendMode(param1:String) : void
        {
            this._blendMode = param1;
            return;
        }// end function

        public function setBlurEffect() : void
        {
            if (this._effectManager == null)
            {
                this._effectManager = new EffectManager();
            }
            var _loc_1:* = new EffectAfterImagePut(this._buraParent, _mc);
            _loc_1.setBlur(this._blurPow.x, this._blurPow.y);
            _loc_1.blurTime = this._blurTime;
            _loc_1.blurLiveTime = this._blurLiveTime;
            _loc_1.vec = this._blurVec.clone();
            _loc_1.scaleAdd = this._blurScaleAdd;
            _loc_1.colorTransform = this._blurColor;
            _loc_1.endColorTransform = this._blurEndColor;
            if (this._bBlurFront != this._bOldBlurPriority)
            {
                this.setLayerPriority(this._bBlurFront);
                this._bOldBlurPriority = this._bBlurFront;
            }
            _loc_1.blendMode = this._blendMode;
            this._effectManager.addEffect(_loc_1);
            return;
        }// end function

        override public function release() : void
        {
            super.release();
            if (this._effectManager)
            {
                this._effectManager.release();
            }
            this._effectManager = null;
            if (this._buraParent)
            {
                if (this._buraParent.parent)
                {
                    this._buraParent.parent.removeChild(this._buraParent);
                }
            }
            this._buraParent = null;
            return;
        }// end function

        override public function control(param1:Number) : void
        {
            super.control(param1);
            if (this._effectManager)
            {
                this._effectManager.control(param1);
            }
            return;
        }// end function

        public function clearBlurEffect() : void
        {
            if (this._effectManager)
            {
                this._effectManager.release();
                this._effectManager = null;
            }
            return;
        }// end function

        private function setLayerPriority(param1:Boolean) : void
        {
            if (this._buraParent)
            {
                if (this._buraParent.parent)
                {
                    this._buraParent.parent.removeChild(this._buraParent);
                }
                if (this._bBlurFront)
                {
                    super._layer.getLayer(LayerCharacter.FRONT_EFFECT).addChild(this._buraParent);
                }
                else
                {
                    super._layer.getLayer(LayerCharacter.BACK_EFFECT).addChild(this._buraParent);
                }
            }
            return;
        }// end function

    }
}
