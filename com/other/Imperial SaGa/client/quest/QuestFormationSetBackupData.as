package quest
{
    import formation.*;

    public class QuestFormationSetBackupData extends Object
    {
        private var _aKeyMember:Array;
        private var _unitFormation:FormationSetData;

        public function QuestFormationSetBackupData(param1:Array, param2:FormationSetData)
        {
            this._aKeyMember = param1.concat();
            this._unitFormation = new FormationSetData(param2.id, param2.aPlayerUniqueId);
            return;
        }// end function

        public function get aKeyMember() : Array
        {
            return this._aKeyMember;
        }// end function

        public function get unitFormation() : FormationSetData
        {
            return this._unitFormation;
        }// end function

        public function checkKeyMember(param1:Array) : Boolean
        {
            if (this._aKeyMember.length != param1.length)
            {
                return false;
            }
            var _loc_2:* = 0;
            while (_loc_2 < this._aKeyMember.length)
            {
                
                if (this._aKeyMember[_loc_2] != param1[_loc_2])
                {
                    return false;
                }
                _loc_2++;
            }
            return true;
        }// end function

    }
}
