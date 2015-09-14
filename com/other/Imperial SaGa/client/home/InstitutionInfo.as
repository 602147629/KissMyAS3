package home
{
    import facility.*;

    public class InstitutionInfo extends Object
    {
        private var _id:int;
        private var _grade:int;
        private var _exp:int;
        private var _aUpgradeTime:Array;
        private var _type:Array;
        private var _upgradeEnd:int;
        private var _bBusy:Boolean;

        public function InstitutionInfo()
        {
            this._id = Constant.EMPTY_ID;
            this._grade = 0;
            this._exp = 0;
            this._aUpgradeTime = [];
            this._type = [];
            this._upgradeEnd = 0;
            this._bBusy = false;
            return;
        }// end function

        public function setFacilityInfo(param1:Object) : void
        {
            var _loc_2:* = null;
            this._id = param1.id;
            this._grade = param1.grade;
            this._exp = param1.exp;
            if (param1.aUpGradeData && param1.aUpGradeData.length > 0)
            {
                this._aUpgradeTime = [];
                for each (_loc_2 in param1.aUpGradeData)
                {
                    
                    this._aUpgradeTime.push(new FacilityUpgradeTimeData(_loc_2));
                }
            }
            this._upgradeEnd = param1.upgradeEnd;
            this._bBusy = false;
            return;
        }// end function

        public function get id() : int
        {
            return this._id;
        }// end function

        public function get grade() : int
        {
            return this._grade;
        }// end function

        public function get exp() : int
        {
            return this._exp;
        }// end function

        public function get aUpgradeTime() : Array
        {
            var _loc_2:* = null;
            var _loc_1:* = [];
            for each (_loc_2 in this._aUpgradeTime)
            {
                
                _loc_1.push(_loc_2.clone());
            }
            return _loc_1;
        }// end function

        public function get aUpgradeType() : Array
        {
            var _loc_2:* = null;
            var _loc_1:* = [];
            for each (_loc_2 in this._aUpgradeTime)
            {
                
                _loc_1.push(_loc_2.clone());
            }
            return _loc_1;
        }// end function

        public function get upgradeEnd() : int
        {
            return this._upgradeEnd;
        }// end function

        public function get bBusy() : Boolean
        {
            return this._bBusy;
        }// end function

        public function setBusy() : void
        {
            this._bBusy = true;
            return;
        }// end function

    }
}
