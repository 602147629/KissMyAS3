package lovefox.gameUI
{
    import flash.display.*;

    public class ButtonSlot extends Slot
    {
        public var _icon:Bitmap;
        public var _effect:Sprite;
        public var _effectBmp:Bitmap;
        protected var _data:Object;

        public function ButtonSlot(param1)
        {
            super(0, param1);
            this.init();
            return;
        }// end function

        override public function init()
        {
            super.init();
            _container.x = 0;
            _container.y = 0;
            _cdShape.x = _container.x;
            _cdShape.y = _container.y;
            this._icon = new Bitmap();
            _container.addChild(this._icon);
            return;
        }// end function

        public function setEffect(param1, param2, param3)
        {
            if (this._effect == null)
            {
                this._effect = new Sprite();
                addChild(this._effect);
                this._effectBmp = new Bitmap();
                this._effect.addChild(this._effectBmp);
            }
            this._effectBmp.bitmapData = Config.findIcon(param1, param2, param3);
            this._effect.x = _size / 2;
            this._effect.y = _size;
            var _loc_4:* = 0.2;
            this._effect.scaleY = 0.2;
            this._effect.scaleX = _loc_4;
            this._effectBmp.x = (-this._effectBmp.width) / 2;
            this._effectBmp.y = (-this._effectBmp.height) / 2;
            this._effectBmp.bitmapData = Config.findIcon(param1, param2, param3);
            TweenLite.to(this._effect, 0.4, {scaleX:1, scaleY:1, y:_size / 2, ease:Back.easeOut});
            return;
        }// end function

        public function clearEffect()
        {
            if (this._effect != null)
            {
                if (this._effectBmp.bitmapData != null)
                {
                    this._effectBmp.bitmapData.dispose();
                    this._effectBmp.bitmapData = null;
                }
            }
            return;
        }// end function

        public function setIcon(param1, param2 = false, param3 = 32, param4 = 32)
        {
            if (this._icon.bitmapData != null)
            {
                this._icon.bitmapData.dispose();
            }
            if (!param2)
            {
                this.buttonMode = true;
            }
            if (param1 != null)
            {
                this._icon.bitmapData = Config.findIcon(param1, param3, param4);
                this._icon.x = int((_size - this._icon.width) / 2);
                this._icon.y = int((_size - this._icon.height) / 2);
            }
            return;
        }// end function

        public function set data(param1:Object) : void
        {
            this._data = param1;
            return;
        }// end function

        public function get data() : Object
        {
            return this._data;
        }// end function

    }
}
