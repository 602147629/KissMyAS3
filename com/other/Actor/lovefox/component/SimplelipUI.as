package lovefox.component
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;

    public class SimplelipUI extends Component
    {
        private var _bg:Sprite;
        private var _labelarr:Array;
        private var _select:Boolean = false;
        private var _rollflag:Boolean = false;
        private var _id:int = -1;
        private var _autoWidth:Boolean = false;

        public function SimplelipUI(param1:DisplayObjectContainer = null, param2:Number = 0, param3:Number = 0, param4:Number = 0)
        {
            if (param1 != null)
            {
                param1.addChild(this);
            }
            x = param2;
            y = param3;
            width = param4;
            this.initpanel();
            return;
        }// end function

        private function initpanel() : void
        {
            this._bg = new Sprite();
            this.addChild(this._bg);
            color = 16314584;
            this._labelarr = new Array();
            this.addEventListener(MouseEvent.ROLL_OVER, this.rollover);
            this.addEventListener(MouseEvent.ROLL_OUT, this.rollout);
            return;
        }// end function

        override public function draw() : void
        {
            super.draw();
            this._bg.graphics.clear();
            if (!enabled)
            {
                this._bg.graphics.beginFill(6710886, 0.5);
                this._bg.graphics.lineStyle(1, 13893609);
            }
            else if (this._select || this._rollflag)
            {
                this._bg.graphics.beginFill(7593153);
                this._bg.graphics.lineStyle(1, 8647893);
            }
            else
            {
                this._bg.graphics.beginFill(16314584, 1);
                this._bg.graphics.lineStyle(1, 16777215);
            }
            this._bg.graphics.drawRect(0, 0, _width, 22);
            this._bg.graphics.endFill();
            return;
        }// end function

        public function set label(param1:Array) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_2:* = 0;
            while (_loc_2 < this._labelarr.length)
            {
                
                if (this._labelarr[_loc_2].parent != null)
                {
                    this.removeChild(this._labelarr[_loc_2]);
                }
                _loc_2 = _loc_2 + 1;
            }
            this._labelarr = new Array();
            if (param1.length == 0)
            {
            }
            else if (param1.length == 1)
            {
                _loc_3 = new LabelUI(this, 5, 2, param1[0].str);
                _loc_3.x = (_width - _loc_3.width) / 2;
                if (param1[0].id != null)
                {
                    this._id = param1[0].id;
                }
                this._labelarr.push(_loc_3);
                if (this._autoWidth)
                {
                    this._bg.width = this._labelarr[0].width + 5;
                    this._bg.x = (width - this._bg.width) / 2;
                }
            }
            else
            {
                _loc_4 = 10;
                _loc_5 = 0;
                while (_loc_5 < param1.length)
                {
                    
                    _loc_6 = new LabelUI(this, _loc_4, 2, param1[_loc_5].str);
                    if (_loc_5 == 0)
                    {
                        _loc_6.x = _loc_4;
                        if (param1[0].id != null)
                        {
                            this._id = param1[0].id;
                        }
                        _loc_4 = _loc_4 + param1[_loc_5].len;
                    }
                    else
                    {
                        if (param1[_loc_5].len < _loc_6.width)
                        {
                            _loc_6.x = _loc_4;
                        }
                        else
                        {
                            _loc_6.x = _loc_4;
                        }
                        _loc_4 = _loc_4 + param1[_loc_5].len;
                    }
                    this._labelarr.push(_loc_6);
                    _loc_5 = _loc_5 + 1;
                }
            }
            return;
        }// end function

        public function changeLabel(param1:String, param2:int = 0) : void
        {
            this._labelarr[param2].text = param1;
            if (this._autoWidth && this._labelarr.length == 1)
            {
                this._bg.width = this._labelarr[0].width + 5;
                this._bg.x = (width - this._bg.width) / 2;
            }
            return;
        }// end function

        public function get select() : Boolean
        {
            return this._select;
        }// end function

        public function set select(param1:Boolean) : void
        {
            this._select = param1;
            this.draw();
            return;
        }// end function

        private function rollover(event:MouseEvent) : void
        {
            if (enabled)
            {
                this._rollflag = true;
                this.draw();
            }
            return;
        }// end function

        private function rollout(event:MouseEvent) : void
        {
            if (enabled)
            {
                this._rollflag = false;
                this.draw();
            }
            return;
        }// end function

        public function get id() : int
        {
            return this._id;
        }// end function

        public function set id(param1:int) : void
        {
            this._id = param1;
            return;
        }// end function

        public function get autoWidth() : Boolean
        {
            return this._autoWidth;
        }// end function

        public function set autoWidth(param1:Boolean) : void
        {
            this._autoWidth = param1;
            if (this._labelarr.length == 1)
            {
                if (param1)
                {
                    this._bg.width = this._labelarr[0].width + 5;
                    this._bg.x = (width - this._bg.width) / 2;
                }
            }
            return;
        }// end function

        public function set textColor(param1:int) : void
        {
            var _loc_2:* = 0;
            while (_loc_2 < this._labelarr.length)
            {
                
                this._labelarr[_loc_2].textColor = param1;
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

    }
}
