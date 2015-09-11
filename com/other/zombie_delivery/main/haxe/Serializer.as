package haxe
{
    import flash.*;
    import flash.utils.*;
    import haxe.ds.*;
    import haxe.io.*;

    public class Serializer extends Object
    {
        public var useEnumIndex:Boolean;
        public var useCache:Boolean;
        public var shash:StringMap;
        public var scount:int;
        public var cache:Array;
        public var buf:StringBuf;
        public static var USE_CACHE:Boolean;
        public static var USE_ENUM_INDEX:Boolean;
        public static var BASE64:String;

        public function Serializer() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            buf = new StringBuf();
            cache = [];
            useCache = Serializer.USE_CACHE;
            useEnumIndex = Serializer.USE_ENUM_INDEX;
            shash = new StringMap();
            scount = 0;
            return;
        }// end function

        public function toString() : String
        {
            return buf.b;
        }// end function

        public function serializeString(param1:String) : void
        {
            var _loc_2:* = shash.get(param1);
            if (_loc_2 != null)
            {
                buf.b = buf.b + "R";
                if (_loc_2 == null)
                {
                    buf.b = buf.b + "null";
                }
                else
                {
                    buf.b = buf.b + ("" + _loc_2);
                }
                return;
            }
            var _loc_3:* = scount;
            (scount + 1);
            shash.set(param1, _loc_3);
            buf.b = buf.b + "y";
            param1 = encodeURIComponent(param1);
            buf.b = buf.b + ("" + param1.length);
            buf.b = buf.b + ":";
            if (param1 == null)
            {
                buf.b = buf.b + "null";
            }
            else
            {
                buf.b = buf.b + ("" + param1);
            }
            return;
        }// end function

        public function serializeRef(param1) : Boolean
        {
            var _loc_4:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = cache.length;
            while (_loc_2 < _loc_3)
            {
                
                _loc_2++;
                _loc_4 = _loc_2;
                if (cache[_loc_4] == param1)
                {
                    buf.b = buf.b + "r";
                    buf.b = buf.b + ("" + _loc_4);
                    return true;
                }
            }
            cache.push(param1);
            return false;
        }// end function

        public function serializeFields(param1) : void
        {
            var _loc_4:* = null as String;
            var _loc_2:* = 0;
            var _loc_3:* = Reflect.fields(param1);
            while (_loc_2 < _loc_3.length)
            {
                
                _loc_4 = _loc_3[_loc_2];
                _loc_2++;
                serializeString(_loc_4);
                serialize(Reflect.field(param1, _loc_4));
            }
            buf.b = buf.b + "g";
            return;
        }// end function

        public function serializeClassFields(param1:Object, param2:Class) : void
        {
            var _loc_7:* = 0;
            var _loc_8:* = null as String;
            var _loc_3:* = describeType(param2);
            var _loc_4:* = _loc_3.factory[0].child("variable");
            var _loc_5:* = 0;
            var _loc_6:* = _loc_4.length();
            while (_loc_5 < _loc_6)
            {
                
                _loc_5++;
                _loc_7 = _loc_5;
                _loc_8 = _loc_4[_loc_7].attribute("name").toString();
                if (!param1.hasOwnProperty(_loc_8))
                {
                    continue;
                }
                serializeString(_loc_8);
                serialize(Reflect.field(param1, _loc_8));
            }
            buf.b = buf.b + "g";
            return;
        }// end function

        public function serialize(param1) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = NaN;
            var _loc_6:* = null as Class;
            var _loc_7:* = null as Class;
            var _loc_8:* = null as Array;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            var _loc_12:* = null as List;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null as Date;
            var _loc_16:* = null as String;
            var _loc_17:* = null as StringMap;
            var _loc_18:* = null as IntMap;
            var _loc_19:* = null as ObjectMap;
            var _loc_20:* = null as Bytes;
            var _loc_21:* = null as StringBuf;
            var _loc_22:* = 0;
            var _loc_23:* = 0;
            var _loc_24:* = null as String;
            var _loc_3:* = Type.typeof(param1);
            switch(_loc_3.index) branch count is:<7>[48, 69, 141, 286, 2291, 2672, 333, 2347] default offset is:<29>;
            throw "Cannot serialize " + Std.string(param1);
            ;
            buf.b = buf.b + "n";
            ;
            _loc_4 = param1;
            if (_loc_4 == 0)
            {
                buf.b = buf.b + "z";
                return;
            }
            buf.b = buf.b + "i";
            buf.b = buf.b + ("" + _loc_4);
            ;
            _loc_5 = param1;
            if (Math.isNaN(_loc_5))
            {
                buf.b = buf.b + "k";
            }
            else if (!Math.isFinite(_loc_5))
            {
                if (_loc_5 < 0)
                {
                    buf.b = buf.b + "m";
                }
                else
                {
                    buf.b = buf.b + "p";
                }
            }
            else
            {
                buf.b = buf.b + "d";
                buf.b = buf.b + ("" + _loc_5);
            }
            ;
            if (param1)
            {
                buf.b = buf.b + "t";
            }
            else
            {
                buf.b = buf.b + "f";
            }
            ;
            _loc_6 = _loc_3.params[0];
            if (_loc_6 == String)
            {
                serializeString(param1);
                return;
            }
            if (useCache)
            {
            }
            if (serializeRef(param1))
            {
                return;
            }
            _loc_7 = _loc_6;
            if (_loc_7 == Array)
            {
                _loc_4 = 0;
                buf.b = buf.b + "a";
                _loc_8 = param1;
                _loc_9 = _loc_8.length;
                _loc_10 = 0;
                while (_loc_10 < _loc_9)
                {
                    
                    _loc_10++;
                    _loc_11 = _loc_10;
                    if (_loc_8[_loc_11] == null)
                    {
                        _loc_4++;
                        continue;
                    }
                    if (_loc_4 > 0)
                    {
                        if (_loc_4 == 1)
                        {
                            buf.b = buf.b + "n";
                        }
                        else
                        {
                            buf.b = buf.b + "u";
                            buf.b = buf.b + ("" + _loc_4);
                        }
                        _loc_4 = 0;
                    }
                    serialize(_loc_8[_loc_11]);
                }
                if (_loc_4 > 0)
                {
                    if (_loc_4 == 1)
                    {
                        buf.b = buf.b + "n";
                    }
                    else
                    {
                        buf.b = buf.b + "u";
                        buf.b = buf.b + ("" + _loc_4);
                    }
                }
                buf.b = buf.b + "h";
            }
            else if (_loc_7 == List)
            {
                buf.b = buf.b + "l";
                _loc_12 = param1;
                _loc_13 = _loc_12.iterator();
                
                if (_loc_13.hasNext())
                {
                    _loc_14 = _loc_13.next();
                    serialize(_loc_14);
                    ;
                }
                buf.b = buf.b + "h";
            }
            else if (_loc_7 == Date)
            {
                _loc_15 = param1;
                buf.b = buf.b + "v";
                _loc_16 = _loc_15.toString();
                if (_loc_16 == null)
                {
                    buf.b = buf.b + "null";
                }
                else
                {
                    buf.b = buf.b + ("" + _loc_16);
                }
            }
            else if (_loc_7 == StringMap)
            {
                buf.b = buf.b + "b";
                _loc_17 = param1;
                _loc_13 = _loc_17.keys();
                
                if (_loc_13.hasNext())
                {
                    _loc_16 = _loc_13.next();
                    serializeString(_loc_16);
                    serialize(_loc_17.get(_loc_16));
                    ;
                }
                buf.b = buf.b + "h";
            }
            else if (_loc_7 == IntMap)
            {
                buf.b = buf.b + "q";
                _loc_18 = param1;
                _loc_13 = _loc_18.keys();
                
                if (_loc_13.hasNext())
                {
                    _loc_4 = _loc_13.next();
                    buf.b = buf.b + ":";
                    buf.b = buf.b + ("" + _loc_4);
                    serialize(_loc_18.h[_loc_4]);
                    ;
                }
                buf.b = buf.b + "h";
            }
            else if (_loc_7 == ObjectMap)
            {
                buf.b = buf.b + "M";
                _loc_19 = param1;
                _loc_13 = _loc_19.keys();
                
                if (_loc_13.hasNext())
                {
                    _loc_14 = _loc_13.next();
                    serialize(_loc_14);
                    serialize(_loc_19[_loc_14]);
                    ;
                }
                buf.b = buf.b + "h";
            }
            else if (_loc_7 == Bytes)
            {
                _loc_20 = param1;
                _loc_4 = 0;
                _loc_9 = _loc_20.length - 2;
                _loc_21 = new StringBuf();
                _loc_16 = Serializer.BASE64;
                while (_loc_4 < _loc_9)
                {
                    
                    _loc_4++;
                    _loc_11 = _loc_4;
                    _loc_10 = _loc_20.b[_loc_11];
                    _loc_4++;
                    _loc_22 = _loc_4;
                    _loc_11 = _loc_20.b[_loc_22];
                    _loc_4++;
                    _loc_23 = _loc_4;
                    _loc_22 = _loc_20.b[_loc_23];
                    _loc_24 = _loc_16.charAt(_loc_10 >> 2);
                    if (_loc_24 == null)
                    {
                        _loc_21.b = _loc_21.b + "null";
                    }
                    else
                    {
                        _loc_21.b = _loc_21.b + ("" + _loc_24);
                    }
                    _loc_24 = _loc_16.charAt((_loc_10 << 4 | _loc_11 >> 4) & 63);
                    if (_loc_24 == null)
                    {
                        _loc_21.b = _loc_21.b + "null";
                    }
                    else
                    {
                        _loc_21.b = _loc_21.b + ("" + _loc_24);
                    }
                    _loc_24 = _loc_16.charAt((_loc_11 << 2 | _loc_22 >> 6) & 63);
                    if (_loc_24 == null)
                    {
                        _loc_21.b = _loc_21.b + "null";
                    }
                    else
                    {
                        _loc_21.b = _loc_21.b + ("" + _loc_24);
                    }
                    _loc_24 = _loc_16.charAt(_loc_22 & 63);
                    if (_loc_24 == null)
                    {
                        _loc_21.b = _loc_21.b + "null";
                        continue;
                    }
                    _loc_21.b = _loc_21.b + ("" + _loc_24);
                }
                if (_loc_4 == _loc_9)
                {
                    _loc_4++;
                    _loc_11 = _loc_4;
                    _loc_10 = _loc_20.b[_loc_11];
                    _loc_4++;
                    _loc_22 = _loc_4;
                    _loc_11 = _loc_20.b[_loc_22];
                    _loc_24 = _loc_16.charAt(_loc_10 >> 2);
                    if (_loc_24 == null)
                    {
                        _loc_21.b = _loc_21.b + "null";
                    }
                    else
                    {
                        _loc_21.b = _loc_21.b + ("" + _loc_24);
                    }
                    _loc_24 = _loc_16.charAt((_loc_10 << 4 | _loc_11 >> 4) & 63);
                    if (_loc_24 == null)
                    {
                        _loc_21.b = _loc_21.b + "null";
                    }
                    else
                    {
                        _loc_21.b = _loc_21.b + ("" + _loc_24);
                    }
                    _loc_24 = _loc_16.charAt(_loc_11 << 2 & 63);
                    if (_loc_24 == null)
                    {
                        _loc_21.b = _loc_21.b + "null";
                    }
                    else
                    {
                        _loc_21.b = _loc_21.b + ("" + _loc_24);
                    }
                }
                else if (_loc_4 == (_loc_9 + 1))
                {
                    _loc_4++;
                    _loc_11 = _loc_4;
                    _loc_10 = _loc_20.b[_loc_11];
                    _loc_24 = _loc_16.charAt(_loc_10 >> 2);
                    if (_loc_24 == null)
                    {
                        _loc_21.b = _loc_21.b + "null";
                    }
                    else
                    {
                        _loc_21.b = _loc_21.b + ("" + _loc_24);
                    }
                    _loc_24 = _loc_16.charAt(_loc_10 << 4 & 63);
                    if (_loc_24 == null)
                    {
                        _loc_21.b = _loc_21.b + "null";
                    }
                    else
                    {
                        _loc_21.b = _loc_21.b + ("" + _loc_24);
                    }
                }
                _loc_24 = _loc_21.b;
                buf.b = buf.b + "s";
                buf.b = buf.b + ("" + _loc_24.length);
                buf.b = buf.b + ":";
                if (_loc_24 == null)
                {
                    buf.b = buf.b + "null";
                }
                else
                {
                    buf.b = buf.b + ("" + _loc_24);
                }
            }
            else
            {
                if (useCache)
                {
                    cache.pop();
                }
                ;
                _loc_13 = param1.hxSerialize != null;
                if (false)
                {
                    buf.b = buf.b + "C";
                    serializeString(Type.getClassName(_loc_6));
                    if (useCache)
                    {
                        cache.push(param1);
                    }
                    param1.hxSerialize(this);
                    buf.b = buf.b + "g";
                }
                else
                {
                    buf.b = buf.b + "c";
                    serializeString(Type.getClassName(_loc_6));
                    if (useCache)
                    {
                        cache.push(param1);
                    }
                    serializeClassFields(param1, _loc_6);
                }
            }
            ;
            if (useCache)
            {
            }
            if (serializeRef(param1))
            {
                return;
            }
            buf.b = buf.b + "o";
            serializeFields(param1);
            ;
            _loc_6 = _loc_3.params[0];
            if (useCache)
            {
                if (serializeRef(param1))
                {
                    return;
                }
                cache.pop();
            }
            if (useEnumIndex)
            {
                buf.b = buf.b + "j";
            }
            else
            {
                buf.b = buf.b + "w";
            }
            serializeString(Type.getEnumName(_loc_6));
            if (useEnumIndex)
            {
                buf.b = buf.b + ":";
                _loc_4 = param1.index;
                buf.b = buf.b + ("" + _loc_4);
            }
            else
            {
                serializeString(param1.tag);
            }
            buf.b = buf.b + ":";
            _loc_8 = param1.params;
            if (_loc_8 == null)
            {
                buf.b = buf.b + "0";
            }
            else
            {
                buf.b = buf.b + ("" + _loc_8.length);
                _loc_4 = 0;
                while (_loc_4 < _loc_8.length)
                {
                    
                    _loc_13 = _loc_8[_loc_4];
                    _loc_4++;
                    serialize(_loc_13);
                }
            }
            if (useCache)
            {
                cache.push(param1);
            }
            ;
            throw "Cannot serialize function";
            return;
        }// end function

        public static function run(param1) : String
        {
            var _loc_2:* = new Serializer();
            _loc_2.serialize(param1);
            return _loc_2.toString();
        }// end function

    }
}
