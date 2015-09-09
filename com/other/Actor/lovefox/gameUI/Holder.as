package lovefox.gameUI
{
    import flash.display.*;
    import flash.text.*;
    import lovefox.unit.*;

    public class Holder extends Sprite
    {
        public static var _holder:Sprite;
        public static var _holdingItem:Item;
        public static var _holdingOther:Object;
        public static var _holdingIcon:Object;
        public static var _holdingLayer:Object;
        public static var _infoRect:Sprite;
        public static var _buffTxt:TextField;
        public static var _infoTxt:TextField;
        public static var _titleTxt:TextField;
        public static var _infoMsg:String;
        public static var _twinInfoRect:Sprite;
        public static var _twinInfoTxt:TextField;
        public static var _twinInfoMsg:String;
        public static var _rightInfoRect:Sprite;
        public static var _rightInfoTxt:TextField;
        public static var _rightInfoMsg:String;
        public static var _icon:Bitmap;
        private static var _rqBuff:Object = {};
        private static var _data:Object;
        private static var _infoStar:Array = [];
        private static var _infoIcon:CloneSlot;
        private static var _twinInfoStar:Array = [];
        private static var _twinInfoIcon:CloneSlot;
        private static var _iconslot:CloneSlot;
        private static var _defaultTF:TextFormat = new TextFormat();

        public function Holder()
        {
            _holder = this;
            _holdingIcon = new Bitmap();
            _holdingLayer = new Sprite();
            _holder.addChild(_holdingLayer);
            _holdingLayer.addChild(_holdingIcon);
            _infoRect = new Sprite();
            _buffTxt = Config.getSimpleTextField();
            _buffTxt.multiline = true;
            _buffTxt.textColor = 16777215;
            _infoTxt = Config.getSimpleTextField();
            _infoTxt.multiline = true;
            _infoTxt.textColor = 16777215;
            _titleTxt = Config.getSimpleTextField();
            _titleTxt.textColor = 16777215;
            _titleTxt.y = 8;
            _infoRect.addChild(_infoTxt);
            _twinInfoRect = new Sprite();
            _twinInfoTxt = Config.getSimpleTextField();
            _twinInfoTxt.multiline = true;
            _twinInfoTxt.textColor = 16777215;
            _twinInfoRect.addChild(_twinInfoTxt);
            _rightInfoRect = new Sprite();
            _rightInfoTxt = Config.getSimpleTextField();
            _rightInfoTxt.multiline = true;
            _rightInfoTxt.textColor = 16777215;
            _rightInfoRect.addChild(_rightInfoTxt);
            mouseEnabled = false;
            mouseChildren = false;
            return;
        }// end function

        public static function set data(param1)
        {
            _data = param1;
            return;
        }// end function

        public static function get data()
        {
            return _data;
        }// end function

        public static function set item(param1:Item)
        {
            var _loc_2:* = _holdingItem;
            _holdingItem = param1;
            if (_holdingItem != null)
            {
                if (param1._icon.parent != null)
                {
                    param1._icon.parent.removeChild(param1._icon);
                }
                _holdingLayer.addChild(param1._icon);
                _holdingLayer.x = (-_holdingLayer.width) / 2;
                _holdingLayer.y = (-_holdingLayer.height) / 2;
                closeInfo();
                other = null;
                _holder.startDrag(true);
                Config.ui._chatUI._channelRtf.mouseEnabled = true;
            }
            else
            {
                if (_loc_2 != null)
                {
                    if (_loc_2._icon.parent == _holdingLayer)
                    {
                        _holdingLayer.removeChild(_loc_2._icon);
                    }
                }
                Config.ui._chatUI._channelRtf.mouseEnabled = false;
            }
            return;
        }// end function

        public static function get item() : Item
        {
            return _holdingItem;
        }// end function

        public static function set other(param1)
        {
            if (param1 != null)
            {
                if (item != null)
                {
                    item._drawer[item._position].item = item;
                }
                item = null;
                _holdingOther = param1.obj;
                _holdingIcon.bitmapData = param1.bmpd;
                _holdingLayer.x = (-_holdingLayer.width) / 2;
                _holdingLayer.y = (-_holdingLayer.height) / 2;
                _holder.startDrag(true);
            }
            else
            {
                _holdingOther = null;
                _holdingIcon.bitmapData = null;
            }
            return;
        }// end function

        public static function get other()
        {
            return _holdingOther;
        }// end function

        public static function closeInfo()
        {
            if (_infoTxt != null)
            {
                _infoTxt.setTextFormat(_defaultTF);
            }
            if (_infoRect.parent != null)
            {
                _infoRect.parent.removeChild(_infoRect);
            }
            if (_twinInfoRect.parent != null)
            {
                _twinInfoRect.parent.removeChild(_twinInfoRect);
            }
            if (_rightInfoRect.parent != null)
            {
                _rightInfoRect.parent.removeChild(_rightInfoRect);
            }
            clearStar();
            clearTwinStar();
            clearIcon();
            return;
        }// end function

        public static function showRightInfo(param1, param2, param3 = false, param4 = 0)
        {
            if (item == null)
            {
                if (_rightInfoMsg != param1)
                {
                    _rightInfoMsg = param1;
                    if (param4 > 0)
                    {
                        _buffTxt.htmlText = "<p align=\'left\'>" + _rightInfoMsg + "</p>";
                        if (_buffTxt.width <= param4)
                        {
                            _rightInfoTxt.wordWrap = false;
                        }
                        else
                        {
                            _rightInfoTxt.wordWrap = true;
                            _rightInfoTxt.width = param4;
                        }
                    }
                    else
                    {
                        _rightInfoTxt.wordWrap = false;
                    }
                    _rightInfoTxt.htmlText = "<p align=\'left\'>" + _rightInfoMsg + "</p>";
                    _rightInfoRect.graphics.clear();
                    _rightInfoRect.graphics.lineStyle(0, 16768355, 0.4, true);
                    _rightInfoRect.graphics.beginFill(0, 0.8);
                    _rightInfoRect.graphics.drawRect(-3, -3, _rightInfoTxt.width + 6, _rightInfoTxt.height + 8);
                    _rightInfoRect.graphics.endFill();
                }
                _rightInfoRect.x = _infoRect.x + _infoRect.width;
                _rightInfoRect.y = _infoRect.y;
                _holder.parent.addChild(_rightInfoRect);
            }
            return;
        }// end function

        public static function showTwinInfo(param1, param2, param3 = false, param4 = 0, param5 = null)
        {
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            if (item == null)
            {
                clearTwinStar();
                if (_twinInfoMsg != param1)
                {
                    _twinInfoMsg = param1;
                    if (param4 > 0)
                    {
                        _buffTxt.htmlText = "<p align=\'left\'>" + _twinInfoMsg + "</p>";
                        if (_buffTxt.width <= param4)
                        {
                            _twinInfoTxt.wordWrap = false;
                        }
                        else
                        {
                            _twinInfoTxt.wordWrap = true;
                            _twinInfoTxt.width = param4;
                        }
                    }
                    else
                    {
                        _twinInfoTxt.wordWrap = false;
                    }
                    _twinInfoTxt.htmlText = "<p align=\'left\'>" + _twinInfoMsg + "</p>";
                    _twinInfoRect.graphics.clear();
                    _twinInfoRect.graphics.lineStyle(0, 16768355, 0.4, true);
                    _twinInfoRect.graphics.beginFill(0, 0.8);
                    _twinInfoRect.graphics.drawRect(-3, -3, _twinInfoTxt.width + 6, _twinInfoTxt.height + 8);
                    _twinInfoRect.graphics.endFill();
                }
                _twinInfoRect.x = _infoRect.x - _twinInfoRect.width;
                _twinInfoRect.y = _infoRect.y;
                if (param5 != null && param5 > 0)
                {
                    _loc_6 = 0;
                    while (_loc_6 < (param5 - 1) % 5 + 1)
                    {
                        
                        if (param5 <= 5)
                        {
                            _loc_7 = "misc/star1";
                        }
                        else if (param5 <= 10)
                        {
                            _loc_7 = "misc/star2";
                        }
                        else if (param5 <= 15)
                        {
                            _loc_7 = "misc/star3";
                        }
                        else if (param5 <= 20)
                        {
                            _loc_7 = "misc/star4";
                        }
                        else if (param5 <= 25)
                        {
                            _loc_7 = "misc/star5";
                        }
                        else if (param5 <= 30)
                        {
                            _loc_7 = "misc/star6";
                        }
                        else if (param5 <= 35)
                        {
                            _loc_7 = "misc/star7";
                        }
                        else if (param5 <= 40)
                        {
                            _loc_7 = "misc/star8";
                        }
                        else if (param5 <= 45)
                        {
                            _loc_7 = "misc/star9";
                        }
                        else if (param5 <= 50)
                        {
                            _loc_7 = "misc/star10";
                        }
                        else if (param5 <= 55)
                        {
                            _loc_7 = "misc/star11";
                        }
                        else
                        {
                            _loc_7 = "misc/star12";
                        }
                        _twinInfoStar[_loc_6] = new Bitmap(Config.findIcon(_loc_7, 12, 12));
                        _twinInfoStar[_loc_6].y = 20;
                        _twinInfoStar[_loc_6].x = _loc_6 * 20 + 10;
                        _twinInfoRect.addChild(_twinInfoStar[_loc_6]);
                        _loc_6 = _loc_6 + 1;
                    }
                }
                _holder.parent.addChild(_twinInfoRect);
            }
            return;
        }// end function

        private static function clearStar()
        {
            var _loc_1:* = undefined;
            if (_infoStar.length > 0)
            {
                _loc_1 = 0;
                while (_loc_1 < _infoStar.length)
                {
                    
                    _infoStar[_loc_1].bitmapData.dispose();
                    _infoStar[_loc_1].parent.removeChild(_infoStar[_loc_1]);
                    _loc_1 = _loc_1 + 1;
                }
                _infoStar = [];
            }
            return;
        }// end function

        private static function clearTwinStar()
        {
            var _loc_1:* = undefined;
            if (_twinInfoStar.length > 0)
            {
                _loc_1 = 0;
                while (_loc_1 < _twinInfoStar.length)
                {
                    
                    _twinInfoStar[_loc_1].bitmapData.dispose();
                    _twinInfoStar[_loc_1].parent.removeChild(_twinInfoStar[_loc_1]);
                    _loc_1 = _loc_1 + 1;
                }
                _twinInfoStar = [];
            }
            return;
        }// end function

        private static function clearIcon()
        {
            if (_iconslot != null)
            {
                _iconslot.item = null;
                if (_iconslot.parent != null)
                {
                    _iconslot.parent.removeChild(_iconslot);
                }
            }
            return;
        }// end function

        public static function setInfoPos(param1, param2, param3 = false)
        {
            if (_infoRect.parent != null)
            {
                _infoRect.x = param1;
                if (param3)
                {
                    _infoRect.y = param2 - _infoRect.height;
                }
                else
                {
                    _infoRect.y = param2 + 3;
                }
            }
            return;
        }// end function

        public static function showInfo(param1, param2, param3 = false, param4 = 0, param5 = 0, param6 = null, param7 = null, param8 = null)
        {
            var _loc_9:* = undefined;
            var _loc_10:* = undefined;
            var _loc_11:* = undefined;
            param1 = param1.replace(/\\\
n""\\n/g, "\n");
            if (item == null)
            {
                clearStar();
                clearIcon();
                if (param7 != null)
                {
                    if (_iconslot == null)
                    {
                        _iconslot = new CloneSlot(0, 32);
                        _iconslot.mouseChildren = false;
                        _iconslot.mouseEnabled = false;
                        _iconslot.x = 3;
                        _iconslot.y = 3;
                    }
                    _iconslot.item = param7;
                    _infoRect.addChild(_iconslot);
                }
                if (_infoMsg != param1)
                {
                    _infoMsg = param1;
                    if (param5 > 0)
                    {
                        _buffTxt.htmlText = "<p align=\'left\'>" + _infoMsg + "</p>";
                        if (_buffTxt.width <= param5)
                        {
                            _infoTxt.wordWrap = false;
                        }
                        else
                        {
                            _infoTxt.wordWrap = true;
                            _infoTxt.width = param5;
                        }
                    }
                    else
                    {
                        _infoTxt.wordWrap = false;
                    }
                }
                if (param7 != null)
                {
                    _infoTxt.y = 36;
                }
                else
                {
                    _infoTxt.y = 0;
                }
                if (param8 != null)
                {
                    _infoTxt.y = _infoTxt.y + 40;
                    _titleTxt.text = param8;
                    _infoRect.addChild(_titleTxt);
                }
                else if (_titleTxt.parent != null)
                {
                    _titleTxt.parent.removeChild(_titleTxt);
                }
                _infoTxt.htmlText = "<p align=\'left\'>" + _infoMsg + "</p>";
                _infoRect.graphics.clear();
                _infoRect.graphics.lineStyle(0, 16768355, 0.4, true);
                _infoRect.graphics.beginFill(0, 0.8);
                _infoRect.graphics.drawRect(-3, -3, _infoTxt.width + 6, _infoTxt.y + _infoTxt.height + 8);
                _infoRect.graphics.endFill();
                if (param8 != null)
                {
                    _infoRect.graphics.beginFill(0, 1);
                    _infoRect.graphics.drawRect(-3, -3, _infoTxt.width + 6, 40);
                    _infoRect.graphics.endFill();
                }
                if (param4 == 0)
                {
                    _infoRect.x = Math.min(Config.ui._width - (_infoTxt.width + 6) - 2 + 3, Math.max(5, param2.x + param2.width / 2 - _infoRect.width / 2 + 3));
                }
                else if (param4 == 1)
                {
                    _infoRect.x = Math.min(Config.ui._width - (_infoTxt.width + 6) - 2 + 3, Math.max(5, param2.x + 3));
                }
                else if (param4 == 2)
                {
                    _infoRect.x = Math.min(Config.ui._width - (_infoTxt.width + 6) - 2 + 3, Math.max(5, param2.x + param2.width));
                }
                _loc_9 = param2.y + 3;
                if (param3)
                {
                    _infoRect.y = Math.max(5, _loc_9 - _infoRect.height);
                }
                else if (_loc_9 + param2.height + _infoRect.height > Config.map._mapHeight)
                {
                    _infoRect.y = Math.max(5, _loc_9 - _infoRect.height);
                }
                else
                {
                    _infoRect.y = _loc_9 + param2.height;
                }
                if (param6 != null && param6 > 0)
                {
                    _loc_10 = 0;
                    while (_loc_10 < (param6 - 1) % 5 + 1)
                    {
                        
                        if (param6 <= 5)
                        {
                            _loc_11 = "misc/star1";
                        }
                        else if (param6 <= 10)
                        {
                            _loc_11 = "misc/star2";
                        }
                        else if (param6 <= 15)
                        {
                            _loc_11 = "misc/star3";
                        }
                        else if (param6 <= 20)
                        {
                            _loc_11 = "misc/star4";
                        }
                        else if (param6 <= 25)
                        {
                            _loc_11 = "misc/star5";
                        }
                        else if (param6 <= 30)
                        {
                            _loc_11 = "misc/star6";
                        }
                        else if (param6 <= 35)
                        {
                            _loc_11 = "misc/star7";
                        }
                        else if (param6 <= 40)
                        {
                            _loc_11 = "misc/star8";
                        }
                        else if (param6 <= 45)
                        {
                            _loc_11 = "misc/star9";
                        }
                        else if (param6 <= 50)
                        {
                            _loc_11 = "misc/star10";
                        }
                        else if (param6 <= 55)
                        {
                            _loc_11 = "misc/star11";
                        }
                        else
                        {
                            _loc_11 = "misc/star12";
                        }
                        _infoStar[_loc_10] = new Bitmap(Config.findIcon(_loc_11, 12, 12));
                        if (param7 != null)
                        {
                            _infoStar[_loc_10].y = 56;
                        }
                        else
                        {
                            _infoStar[_loc_10].y = 20;
                        }
                        _infoStar[_loc_10].x = _loc_10 * 20 + 5;
                        _infoRect.addChild(_infoStar[_loc_10]);
                        _loc_10 = _loc_10 + 1;
                    }
                }
                _holder.parent.addChild(_infoRect);
            }
            return;
        }// end function

    }
}
