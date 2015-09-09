package com.bit101.components
{
    import flash.display.*;

    public class Table extends Sprite
    {
        private var _grid0:Bitmap;
        private var _grid1:Bitmap;
        private var _grid2:Bitmap;
        private var _grid3:Bitmap;
        private var _grid4:Bitmap;
        private var _grid5:Bitmap;
        private var _grid6:Bitmap;
        private var _grid7:Bitmap;
        private var _grid8:Bitmap;
        private var _type:uint;
        public var _width:uint = 0;
        private var _height:uint = 0;
        private static var _buff:Object = {};

        public function Table(param1)
        {
            this.setTable(param1);
            this.cacheAsBitmap = true;
            return;
        }// end function

        private function addGrid(param1, param2)
        {
            if (param2[param1] != null)
            {
                this["_grid" + param1] = new Bitmap(param2[param1], PixelSnapping.NEVER, false);
                addChild(this["_grid" + param1]);
            }
            return;
        }// end function

        public function destroy()
        {
            this.removeAll();
            return;
        }// end function

        private function removeAll()
        {
            var _loc_1:* = undefined;
            _loc_1 = 0;
            while (_loc_1 < 9)
            {
                
                if (this["_grid" + _loc_1] != null)
                {
                    removeChild(this["_grid" + _loc_1]);
                }
                _loc_1 = _loc_1 + 1;
            }
            return;
        }// end function

        public function setTable(param1)
        {
            this.removeAll();
            this._type = _buff[param1].length;
            var _loc_2:* = _buff[param1];
            if (this._type > 3)
            {
                this.addGrid(4, _loc_2);
                this.addGrid(0, _loc_2);
                this.addGrid(1, _loc_2);
                this.addGrid(2, _loc_2);
                this.addGrid(3, _loc_2);
                this.addGrid(5, _loc_2);
                this.addGrid(6, _loc_2);
                this.addGrid(7, _loc_2);
                this.addGrid(8, _loc_2);
            }
            else if (this._type == 3)
            {
                this.addGrid(0, _loc_2);
                this.addGrid(1, _loc_2);
                this.addGrid(2, _loc_2);
            }
            else if (this._type == 2)
            {
                this.addGrid(0, _loc_2);
                this.addGrid(1, _loc_2);
            }
            else if (this._type == 1)
            {
                this.addGrid(0, _loc_2);
            }
            this.resize(this._width, this._height);
            return;
        }// end function

        public function resize(param1, param2 = null)
        {
            this._width = param1;
            if (param2 != null)
            {
                this._height = param2;
            }
            this.cacheAsBitmap = false;
            if (this._type > 3)
            {
                if (this._grid1 != null)
                {
                    this._grid1.x = this._grid0.width;
                    this._grid1.width = param1 - this._grid0.width - this._grid2.width;
                }
                this._grid2.x = param1 - this._grid2.width;
                if (this._grid3 != null)
                {
                    this._grid3.y = this._grid0.height;
                    this._grid3.height = param2 - this._grid0.height - this._grid6.height;
                }
                if (this._grid4 != null)
                {
                    this._grid4.x = this._grid0.width;
                    this._grid4.y = this._grid0.height;
                    this._grid4.width = param1 - this._grid0.width - this._grid2.width;
                    this._grid4.height = param2 - this._grid1.height - this._grid6.height;
                }
                if (this._grid4 != null)
                {
                    this._grid4.width = param1 - this._grid3.width - this._grid5.width;
                    this._grid4.height = param2 - this._grid1.height - this._grid7.height;
                }
                if (this._grid5 != null)
                {
                    this._grid5.x = param1 - this._grid5.width;
                    this._grid5.y = this._grid2.height;
                    this._grid5.height = param2 - this._grid2.height - this._grid8.height;
                }
                this._grid6.y = param2 - this._grid6.height;
                if (this._grid7 != null)
                {
                    this._grid7.x = this._grid6.width;
                    this._grid7.y = param2 - this._grid7.height;
                    this._grid7.width = param1 - this._grid6.width - this._grid8.width;
                }
                this._grid8.x = param1 - this._grid8.width;
                this._grid8.y = param2 - this._grid8.height;
            }
            else if (this._type == 3)
            {
                if (this._grid1 != null)
                {
                    this._grid1.x = this._grid0.width;
                    this._grid1.width = param1 - this._grid0.width - this._grid2.width;
                }
                this._grid2.x = param1 - this._grid2.width;
            }
            else if (this._type == 2)
            {
                if (this._grid1 != null)
                {
                    this._grid1.x = this._grid0.width;
                    this._grid1.width = param1 - this._grid0.width;
                }
            }
            else if (this._type == 1)
            {
                this._grid0.width = param1;
            }
            this.cacheAsBitmap = true;
            return;
        }// end function

        public static function init()
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_1:* = Config._xmlMap["ui.xml"];
            _loc_2 = 0;
            while (_loc_2 < _loc_1.children().length())
            {
                
                if (String(_loc_1.children()[_loc_2].name()).indexOf("table") != -1)
                {
                    _buff[String(_loc_1.children()[_loc_2].name())] = [];
                    _loc_3 = 0;
                    while (_loc_3 < _loc_1.children()[_loc_2].children().length())
                    {
                        
                        if (String(_loc_1.children()[_loc_2].children()[_loc_3]) != "")
                        {
                            _buff[String(_loc_1.children()[_loc_2].name())][_loc_3] = BitmapLoader.pick(String(_loc_1.children()[_loc_2].children()[_loc_3]));
                        }
                        _loc_3 = _loc_3 + 1;
                    }
                }
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

    }
}
