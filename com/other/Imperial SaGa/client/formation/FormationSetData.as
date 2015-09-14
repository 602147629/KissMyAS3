package formation
{

    public class FormationSetData extends Object
    {
        private var _id:int;
        private var _aPlayerUniqueId:Array;
        public static const FORMATION_INDEX_POSITION_1:int = 0;
        public static const FORMATION_INDEX_POSITION_2:int = 1;
        public static const FORMATION_INDEX_POSITION_3:int = 2;
        public static const FORMATION_INDEX_POSITION_4:int = 3;
        public static const FORMATION_INDEX_POSITION_5:int = 4;
        public static const FORMATION_INDEX_COMMANDER:int = 5;
        public static const FORMATION_INDEX_NUM:int = 6;

        public function FormationSetData(param1:int, param2:Array)
        {
            this.setData(param1, param2);
            return;
        }// end function

        public function get id() : int
        {
            return this._id;
        }// end function

        public function get aPlayerUniqueId() : Array
        {
            return this._aPlayerUniqueId.concat();
        }// end function

        public function setData(param1:int, param2:Array) : void
        {
            this._id = param1;
            this._aPlayerUniqueId = param2.concat();
            return;
        }// end function

        public function toObject() : Object
        {
            return {id:this._id, aPlayerUniqueId:this._aPlayerUniqueId.concat()};
        }// end function

    }
}
