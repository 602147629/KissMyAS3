package process
{
    import flash.display.*;

    public class ProcessBase extends Sprite
    {
        protected var _bResourceLoadWait:Boolean = false;
        protected var _bTopbarButtonDisable:Boolean;

        public function ProcessBase()
        {
            return;
        }// end function

        public function get bResourceLoadWait() : Boolean
        {
            return this._bResourceLoadWait;
        }// end function

        public function set bResourceLoadWait(param1:Boolean) : void
        {
            this._bResourceLoadWait = param1;
            return;
        }// end function

        public function get bTopbarButtonDisable() : Boolean
        {
            return this._bTopbarButtonDisable;
        }// end function

        public function set bTopbarButtonDisable(param1:Boolean) : void
        {
            this._bTopbarButtonDisable = param1;
            return;
        }// end function

        public function init() : void
        {
            this._bTopbarButtonDisable = true;
            return;
        }// end function

        public function release() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = null;
            if (this.numChildren > 0)
            {
                _loc_1 = this.numChildren;
                _loc_2 = _loc_1 - 1;
                while (_loc_2 >= 0)
                {
                    
                    _loc_3 = this.getChildAt(_loc_2);
                    if (_loc_3.parent)
                    {
                        _loc_3.parent.removeChild(_loc_3);
                    }
                    _loc_2 = _loc_2 - 1;
                }
            }
            return;
        }// end function

        public function controlResourceWait() : void
        {
            return;
        }// end function

        public function control(param1:Number) : void
        {
            return;
        }// end function

    }
}
