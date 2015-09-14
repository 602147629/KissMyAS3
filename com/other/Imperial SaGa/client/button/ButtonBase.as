package button
{
    import flash.display.*;
    import sound.*;

    public class ButtonBase extends Object
    {
        public var _mc:MovieClip;
        protected var _mcHit:MovieClip;
        protected var _cbClickFunc:Function;
        protected var _cbOverFunc:Function;
        protected var _cbOutFunc:Function;
        protected var _bDisable:Boolean;
        protected var _bMouseOver:Boolean;
        protected var _id:int = -1;
        protected var _enterSeId:int;
        protected var _overSeId:int;
        protected var _bHitPixel:Boolean;
        protected var _sealCount:int;
        protected var _sealLabelChangeCount:int;
        private var _bSealDisable:Boolean;
        protected var _bDragBlock:Boolean;
        static const _LABEL_CLICK:String = "click";
        static const _LABEL_MOUSE_OVER:String = "onMouse";
        static const _LABEL_MOUSE_OUT:String = "offMouse";
        static const _LABEL_DISABLE:String = "disable";

        public function ButtonBase(param1:MovieClip, param2:Function, param3:Function = null, param4:Function = null)
        {
            this._mc = param1;
            this._mcHit = this._mc;
            this._cbClickFunc = param2;
            this._cbOverFunc = param3;
            this._cbOutFunc = param4;
            this._bMouseOver = false;
            this._enterSeId = Constant.UNDECIDED;
            this._overSeId = SE_SELECT_ID;
            this._bHitPixel = false;
            this._sealCount = 0;
            this._sealLabelChangeCount = 0;
            this._bSealDisable = false;
            this._bDragBlock = true;
            return;
        }// end function

        public function setHitMovieClip(param1:MovieClip) : void
        {
            this._mcHit = param1;
            return;
        }// end function

        public function get id() : int
        {
            return this._id;
        }// end function

        public function set enterSeId(param1:int) : void
        {
            this._enterSeId = param1;
            return;
        }// end function

        public function set overSeId(param1:int) : void
        {
            this._overSeId = param1;
            return;
        }// end function

        public function getMoveClip() : MovieClip
        {
            return this._mc;
        }// end function

        public function getHitMoveClip() : MovieClip
        {
            return this._mcHit;
        }// end function

        public function isEnable() : Boolean
        {
            return this._bDisable == false && !this.isSealed();
        }// end function

        public function setId(param1:int) : void
        {
            this._id = param1;
            return;
        }// end function

        public function set bHitPixel(param1:Boolean) : void
        {
            this._bHitPixel = param1;
            return;
        }// end function

        public function isSealed() : Boolean
        {
            return this._sealCount > 0;
        }// end function

        public function sealDisable(param1:Boolean) : void
        {
            this._bSealDisable = param1;
            return;
        }// end function

        public function isDragBlock() : Boolean
        {
            return this._bDragBlock && this.isEnable();
        }// end function

        public function release() : void
        {
            if (this._mc)
            {
                if (this._mc.parent)
                {
                    this._mc.parent.removeChild(this._mc);
                }
            }
            this._mc = null;
            this._mcHit = null;
            return;
        }// end function

        public function reset() : void
        {
            this.labelChange(_LABEL_MOUSE_OUT);
            this._bMouseOver = false;
            this._sealCount = 0;
            this._sealLabelChangeCount = 0;
            this._bSealDisable = false;
            return;
        }// end function

        public function isHit(param1:Number, param2:Number) : Boolean
        {
            return this._mcHit.hitTestPoint(param1, param2, this._bHitPixel);
        }// end function

        public function setClick() : void
        {
            this.labelChange(_LABEL_CLICK);
            if (this._enterSeId != Constant.UNDECIDED)
            {
                SoundManager.getInstance().playSe(this._enterSeId);
            }
            if (this._cbClickFunc != null)
            {
                this._cbClickFunc(this._id);
            }
            return;
        }// end function

        public function setMouseOver() : void
        {
            if (this._bMouseOver == false && this._bDisable == false)
            {
                if (this._overSeId != Constant.UNDECIDED)
                {
                    SoundManager.getInstance().playSe(this._overSeId);
                }
                this.labelChange(_LABEL_MOUSE_OVER);
                if (this._cbOverFunc != null)
                {
                    this._cbOverFunc(this._id);
                }
            }
            this._bMouseOver = true;
            return;
        }// end function

        public function setMouseOut() : void
        {
            if (this._bMouseOver == true && this._bDisable == false)
            {
                this.labelChange(_LABEL_MOUSE_OUT);
                if (this._cbOutFunc != null)
                {
                    this._cbOutFunc(this._id);
                }
            }
            this._bMouseOver = false;
            return;
        }// end function

        public function setMouseDown() : void
        {
            return;
        }// end function

        public function setMouseUp() : void
        {
            return;
        }// end function

        public function setDisable(param1:Boolean) : void
        {
            if (param1)
            {
                this.labelChange(_LABEL_DISABLE);
                this._bDisable = true;
            }
            else
            {
                if (this._sealLabelChangeCount == 0)
                {
                    this.labelChange(_LABEL_MOUSE_OUT);
                }
                this._bDisable = false;
            }
            this._bMouseOver = false;
            return;
        }// end function

        public function setDisableFlag(param1:Boolean) : void
        {
            if (param1)
            {
                this._bDisable = true;
            }
            else
            {
                this._bDisable = false;
            }
            return;
        }// end function

        public function getDisableFlag() : Boolean
        {
            return this._bDisable;
        }// end function

        public function setVisible(param1:Boolean) : void
        {
            this.setDisable(param1 == false);
            if (this._mc)
            {
                this._mc.visible = param1;
            }
            return;
        }// end function

        public function seal(param1:Boolean = false) : void
        {
            if (this._bSealDisable)
            {
                return;
            }
            var _loc_2:* = this;
            var _loc_3:* = this._sealCount + 1;
            _loc_2._sealCount = _loc_3;
            if (param1)
            {
                var _loc_2:* = this;
                var _loc_3:* = this._sealLabelChangeCount + 1;
                _loc_2._sealLabelChangeCount = _loc_3;
                this.labelChange(_LABEL_DISABLE);
            }
            if (this._bMouseOver)
            {
                this.labelChange(_LABEL_MOUSE_OUT);
            }
            this._bMouseOver = false;
            return;
        }// end function

        public function unseal(param1:Boolean = false) : void
        {
            if (this._sealCount > 0)
            {
                var _loc_2:* = this;
                var _loc_3:* = this._sealCount - 1;
                _loc_2._sealCount = _loc_3;
                if (param1)
                {
                    var _loc_2:* = this;
                    var _loc_3:* = this._sealLabelChangeCount - 1;
                    _loc_2._sealLabelChangeCount = _loc_3;
                }
                if (this._sealLabelChangeCount == 0 && !this._bDisable)
                {
                    this.labelChange(_LABEL_MOUSE_OUT);
                }
            }
            return;
        }// end function

        protected function labelChange(param1:String) : void
        {
            if (this._mc)
            {
                this._mc.gotoAndStop(param1);
            }
            return;
        }// end function

        public static function get SE_DECIDE_ID() : int
        {
            return SoundId.SE_SELECT;
        }// end function

        public static function get SE_CANCEL_ID() : int
        {
            return SoundId.SE_CANCEL;
        }// end function

        public static function get SE_CURSOR_ID() : int
        {
            return SoundId.SE_RS3_SYSTEM_CURSOR;
        }// end function

        public static function get SE_SELECT_ID() : int
        {
            return SoundId.SE_BED;
        }// end function

    }
}
