package lovefox.component
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import flash.utils.*;

    public class RichTextField extends Sprite
    {
        public var _textfield:TextField;
        private var _defaultTextFormat:TextFormat;
        private var _length:int;
        private var _spriteContainer:Sprite;
        private var _spriteVspace:int;
        private var _spriteHspace:int;
        private var _selectBegin:int;
        private var _selectEnd:int;
        private var _scrollV:int;
        private var _spriteMask:Shape;
        private var _replacing:Boolean;
        private var _format:Dictionary;
        public var autoScroll:Boolean;
        public var lineHeight:Number;
        public var PLACEHOLDER:String = "　";
        private var PLACEHOLDER_FONT:String = "宋体";
        private var PLACEHOLDER_COLOR:uint = 0;
        public static const DYNAMIC:String = "dynamic";
        public static const INPUT:String = "input";
        private static const ADJUST_TYPE_INSERT:String = "adjust_type_insert";
        private static const ADJUST_TYPE_CHANGE:String = "adjust_type_change";

        public function RichTextField(param1:Number, param2:Number, param3:String = "dynamic")
        {
            this.initTextField(param1, param2);
            addChild(this._textfield);
            this._spriteContainer = new Sprite();
            addChild(this._spriteContainer);
            this._format = new Dictionary();
            this._scrollV = 1;
            this.lineHeight = 0;
            var _loc_4:* = 2;
            this._spriteVspace = 2;
            this._spriteHspace = _loc_4;
            this.type = param3;
            this._spriteMask = this.createSpritesMask(this._textfield.x, this._textfield.y, this._textfield.width, this._textfield.height);
            addChild(this._spriteMask);
            this._spriteContainer.mask = this._spriteMask;
            return;
        }// end function

        public function appendUbbText(param1:String, param2:TextFormat = null, param3:Boolean = true)
        {
            var sIndex:*;
            var eIndex:*;
            var ubbStr:*;
            var temp:*;
            var newStr:*;
            var arr:*;
            var str:* = param1;
            var format:* = param2;
            var autoWordWrap:* = param3;
            try
            {
                newStr;
                arr;
                while (true)
                {
                    
                    sIndex;
                    temp = str.indexOf("<f:");
                    if (temp != -1)
                    {
                        if (sIndex == -1)
                        {
                            sIndex = temp;
                        }
                        else
                        {
                            sIndex = Math.min(sIndex, temp);
                        }
                    }
                    temp = str.indexOf("<i:");
                    if (temp != -1)
                    {
                        if (sIndex == -1)
                        {
                            sIndex = temp;
                        }
                        else
                        {
                            sIndex = Math.min(sIndex, temp);
                        }
                    }
                    temp = str.indexOf("<l:");
                    if (temp != -1)
                    {
                        if (sIndex == -1)
                        {
                            sIndex = temp;
                        }
                        else
                        {
                            sIndex = Math.min(sIndex, temp);
                        }
                    }
                    temp = str.indexOf("<n:");
                    if (temp != -1)
                    {
                        if (sIndex == -1)
                        {
                            sIndex = temp;
                        }
                        else
                        {
                            sIndex = Math.min(sIndex, temp);
                        }
                    }
                    temp = str.indexOf("<u:");
                    if (temp != -1)
                    {
                        if (sIndex == -1)
                        {
                            sIndex = temp;
                        }
                        else
                        {
                            sIndex = Math.min(sIndex, temp);
                        }
                    }
                    temp = str.indexOf("<c:");
                    if (temp != -1)
                    {
                        if (sIndex == -1)
                        {
                            sIndex = temp;
                        }
                        else
                        {
                            sIndex = Math.min(sIndex, temp);
                        }
                    }
                    temp = str.indexOf("<t:");
                    if (temp != -1)
                    {
                        if (sIndex == -1)
                        {
                            sIndex = temp;
                        }
                        else
                        {
                            sIndex = Math.min(sIndex, temp);
                        }
                    }
                    temp = str.indexOf("<u>");
                    if (temp != -1)
                    {
                        if (sIndex == -1)
                        {
                            sIndex = temp;
                        }
                        else
                        {
                            sIndex = Math.min(sIndex, temp);
                        }
                    }
                    if (sIndex == -1)
                    {
                        break;
                        continue;
                    }
                    if (str.substr(sIndex, 3) == "<f:")
                    {
                        eIndex = str.indexOf(">", sIndex);
                        ubbStr = str.substring(sIndex, (eIndex + 1));
                        arr.push({src:new Ubb(ubbStr), index:sIndex});
                        str = str.substring(0, sIndex) + str.substring((eIndex + 1));
                        continue;
                    }
                    if (str.substr(sIndex, 3) == "<i:")
                    {
                        eIndex = str.indexOf(">", sIndex);
                        ubbStr = str.substring(sIndex, (eIndex + 1));
                        arr.push({src:new Ubb(ubbStr), index:sIndex});
                        str = str.substring(0, sIndex) + str.substring((eIndex + 1));
                        continue;
                    }
                    if (str.substr(sIndex, 3) == "<l:")
                    {
                        eIndex = str.indexOf(">", sIndex);
                        ubbStr = str.substring(sIndex, (eIndex + 1));
                        arr.push({src:new Ubb(ubbStr), index:sIndex});
                        str = str.substring(0, sIndex) + str.substring((eIndex + 1));
                        continue;
                    }
                    if (str.substr(sIndex, 3) == "<n:")
                    {
                        eIndex = str.indexOf(">", sIndex);
                        ubbStr = str.substring(sIndex, (eIndex + 1));
                        arr.push({src:new Ubb(ubbStr), index:sIndex});
                        str = str.substring(0, sIndex) + str.substring((eIndex + 1));
                        continue;
                    }
                    if (str.substr(sIndex, 3) == "<u:")
                    {
                        eIndex = str.indexOf(">", sIndex);
                        ubbStr = str.substring(sIndex, (eIndex + 1));
                        arr.push({src:new Ubb(ubbStr), index:sIndex});
                        str = str.substring(0, sIndex) + str.substring((eIndex + 1));
                        continue;
                    }
                    if (str.substr(sIndex, 3) == "<c:")
                    {
                        eIndex = str.indexOf(">", sIndex);
                        ubbStr = str.substring(sIndex, (eIndex + 1));
                        arr.push({src:new Ubb(ubbStr), index:sIndex});
                        str = str.substring(0, sIndex) + str.substring((eIndex + 1));
                        continue;
                    }
                    if (str.substr(sIndex, 3) == "<t:")
                    {
                        eIndex = str.indexOf(">", sIndex);
                        ubbStr = str.substring(sIndex, (eIndex + 1));
                        arr.push({src:new Ubb(ubbStr), index:sIndex});
                        str = str.substring(0, sIndex) + str.substring((eIndex + 1));
                        continue;
                    }
                    if (str.substr(sIndex, 3) == "<u>")
                    {
                        eIndex = str.indexOf("</u>", sIndex);
                        ubbStr = str.substring(sIndex, eIndex + 4);
                        arr.push({src:new Ubb(ubbStr), index:sIndex});
                        str = str.substring(0, sIndex) + str.substring(eIndex + 4);
                    }
                }
                this.appendRichText(str, arr, format, autoWordWrap);
            }
            catch (e)
            {
            }
            return;
        }// end function

        public function appendRichText(param1:String, param2:Array = null, param3:TextFormat = null, param4:Boolean = true) : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            this.appendText(param1, param3, param4);
            if (param2)
            {
                _loc_5 = 0;
                while (_loc_5 < param2.length)
                {
                    
                    _loc_6 = param2[_loc_5].index;
                    if (_loc_6 == -1)
                    {
                        _loc_6 = param1.length;
                    }
                    else if (param4)
                    {
                        _loc_6 = _loc_6 - 1;
                    }
                    _loc_6 = _loc_6 + (this._textfield.length - param1.length);
                    if (param4 && _loc_6 == this._textfield.length)
                    {
                        _loc_6 = _loc_6 - 1;
                    }
                    this.addSprite(param2[_loc_5].src, _loc_6, -1, this.lineHeight);
                    _loc_5++;
                }
            }
            if (this.autoScroll)
            {
                this._textfield.scrollV = this._textfield.maxScrollV;
            }
            dispatchEvent(new Event(Event.CHANGE));
            return;
        }// end function

        public function appendText(param1:String, param2:TextFormat = null, param3:Boolean = true) : void
        {
            this.recoverDefaultTextFormat();
            var _loc_4:* = param1;
            if (param3)
            {
                _loc_4 = _loc_4 + "\n";
            }
            _loc_4 = _loc_4.split("\r").join("\n");
            var _loc_5:* = this._textfield.length - 1;
            this._textfield.appendText(_loc_4);
            if (param2)
            {
                this._textfield.setTextFormat(param2, _loc_5, (this._textfield.length - 1));
            }
            dispatchEvent(new Event(Event.CHANGE));
            return;
        }// end function

        public function appendFromRichText(param1:RichTextField, param2:int = -1, param3:int = -1, param4:Boolean = true) : void
        {
            var _loc_9:* = null;
            var _loc_10:* = null;
            this.recoverDefaultTextFormat();
            var _loc_5:* = this._textfield.text.length;
            if (param2 == -1 && param3 == -1)
            {
                param2 = 0;
                param3 = param1.textfield.text.length - 1;
            }
            else if (param3 == -1)
            {
                param3 = param2;
            }
            var _loc_6:* = param1.textfield.text.substring(param2, (param3 + 1));
            if (param4)
            {
                _loc_6 = _loc_6 + "\n";
            }
            _loc_6 = _loc_6.split("\r").join("\n");
            this._textfield.appendText(_loc_6);
            this.applyTextFormat(param1.format, _loc_5);
            var _loc_7:* = 0;
            var _loc_8:* = _loc_6.length;
            while (_loc_7 < _loc_8)
            {
                
                _loc_9 = _loc_6.charAt(_loc_7);
                if (_loc_9 == this.PLACEHOLDER)
                {
                    _loc_10 = param1.getSpriteByName(String(_loc_7));
                    if (_loc_10)
                    {
                        trace("appendFromRichText Sprite", _loc_10, _loc_7, _loc_5 + _loc_7);
                        this._textfield.replaceText(_loc_5 + _loc_7, _loc_5 + _loc_7 + 1, "");
                        this.addSprite(_loc_10, _loc_5 + _loc_7, _loc_10.width, _loc_10.height);
                    }
                }
                _loc_7++;
            }
            return;
        }// end function

        public function copyFromRichText(param1:RichTextField, param2:int = -1, param3:int = -1, param4:Boolean = true) : void
        {
            var _loc_9:* = null;
            var _loc_10:* = null;
            this.recoverDefaultTextFormat();
            var _loc_5:* = this._textfield.text.length;
            if (param2 == -1 && param3 == -1)
            {
                param2 = 0;
                param3 = param1.textfield.text.length - 1;
            }
            else if (param3 == -1)
            {
                param3 = param2;
            }
            var _loc_6:* = param1.textfield.text.substring(param2, (param3 + 1));
            if (param4)
            {
                _loc_6 = _loc_6 + "\n";
            }
            _loc_6 = _loc_6.split("\r").join("\n");
            this._textfield.text = _loc_6;
            this.applyTextFormat(param1.format, _loc_5);
            var _loc_7:* = 0;
            var _loc_8:* = _loc_6.length;
            while (_loc_7 < _loc_8)
            {
                
                _loc_9 = _loc_6.charAt(_loc_7);
                if (_loc_9 == this.PLACEHOLDER)
                {
                    _loc_10 = param1.getSpriteByName(String(_loc_7));
                    if (_loc_10)
                    {
                        trace("copyFromRichText Sprite", _loc_10, _loc_7, _loc_5 + _loc_7);
                        this._textfield.replaceText(_loc_5 + _loc_7, _loc_5 + _loc_7 + 1, "");
                        this.addSprite(_loc_10, _loc_5 + _loc_7, _loc_10.width, _loc_10.height);
                    }
                }
                _loc_7++;
            }
            return;
        }// end function

        public function addSprite(param1, param2:int = -1, param3:Number = -1, param4:Number = -1) : void
        {
            var _loc_5:* = null;
            var _loc_8:* = null;
            if (param1 is Class)
            {
                _loc_5 = param1;
                _loc_8 = new param1 as Sprite;
            }
            else
            {
                _loc_8 = param1;
            }
            if (param3 > 0)
            {
                _loc_8.width = param3;
            }
            if (param4 > 0)
            {
                _loc_8.height = param4;
            }
            if (param2 == -1)
            {
                param2 = this._textfield.caretIndex;
            }
            var _loc_6:* = this.getPlaceholderFormat(_loc_8.width, _loc_8.height);
            this._replacing = true;
            var _loc_7:* = this._textfield.scrollV;
            this._textfield.replaceText(param2, param2, this.PLACEHOLDER);
            this._textfield.setTextFormat(_loc_6, param2);
            this._replacing = false;
            this._textfield.scrollV = _loc_7;
            this._spriteContainer.addChild(_loc_8);
            _loc_8.name = String(param2);
            var _loc_9:* = this;
            var _loc_10:* = this._length + 1;
            _loc_9._length = _loc_10;
            this.adjustSprites(param2, 1, ADJUST_TYPE_INSERT);
            return;
        }// end function

        public function setTextFormat(param1:TextFormat, param2:int = -1, param3:int = -1) : void
        {
            if (param2 > -1 && param2 == param3)
            {
                return;
            }
            if (param3 < 0)
            {
                if (param2 < 0)
                {
                    param3 = this._textfield.text.length;
                }
                else
                {
                    param3 = param2 + 1;
                }
            }
            if (param2 < 0)
            {
                param2 = 0;
            }
            if (param3 <= param2)
            {
                return;
            }
            this._textfield.setTextFormat(param1, param2, param3);
            this.recoverPlaceholderFormat(param2, param3);
            this._format[{begin:param2, end:param3}] = param1;
            this.adjustCoordinate(param2, (this._textfield.text.length - 1));
            return;
        }// end function

        public function clear() : void
        {
            this._textfield.text = "";
            this._length = 0;
            this._scrollV = 1;
            this.recoverDefaultTextFormat();
            this._format = new Dictionary();
            this._spriteContainer.y = 0;
            while (this._spriteContainer.numChildren > 0)
            {
                
                if (Ubb(this._spriteContainer.getChildAt(0)).destroy != null)
                {
                    Ubb(this._spriteContainer.getChildAt(0)).destroy();
                }
                this._spriteContainer.removeChildAt(0);
            }
            return;
        }// end function

        private function scrollHandler(event:Event) : void
        {
            var scrollDirection:int;
            var begin:int;
            var end:int;
            var scrollHeight:Number;
            var i:int;
            var evt:* = event;
            if (!this._replacing)
            {
                scrollDirection = this._textfield.scrollV > this._scrollV ? (1) : (-1);
                begin = scrollDirection > 0 ? (this._textfield.scrollV - 2) : (this._scrollV - 2);
                end = scrollDirection > 0 ? (this._scrollV - 2) : (this._textfield.scrollV - 2);
                scrollHeight;
                i = begin;
                while (i > end)
                {
                    
                    try
                    {
                        scrollHeight = scrollHeight + this._textfield.getLineMetrics(i).height;
                    }
                    catch (e)
                    {
                    }
                    i = (i - 1);
                }
                this._spriteContainer.y = this._spriteContainer.y - scrollDirection * scrollHeight;
            }
            if (this._replacing && this._textfield.scrollV == 1)
            {
                return;
            }
            this._scrollV = this._textfield.scrollV;
            return;
        }// end function

        private function getSelectionHandler(event:MouseEvent) : void
        {
            this._selectBegin = this._textfield.selectionBeginIndex;
            this._selectEnd = this._textfield.selectionEndIndex;
            return;
        }// end function

        private function inputHandler(event:Event) : void
        {
            this.recoverDefaultTextFormat();
            return;
        }// end function

        private function changeHandler(event:Event) : void
        {
            dispatchEvent(new Event(TextEvent.TEXT_INPUT));
            var _loc_2:* = this._textfield.length - this._length;
            this._length = this._textfield.length;
            var _loc_3:* = this._textfield.caretIndex;
            if (_loc_2 < 0)
            {
                this.checkSpriteExist(this._textfield.caretIndex, _loc_2);
            }
            this.adjustSprites(this._textfield.caretIndex, _loc_2, ADJUST_TYPE_CHANGE);
            return;
        }// end function

        private function checkSpriteExist(param1:int, param2:int) : void
        {
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_3:* = param1 + param2 + 1;
            var _loc_4:* = param1 + 1;
            if (param2 < -1 && this._selectBegin != this._selectEnd)
            {
                trace("selection:", this._selectBegin, this._selectEnd);
                _loc_3 = this._selectBegin;
                _loc_4 = this._selectEnd;
            }
            var _loc_5:* = _loc_3;
            while (_loc_5 < _loc_4)
            {
                
                _loc_6 = this._spriteContainer.getChildByName(String(_loc_5)) as Sprite;
                if (_loc_6)
                {
                    _loc_7 = this._spriteContainer.getChildIndex(_loc_6);
                    trace("remove ", _loc_5, this.getSpriteIndexAt(_loc_7), param1, param2, _loc_3, _loc_4);
                    this._spriteContainer.removeChild(_loc_6);
                }
                _loc_5++;
            }
            return;
        }// end function

        private function adjustSprites(param1:int, param2:int = 1, param3:String = "adjust_type_change") : void
        {
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_4:* = true;
            var _loc_5:* = 0;
            var _loc_6:* = this.numSprite;
            while (_loc_5 < _loc_6)
            {
                
                _loc_7 = this.getSpriteIndexAt(_loc_5);
                if (_loc_7 < (param1 - 1))
                {
                    ;
                }
                else if (_loc_7 == param1 && param3 == ADJUST_TYPE_CHANGE)
                {
                    _loc_7 = _loc_7 + param2;
                }
                else if (_loc_7 == (param1 - 1) && param3 == ADJUST_TYPE_CHANGE && param2 < 0)
                {
                    ;
                }
                else if (_loc_7 == (param1 - 1) && param3 == ADJUST_TYPE_CHANGE && param2 > 0)
                {
                    _loc_7 = _loc_7 + param2;
                }
                else if (_loc_7 == (param1 - 1) && param3 == ADJUST_TYPE_INSERT)
                {
                    _loc_7 = _loc_7;
                }
                else if (_loc_7 == param1 && param3 == ADJUST_TYPE_INSERT)
                {
                    if (_loc_4 && this._textfield.text.charAt((param1 + 1)) == this.PLACEHOLDER)
                    {
                        if (this._textfield.getTextFormat((param1 + 1)).letterSpacing != 0)
                        {
                            _loc_7 = _loc_7 + param2;
                            _loc_4 = false;
                        }
                    }
                    else
                    {
                        _loc_4 = true;
                    }
                }
                else if (_loc_7 != param1)
                {
                    _loc_7 = _loc_7 + param2;
                }
                _loc_8 = this._spriteContainer.getChildAt(_loc_5) as Sprite;
                _loc_9 = this.getCharBoundaries(_loc_7);
                if (_loc_8 && _loc_9)
                {
                    _loc_8.name = String(_loc_7);
                    this.setSpriteCoordinate(_loc_8, _loc_9);
                }
                _loc_5++;
            }
            return;
        }// end function

        private function recoverPlaceholderFormat(param1:int, param2:int) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_3:* = param1;
            while (_loc_3 < param2)
            {
                
                if (this._textfield.text.charAt(_loc_3) == this.PLACEHOLDER)
                {
                    _loc_4 = this._spriteContainer.getChildByName(String(_loc_3)) as Sprite;
                    if (!_loc_4)
                    {
                    }
                    else
                    {
                        _loc_5 = this.getPlaceholderFormat(_loc_4.width, _loc_4.height);
                        this._textfield.setTextFormat(_loc_5, _loc_3);
                    }
                }
                _loc_3++;
            }
            return;
        }// end function

        private function getPlaceholderFormat(param1:Number, param2:Number) : TextFormat
        {
            var _loc_3:* = new TextFormat();
            _loc_3.font = this.PLACEHOLDER_FONT;
            _loc_3.color = this.PLACEHOLDER_COLOR;
            _loc_3.size = param2 + 2 * this._spriteVspace;
            _loc_3.underline = false;
            _loc_3.letterSpacing = param1 - param2 - 2 * this._spriteVspace + 2 * this._spriteHspace;
            return _loc_3;
        }// end function

        private function recoverDefaultTextFormat() : void
        {
            if (this._defaultTextFormat)
            {
                this.defaultTextFormat = this._defaultTextFormat;
            }
            return;
        }// end function

        private function adjustCoordinate(param1:int = -1, param2:int = -1) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = this._spriteContainer.numChildren;
            while (_loc_3 < _loc_4)
            {
                
                _loc_5 = this._spriteContainer.getChildAt(_loc_3) as Sprite;
                _loc_6 = int(_loc_5.name);
                if (param1 <= _loc_6 && param2 >= _loc_6)
                {
                    _loc_7 = this.getCharBoundaries(_loc_6);
                    if (_loc_7)
                    {
                        this.setSpriteCoordinate(_loc_5, _loc_7);
                    }
                }
                _loc_3++;
            }
            return;
        }// end function

        private function setSpriteCoordinate(param1:Sprite, param2:Rectangle) : void
        {
            param1.x = this._spriteContainer.x + param2.left + this._spriteHspace;
            param1.y = param2.top + param2.height - param1.height - this._spriteVspace;
            return;
        }// end function

        private function getCharBoundaries(param1:int) : Rectangle
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_2:* = this._textfield.getCharBoundaries(param1);
            if (!_loc_2)
            {
                _loc_3 = this._textfield.getLineIndexOfChar(param1);
                if (this._textfield.bottomScrollV < _loc_3)
                {
                    _loc_4 = this._textfield.scrollV;
                    this._textfield.scrollV = _loc_3;
                    _loc_2 = this._textfield.getCharBoundaries(param1);
                    this._textfield.scrollV = _loc_4;
                }
            }
            return _loc_2;
        }// end function

        private function applyTextFormat(param1:Dictionary, param2:int) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            for (_loc_3 in param1)
            {
                
                _loc_4 = _loc_3.begin + param2;
                _loc_5 = _loc_3.end + param2;
                this.setTextFormat(param1[_loc_3], _loc_4, _loc_5);
            }
            return;
        }// end function

        public function setCaretIndex(param1:int) : void
        {
            this._textfield.setSelection(param1, param1);
            return;
        }// end function

        private function initTextField(param1:Number, param2:Number) : void
        {
            this._textfield = new TextField();
            if (Config._switchEnglish)
            {
                this._textfield.defaultTextFormat = new TextFormat("Tahoma");
            }
            this._textfield.width = param1;
            this._textfield.height = param2;
            this._textfield.wordWrap = true;
            this._textfield.restrict = "^" + this.PLACEHOLDER;
            this._textfield.addEventListener(Event.SCROLL, this.handleTextScoll);
            return;
        }// end function

        private function handleTextScoll(param1)
        {
            dispatchEvent(new Event(Event.SCROLL));
            return;
        }// end function

        public function set scrollV(param1)
        {
            this._textfield.scrollV = param1;
            return;
        }// end function

        public function get maxScrollV()
        {
            return this._textfield.maxScrollV;
        }// end function

        public function get scrollV()
        {
            return this._textfield.scrollV;
        }// end function

        public function get numLines()
        {
            return this._textfield.numLines;
        }// end function

        public function set selectable(param1)
        {
            this._textfield.selectable = param1;
            return;
        }// end function

        public function set textColor(param1)
        {
            this._textfield.textColor = param1;
            return;
        }// end function

        public function get textColor()
        {
            return this._textfield.textColor;
        }// end function

        public function set maxChars(param1)
        {
            this._textfield.maxChars = param1;
            return;
        }// end function

        public function get maxChars()
        {
            return this._textfield.maxChars;
        }// end function

        public function get snapRect()
        {
            var _loc_1:* = new BitmapData(this._textfield.width, this._textfield.height, true, 0);
            _loc_1.draw(this);
            var _loc_2:* = _loc_1.getColorBoundsRect(4278190080, 0, false);
            _loc_2.height = _loc_2.height + _loc_2.y;
            _loc_1.dispose();
            return _loc_2;
        }// end function

        public function set focus(param1)
        {
            if (param1)
            {
                Config.stage.focus = this._textfield;
            }
            else
            {
                Config.stage.focus = null;
            }
            return;
        }// end function

        public function get focus()
        {
            if (Config.stage.focus == this._textfield)
            {
                return true;
            }
            return false;
        }// end function

        public function set ubbText(param1:String)
        {
            this.clear();
            if (param1 != null)
            {
                this.appendUbbText(param1, null, false);
            }
            return;
        }// end function

        public function get ubbText() : String
        {
            var _loc_2:* = null;
            var _loc_5:* = null;
            var _loc_6:* = undefined;
            var _loc_1:* = this._textfield.text;
            var _loc_3:* = 0;
            _loc_1 = _loc_1.split("\r").join("\n");
            var _loc_4:* = 0;
            while (_loc_4 < _loc_1.length)
            {
                
                _loc_5 = _loc_1.charAt(_loc_4);
                if (_loc_5 == this.PLACEHOLDER)
                {
                    _loc_6 = this.getSpriteByName(String(_loc_4 - _loc_3));
                    if (_loc_6)
                    {
                        _loc_2 = _loc_6.label;
                        _loc_1 = _loc_1.substring(0, _loc_4) + _loc_2 + _loc_1.substring((_loc_4 + 1));
                        _loc_4 = _loc_4 + (_loc_2.length - 1);
                        _loc_3 = _loc_3 + (_loc_2.length - 1);
                    }
                }
                _loc_4++;
            }
            return _loc_1;
        }// end function

        private function createSpritesMask(param1:Number, param2:Number, param3:Number, param4:Number) : Shape
        {
            var _loc_5:* = new Shape();
            new Shape().graphics.beginFill(16711680);
            _loc_5.graphics.lineStyle(0, 0);
            _loc_5.graphics.drawRect(param1, param2, param3, param4);
            _loc_5.graphics.endFill();
            return _loc_5;
        }// end function

        public function resize(param1:Number, param2:Number) : void
        {
            var _loc_3:* = param1;
            this._spriteMask.width = param1;
            this._textfield.width = _loc_3;
            var _loc_3:* = param2;
            this._spriteMask.height = param2;
            this._textfield.height = _loc_3;
            this.adjustCoordinate(0, this._textfield.length);
            this.scrollV = this.scrollV;
            return;
        }// end function

        public function replace(param1:String, param2:String, param3:int, param4:int) : void
        {
            param1 = param1.split(this.PLACEHOLDER).join("");
            param2 = param2.split(this.PLACEHOLDER).join("");
            this._textfield.text = this._textfield.text.substring(0, param3) + this._textfield.text.substring(param3, param4).split(param1).join(param2) + this._textfield.text.substring(param4);
            this._length = this._length + (param2.length - param1.length);
            this.recoverPlaceholderFormat(0, this.length);
            return;
        }// end function

        public function get textfield() : TextField
        {
            return this._textfield;
        }// end function

        public function get length() : int
        {
            return this._textfield.text.length;
        }// end function

        public function get textLength() : int
        {
            return this.text.length;
        }// end function

        public function get text() : String
        {
            return this._textfield.text.split(this.PLACEHOLDER).join("");
        }// end function

        public function set text(param1:String) : void
        {
            param1 = param1.split(this.PLACEHOLDER).join("");
            this._textfield.text = param1;
            dispatchEvent(new Event(Event.CHANGE));
            return;
        }// end function

        public function get format() : Dictionary
        {
            return this._format;
        }// end function

        public function get numSprite() : int
        {
            return this._spriteContainer.numChildren;
        }// end function

        public function getSpriteIndexAt(param1:int) : int
        {
            var _loc_2:* = this.getSpriteAt(param1);
            if (_loc_2)
            {
                return int(_loc_2.name);
            }
            return -1;
        }// end function

        public function getSpriteAt(param1:int) : Sprite
        {
            if (param1 >= this._spriteContainer.numChildren)
            {
                return null;
            }
            return this._spriteContainer.getChildAt(param1) as Sprite;
        }// end function

        public function getSpriteByName(param1:String) : Sprite
        {
            return this._spriteContainer.getChildByName(param1) as Sprite;
        }// end function

        public function set spriteVspace(param1:int) : void
        {
            this._spriteVspace = param1;
            return;
        }// end function

        public function set spriteHspace(param1:int) : void
        {
            this._spriteHspace = param1;
            return;
        }// end function

        public function set defaultTextFormat(param1:TextFormat) : void
        {
            if (param1.letterSpacing == null)
            {
                param1.letterSpacing = 0;
            }
            this._defaultTextFormat = param1;
            this._textfield.defaultTextFormat = param1;
            return;
        }// end function

        public function get defaultTextFormat() : TextFormat
        {
            return this._defaultTextFormat;
        }// end function

        public function set placeholderColor(param1:uint) : void
        {
            this.PLACEHOLDER_COLOR = param1;
            return;
        }// end function

        public function set type(param1:String) : void
        {
            this._textfield.type = param1;
            this._textfield.addEventListener(Event.SCROLL, this.scrollHandler);
            if (param1 == INPUT)
            {
                this._textfield.addEventListener(Event.CHANGE, this.changeHandler);
                this._textfield.addEventListener(TextEvent.TEXT_INPUT, this.inputHandler);
                this._textfield.addEventListener(MouseEvent.MOUSE_UP, this.getSelectionHandler);
                this._textfield.addEventListener(MouseEvent.ROLL_OUT, this.getSelectionHandler);
            }
            return;
        }// end function

        public function get type() : String
        {
            return this._textfield.type;
        }// end function

    }
}
