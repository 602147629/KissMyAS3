package script
{

    public class FlagInfomation extends Object
    {
        private var _id:int;
        private var _updateCondition:int;
        private static const UPDATE_CONDTION_NONE:int = 0;
        private static const UPDATE_CONDTION_CLEAR:int = 1;

        public function FlagInfomation()
        {
            return;
        }// end function

        public function setFlagInfomation(param1:XML) : void
        {
            this._id = parseInt(param1.id);
            this._updateCondition = parseInt(param1.updateCondtion);
            return;
        }// end function

        public function checkUpdateCondtion(param1:int) : Boolean
        {
            if (this._updateCondition == UPDATE_CONDTION_NONE)
            {
                return true;
            }
            if (this._updateCondition == UPDATE_CONDTION_CLEAR && param1 == CommonConstant.QUEST_RESULT_CLEAR)
            {
                return true;
            }
            return false;
        }// end function

        public function get id() : int
        {
            return this._id;
        }// end function

        public function get updateCondition() : int
        {
            return this._updateCondition;
        }// end function

    }
}
