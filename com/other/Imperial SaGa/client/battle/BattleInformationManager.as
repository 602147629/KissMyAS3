package battle
{
    import resource.*;

    public class BattleInformationManager extends Object
    {
        private var _bCreated:Boolean;
        private var _bCreatedStatus:Boolean;
        private var _bCreatedFlashSkill:Boolean;
        private var _loader:XmlLoader;
        private var _loaderStatus:XmlLoader;
        private var _loaderFlashSkill:XmlLoader;
        private var _aBattleBg:Array;
        private var _aBattleStatus:Array;
        private var _aBattleFlashSkill:Array;
        private static var _instance:BattleInformationManager = null;

        public function BattleInformationManager()
        {
            this._aBattleBg = [];
            this._aBattleStatus = [];
            this._aBattleFlashSkill = [];
            return;
        }// end function

        public function get bCreated() : Boolean
        {
            return this._bCreated;
        }// end function

        public function get bCreatedStatus() : Boolean
        {
            return this._bCreatedStatus;
        }// end function

        public function get bCreatedFlashSkill() : Boolean
        {
            return this._bCreatedFlashSkill;
        }// end function

        public function get aBattleStatus() : Array
        {
            return this._aBattleStatus.concat();
        }// end function

        public function get aBattleFlashSkill() : Array
        {
            return this._aBattleFlashSkill.concat();
        }// end function

        public function loadData() : void
        {
            this._loader = new XmlLoader();
            this._loader.load(ResourcePath.PARAMETER_PATH + "BattleBg.xml", this.cbLoadComplete, false);
            this._loaderStatus = new XmlLoader();
            this._loaderStatus.load(ResourcePath.PARAMETER_PATH + "StatusList.xml", this.cbLoadStatusListComplete, false);
            this._loaderFlashSkill = new XmlLoader();
            this._loaderFlashSkill.load(ResourcePath.PARAMETER_PATH + "FlashSkillParameter.xml", this.cbLoadFlashSkillComplete, false);
            return;
        }// end function

        public function isLoaded() : Boolean
        {
            if (this._loader != null && this._loaderStatus != null && this._loaderFlashSkill != null)
            {
                return this._loader.bLoaded && this._loaderStatus.bLoaded && this._loaderFlashSkill.bLoaded;
            }
            return false;
        }// end function

        private function cbLoadComplete(param1:XML) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_2:* = uint(param1.Ver);
            for each (_loc_3 in param1.Data)
            {
                
                _loc_4 = new BattleBgListData();
                _loc_4.setXml(_loc_3);
                this._aBattleBg.push(_loc_4);
            }
            this._loader.release();
            this._loader = null;
            this._bCreated = true;
            return;
        }// end function

        private function cbLoadStatusListComplete(param1:XML) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            for each (_loc_2 in param1.Data)
            {
                
                _loc_3 = new BattleStatusListData();
                _loc_3.setXml(_loc_2);
                this._aBattleStatus.push(_loc_3);
            }
            this._loaderStatus.release();
            this._loaderStatus = null;
            this._bCreatedStatus = true;
            return;
        }// end function

        private function cbLoadFlashSkillComplete(param1:XML) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            for each (_loc_2 in param1.Data)
            {
                
                _loc_3 = new BattleFlashSkillData();
                _loc_3.setXml(_loc_2);
                this._aBattleFlashSkill.push(_loc_3);
            }
            this._loaderFlashSkill.release();
            this._loaderFlashSkill = null;
            this._bCreatedFlashSkill = true;
            return;
        }// end function

        public function getBgFileName(param1:int) : String
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aBattleBg)
            {
                
                if (_loc_2.id == param1)
                {
                    return _loc_2.fileName;
                }
            }
            return "";
        }// end function

        public function getStatusListData(param1:int) : BattleStatusListData
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aBattleStatus)
            {
                
                if (_loc_2.id == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function getGorupBadStatusId(param1:int) : Array
        {
            var _loc_3:* = null;
            var _loc_2:* = [];
            for each (_loc_3 in this._aBattleStatus)
            {
                
                if (_loc_3.group == param1)
                {
                    _loc_2.push(_loc_3.id);
                }
            }
            return _loc_2;
        }// end function

        public function getFlashSkillData(param1:int) : BattleFlashSkillData
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aBattleFlashSkill)
            {
                
                if (_loc_2.enemyRank == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public static function getInstance() : BattleInformationManager
        {
            if (_instance == null)
            {
                _instance = new BattleInformationManager;
            }
            return _instance;
        }// end function

    }
}
