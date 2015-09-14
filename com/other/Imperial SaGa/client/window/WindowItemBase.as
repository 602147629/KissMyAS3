package window
{
    import flash.display.*;
    import flash.geom.*;

    public class WindowItemBase extends Sprite
    {
        protected var _size:Point;
        protected var _bEnable:Boolean;
        protected var _bMask:Boolean;
        protected var _bSingleHorz:Boolean;
        protected var _windowBase:WindowBase;

        public function WindowItemBase()
        {
            this._bEnable = true;
            this._bMask = true;
            this._bSingleHorz = true;
            this._size = new Point();
            return;
        }// end function

        public function release() : void
        {
            this._windowBase = null;
            return;
        }// end function

        public function control() : void
        {
            if (this._bEnable)
            {
                this.itemControl();
            }
            return;
        }// end function

        public function enble(param1:Boolean) : void
        {
            if (this._bEnable != param1)
            {
                this._bEnable = param1;
            }
            return;
        }// end function

        public function setWidth(param1:Number) : void
        {
            return;
        }// end function

        public function getOrgSize() : Point
        {
            return this._size;
        }// end function

        public function setWindowBase(param1:WindowBase) : void
        {
            this._windowBase = param1;
            return;
        }// end function

        public function isEnable() : Boolean
        {
            return this._bEnable;
        }// end function

        public function get size() : Point
        {
            return this._size;
        }// end function

        public function get bMask() : Boolean
        {
            return this._bMask;
        }// end function

        public function get bSingleHorz() : Boolean
        {
            return this._bSingleHorz;
        }// end function

        protected function itemControl() : void
        {
            return;
        }// end function

        protected function updateLabel(param1:Boolean) : void
        {
            return;
        }// end function

    }
}
