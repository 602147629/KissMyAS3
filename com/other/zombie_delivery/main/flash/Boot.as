package flash
{
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.text.*;
    import flash.utils.*;

    dynamic public class Boot extends MovieClip
    {
        public static var tf:TextField;
        public static var lines:Array;
        public static var lastError:Error;
        public static var skip_constructor:Boolean;

        public function Boot() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            return;
        }// end function

        public function start() : void
        {
            var _loc_3:* = null;
            var _loc_2:* = Lib.current;
            if (_loc_2 == this)
            {
            }
            if (_loc_2.stage != null)
            {
            }
            if (_loc_2.stage.align == "")
            {
                _loc_2.stage.align = "TOP_LEFT";
            }
            ;
            _loc_3 = null;
            if (_loc_2.stage == null)
            {
                _loc_2.addEventListener(Event.ADDED_TO_STAGE, doInitDelay);
            }
            else
            {
                if (_loc_2.stage.stageWidth != 0)
                {
                }
                if (_loc_2.stage.stageHeight == 0)
                {
                    setTimeout(start, 1);
                }
                else
                {
                    init();
                }
            }
            return;
        }// end function

        public function init() : void
        {
            throw "assert";
            return;
        }// end function

        public function doInitDelay(param1) : void
        {
            Lib.current.removeEventListener(Event.ADDED_TO_STAGE, doInitDelay);
            start();
            return;
        }// end function

        public static function enum_to_string(param1:Object) : String
        {
            var _loc_5:* = null;
            if (param1.params == null)
            {
                return param1.tag;
            }
            var _loc_2:* = [];
            var _loc_3:* = 0;
            var _loc_4:* = param1.params;
            while (_loc_3 < _loc_4.length)
            {
                
                _loc_5 = _loc_4[_loc_3];
                _loc_3++;
                _loc_2.push(Boot.__string_rec(_loc_5, ""));
            }
            return param1.tag + "(" + _loc_2.join(",") + ")";
        }// end function

        public static function __instanceof(param1, param2) : Boolean
        {
            var _loc_4:* = null;
            if (param2 == Dynamic)
            {
                return true;
            }
            return param1 is param2;
            ;
            _loc_4 = null;
            return false;
        }// end function

        public static function __clear_trace() : void
        {
            if (Boot.tf == null)
            {
                return;
            }
            Boot.tf.parent.removeChild(Boot.tf);
            Boot.tf = null;
            Boot.lines = null;
            return;
        }// end function

        public static function __set_trace_color(param1:uint) : void
        {
            var _loc_2:* = Boot.getTrace();
            _loc_2.textColor = param1;
            _loc_2.filters = [];
            return;
        }// end function

        public static function getTrace() : TextField
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = null as TextFormat;
            var _loc_1:* = Lib.current;
            if (Boot.tf == null)
            {
                Boot.tf = new TextField();
                _loc_2 = 16777215;
                _loc_3 = 0;
                if (_loc_1.stage != null)
                {
                    _loc_3 = _loc_1.stage.color;
                    _loc_2 = 16777215 - _loc_3;
                }
                Boot.tf.textColor = _loc_2;
                Boot.tf.filters = [new GlowFilter(_loc_3, 1, 2, 2, 20)];
                _loc_4 = Boot.tf.getTextFormat();
                _loc_4.font = "_sans";
                Boot.tf.defaultTextFormat = _loc_4;
                Boot.tf.selectable = false;
                if (_loc_1.stage == null)
                {
                    Boot.tf.width = 800;
                }
                else
                {
                    Boot.tf.width = _loc_1.stage.stageWidth;
                }
                Boot.tf.autoSize = TextFieldAutoSize.LEFT;
                Boot.tf.mouseEnabled = false;
            }
            if (_loc_1.stage == null)
            {
                _loc_1.addChild(Boot.tf);
            }
            else
            {
                _loc_1.stage.addChild(Boot.tf);
            }
            return Boot.tf;
        }// end function

        public static function __trace(param1, param2:Object) : void
        {
            var _loc_4:* = null as String;
            var _loc_6:* = 0;
            var _loc_7:* = null as Array;
            var _loc_8:* = null;
            var _loc_3:* = Boot.getTrace();
            if (param2 == null)
            {
                _loc_4 = "(null)";
            }
            else
            {
                _loc_4 = param2.fileName + ":" + param2.lineNumber;
            }
            if (Boot.lines == null)
            {
                Boot.lines = [];
            }
            var _loc_5:* = _loc_4 + ": " + Boot.__string_rec(param1, "");
            if (param2 != null)
            {
            }
            if (param2.customParams != null)
            {
                _loc_6 = 0;
                _loc_7 = param2.customParams;
                while (_loc_6 < _loc_7.length)
                {
                    
                    _loc_8 = _loc_7[_loc_6];
                    _loc_6++;
                    _loc_5 = _loc_5 + ("," + Boot.__string_rec(_loc_8, ""));
                }
            }
            Boot.lines = Boot.lines.concat(_loc_5.split("\n"));
            _loc_3.text = Boot.lines.join("\n");
            var _loc_9:* = Lib.current.stage;
            if (_loc_9 == null)
            {
                return;
            }
            do
            {
                
                Boot.lines.shift();
                _loc_3.text = Boot.lines.join("\n");
                if (Boot.lines.length > 1)
                {
                }
            }while (_loc_3.height > _loc_9.stageHeight)
            return;
        }// end function

        public static function __string_rec(param1, param2:String) : String
        {
            var _loc_5:* = null as String;
            var _loc_6:* = null as Array;
            var _loc_7:* = null as Array;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = null as String;
            var _loc_11:* = false;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_14:* = null as String;
            var _loc_4:* = getQualifiedClassName(param1);
            _loc_5 = _loc_4;
            if (_loc_5 == "Object")
            {
                _loc_8 = 0;
                _loc_7 = [];
                _loc_9 = param1;
                while (_loc_9 in _loc_8)
                {
                    
                    _loc_7.push(_loc_9[_loc_8]);
                }
                _loc_6 = _loc_7;
                _loc_10 = "{";
                _loc_11 = true;
                _loc_8 = 0;
                _loc_12 = _loc_6.length;
                while (_loc_8 < _loc_12)
                {
                    
                    _loc_8++;
                    _loc_13 = _loc_8;
                    _loc_14 = _loc_6[_loc_13];
                    if (_loc_14 == "toString")
                    {
                        return param1.toString();
                        ;
                        _loc_9 = null;
                    }
                    if (_loc_11)
                    {
                        _loc_11 = false;
                    }
                    else
                    {
                        _loc_10 = _loc_10 + ",";
                    }
                    _loc_10 = _loc_10 + (" " + _loc_14 + " : " + Boot.__string_rec(param1[_loc_14], param2));
                }
                if (!_loc_11)
                {
                    _loc_10 = _loc_10 + " ";
                }
                _loc_10 = _loc_10 + "}";
                return _loc_10;
            }
            else if (_loc_5 == "Array")
            {
                if (param1 == Array)
                {
                    return "#Array";
                }
                _loc_10 = "[";
                _loc_11 = true;
                _loc_6 = param1;
                _loc_8 = 0;
                _loc_12 = _loc_6.length;
                while (_loc_8 < _loc_12)
                {
                    
                    _loc_8++;
                    _loc_13 = _loc_8;
                    if (_loc_11)
                    {
                        _loc_11 = false;
                    }
                    else
                    {
                        _loc_10 = _loc_10 + ",";
                    }
                    _loc_10 = _loc_10 + Boot.__string_rec(_loc_6[_loc_13], param2);
                }
                return _loc_10 + "]";
            }
            else
            {
                _loc_5 = typeof(param1);
                _loc_10 = _loc_5;
                if (_loc_10 == "function")
                {
                    return "<function>";
                }
                else if (_loc_10 == "undefined")
                {
                    return "null";
                    ;
                }
            }
            return new String(param1);
        }// end function

        public static function __unprotect__(param1:String) : String
        {
            return param1;
        }// end function

    }
}
