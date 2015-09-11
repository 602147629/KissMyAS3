package 
{
    import flash.*;

    final public class ValueType extends Object
    {
        public var tag:String;
        public var index:int;
        public var params:Array;
        public const __enum__:Boolean = true;
        public static const __isenum:Boolean = true;
        public static var __constructs__:Object;
        public static var TUnknown:ValueType;
        public static var TObject:ValueType;
        public static var TNull:ValueType;
        public static var TInt:ValueType;
        public static var TFunction:ValueType;
        public static var TFloat:ValueType;
        public static var TBool:ValueType;

        public function ValueType(param1:String, param2:int, param3) : void
        {
            tag = param1;
            index = param2;
            params = param3;
            return;
        }// end function

        final public function toString() : String
        {
            return Boot.enum_to_string(this);
        }// end function

        public static function TEnum(param1:Class) : ValueType
        {
            return new ValueType("TEnum", 7, [param1]);
        }// end function

        public static function TClass(param1:Class) : ValueType
        {
            return new ValueType("TClass", 6, [param1]);
        }// end function

    }
}
