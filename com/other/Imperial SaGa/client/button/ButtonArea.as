package button
{
    import flash.display.*;

    public class ButtonArea extends Object
    {
        protected var _aButton:Array;
        protected var _mcHit:MovieClip;
        protected var _bEnable:Boolean;

        public function ButtonArea(param1:MovieClip)
        {
            this._mcHit = param1;
            this._aButton = [];
            this._bEnable = true;
            return;
        }// end function

        public function setHitMovieClip(param1:MovieClip) : void
        {
            this._mcHit = param1;
            return;
        }// end function

        public function isEnable() : Boolean
        {
            return this._bEnable;
        }// end function

        public function setEnable(param1:Boolean) : void
        {
            this._bEnable = param1;
            return;
        }// end function

        public function release() : void
        {
            this._aButton = null;
            this._mcHit = null;
            return;
        }// end function

        public function isHit(param1:Number, param2:Number) : Boolean
        {
            return this._mcHit.hitTestPoint(param1, param2, true);
        }// end function

        public function hasButton(param1:ButtonBase) : Boolean
        {
            return this._aButton.indexOf(param1) >= 0;
        }// end function

        public function addButton(param1:ButtonBase) : void
        {
            var _loc_2:* = this._aButton.indexOf(param1);
            if (_loc_2 < 0)
            {
                this._aButton.push(param1);
            }
            return;
        }// end function

        public function removeButton(param1:ButtonBase) : void
        {
            var _loc_2:* = this._aButton.indexOf(param1);
            if (_loc_2 >= 0)
            {
                this._aButton.splice(_loc_2, 1);
            }
            return;
        }// end function

    }
}
