package 
{
    import flash.*;
    import flash.utils.*;

    public class Type extends Object
    {

        public function Type() : void
        {
            return;
        }// end function

        public static function getClass(param1:Object) : Class
        {
            var _loc_2:* = getQualifiedClassName(param1);
            if (_loc_2 != "null")
            {
            }
            if (_loc_2 != "Object")
            {
            }
            if (_loc_2 != "int")
            {
            }
            if (_loc_2 != "Number")
            {
            }
            if (_loc_2 == "Boolean")
            {
                return null;
            }
            if (param1.hasOwnProperty("prototype"))
            {
                return null;
            }
            var _loc_3:* = getDefinitionByName(_loc_2) as Class;
            if (_loc_3.__isenum)
            {
                return null;
            }
            return _loc_3;
        }// end function

        public static function getClassName(param1:Class) : String
        {
            if (param1 == null)
            {
                return null;
            }
            var _loc_2:* = getQualifiedClassName(param1);
            var _loc_3:* = _loc_2;
            if (_loc_3 == "int")
            {
                return "Int";
            }
            else if (_loc_3 == "Number")
            {
                return "Float";
            }
            else if (_loc_3 == "Boolean")
            {
                return "Bool";
                ;
            }
            return _loc_2.split("::").join(".");
        }// end function

        public static function getEnumName(param1:Class) : String
        {
            return Type.getClassName(param1);
        }// end function

        public static function resolveClass(param1:String) : Class
        {
            var _loc_3:* = null as Class;
            var _loc_4:* = null;
            var _loc_5:* = null as String;
            _loc_3 = getDefinitionByName(param1) as Class;
            if (_loc_3.__isenum)
            {
                return null;
            }
            return _loc_3;
            ;
            _loc_4 = null;
            _loc_5 = param1;
            if (_loc_5 == "Int")
            {
                return int;
            }
            else if (_loc_5 == "Float")
            {
                return Number;
                ;
            }
            return null;
            if (_loc_3 != null)
            {
            }
            if (_loc_3.__name__ == null)
            {
                return null;
            }
            return _loc_3;
        }// end function

        public static function resolveEnum(param1:String) : Class
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            _loc_3 = getDefinitionByName(param1);
            if (!_loc_3.__isenum)
            {
                return null;
            }
            return _loc_3;
            ;
            _loc_4 = null;
            if (param1 == "Bool")
            {
                return Boolean;
            }
            return null;
            if (_loc_3 != null)
            {
            }
            if (_loc_3.__ename__ == null)
            {
                return null;
            }
            return _loc_3;
        }// end function

        public static function createInstance(param1:Class, param2:Array) : Object
        {
            var _loc_3:* = param2.length;
            switch(_loc_3) branch count is:<14>[57, 65, 79, 99, 125, 157, 195, 239, 289, 345, 407, 475, 549, 629, 715] default offset is:<50>;
            throw "Too many arguments";
            ;
            return new param1;
            ;
            return new param1(param2[0]);
            ;
            return new param1(param2[0], param2[1]);
            ;
            return new param1(param2[0], param2[1], param2[2]);
            ;
            return new param1(param2[0], param2[1], param2[2], param2[3]);
            ;
            return new param1(param2[0], param2[1], param2[2], param2[3], param2[4]);
            ;
            return new param1(param2[0], param2[1], param2[2], param2[3], param2[4], param2[5]);
            ;
            return new param1(param2[0], param2[1], param2[2], param2[3], param2[4], param2[5], param2[6]);
            ;
            return new param1(param2[0], param2[1], param2[2], param2[3], param2[4], param2[5], param2[6], param2[7]);
            ;
            return new param1(param2[0], param2[1], param2[2], param2[3], param2[4], param2[5], param2[6], param2[7], param2[8]);
            ;
            return new param1(param2[0], param2[1], param2[2], param2[3], param2[4], param2[5], param2[6], param2[7], param2[8], param2[9]);
            ;
            return new param1(param2[0], param2[1], param2[2], param2[3], param2[4], param2[5], param2[6], param2[7], param2[8], param2[9], param2[10]);
            ;
            return new param1(param2[0], param2[1], param2[2], param2[3], param2[4], param2[5], param2[6], param2[7], param2[8], param2[9], param2[10], param2[11]);
            ;
            return new param1(param2[0], param2[1], param2[2], param2[3], param2[4], param2[5], param2[6], param2[7], param2[8], param2[9], param2[10], param2[11], param2[12]);
            ;
            return new param1(param2[0], param2[1], param2[2], param2[3], param2[4], param2[5], param2[6], param2[7], param2[8], param2[9], param2[10], param2[11], param2[12], param2[13]);
            return;
        }// end function

        public static function createEmptyInstance(param1:Class) : Object
        {
            var _loc_3:* = null as Object;
            var _loc_4:* = null;
            Boot.skip_constructor = true;
            _loc_3 = new param1;
            Boot.skip_constructor = false;
            return _loc_3;
            ;
            _loc_4 = null;
            Boot.skip_constructor = false;
            throw _loc_4;
            return null;
        }// end function

        public static function createEnum(param1:Class, param2:String, param3:Array = undefined) : Object
        {
            var _loc_4:* = param1[param2];
            if (_loc_4 == null)
            {
                throw "No such constructor " + param2;
            }
            if (Reflect.isFunction(_loc_4))
            {
                if (param3 == null)
                {
                    throw "Constructor " + param2 + " need parameters";
                }
                return _loc_4.apply(param1, param3);
            }
            if (param3 != null)
            {
            }
            if (param3.length != 0)
            {
                throw "Constructor " + param2 + " does not need parameters";
            }
            return _loc_4;
        }// end function

        public static function getEnumConstructs(param1:Class) : Array
        {
            var _loc_2:* = param1.__constructs__;
            return _loc_2.copy();
        }// end function

        public static function typeof(param1) : ValueType
        {
            var _loc_5:* = NaN;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_3:* = getQualifiedClassName(param1);
            var _loc_4:* = _loc_3;
            if (_loc_4 == "null")
            {
                return ValueType.TNull;
            }
            else if (_loc_4 == "void")
            {
                return ValueType.TNull;
            }
            else if (_loc_4 == "int")
            {
                return ValueType.TInt;
            }
            else if (_loc_4 == "Number")
            {
                if (param1 >= -268435456)
                {
                }
                if (param1 >= 268435456)
                {
                    _loc_5 = param1;
                }
                if (_loc_5 == param1)
                {
                    return ValueType.TInt;
                }
                return ValueType.TFloat;
            }
            else if (_loc_4 == "Boolean")
            {
                return ValueType.TBool;
            }
            else if (_loc_4 == "Object")
            {
                return ValueType.TObject;
            }
            else if (_loc_4 == "Function")
            {
                return ValueType.TFunction;
            }
            else
            {
                _loc_6 = null;
                _loc_6 = getDefinitionByName(_loc_3);
                if (param1.hasOwnProperty("prototype"))
                {
                    return ValueType.TObject;
                }
                if (_loc_6.__isenum)
                {
                    return ValueType.TEnum(_loc_6);
                }
                return ValueType.TClass(_loc_6);
                ;
                _loc_7 = null;
                if (_loc_3 != "builtin.as$0::MethodClosure")
                {
                }
                if (_loc_3.indexOf("-") != -1)
                {
                    return ValueType.TFunction;
                }
                if (_loc_6 == null)
                {
                    return ValueType.TFunction;
                }
                else
                {
                    return ValueType.TClass(_loc_6);
                }
            }
            return null;
        }// end function

        public static function enumEq(param1:Object, param2:Object) : Boolean
        {
            var _loc_4:* = null as Array;
            var _loc_5:* = null as Array;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            if (param1 == param2)
            {
                return true;
            }
            if (param1.index != param2.index)
            {
                return false;
            }
            _loc_4 = param1.params;
            _loc_5 = param2.params;
            _loc_6 = 0;
            _loc_7 = _loc_4.length;
            while (_loc_6 < _loc_7)
            {
                
                _loc_6++;
                _loc_8 = _loc_6;
                if (!Type.enumEq(_loc_4[_loc_8], _loc_5[_loc_8]))
                {
                    return false;
                }
            }
            ;
            _loc_9 = null;
            return false;
            return true;
        }// end function

    }
}
