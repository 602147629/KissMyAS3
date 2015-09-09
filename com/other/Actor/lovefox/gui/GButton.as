package lovefox.gui
{
    import flash.display.*;

    public class GButton extends Sprite
    {
        private var _group:String;
        private var _normalBmp:Bitmap;
        private var _hoverBmp:Bitmap;
        private var _vary:int;
        private var _hover:Boolean;
        private var _hoverTextColor:Object;
        private var _normalTextColor:Object;
        private var _title:Object;
        private var _index:Object;
        private var _mode:uint = 0;
        private var _initNBmpd:Object;
        private var _initHBmpd:Object;
        private var labelstr:String = "";
        public static var BUTTON_MODE:Object = 0;
        public static var CHECKBOX_MODE:Object = 1;
        public static var RADIOBUTTON_MODE:Object = 2;
        private static var _radioGroup:Object = {};
        private static var _radioSelected:Object = {};

        public function GButton(param1)
        {
            this._initNBmpd = BitmapLoader.pick(param1.normal.dir);
            this._initHBmpd = BitmapLoader.pick(param1.hover.dir);
            this._normalBmp = new Bitmap(this._initNBmpd.clone());
            this._hoverBmp = new Bitmap(this._initHBmpd.clone());
            this._hoverBmp.alpha = 0;
            addChild(this._normalBmp);
            addChild(this._hoverBmp);
            this._vary = Number(param1.vary);
            this._hoverTextColor = Number(param1.hoverTextColor);
            this._normalTextColor = Number(param1.normalTextColor);
            addEventListener(MouseEvent.ROLL_OVER, this.handleMouseOver);
            addEventListener(MouseEvent.ROLL_OUT, this.handleMouseOut);
            addEventListener(MouseEvent.CLICK, this.handleClick);
            buttonMode = true;
            return;
        }// end function

        private function handleClick(param1)
        {
            var _loc_2:* = undefined;
            if (this._mode == 1)
            {
                this.hover = !this.hover;
            }
            else if (this._mode == 2)
            {
                _loc_2 = 0;
                while (_loc_2 < _radioGroup[this._group].length)
                {
                    
                    if (_radioGroup[this._group][_loc_2] != this)
                    {
                        _radioGroup[this._group][_loc_2].hover = false;
                    }
                    _loc_2 = _loc_2 + 1;
                }
                _radioSelected[this._group] = this;
                this.hover = true;
            }
            return;
        }// end function

        public function set mode(param1)
        {
            this._mode = param1;
            return;
        }// end function

        public function set label(param1)
        {
            this.labelstr = param1;
            this._normalBmp.bitmapData.dispose();
            this._hoverBmp.bitmapData.dispose();
            var _loc_2:* = Text2Bitmap.toBmp(param1, this._normalTextColor);
            var _loc_3:* = Text2Bitmap.toBmp(param1, this._hoverTextColor);
            var _loc_4:* = (width - _loc_2.width) / 2;
            var _loc_5:* = (height - _loc_2.height) / 2;
            this._normalBmp.bitmapData = this._initNBmpd.clone();
            this._hoverBmp.bitmapData = this._initHBmpd.clone();
            this._normalBmp.bitmapData.copyPixels(_loc_2, _loc_2.rect, new Point(_loc_4, _loc_5), null, null, true);
            this._hoverBmp.bitmapData.copyPixels(_loc_3, _loc_3.rect, new Point(_loc_4, (_loc_5 + 1)), null, null, true);
            _loc_2.dispose();
            _loc_3.dispose();
            return;
        }// end function

        public function get label() : String
        {
            return this.labelstr;
        }// end function

        public function set index(param1)
        {
            this._index = param1;
            return;
        }// end function

        public function get index()
        {
            return this._index;
        }// end function

        public function set title(param1)
        {
            this._title = param1;
            return;
        }// end function

        public function get title()
        {
            return this._title;
        }// end function

        public function set selected(param1)
        {
            var _loc_2:* = undefined;
            if (this._mode == 1)
            {
                this.hover = param1;
            }
            else if (this._mode == 2)
            {
                if (param1)
                {
                    _loc_2 = 0;
                    while (_loc_2 < _radioGroup[this._group].length)
                    {
                        
                        if (_radioGroup[this._group][_loc_2] != this)
                        {
                            _radioGroup[this._group][_loc_2].hover = false;
                        }
                        _loc_2 = _loc_2 + 1;
                    }
                    _radioSelected[this._group] = this;
                    this.hover = true;
                }
                else if (_radioSelected[this._group] == this)
                {
                    _radioSelected[this._group] = null;
                    this.hover = false;
                }
            }
            return;
        }// end function

        public function get selected()
        {
            return this._hover;
        }// end function

        public function get hover()
        {
            return this._hover;
        }// end function

        public function set hover(param1)
        {
            if (this._hover != param1)
            {
                this._hover = param1;
                removeEventListener(Event.ENTER_FRAME, this.handleEnterFrame);
                addEventListener(Event.ENTER_FRAME, this.handleEnterFrame);
            }
            return;
        }// end function

        public function set radioGroup(param1)
        {
            var _loc_2:* = undefined;
            if (this._group != null)
            {
                _loc_2 = 0;
                while (_loc_2 < _radioGroup[this._group].length)
                {
                    
                    if (_radioGroup[this._group][_loc_2] == this)
                    {
                        _radioGroup[this._group].splice(_loc_2, 1);
                        break;
                    }
                    _loc_2 = _loc_2 + 1;
                }
                if (_radioGroup[this._group].length == 0)
                {
                    _radioGroup[this._group] = null;
                    _radioSelected[this._group] = null;
                }
            }
            this._group = param1;
            if (_radioGroup[param1] == null)
            {
                _radioGroup[param1] = [];
            }
            _radioGroup[param1].push(this);
            return;
        }// end function

        public function destroy()
        {
            this._normalBmp.bitmapData.dispose();
            this._hoverBmp.bitmapData.dispose();
            removeEventListener(MouseEvent.ROLL_OVER, this.handleMouseOver);
            removeEventListener(MouseEvent.ROLL_OUT, this.handleMouseOut);
            if (this._vary > 1)
            {
                removeEventListener(Event.ENTER_FRAME, this.handleEnterFrame);
            }
            return;
        }// end function

        private function handleEnterFrame(param1)
        {
            if (this._hover)
            {
                this._hoverBmp.alpha = this._hoverBmp.alpha + 1 / this._vary;
                if (this._hoverBmp.alpha >= 1)
                {
                    removeEventListener(Event.ENTER_FRAME, this.handleEnterFrame);
                }
            }
            else
            {
                this._hoverBmp.alpha = this._hoverBmp.alpha - 1 / this._vary;
                if (this._hoverBmp.alpha <= 0)
                {
                    removeEventListener(Event.ENTER_FRAME, this.handleEnterFrame);
                }
            }
            return;
        }// end function

        private function handleMouseOver(param1)
        {
            if (this._mode != 1)
            {
                if (this._vary > 1)
                {
                    this.hover = true;
                }
            }
            Config.buttonLock = true;
            return;
        }// end function

        private function handleMouseOut(param1)
        {
            if (this._mode == 0)
            {
                if (this._vary > 1)
                {
                    this.hover = false;
                }
            }
            else if (this._mode == 2)
            {
                if (_radioSelected[this._group] != this)
                {
                    if (this._vary > 1)
                    {
                        this.hover = false;
                    }
                }
            }
            Config.buttonLock = false;
            return;
        }// end function

    }
}
