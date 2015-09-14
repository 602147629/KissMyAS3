package notice
{
    import flash.display.*;
    import item.*;
    import player.*;
    import resource.*;
    import tutorial.*;
    import utility.*;

    public class NoticeManager extends Object
    {
        private var _aManagementNotice:Array;
        private var _bManagementNoticeAutoDisp:Boolean;
        private var _aInstitutionNotice:Array;
        private var _aThroughNotice:Array;
        private var _aCharacterLost:Array;
        private var _aLocalNotice:Array;
        private var _noticeTime:uint;
        private var _bLvUpNotice:Boolean;
        private static var _instance:NoticeManager = null;
        public static const SPECIAL_NOTICE:Array = [CommonConstant.NOTICE_CYCLE_CHANGE, CommonConstant.NOTICE_QUEST_LOGOUT];
        public static const NORMAL_NOTICE:Array = [CommonConstant.NOTICE_FACILITY_BARRACKS, CommonConstant.NOTICE_FACILITY_MAGIC_DEVELOP, CommonConstant.NOTICE_FACILITY_MAGIC_DEVELOP_DEVELOP, CommonConstant.NOTICE_FACILITY_SKILL_RESEARCH, CommonConstant.NOTICE_FACILITY_TRAINING_KUMITE, CommonConstant.NOTICE_FACILITY_TRAINING_TRAINING, CommonConstant.NOTICE_PAYMENT_EVENT, CommonConstant.NOTICE_LV_UP_FACILITY, CommonConstant.NOTICE_LV_UP_COMMANDER, CommonConstant.NOTICE_LV_UP_FORMATION, CommonConstant.NOTICE_LV_UP_REMUNERATION];
        public static const LATER_NOTICE:Array = [CommonConstant.NOTICE_COOPERATE_SERIAL];
        private static const THROUGH_NOTICE:Array = [CommonConstant.NOTICE_LV_UP];

        public function NoticeManager()
        {
            return;
        }// end function

        public function init() : void
        {
            this._aInstitutionNotice = [];
            this._aThroughNotice = [];
            this._aManagementNotice = [];
            this._bManagementNoticeAutoDisp = false;
            this._aCharacterLost = [];
            this._aLocalNotice = [];
            this._bLvUpNotice = false;
            return;
        }// end function

        public function addManagementNoticeByObject(param1:Object) : void
        {
            var _loc_2:* = new ManagementNoticeInfo();
            _loc_2.setNoticeInfo(param1);
            this._aManagementNotice.push(_loc_2);
            return;
        }// end function

        public function setManagementNoticeAutoDisp(param1:Boolean) : void
        {
            this._bManagementNoticeAutoDisp = param1;
            return;
        }// end function

        public function addMiniNoticeByObject(param1:Object) : void
        {
            var _loc_2:* = new SimpleNoticeInfo();
            _loc_2.setNoticeInfo(param1);
            if (THROUGH_NOTICE.indexOf(_loc_2.type) >= 0)
            {
                this._aThroughNotice.push(_loc_2);
            }
            else
            {
                this._aInstitutionNotice.push(_loc_2);
            }
            return;
        }// end function

        public function addLvUpNoticeByObject(param1:Object, param2:Boolean) : void
        {
            var _loc_3:* = new SimpleNoticeInfo();
            _loc_3.setNoticeInfo(param1);
            _loc_3.setWarehouse(param2);
            if (THROUGH_NOTICE.indexOf(_loc_3.type) >= 0)
            {
                this._aThroughNotice.push(_loc_3);
            }
            else
            {
                this._aInstitutionNotice.push(_loc_3);
            }
            this._bLvUpNotice = true;
            return;
        }// end function

        public function addCharacterLost(param1:Object) : void
        {
            var _loc_2:* = new PlayerLostData(param1.uniqueId, param1.playerId);
            this._aCharacterLost.push(_loc_2);
            return;
        }// end function

        public function addLocalNotice(param1:int) : void
        {
            var _loc_2:* = new LocalNoticeInfo(param1);
            this._aLocalNotice.push(_loc_2);
            return;
        }// end function

        public function createMiniNotice(param1:Sprite, param2:Array) : SimpleNoticeWindow
        {
            var _loc_3:* = this.aShowNoticeInfo(param2);
            var _loc_4:* = null;
            if (_loc_3.length > 0)
            {
                _loc_3.sortOn(["sortParam", "epochTime"], [Array.NUMERIC, Array.NUMERIC | Array.DESCENDING]);
                this._noticeTime = _loc_3[0].epochTime;
                _loc_4 = new SimpleNoticeWindow(param1, _loc_3[0], this._bLvUpNotice, this.getRemunerationNotice(_loc_3[0].type, this._noticeTime));
            }
            return _loc_4;
        }// end function

        public function bShowNotice() : Boolean
        {
            var _loc_2:* = null;
            var _loc_1:* = false;
            for each (_loc_2 in this._aInstitutionNotice)
            {
                
                if (this.isTutorialDisableType(_loc_2.type))
                {
                    continue;
                }
                _loc_1 = TimeClock.bProgressTime(_loc_2.epochTime);
                if (_loc_1)
                {
                    break;
                }
            }
            return _loc_1;
        }// end function

        public function aShowNoticeInfo(param1:Array) : Array
        {
            var _loc_3:* = null;
            var _loc_2:* = [];
            for each (_loc_3 in this._aInstitutionNotice)
            {
                
                if (param1.indexOf(_loc_3.type) == -1 || this.isTutorialDisableType(_loc_3.type))
                {
                    continue;
                }
                if (TimeClock.bProgressTime(_loc_3.epochTime) == true)
                {
                    _loc_2.push(_loc_3);
                }
            }
            return _loc_2;
        }// end function

        private function isTutorialDisableType(param1:int) : Boolean
        {
            switch(param1)
            {
                case CommonConstant.NOTICE_FACILITY_TRAINING_KUMITE:
                {
                    return TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_KUMITE_6);
                }
                case CommonConstant.NOTICE_FACILITY_TRAINING_TRAINING:
                {
                    return TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_TRAINING_4);
                }
                case CommonConstant.NOTICE_FACILITY_MAGIC_DEVELOP_DEVELOP:
                {
                    return TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_MAGIC_LABO_DEVELOP_3);
                }
                case CommonConstant.NOTICE_FACILITY_MAGIC_DEVELOP:
                {
                    return TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_MAGIC_LABO_LEARNING_4);
                }
                case CommonConstant.NOTICE_FACILITY_BARRACKS:
                {
                    return TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_BARRACKS_3);
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

        public function aEndNoticeUniqueId(param1:int) : Array
        {
            var _loc_3:* = null;
            var _loc_2:* = [];
            for each (_loc_3 in this._aInstitutionNotice)
            {
                
                if (_loc_3.type == param1)
                {
                    if (_loc_3.epochTime <= this._noticeTime)
                    {
                        _loc_2.push(_loc_3.uniqueId);
                    }
                }
            }
            return _loc_2;
        }// end function

        public function bShowManagementNotice() : Boolean
        {
            if (this._bManagementNoticeAutoDisp == true && this._aManagementNotice.length > 0)
            {
                return true;
            }
            return false;
        }// end function

        public function crearManagementNotice() : void
        {
            this._bManagementNoticeAutoDisp = false;
            return;
        }// end function

        public function bShowAlreadyManagementNotice() : Boolean
        {
            return this._aManagementNotice.length > 0;
        }// end function

        public function clearCharacterLostNotice() : void
        {
            this._aCharacterLost = [];
            return;
        }// end function

        public function clearLocalNotice() : void
        {
            this._aLocalNotice = [];
            return;
        }// end function

        public function clearThroughNotice() : void
        {
            this._aThroughNotice = [];
            return;
        }// end function

        public function clearThroughNoticeById(param1:int) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = this._aThroughNotice.length - 1;
            while (_loc_2 >= 0)
            {
                
                _loc_3 = this._aThroughNotice[_loc_2];
                if (_loc_3.uniqueId == param1)
                {
                    this._aThroughNotice.splice(_loc_2, 1);
                    break;
                }
                _loc_2 = _loc_2 - 1;
            }
            return;
        }// end function

        public function crearSimpleNoticeById(param1:int) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = this._aInstitutionNotice.length - 1;
            while (_loc_2 >= 0)
            {
                
                _loc_3 = this._aInstitutionNotice[_loc_2];
                if (_loc_3.uniqueId == param1)
                {
                    this._aInstitutionNotice.splice(_loc_2, 1);
                    break;
                }
                _loc_2 = _loc_2 - 1;
            }
            return;
        }// end function

        public function crearSimpleNoticeByType(param1:int) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = this._aInstitutionNotice.length - 1;
            while (_loc_2 >= 0)
            {
                
                _loc_3 = this._aInstitutionNotice[_loc_2];
                if (_loc_3.type == param1)
                {
                    if (_loc_3.epochTime <= this._noticeTime)
                    {
                        this._aInstitutionNotice.splice(_loc_2, 1);
                    }
                }
                _loc_2 = _loc_2 - 1;
            }
            this._noticeTime = 0;
            if (param1 == CommonConstant.NOTICE_LV_UP_REMUNERATION || param1 == CommonConstant.NOTICE_LV_UP_FORMATION || param1 == CommonConstant.NOTICE_LV_UP_FACILITY || param1 == CommonConstant.NOTICE_LV_UP_COMMANDER)
            {
                this._bLvUpNotice = false;
            }
            return;
        }// end function

        public function removeSimpleNoticeById(param1:int) : SimpleNoticeInfo
        {
            var _loc_3:* = null;
            var _loc_2:* = this._aInstitutionNotice.length - 1;
            while (_loc_2 >= 0)
            {
                
                _loc_3 = this._aInstitutionNotice[_loc_2];
                if (_loc_3.uniqueId == param1)
                {
                    this._aInstitutionNotice.splice(_loc_2, 1);
                    return _loc_3;
                }
                _loc_2 = _loc_2 - 1;
            }
            return null;
        }// end function

        public function removeSimpleNoticeByTypeTime(param1:int, param2:uint) : SimpleNoticeInfo
        {
            var _loc_4:* = null;
            var _loc_3:* = this._aInstitutionNotice.length - 1;
            while (_loc_3 >= 0)
            {
                
                _loc_4 = this._aInstitutionNotice[_loc_3];
                if (_loc_4.type == param1 && _loc_4.epochTime == param2)
                {
                    this._aInstitutionNotice.splice(_loc_3, 1);
                    return _loc_4;
                }
                _loc_3 = _loc_3 - 1;
            }
            return null;
        }// end function

        public function addThroughNotice(param1:SimpleNoticeInfo) : void
        {
            if (param1)
            {
                this._aThroughNotice.push(param1);
            }
            return;
        }// end function

        public function getLvUpCount() : int
        {
            var _loc_3:* = null;
            var _loc_1:* = 0;
            var _loc_2:* = this._aInstitutionNotice.length - 1;
            while (_loc_2 >= 0)
            {
                
                _loc_3 = this._aInstitutionNotice[_loc_2];
                if (_loc_3.type == CommonConstant.NOTICE_LV_UP_REMUNERATION)
                {
                    _loc_1++;
                }
                _loc_2 = _loc_2 - 1;
            }
            return _loc_1;
        }// end function

        public function loadRemunerationResource() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            for each (_loc_2 in this._aInstitutionNotice)
            {
                
                if ((_loc_2.type == CommonConstant.NOTICE_LV_UP_REMUNERATION || _loc_2.type == CommonConstant.NOTICE_PAYMENT_EVENT) && _loc_2.itemType)
                {
                    _loc_1 = ItemManager.getInstance().getItemPng(_loc_2.itemType, _loc_2.itemId);
                    if (_loc_1)
                    {
                        ResourceManager.getInstance().loadResource(_loc_1);
                    }
                }
            }
            return;
        }// end function

        private function getRemunerationNotice(param1:int, param2:uint) : Array
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            if (param1 == CommonConstant.NOTICE_LV_UP_REMUNERATION || param1 == CommonConstant.NOTICE_PAYMENT_EVENT)
            {
                _loc_3 = [];
                _loc_4 = 0;
                while (_loc_4 < this._aInstitutionNotice.length)
                {
                    
                    _loc_5 = this._aInstitutionNotice[_loc_4];
                    if (_loc_5.type == param1 && _loc_5.itemType)
                    {
                        if (_loc_5.epochTime <= param2)
                        {
                            _loc_6 = new RemunerationNoticeData();
                            _loc_6.setRemuneration(_loc_5.uniqueId, _loc_5.type, _loc_5.itemType, _loc_5.itemId, _loc_5.itemNum, _loc_5.bWarehouse);
                            _loc_3.push(_loc_6);
                        }
                    }
                    _loc_4++;
                }
                if (_loc_3.length > 0)
                {
                    return _loc_3;
                }
            }
            return null;
        }// end function

        public function get aManagementNotice() : Array
        {
            return this._aManagementNotice;
        }// end function

        public function get aInstitutionNotice() : Array
        {
            return this._aInstitutionNotice.concat();
        }// end function

        public function get aThroughNotice() : Array
        {
            return this._aThroughNotice.concat();
        }// end function

        public function get aCharacterLost() : Array
        {
            return this._aCharacterLost.concat();
        }// end function

        public function get aLocalNotice() : Array
        {
            return this._aLocalNotice.concat();
        }// end function

        public static function getInstance() : NoticeManager
        {
            if (_instance == null)
            {
                _instance = new NoticeManager;
            }
            return _instance;
        }// end function

    }
}
