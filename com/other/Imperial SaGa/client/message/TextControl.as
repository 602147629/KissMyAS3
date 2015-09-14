package message
{
    import flash.display.*;
    import flash.geom.*;
    import flash.text.*;
    import resource.*;

    public class TextControl extends Object
    {
        protected var _text:String;
        protected var _baseMc:DisplayObjectContainer;
        protected var _textField:TextField;
        protected var _textFormat:TextFormat;
        private var _ct:ColorTransform;
        private var _x:Number;
        private var _y:Number;
        private var _bAutoSize:Boolean;
        private var _textAlign:String;
        private var _textSpr:Sprite;
        private var _textIndex:int;
        private var _textLine:int;
        private var _textWidth:int;
        private var _textHeight:int;
        private var _maxWidth:Number;
        private var _aText:Array;
        private var _aTextLine:Array;
        public static const CENTER:String = "center";
        public static const LEFT:String = "left";
        public static const RIGHT:String = "right";

        public function TextControl(param1:TextField, param2:ColorTransform = null) : void
        {
            this._textField = param1;
            this._baseMc = param1.parent;
            this._ct = param2;
            this._textFormat = param1.defaultTextFormat;
            this._textFormat.font = ResourceManager.getInstance().fontName;
            var _loc_3:* = new TextField();
            _loc_3.defaultTextFormat = this._textFormat;
            _loc_3.text = "　";
            this._textWidth = _loc_3.textWidth;
            this._textHeight = this._textFormat.size + this._textFormat.leading;
            this._textAlign = this._textFormat.align;
            this._textLine = 0;
            param1.visible = false;
            this._bAutoSize = false;
            this._aTextLine = new Array();
            return;
        }// end function

        public function release() : void
        {
            if (this._textSpr && this._textSpr.parent)
            {
                this._textSpr.parent.removeChild(this._textSpr);
                this._textSpr = null;
            }
            return;
        }// end function

        public function control() : void
        {
            return;
        }// end function

        public function bAutoSize(param1:Boolean) : void
        {
            this._bAutoSize = param1;
            return;
        }// end function

        public function getWidth() : Number
        {
            return this._textSpr.width;
        }// end function

        public function getHeigth() : Number
        {
            var _loc_1:* = this._textHeight;
            return _loc_1 * this._aTextLine.length;
        }// end function

        public function setText(param1:String) : Boolean
        {
            var _loc_3:* = null;
            var _loc_2:* = this._baseMc.getChildByName(this._textField.name + "orgText") as TextHolder;
            if (_loc_2 == null || _loc_2.text != param1)
            {
                this._initSprite(param1);
                this._setMessage();
                if (_loc_2 == null)
                {
                    _loc_2 = new TextHolder();
                    _loc_2.name = this._textField.name + "orgText";
                    this._baseMc.addChild(_loc_2);
                }
                _loc_2.text = param1;
                return true;
            }
            else
            {
                _loc_3 = this._textField.name + "_trc";
                this._textSpr = this._baseMc.getChildByName(_loc_3) as Sprite;
            }
            return false;
        }// end function

        private function _initSprite(param1:String) : void
        {
            this._textIndex = 0;
            var _loc_2:* = this._textField.name + "_trc";
            var _loc_3:* = this._baseMc.getChildByName(_loc_2) as Sprite;
            if (_loc_3 != null && _loc_3.parent != null)
            {
                _loc_3.parent.removeChild(_loc_3);
            }
            this._textSpr = new Sprite();
            if (this._ct)
            {
                this._textSpr.transform.colorTransform = this._ct;
            }
            this._baseMc.addChild(this._textSpr);
            this._textSpr.name = _loc_2;
            this._textSpr.filters = this._textField.filters;
            this._textSpr.x = this._textField.x;
            this._textSpr.y = this._textField.y;
            this._maxWidth = this._textField.width;
            this._text = param1;
            this._x = 0;
            this._y = 0;
            this.resetLinePosition((this._textIndex - 1));
            this.initializeTextField(param1);
            this._aText = new Array();
            return;
        }// end function

        private function _setMessage() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            while (this.nextText())
            {
                
                this.control();
            }
            this._aTextLine.push(this._aText);
            this._aText = new Array();
            this._textSpr.scaleX = 1;
            var _loc_1:* = true;
            if (this._bAutoSize)
            {
                if (this._textField.width < this._textSpr.width)
                {
                    this._textSpr.scaleX = this._textField.width / this._textSpr.width;
                    _loc_1 = false;
                }
            }
            if (_loc_1)
            {
                if (this._aTextLine.length > 1 || this._textField.width >= this._textSpr.width)
                {
                    _loc_2 = [];
                    _loc_4 = this._textSpr.width;
                    switch(this._textAlign)
                    {
                        case CENTER:
                        {
                            for each (_loc_2 in this._aTextLine)
                            {
                                
                                if (_loc_2.length > 0)
                                {
                                    _loc_4 = this.getTextLineWidth(_loc_2);
                                    _loc_5 = (this._maxWidth - _loc_4) / 2 - _loc_2[0].x;
                                    for each (_loc_3 in _loc_2)
                                    {
                                        
                                        _loc_3.x = _loc_3.x + _loc_5;
                                    }
                                }
                            }
                            break;
                        }
                        case RIGHT:
                        {
                            for each (_loc_2 in this._aTextLine)
                            {
                                
                                if (_loc_2.length > 0)
                                {
                                    _loc_4 = this.getTextLineWidth(_loc_2);
                                    _loc_5 = this._maxWidth - _loc_4 - _loc_2[0].x;
                                    for each (_loc_3 in _loc_2)
                                    {
                                        
                                        _loc_3.x = _loc_3.x + _loc_5;
                                    }
                                }
                            }
                            break;
                        }
                        default:
                        {
                            break;
                            break;
                        }
                    }
                }
            }
            return;
        }// end function

        public function startMessage(param1:String) : void
        {
            this._initSprite(param1);
            return;
        }// end function

        public function nextMessage(param1:int) : Boolean
        {
            return this.nextText(param1);
        }// end function

        private function nextText(param1:int = 1) : Boolean
        {
            var _loc_3:* = null;
            var _loc_4:* = NaN;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_2:* = 0;
            while (_loc_2 < param1)
            {
                
                if (this._text == null)
                {
                    return false;
                }
                if (this._text.length <= this._textIndex)
                {
                    return false;
                }
                var _loc_7:* = this;
                var _loc_8:* = this._textIndex + 1;
                _loc_7._textIndex = _loc_8;
                _loc_3 = this._text.substring((this._textIndex - 1), this._textIndex);
                if (_loc_3 == "\n")
                {
                    this.returnText();
                    return true;
                }
                _loc_5 = new TextField();
                _loc_6 = this._textFormat;
                _loc_5.defaultTextFormat = _loc_6;
                _loc_5.embedFonts = true;
                _loc_5.autoSize = this._textAlign;
                _loc_5.selectable = false;
                _loc_5.height = 0;
                _loc_5.condenseWhite = false;
                _loc_5.text = _loc_3;
                _loc_4 = Math.floor(_loc_5.textWidth + this._textFormat.kerning);
                this._textSpr.addChild(_loc_5);
                this._aText.push(_loc_5);
                _loc_5.x = this._x;
                _loc_5.y = this._y;
                this._x = this._x + _loc_4;
                if (this._text.length <= this._textIndex)
                {
                    return false;
                }
                _loc_2++;
            }
            return true;
        }// end function

        private function returnText() : void
        {
            this.resetLinePosition(this._textIndex);
            this._y = this._y + this._textHeight;
            this._aTextLine.push(this._aText);
            this._aText = new Array();
            return;
        }// end function

        private function resetLinePosition(param1:int) : void
        {
            this._x = 0;
            return;
        }// end function

        private function initializeTextField(param1:String) : void
        {
            var _loc_2:* = param1.split("\n")[0];
            var _loc_3:* = new TextField();
            _loc_3.defaultTextFormat = this._textFormat;
            _loc_3.autoSize = this._textAlign;
            _loc_3.embedFonts = true;
            _loc_3.multiline = false;
            _loc_3.wordWrap = false;
            _loc_3.width = 0;
            _loc_3.height = 0;
            _loc_3.text = _loc_2;
            return;
        }// end function

        private function getTextLineWidth(param1:Array) : int
        {
            var _loc_2:* = null;
            if (param1.length > 0)
            {
                _loc_2 = param1[(param1.length - 1)] as TextField;
                return _loc_2.x + _loc_2.width - param1[0].x;
            }
            return 0;
        }// end function

        public static function setText(param1:TextField, param2:String, param3:Boolean = true, param4:ColorTransform = null) : TextControl
        {
            var _loc_5:* = new TextControl(param1, param4);
            new TextControl(param1, param4).bAutoSize(param3);
            _loc_5.setText(param2);
            return _loc_5;
        }// end function

        public static function setIdText(param1:TextField, param2:int, param3:Boolean = true) : TextControl
        {
            var _loc_4:* = MessageManager.getInstance().getMessage(param2);
            return setText(param1, _loc_4, param3);
        }// end function

        public static function setAgYearText(param1:MovieClip, param2:MovieClip, param3:int) : void
        {
            param3 = CommonConstant.CHRONOLOGICAL_TABLE_START_YEAR + param3;
            TextControl.setIdText(param1.textDt, MessageId.COMMON_NAME_OF_AN_ERA01);
            TextControl.setText(param2.textDt, TextControl.formatIdText(MessageId.COMMON_NAME_OF_AN_ERA02, param3.toString()));
            return;
        }// end function

        public static function setBonusText(param1:MovieClip, param2:Boolean, param3:int) : TextControl
        {
            var _loc_4:* = "";
            param1.visible = param2;
            if (param2)
            {
                param1.gotoAndStop(param3 < 0 ? ("down") : ("up"));
                _loc_4 = param3 < 0 ? ("-" + (-param3)) : ("+" + param3);
            }
            return TextControl.setText(param1.textMc.textDt, _loc_4);
        }// end function

        public static function setReverseBonusText(param1:MovieClip, param2:Boolean, param3:int) : TextControl
        {
            var _loc_4:* = "";
            param1.visible = param2;
            if (param2)
            {
                param1.gotoAndStop(param3 > 0 ? ("down") : ("up"));
                _loc_4 = param3 <= 0 ? ("-" + (-param3)) : ("+" + param3);
            }
            return TextControl.setText(param1.textMc.textDt, _loc_4);
        }// end function

        public static function createColorTag(param1:uint) : String
        {
            return "<color 0x" + param1.toString(16) + ">";
        }// end function

        public static function createHitValText(param1:int) : String
        {
            param1 = param1 / 10;
            return param1.toString();
        }// end function

        public static function createDateString(param1:uint) : String
        {
            var _loc_2:* = new Date(param1 * 1000);
            return formatIdText(MessageId.STORAGE_DATE, _loc_2.fullYear, fillDigits((_loc_2.month + 1)), fillDigits(_loc_2.date), fillDigits(_loc_2.hours), fillDigits(_loc_2.minutes));
        }// end function

        private static function fillDigits(param1:uint, param2:uint = 2) : String
        {
            var _loc_3:* = "";
            var _loc_4:* = 0;
            while (_loc_4 < param2)
            {
                
                _loc_3 = _loc_3 + "0";
                _loc_4++;
            }
            _loc_3 = _loc_3 + param1.toString();
            return _loc_3.substr(-param2, param2);
        }// end function

        public static function formatIdText(param1:int, ... args) : String
        {
            args = new activation;
            var count:int;
            var pattern:RegExp;
            var id:* = param1;
            var val:* = args;
            if ( < 0 &&  >= MessageId.MAX)
            {
                return "";
            }
            var text:* = MessageManager.getInstance().getMessage();
            if ( && length > 0)
            {
                count;
                pattern = new RegExp("%%|%d|%s", "gm");
                text = replace(, function () : String
            {
                return arguments[0] == "%%" ? ("%") : (val.length > count ? (val[count++]) : (arguments[0]));
            }// end function
            );
            }
            return ;
        }// end function

    }
}

import flash.display.*;

import flash.geom.*;

import flash.text.*;

import resource.*;

class TextHolder extends Sprite
{
    public var text:String;

    function TextHolder() : void
    {
        this.text = "";
        return;
    }// end function

}

