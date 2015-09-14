package window
{
    import flash.display.*;
    import flash.geom.*;
    import flash.text.*;
    import message.*;
    import resource.*;

    public class WindowText extends WindowItemBase
    {
        private var _textMc:MovieClip;
        private var _textControl:TextControl;
        private var _adjust:int;
        private var _scale:Number;
        private var _width:Number;
        private var _textSize:Number;
        public static const CENTER:int = 0;
        public static const LEFT:int = 1;
        public static const RIGHT:int = 2;

        public function WindowText(param1:String, param2:Number = 1)
        {
            this._scale = param2;
            this._adjust = LEFT;
            this.createtextMc(param1);
            return;
        }// end function

        public function setText(param1:String) : void
        {
            this.createtextMc(param1);
            return;
        }// end function

        override public function setWidth(param1:Number) : void
        {
            super.setWidth(param1);
            switch(this._adjust)
            {
                case CENTER:
                {
                    this._textMc.x = (param1 - this.getOrgSize().x) / 2;
                    break;
                }
                case LEFT:
                {
                    this._textMc.x = 0;
                    break;
                }
                case RIGHT:
                {
                    this._textMc.x = param1 - this.getOrgSize().x;
                    break;
                }
                default:
                {
                    break;
                }
            }
            this._width = param1;
            return;
        }// end function

        override public function getOrgSize() : Point
        {
            var _loc_1:* = _size.clone();
            _loc_1.x = this._textControl.getWidth();
            return _loc_1;
        }// end function

        private function createtextMc(param1:String) : void
        {
            var _loc_2:* = new MovieClip();
            var _loc_3:* = param1.split("\n");
            if (this._textMc == null)
            {
                _loc_2 = ResourceManager.getInstance().createMovieClip(ResourceManager.EMBED_COMMON_WINDOW, "textWindow");
                this._textSize = _loc_2.textMc.defaultTextFormat.size;
            }
            else
            {
                _loc_2 = this._textMc;
            }
            var _loc_4:* = _loc_2.textMc.defaultTextFormat;
            _loc_2.textMc.defaultTextFormat.size = Math.ceil(int(this._textSize) * this._scale);
            _loc_2.textMc.defaultTextFormat = _loc_4;
            this._textControl = new TextControl(_loc_2.textMc);
            if (this._textControl.setText(param1))
            {
                _size.x = this._textControl.getWidth();
                _size.y = _loc_4.size + _loc_4.leading;
                _size.y = this._textControl.getHeigth();
                _loc_2.textMc.width = 0;
                _loc_2.textMc.height = _size.y;
            }
            this._textMc = _loc_2;
            addChild(this._textMc);
            this.setWidth(this._width);
            return;
        }// end function

    }
}
