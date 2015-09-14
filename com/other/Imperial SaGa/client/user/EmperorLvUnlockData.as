package user
{

    public class EmperorLvUnlockData extends Object
    {
        private var _type:int;
        private var _id:int;
        public static const UNLOCK_TYPE_FACILITY:int = 0;
        public static const UNLOCK_TYPE_FORMATION:int = 1;
        public static const UNLOCK_TYPE_ITEM:int = 2;
        public static const UNLOCK_ID_COMMANDER_SKILL:int = 100;

        public function EmperorLvUnlockData(param1:int, param2:int)
        {
            this._type = param1;
            this._id = param2;
            return;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function get id() : int
        {
            return this._id;
        }// end function

    }
}
