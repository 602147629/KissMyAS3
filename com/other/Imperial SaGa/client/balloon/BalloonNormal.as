package balloon
{
    import flash.display.*;
    import flash.geom.*;
    import message.*;
    import resource.*;

    public class BalloonNormal extends Object
    {
        private var _bEnable:Boolean;
        private var _bMouseOver:Boolean;
        private var _parent:DisplayObjectContainer;
        private var _mcHit:DisplayObjectContainer;
        private var _mcPos:DisplayObjectContainer;
        private var _mcBalloon:MovieClip;
        private var _balloonLabel:String;
        private var _balloonMessage:String;
        private var _bSetPos:Boolean;
        public static const TYPE_SMALLS_U1:String = "smallS_u1";
        public static const TYPE_SMALLS_D1:String = "smallS_d1";
        public static const TYPE_SMALLS_R1:String = "smallS_r1";
        public static const TYPE_SMALLS_L1:String = "smallS_l1";
        public static const TYPE_SMALL_U1:String = "small_u1";
        public static const TYPE_SMALL_U2:String = "small_u2";
        public static const TYPE_SMALL_D1:String = "small_d1";
        public static const TYPE_SMALL_D2:String = "small_d2";
        public static const TYPE_SMALL_R1:String = "small_r1";
        public static const TYPE_SMALL_R2:String = "small_r2";
        public static const TYPE_SMALL_L1:String = "small_l1";
        public static const TYPE_SMALL_L2:String = "small_l2";
        public static const TYPE_SMALLB_U1:String = "smallB_u1";
        public static const TYPE_SMALLB_U2:String = "smallB_u2";
        public static const TYPE_SMALLB_D1:String = "smallB_d1";
        public static const TYPE_SMALLB_D2:String = "smallB_d2";
        public static const TYPE_SMALLB_R1:String = "smallB_r1";
        public static const TYPE_SMALLB_R2:String = "smallB_r2";
        public static const TYPE_SMALLB_L1:String = "smallB_l1";
        public static const TYPE_SMALLB_L2:String = "smallB_l2";
        public static const TYPE_MIDDLE_U1:String = "middle_u1";
        public static const TYPE_MIDDLE_U2:String = "middle_u2";
        public static const TYPE_MIDDLE_D1:String = "middle_d1";
        public static const TYPE_MIDDLE_D2:String = "middle_d2";
        public static const TYPE_MIDDLE_R1:String = "middle_r1";
        public static const TYPE_MIDDLE_R2:String = "middle_r2";
        public static const TYPE_MIDDLE_L1:String = "middle_l1";
        public static const TYPE_MIDDLE_L2:String = "middle_l2";
        public static const TYPE_LARGE_U1:String = "large_u1";
        public static const TYPE_LARGE_U2:String = "large_u2";
        public static const TYPE_LARGE_U3:String = "large_u3";
        public static const TYPE_LARGE_D1:String = "large_d1";
        public static const TYPE_LARGE_D2:String = "large_d2";
        public static const TYPE_LARGE_D3:String = "large_d3";
        public static const TYPE_LARGE_R1:String = "large_r1";
        public static const TYPE_LARGE_R2:String = "large_r2";
        public static const TYPE_LARGE_R3:String = "large_r3";
        public static const TYPE_LARGE_L1:String = "large_l1";
        public static const TYPE_LARGE_L2:String = "large_l2";
        public static const TYPE_LARGE_L3:String = "large_l3";
        private static const _STR_SPACE:String = "　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　";
        private static const _LEN_SPACE:int = _STR_SPACE.length;

        public function BalloonNormal(param1:DisplayObjectContainer, param2:DisplayObjectContainer, param3:DisplayObjectContainer, param4:String = null)
        {
            this._parent = param1;
            this._mcHit = param2;
            this._mcPos = param3;
            this._balloonMessage = null;
            this._bEnable = true;
            this._bSetPos = false;
            this._mcBalloon = ResourceManager.getInstance().createMovieClip(ResourcePath.COMMON_DATA_PATH + "UI_Balloon.swf", "BalloonMc");
            this.updatePosition();
            if (this._mcPos is MovieClip)
            {
                this.setTypeLabel((this._mcPos as MovieClip).currentLabel);
            }
            else
            {
                this.setTypeLabel(TYPE_SMALLS_U1);
            }
            this.setMouseSwitch(false);
            this.setMessage(param4);
            return;
        }// end function

        public function get bEnable() : Boolean
        {
            return this._bEnable;
        }// end function

        public function set bEnable(param1:Boolean) : void
        {
            this._bEnable = param1;
            if (this._bEnable == false)
            {
                this._bMouseOver = false;
            }
            return;
        }// end function

        public function get bMouseOver() : Boolean
        {
            return this._bMouseOver;
        }// end function

        public function getHitObject() : DisplayObjectContainer
        {
            return this._mcHit;
        }// end function

        private function updatePosition() : void
        {
            var _loc_1:* = this._parent.transform.concatenatedMatrix.clone();
            var _loc_2:* = this._mcPos.transform.concatenatedMatrix.clone();
            _loc_1.invert();
            _loc_2.concat(_loc_1);
            this._mcBalloon.x = _loc_2.tx;
            this._mcBalloon.y = _loc_2.ty;
            return;
        }// end function

        public function release() : void
        {
            if (this._mcBalloon && this._mcBalloon.parent)
            {
                this._mcBalloon.parent.removeChild(this._mcBalloon);
            }
            this._mcBalloon = null;
            this._mcPos = null;
            this._mcHit = null;
            this._parent = null;
            return;
        }// end function

        public function setPos(param1:Point) : void
        {
            this._mcBalloon.x = param1.x;
            this._mcBalloon.y = param1.y;
            this._bSetPos = true;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            if (this._bSetPos)
            {
                return;
            }
            this.updatePosition();
            return;
        }// end function

        public function isHitTargetPos(param1:Point) : Boolean
        {
            if (this._bEnable == false)
            {
                return false;
            }
            return this._mcHit.hitTestPoint(param1.x, param1.y);
        }// end function

        public function setMouseOver(param1:Boolean) : void
        {
            if (this._bMouseOver != param1)
            {
                this.setMouseSwitch(param1);
            }
            return;
        }// end function

        public function setClose() : void
        {
            this.setMouseSwitch(false);
            return;
        }// end function

        private function setMouseSwitch(param1:Boolean) : void
        {
            this._bMouseOver = param1;
            if (this._mcBalloon.parent)
            {
                this._mcBalloon.parent.removeChild(this._mcBalloon);
            }
            if (param1)
            {
                this._parent.addChild(this._mcBalloon);
            }
            return;
        }// end function

        public function setMessage(param1:String) : void
        {
            if (this._balloonMessage != param1)
            {
                this._balloonMessage = param1;
                this.updateMessage();
            }
            return;
        }// end function

        public function setBalloonType(param1:String) : void
        {
            this.setTypeLabel(param1);
            this.updateMessage();
            return;
        }// end function

        private function setTypeLabel(param1:String) : void
        {
            this._balloonLabel = param1;
            this._mcBalloon.gotoAndStop(this._balloonLabel);
            return;
        }// end function

        private function updateMessage() : void
        {
            var _loc_3:* = 0;
            var _loc_5:* = null;
            if (this._balloonMessage == null)
            {
                return;
            }
            var _loc_1:* = this._balloonMessage.split("\n");
            var _loc_2:* = _loc_1.length;
            var _loc_4:* = 0;
            for each (_loc_5 in _loc_1)
            {
                
                if (_loc_4 < _loc_5.length)
                {
                    _loc_4 = _loc_5.length;
                }
            }
            _loc_3 = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_1[_loc_3] = _loc_1[_loc_3] + this.addSpace(_loc_4 - _loc_1[_loc_3].length);
                _loc_3++;
            }
            this._balloonMessage = _loc_1.join("\n");
            TextControl.setText(this._mcBalloon.TextMc.TextDt, this._balloonMessage);
            return;
        }// end function

        private function addSpace(param1:int) : String
        {
            var _loc_2:* = "";
            while (param1 > 0)
            {
                
                if (param1 >= _LEN_SPACE)
                {
                    _loc_2 = _loc_2 + _STR_SPACE;
                    param1 = param1 - _LEN_SPACE;
                    continue;
                }
                _loc_2 = _loc_2 + _STR_SPACE.substr(0, param1);
                param1 = 0;
            }
            return _loc_2;
        }// end function

    }
}
