package lovefox.gui
{
    import flash.display.*;
    import flash.text.*;

    public class Laba extends Sprite
    {
        private var _letterWidth:int = 16;
        private var _letterHeight:int = 32;
        private var _letterColor:int = 16777215;
        private var _mask:Shape;
        private var _letterLayer:Sprite;
        private var _letters:Array;
        private var _tfs1:Array;
        private var _tfs2:Array;
        private var _moveMap:Object;
        private var _looping:Boolean = false;
        private var _buff:Object;
        private var _maxNum:Object = 0;
        private var _fontSize:int = 32;

        public function Laba()
        {
            this._letters = [];
            this._tfs1 = [];
            this._tfs2 = [];
            this._moveMap = {};
            mouseChildren = false;
            mouseEnabled = false;
            this.init();
            return;
        }// end function

        private function init()
        {
            this._mask = new Shape();
            this._letterLayer = new Sprite();
            addChild(this._letterLayer);
            addChild(this._mask);
            this._letterLayer.mask = this._mask;
            return;
        }// end function

        public function setLetter(param1:String)
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            if (this._looping)
            {
                this._buff = param1;
            }
            else
            {
                this._buff = null;
                _loc_2 = param1.split("");
                if (_loc_2.length != this._letters.length)
                {
                    this._maxNum = Math.max(_loc_2.length, this._maxNum);
                    this._mask.graphics.clear();
                    this._mask.graphics.beginFill(16711680, 1);
                    this._mask.graphics.drawRect((-this._letterWidth) * this._maxNum, 0, this._letterWidth * this._maxNum + 5, this._letterHeight);
                }
                this._moveMap = {};
                _loc_5 = 0;
                while (_loc_5 < this._maxNum)
                {
                    
                    _loc_3 = (_loc_2.length - 1) - _loc_5;
                    _loc_4 = (this._letters.length - 1) - _loc_5;
                    if (this._tfs1[_loc_5] == null)
                    {
                        this._tfs1[_loc_5] = this.getTf();
                        this._letterLayer.addChild(this._tfs1[_loc_5]);
                        this._tfs2[_loc_5] = this.getTf();
                        var _loc_6:* = (-this._letterWidth) * (_loc_5 + 1);
                        this._tfs2[_loc_5].x = (-this._letterWidth) * (_loc_5 + 1);
                        this._tfs1[_loc_5].x = _loc_6;
                    }
                    if (_loc_2[_loc_3] == null || this._letters[_loc_4] == null || this._letters[_loc_4] != _loc_2[_loc_3])
                    {
                        if (this._letters[_loc_4] != null)
                        {
                            this._tfs2[_loc_5].text = this._letters[_loc_4];
                            this._tfs2[_loc_5].y = 0;
                            this._letterLayer.addChild(this._tfs2[_loc_5]);
                        }
                        if (_loc_2[_loc_3] != null)
                        {
                            this._tfs1[_loc_5].text = _loc_2[_loc_3];
                        }
                        else
                        {
                            this._tfs1[_loc_5].text = "";
                        }
                        this._tfs1[_loc_5].y = -this._letterHeight;
                        this._moveMap[_loc_5] = true;
                    }
                    _loc_5++;
                }
                this._letters = _loc_2;
                this._looping = true;
                Config.startLoop(this.loop);
            }
            return;
        }// end function

        private function loop(param1 = null)
        {
            var _loc_4:* = undefined;
            var _loc_2:* = false;
            var _loc_3:* = 0;
            for (_loc_4 in this._moveMap)
            {
                
                this._tfs1[_loc_4].y = -this._tfs1[_loc_4].y / 5 + this._tfs1[_loc_4].y;
                this._tfs2[_loc_4].y = this._tfs1[_loc_4].y + this._letterHeight;
                var _loc_7:* = [new BlurFilter(Math.abs(-this._tfs1[_loc_4].y / 5) / 4, Math.abs(-this._tfs1[_loc_4].y / 5), 3)];
                this._tfs2[_loc_4].filters = [new BlurFilter(Math.abs(-this._tfs1[_loc_4].y / 5) / 4, Math.abs(-this._tfs1[_loc_4].y / 5), 3)];
                this._tfs1[_loc_4].filters = _loc_7;
                if (Math.abs(this._tfs1[_loc_4].y) < 1)
                {
                    _loc_2 = true;
                }
                _loc_3 = _loc_3 + 1;
            }
            if (_loc_2 || _loc_3 == 0)
            {
                for (_loc_4 in this._moveMap)
                {
                    
                    var _loc_7:* = [];
                    this._tfs2[_loc_4].filters = [];
                    this._tfs1[_loc_4].filters = _loc_7;
                    this._tfs1[_loc_4].y = 0;
                    if (this._tfs2[_loc_4].parent != null)
                    {
                        this._letterLayer.removeChild(this._tfs2[_loc_4]);
                    }
                }
                Config.stopLoop(this.loop);
                this._looping = false;
                if (this._buff != null)
                {
                    this.setLetter(this._buff);
                }
            }
            return;
        }// end function

        override public function get width() : Number
        {
            return this._letters.length * this._letterWidth;
        }// end function

        private function getTf() : TextField
        {
            var _loc_1:* = Config.getSimpleTextField();
            _loc_1.defaultTextFormat = new TextFormat(null, this.fontSize, this._letterColor, true);
            return _loc_1;
        }// end function

        public function get fontSize() : int
        {
            return this._fontSize;
        }// end function

        public function set fontSize(param1:int) : void
        {
            this._fontSize = param1;
            return;
        }// end function

    }
}
