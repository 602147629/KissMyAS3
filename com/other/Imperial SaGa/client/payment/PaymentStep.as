package payment
{

    public class PaymentStep extends Object
    {
        private var _id:uint;
        private var _jadge:int;
        private var _resourceType:int;
        private var _value:int;
        public static const ID_INSTANT_CROWN:int = 10;
        public static const ID_INSTANT_INSTANT_LEARNING:int = 11;
        public static const ID_ADD_PROBABILITY_CROWN:int = 20;
        public static const ID_ADD_PROBABILITY_PROBABILITY_ITEM:int = 21;
        public static const RESOURCE_TYPE_CROWN:int = 0;
        public static const RESOURCE_TYPE_INSTANT_LEARNING:int = 1;
        public static const RESOURCE_TYPE_PROBABILITY_ITEM:int = 2;

        public function PaymentStep()
        {
            return;
        }// end function

        public function get id() : uint
        {
            return this._id;
        }// end function

        public function get jadge() : int
        {
            return this._jadge;
        }// end function

        public function get resourceType() : int
        {
            return this._resourceType;
        }// end function

        public function get value() : int
        {
            return this._value;
        }// end function

        public function setXml(param1:XML) : void
        {
            this._id = param1.id;
            this._jadge = param1.jadge;
            this._resourceType = param1.resourceType;
            this._value = param1.value;
            return;
        }// end function

    }
}
