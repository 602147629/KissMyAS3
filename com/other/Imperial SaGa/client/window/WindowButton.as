package window
{
    import button.*;
    import flash.display.*;
    import flash.geom.*;
    import message.*;
    import resource.*;

    public class WindowButton extends WindowItemBase
    {
        private var _buttonMc:MovieClip;
        private var _button:ButtonBase;
        private var _cbClick:Function;
        private var _posType:int;
        private var _pos:Point;
        public static const POS_DEFAULT:int = 0;
        public static const POS_LEFT:int = 1;
        public static const POS_RIGHT:int = 2;
        public static const POS_SETTING:int = 3;

        public function WindowButton(param1:String, param2:Function, param3:int = 0)
        {
            this._cbClick = param2;
            this._posType = param3;
            this.init();
            this.setText(param1);
            return;
        }// end function

        override public function release() : void
        {
            super.release();
            if (this._buttonMc && this._buttonMc.parent)
            {
                this._buttonMc.parent.removeChild(this._buttonMc);
            }
            this._buttonMc = null;
            ButtonManager.getInstance().removeButton(this._button);
            return;
        }// end function

        public function get pos() : Point
        {
            return this._pos;
        }// end function

        public function set pos(param1:Point) : void
        {
            this._pos = param1.clone();
            return;
        }// end function

        private function init() : void
        {
            this._pos = new Point();
            _bMask = false;
            this._buttonMc = ResourceManager.getInstance().createMovieClip(ResourceManager.EMBED_COMMON_WINDOW, "windowButton");
            addChild(this._buttonMc);
            this._button = new ButtonBase(this._buttonMc, this.cbButtonClick);
            this._button.enterSeId = ButtonBase.SE_DECIDE_ID;
            ButtonManager.getInstance().addButtonBase(this._button);
            return;
        }// end function

        override public function setWidth(param1:Number) : void
        {
            this.updateButton();
            return;
        }// end function

        private function setText(param1:String) : void
        {
            TextControl.setText(this._buttonMc.textMc.textDt, param1);
            return;
        }// end function

        private function updateButton() : void
        {
            var _loc_1:* = null;
            if (_windowBase)
            {
                _loc_1 = this._pos.clone();
                switch(this._posType)
                {
                    case POS_DEFAULT:
                    {
                        _loc_1.x = _windowBase.size.x / 2;
                        _loc_1.y = _windowBase.size.y;
                        break;
                    }
                    case POS_LEFT:
                    {
                        _loc_1.x = _windowBase.size.x / 16 * 5;
                        _loc_1.y = _windowBase.size.y;
                        break;
                    }
                    case POS_RIGHT:
                    {
                        _loc_1.x = _windowBase.size.x / 16 * 11;
                        _loc_1.y = _windowBase.size.y;
                        break;
                    }
                    case POS_SETTING:
                    {
                        _loc_1 = this._buttonMc.globalToLocal(this._pos);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                this.x = _loc_1.x;
                this.y = _loc_1.y;
                this._buttonMc.x = 0;
                this._buttonMc.y = 0;
            }
            return;
        }// end function

        private function cbButtonClick(param1:int) : void
        {
            this._cbClick();
            _windowBase.close();
            return;
        }// end function

    }
}
