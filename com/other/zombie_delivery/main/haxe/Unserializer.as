package haxe
{
    import flash.*;
    import flash.utils.*;
    import haxe.ds.*;
    import haxe.io.*;

    public class Unserializer extends Object
    {
        public var scache:Array;
        public var resolver:Object;
        public var pos:int;
        public var length:int;
        public var cache:Array;
        public var buf:String;
        public static var init__:Boolean;
        public static var DEFAULT_RESOLVER:Object;
        public static var BASE64:String;
        public static var CODES:ByteArray;

        public function Unserializer(param1:String = undefined) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            buf = param1;
            length = param1.length;
            pos = 0;
            scache = [];
            cache = [];
            var _loc_2:* = Unserializer.DEFAULT_RESOLVER;
            if (_loc_2 == null)
            {
                _loc_2 = Type;
                Unserializer.DEFAULT_RESOLVER = _loc_2;
            }
            setResolver(_loc_2);
            return;
        }// end function

        public function unserializeObject(param1:Object) : void
        {
            var _loc_2:* = null as String;
            var _loc_3:* = null;
            while (true)
            {
                
                if (pos >= length)
                {
                    throw "Invalid object";
                }
                if (buf.charCodeAt(pos) == 103)
                {
                    break;
                }
                _loc_2 = unserialize();
                if (!(_loc_2 is String))
                {
                    throw "Invalid object key";
                }
                _loc_3 = unserialize();
                param1[_loc_2] = _loc_3;
            }
            (pos + 1);
            return;
        }// end function

        public function unserializeEnum(param1:Class, param2:String)
        {
            var _loc_4:* = pos;
            (pos + 1);
            var _loc_3:* = _loc_4;
            if (buf.charCodeAt(_loc_3) != 58)
            {
                throw "Invalid enum format";
            }
            _loc_3 = readDigits();
            if (_loc_3 == 0)
            {
                return Type.createEnum(param1, param2);
            }
            var _loc_5:* = [];
            do
            {
                
                _loc_5.push(unserialize());
                _loc_3--;
            }while (_loc_3 > 0)
            return Type.createEnum(param1, param2, _loc_5);
        }// end function

        public function unserialize()
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null as String;
            var _loc_6:* = null as Array;
            var _loc_7:* = null;
            var _loc_8:* = null as Class;
            var _loc_9:* = null as String;
            var _loc_10:* = null as List;
            var _loc_11:* = null as StringMap;
            var _loc_12:* = null as IntMap;
            var _loc_13:* = 0;
            var _loc_14:* = null as ObjectMap;
            var _loc_15:* = null;
            var _loc_16:* = null as Date;
            var _loc_17:* = null as ByteArray;
            var _loc_18:* = 0;
            var _loc_19:* = null as Bytes;
            var _loc_20:* = 0;
            var _loc_21:* = 0;
            var _loc_22:* = 0;
            var _loc_23:* = 0;
            var _loc_24:* = 0;
            var _loc_25:* = 0;
            _loc_3 = pos;
            (pos + 1);
            _loc_2 = _loc_3;
            var _loc_1:* = buf.charCodeAt(_loc_2);
            switch(_loc_1) branch count is:<122>[374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 2455, 374, 374, 374, 374, 374, 374, 374, 374, 374, 1725, 374, 374, 374, 374, 976, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 374, 740, 1455, 1044, 417, 374, 391, 374, 374, 404, 1215, 704, 1364, 716, 378, 890, 728, 1560, 922, 1904, 385, 374, 1836, 1129, 1031, 547, 397] default offset is:<374>;
            ;
            return null;
            ;
            return true;
            ;
            return false;
            ;
            return 0;
            ;
            return readDigits();
            ;
            _loc_2 = pos;
            while (true)
            {
                
                _loc_3 = buf.charCodeAt(pos);
                if (_loc_3 >= 43)
                {
                }
                if (_loc_3 >= 58)
                {
                }
                if (_loc_3 != 101)
                {
                }
                if (_loc_3 == 69)
                {
                    (pos + 1);
                    continue;
                }
                break;
            }
            return Std.parseFloat(buf.substr(_loc_2, pos - _loc_2));
            ;
            _loc_2 = readDigits();
            _loc_4 = pos;
            (pos + 1);
            _loc_3 = _loc_4;
            if (buf.charCodeAt(_loc_3) == 58)
            {
            }
            if (length - pos < _loc_2)
            {
                throw "Invalid string length";
            }
            _loc_5 = buf.substr(pos, _loc_2);
            pos = pos + _loc_2;
            _loc_5 = decodeURIComponent(_loc_5.split("+").join(" "));
            scache.push(_loc_5);
            return _loc_5;
            ;
            return Math.NaN;
            ;
            return Math.NEGATIVE_INFINITY;
            ;
            return Math.POSITIVE_INFINITY;
            ;
            _loc_5 = buf;
            _loc_6 = [];
            cache.push(_loc_6);
            while (true)
            {
                
                _loc_2 = buf.charCodeAt(pos);
                if (_loc_2 == 104)
                {
                    (pos + 1);
                    break;
                }
                if (_loc_2 == 117)
                {
                    (pos + 1);
                    _loc_3 = readDigits();
                    _loc_6[_loc_6.length + _loc_3 - 1] = null;
                    continue;
                }
                _loc_6.push(unserialize());
            }
            return _loc_6;
            ;
            _loc_7 = {};
            cache.push(_loc_7);
            unserializeObject(_loc_7);
            return _loc_7;
            ;
            _loc_2 = readDigits();
            if (_loc_2 >= 0)
            {
            }
            if (_loc_2 >= cache.length)
            {
                throw "Invalid reference";
            }
            return cache[_loc_2];
            ;
            _loc_2 = readDigits();
            if (_loc_2 >= 0)
            {
            }
            if (_loc_2 >= scache.length)
            {
                throw "Invalid string reference";
            }
            return scache[_loc_2];
            ;
            throw unserialize();
            ;
            _loc_5 = unserialize();
            _loc_8 = resolver.resolveClass(_loc_5);
            if (_loc_8 == null)
            {
                throw "Class not found " + _loc_5;
            }
            _loc_7 = Type.createEmptyInstance(_loc_8);
            cache.push(_loc_7);
            unserializeObject(_loc_7);
            return _loc_7;
            ;
            _loc_5 = unserialize();
            _loc_8 = resolver.resolveEnum(_loc_5);
            if (_loc_8 == null)
            {
                throw "Enum not found " + _loc_5;
            }
            _loc_7 = unserializeEnum(_loc_8, unserialize());
            cache.push(_loc_7);
            return _loc_7;
            ;
            _loc_5 = unserialize();
            _loc_8 = resolver.resolveEnum(_loc_5);
            if (_loc_8 == null)
            {
                throw "Enum not found " + _loc_5;
            }
            (pos + 1);
            _loc_2 = readDigits();
            _loc_9 = Type.getEnumConstructs(_loc_8)[_loc_2];
            if (_loc_9 == null)
            {
                throw "Unknown enum index " + _loc_5 + "@" + _loc_2;
            }
            _loc_7 = unserializeEnum(_loc_8, _loc_9);
            cache.push(_loc_7);
            return _loc_7;
            ;
            _loc_10 = new List();
            cache.push(_loc_10);
            _loc_5 = buf;
            while (buf.charCodeAt(pos) != 104)
            {
                
                _loc_10.add(unserialize());
            }
            (pos + 1);
            return _loc_10;
            ;
            _loc_11 = new StringMap();
            cache.push(_loc_11);
            _loc_5 = buf;
            while (buf.charCodeAt(pos) != 104)
            {
                
                _loc_9 = unserialize();
                _loc_11.set(_loc_9, unserialize());
            }
            (pos + 1);
            return _loc_11;
            ;
            _loc_12 = new IntMap();
            cache.push(_loc_12);
            _loc_5 = buf;
            _loc_4 = pos;
            (pos + 1);
            _loc_3 = _loc_4;
            _loc_2 = buf.charCodeAt(_loc_3);
            while (_loc_2 == 58)
            {
                
                _loc_3 = readDigits();
                _loc_7 = unserialize();
                _loc_12.h[_loc_3] = _loc_7;
                _loc_13 = pos;
                (pos + 1);
                _loc_4 = _loc_13;
                _loc_2 = buf.charCodeAt(_loc_4);
            }
            if (_loc_2 != 104)
            {
                throw "Invalid IntMap format";
            }
            return _loc_12;
            ;
            _loc_14 = new ObjectMap();
            cache.push(_loc_14);
            _loc_5 = buf;
            while (buf.charCodeAt(pos) != 104)
            {
                
                _loc_7 = unserialize();
                _loc_15 = unserialize();
                _loc_14[_loc_7] = _loc_15;
            }
            (pos + 1);
            return _loc_14;
            ;
            _loc_16 = Date.fromString(buf.substr(pos, 19));
            cache.push(_loc_16);
            pos = pos + 19;
            return _loc_16;
            ;
            _loc_2 = readDigits();
            _loc_5 = buf;
            _loc_4 = pos;
            (pos + 1);
            _loc_3 = _loc_4;
            if (buf.charCodeAt(_loc_3) == 58)
            {
            }
            if (length - pos < _loc_2)
            {
                throw "Invalid bytes length";
            }
            _loc_17 = Unserializer.CODES;
            if (_loc_17 == null)
            {
                _loc_17 = Unserializer.initCodes();
                Unserializer.CODES = _loc_17;
            }
            _loc_3 = pos;
            _loc_4 = _loc_2 & 3;
            _loc_13 = (_loc_2 >> 2) * 3 + (_loc_4 >= 2 ? ((_loc_4 - 1)) : (0));
            _loc_18 = _loc_3 + (_loc_2 - _loc_4);
            _loc_19 = Bytes.alloc(_loc_13);
            _loc_20 = 0;
            while (_loc_3 < _loc_18)
            {
                
                _loc_3++;
                _loc_22 = _loc_3;
                _loc_21 = _loc_17[_loc_5.charCodeAt(_loc_22)];
                _loc_3++;
                _loc_23 = _loc_3;
                _loc_22 = _loc_17[_loc_5.charCodeAt(_loc_23)];
                _loc_20++;
                _loc_23 = _loc_20;
                _loc_19.b[_loc_23] = _loc_21 << 2 | _loc_22 >> 4;
                _loc_3++;
                _loc_24 = _loc_3;
                _loc_23 = _loc_17[_loc_5.charCodeAt(_loc_24)];
                _loc_20++;
                _loc_24 = _loc_20;
                _loc_19.b[_loc_24] = _loc_22 << 4 | _loc_23 >> 2;
                _loc_3++;
                _loc_25 = _loc_3;
                _loc_24 = _loc_17[_loc_5.charCodeAt(_loc_25)];
                _loc_20++;
                _loc_25 = _loc_20;
                _loc_19.b[_loc_25] = _loc_23 << 6 | _loc_24;
            }
            if (_loc_4 >= 2)
            {
                _loc_3++;
                _loc_22 = _loc_3;
                _loc_21 = _loc_17[_loc_5.charCodeAt(_loc_22)];
                _loc_3++;
                _loc_23 = _loc_3;
                _loc_22 = _loc_17[_loc_5.charCodeAt(_loc_23)];
                _loc_20++;
                _loc_23 = _loc_20;
                _loc_19.b[_loc_23] = _loc_21 << 2 | _loc_22 >> 4;
                if (_loc_4 == 3)
                {
                    _loc_3++;
                    _loc_24 = _loc_3;
                    _loc_23 = _loc_17[_loc_5.charCodeAt(_loc_24)];
                    _loc_20++;
                    _loc_24 = _loc_20;
                    _loc_19.b[_loc_24] = _loc_22 << 4 | _loc_23 >> 2;
                }
            }
            pos = pos + _loc_2;
            cache.push(_loc_19);
            return _loc_19;
            ;
            _loc_5 = unserialize();
            _loc_8 = resolver.resolveClass(_loc_5);
            if (_loc_8 == null)
            {
                throw "Class not found " + _loc_5;
            }
            _loc_7 = Type.createEmptyInstance(_loc_8);
            cache.push(_loc_7);
            _loc_7.hxUnserialize(this);
            _loc_3 = pos;
            (pos + 1);
            _loc_2 = _loc_3;
            if (buf.charCodeAt(_loc_2) != 103)
            {
                throw "Invalid custom data";
            }
            return _loc_7;
            (pos - 1);
            throw "Invalid char " + buf.charAt(pos) + " at position " + pos;
            return;
        }// end function

        public function setResolver(param1:Object) : void
        {
            if (param1 == null)
            {
                resolver = {resolveClass:function (param1:String) : Class
            {
                return null;
            }// end function
            , resolveEnum:function (param1:String) : Class
            {
                return null;
            }// end function
            };
            }
            else
            {
                resolver = param1;
            }
            return;
        }// end function

        public function readDigits() : int
        {
            var _loc_4:* = 0;
            var _loc_1:* = 0;
            var _loc_2:* = false;
            var _loc_3:* = pos;
            while (true)
            {
                
                _loc_4 = buf.charCodeAt(pos);
                if (_loc_4 == 0)
                {
                    break;
                }
                if (_loc_4 == 45)
                {
                    if (pos != _loc_3)
                    {
                        break;
                    }
                    _loc_2 = true;
                    (pos + 1);
                    continue;
                }
                if (_loc_4 >= 48)
                {
                }
                if (_loc_4 > 57)
                {
                    break;
                }
                _loc_1 = _loc_1 * 10 + (_loc_4 - 48);
                (pos + 1);
            }
            if (_loc_2)
            {
                _loc_1 = _loc_1 * -1;
            }
            return _loc_1;
        }// end function

        public static function initCodes() : ByteArray
        {
            var _loc_4:* = 0;
            var _loc_1:* = new ByteArray();
            var _loc_2:* = 0;
            var _loc_3:* = Unserializer.BASE64.length;
            while (_loc_2 < _loc_3)
            {
                
                _loc_2++;
                _loc_4 = _loc_2;
                _loc_1[Unserializer.BASE64.charCodeAt(_loc_4)] = _loc_4;
            }
            return _loc_1;
        }// end function

        public static function run(param1:String)
        {
            return new Unserializer(param1).unserialize();
        }// end function

    }
}
