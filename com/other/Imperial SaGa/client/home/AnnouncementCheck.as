package home
{
    import barracks.*;
    import flash.display.*;
    import magicLaboratory.*;
    import message.*;
    import player.*;
    import storage.*;
    import tutorial.*;
    import user.*;
    import utility.*;

    public class AnnouncementCheck extends Object
    {
        private var _createBalloonMessage:Array;
        private var _aInformationIcon:Array;
        private static var _warriorCount:int = 99999999;
        private static var _emplerLv:int = 99999999;
        private static var _giftCount:int = 9999999;
        private static var _bWareHouse:Boolean = true;
        private static var _bCommandRoom:Boolean = true;
        private static var _bMyPage:Boolean = true;

        public function AnnouncementCheck(param1:Array, param2:Array)
        {
            this._createBalloonMessage = [];
            this._createBalloonMessage = param1;
            this._aInformationIcon = [];
            this._aInformationIcon = param2;
            if (!TutorialManager.getInstance().isTutorial())
            {
                this.balloonSetStart();
            }
            return;
        }// end function

        public function setbWareHouse(param1:Boolean) : void
        {
            _bWareHouse = param1;
            return;
        }// end function

        public function setbCommandRoom(param1:Boolean) : void
        {
            _bCommandRoom = param1;
            return;
        }// end function

        public function setbMyPage(param1:Boolean) : void
        {
            _bMyPage = param1;
            return;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            for each (_loc_1 in UserDataManager.getInstance().userData.aInstitution)
            {
                
                _loc_2 = this._createBalloonMessage.pop();
                _loc_2 = null;
                _loc_3 = this._aInformationIcon.pop();
                _loc_3 = null;
            }
            this._createBalloonMessage = null;
            this._aInformationIcon = null;
            return;
        }// end function

        public function reCheak() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = UserDataManager.getInstance().getEmperorLv();
            if (_bMyPage)
            {
                this.setbMyPage(false);
                _emplerLv = _loc_1;
                this._createBalloonMessage[CommonConstant.FACILITY_ID_MYPAGE] = MessageId.FACILITY_BALLOON_PALACE;
                this._aInformationIcon[(CommonConstant.FACILITY_ID_MYPAGE - 1)].visible = false;
            }
            if (!TutorialManager.getInstance().isTutorial())
            {
                _loc_2 = UserDataManager.getInstance().userData;
                this.wareHouse(_loc_2.bNewItem);
            }
            return;
        }// end function

        public function reCheakBarracks() : void
        {
            var _loc_1:* = null;
            if (!TutorialManager.getInstance().isTutorial())
            {
                _loc_1 = UserDataManager.getInstance().userData;
                this._createBalloonMessage[CommonConstant.FACILITY_ID_SORTIE] = MessageId.FACILITY_BALLOON_SORTIE;
                this._createBalloonMessage[CommonConstant.FACILITY_ID_BARRACKS] = MessageId.FACILITY_BALLOON_BARRACKS;
                this._aInformationIcon[(CommonConstant.FACILITY_ID_SORTIE - 1)].visible = false;
                this._aInformationIcon[(CommonConstant.FACILITY_ID_BARRACKS - 1)].visible = false;
                this.sortie();
                this.barracks(_loc_1.aBarracksData);
            }
            return;
        }// end function

        private function balloonSetStart() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = UserDataManager.getInstance().userData;
            this.myPage();
            this.wareHouse(_loc_1.bNewItem);
            this.sortie();
            this.barracks(_loc_1.aBarracksData);
            this.commandRoom(_loc_1.aPlayerPersonal);
            _loc_2 = _loc_1.getInstitutionInfo(CommonConstant.FACILITY_ID_MAGIC_DEVELOP);
            this.magicDevelop(_loc_1.aPlayerPersonal, _loc_2);
            _loc_2 = _loc_1.getInstitutionInfo(CommonConstant.FACILITY_ID_TRAINING_ROOM);
            this.training(_loc_1.aPlayerPersonal, _loc_2);
            _loc_2 = _loc_1.getInstitutionInfo(CommonConstant.FACILITY_ID_MAKE_EQUIP);
            this.makeEquip(_loc_2);
            _loc_2 = _loc_1.getInstitutionInfo(CommonConstant.FACILITY_ID_SKILL_INITIATE);
            this.skillInitiate(_loc_2);
            return;
        }// end function

        private function myPage() : void
        {
            var _loc_1:* = UserDataManager.getInstance().getEmperorLv();
            if (_bMyPage)
            {
                this.setbMyPage(false);
                _emplerLv = _loc_1;
                this._aInformationIcon[(CommonConstant.FACILITY_ID_MYPAGE - 1)].visible = false;
            }
            if (_emplerLv < _loc_1)
            {
                this._createBalloonMessage[CommonConstant.FACILITY_ID_MYPAGE] = MessageId.NOTICE_LV_UP;
                this._aInformationIcon[(CommonConstant.FACILITY_ID_MYPAGE - 1)].visible = true;
            }
            return;
        }// end function

        private function commandRoom(param1:Array) : void
        {
            if (_bCommandRoom)
            {
                this.setbCommandRoom(false);
                _warriorCount = param1.length;
                this._aInformationIcon[(CommonConstant.FACILITY_ID_COMMAND_ROOM - 1)].visible = false;
            }
            if (_warriorCount < param1.length)
            {
                this._createBalloonMessage[CommonConstant.FACILITY_ID_COMMAND_ROOM] = MessageId.FACILITY_BALOON_COMMAND_GET_UNIT;
                this._aInformationIcon[(CommonConstant.FACILITY_ID_COMMAND_ROOM - 1)].visible = true;
            }
            _warriorCount = param1.length;
            return;
        }// end function

        private function sortie() : void
        {
            var _loc_1:* = new HomeSortieChecker();
            _loc_1.checkSortie();
            if (!_loc_1.bSortie)
            {
                this._createBalloonMessage[CommonConstant.FACILITY_ID_SORTIE] = _loc_1.getSortieBalloonMessageId();
                this._aInformationIcon[(CommonConstant.FACILITY_ID_SORTIE - 1)].visible = true;
            }
            _loc_1.release();
            _loc_1 = null;
            return;
        }// end function

        private function wareHouse(param1:Boolean) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = StorageManager.getInstance().warehouseGiftCount();
            if (param1)
            {
                this._createBalloonMessage[CommonConstant.FACILITY_ID_WEARHOUSE] = MessageId.FACILITY_BALOON_STORE_HOUSE_NEWITEM;
                this._aInformationIcon[(CommonConstant.FACILITY_ID_WEARHOUSE - 1)].visible = true;
            }
            if (_bWareHouse)
            {
                this.setbWareHouse(false);
                _giftCount = _loc_2;
                if (!param1)
                {
                    this._aInformationIcon[(CommonConstant.FACILITY_ID_WEARHOUSE - 1)].visible = false;
                }
                if (param1)
                {
                    _loc_3 = UserDataManager.getInstance().userData;
                    _loc_3.setbNewItem(false);
                }
            }
            if (_loc_2 > 0)
            {
                this._createBalloonMessage[CommonConstant.FACILITY_ID_WEARHOUSE] = MessageId.FACILITY_BALOON_STORE_HOUSE_NEWITEM;
                this._aInformationIcon[(CommonConstant.FACILITY_ID_WEARHOUSE - 1)].visible = true;
            }
            return;
        }// end function

        private function barracks(param1:Array) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = TimeClock.getNowTime();
            if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_BARRACKS_3))
            {
                _loc_2 = 0;
            }
            for each (_loc_3 in param1)
            {
                
                if (_loc_3.uniqueId != Constant.EMPTY_ID)
                {
                    if (_loc_3.restoreTime >= _loc_2)
                    {
                        this._createBalloonMessage[CommonConstant.FACILITY_ID_BARRACKS] = MessageId.FACILITY_BALOON_BARRACKS_UNDER_BRAKE;
                    }
                    else
                    {
                        this._createBalloonMessage[CommonConstant.FACILITY_ID_BARRACKS] = MessageId.FACILITY_BALOON_BARRACKS_END_BRAKE;
                    }
                    this._aInformationIcon[(CommonConstant.FACILITY_ID_BARRACKS - 1)].visible = true;
                    break;
                }
            }
            return;
        }// end function

        private function employment(param1:Boolean) : void
        {
            return;
        }// end function

        private function training(param1:Array, param2:InstitutionInfo) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            for each (_loc_3 in param1)
            {
                
                if (_loc_3.isUseFacility() && _loc_3.lastUseFacilityId == CommonConstant.FACILITY_ID_TRAINING_ROOM && _loc_3.lastUseFacilitySubId == CommonConstant.FACILITY_ID_SUB_TRAINING_KUMITE)
                {
                    if (_loc_3.isAwaitingCheckFacility() == false)
                    {
                        this._createBalloonMessage[CommonConstant.FACILITY_ID_TRAINING_ROOM] = MessageId.FACILITY_BALOON_TRAINING_ROOM_UNDER_KUMITE;
                    }
                    else
                    {
                        this._createBalloonMessage[CommonConstant.FACILITY_ID_TRAINING_ROOM] = MessageId.FACILITY_BALOON_TRAINING_ROOM_END_KUMITE;
                    }
                    this._aInformationIcon[(CommonConstant.FACILITY_ID_TRAINING_ROOM - 1)].visible = true;
                    break;
                }
            }
            for each (_loc_4 in param1)
            {
                
                if (_loc_4.isUseFacility() && _loc_4.lastUseFacilityId == CommonConstant.FACILITY_ID_TRAINING_ROOM && _loc_4.lastUseFacilitySubId == CommonConstant.FACILITY_ID_SUB_TRAINING_TRAINING)
                {
                    if (_loc_4.isAwaitingCheckFacility() == false)
                    {
                        this._createBalloonMessage[CommonConstant.FACILITY_ID_TRAINING_ROOM] = MessageId.FACILITY_BALOON_TRAINING_ROOM_UNDER_TRAINING;
                    }
                    else
                    {
                        this._createBalloonMessage[CommonConstant.FACILITY_ID_TRAINING_ROOM] = MessageId.FACILITY_BALOON_TRAINING_ROOM_END_TRAINING;
                    }
                    this._aInformationIcon[(CommonConstant.FACILITY_ID_TRAINING_ROOM - 1)].visible = true;
                    break;
                }
            }
            this.checkFirstGradeUp(param2);
            return;
        }// end function

        private function magicDevelop(param1:Array, param2:InstitutionInfo) : void
        {
            var _loc_4:* = null;
            if (MagicLabolatoryManager.getInstance().isDeveloping())
            {
                if (MagicLabolatoryManager.getInstance().isDevelopTimeOut())
                {
                    this._createBalloonMessage[CommonConstant.FACILITY_ID_MAGIC_DEVELOP] = MessageId.FACILITY_BALOON_SKILL_DEVELOP_END;
                }
                else
                {
                    this._createBalloonMessage[CommonConstant.FACILITY_ID_MAGIC_DEVELOP] = MessageId.FACILITY_BALOON_SKILL_DEVELOP_NOW;
                }
                this._aInformationIcon[(CommonConstant.FACILITY_ID_MAGIC_DEVELOP - 1)].visible = true;
            }
            var _loc_3:* = Constant.EMPTY_ID;
            for each (_loc_4 in param1)
            {
                
                if (_loc_4.isUseFacility() && _loc_4.lastUseFacilityId == CommonConstant.FACILITY_ID_MAGIC_DEVELOP)
                {
                    if (_loc_4.isAwaitingCheckFacility() == false)
                    {
                        if (_loc_3 == Constant.EMPTY_ID)
                        {
                            _loc_3 = MessageId.FACILITY_BALOON_SKILL_RESEACH_UNDER;
                        }
                        continue;
                    }
                    _loc_3 = MessageId.FACILITY_BALOON_SKILL_RESEACH_END;
                }
            }
            if (_loc_3)
            {
                this._createBalloonMessage[CommonConstant.FACILITY_ID_MAGIC_DEVELOP] = _loc_3;
                this._aInformationIcon[(CommonConstant.FACILITY_ID_MAGIC_DEVELOP - 1)].visible = true;
            }
            this.checkFirstGradeUp(param2);
            return;
        }// end function

        private function makeEquip(param1:InstitutionInfo) : void
        {
            this.checkFirstGradeUp(param1);
            return;
        }// end function

        private function skillInitiate(param1:InstitutionInfo) : void
        {
            this.checkFirstGradeUp(param1);
            return;
        }// end function

        private function tradingPost() : void
        {
            return;
        }// end function

        private function checkFirstGradeUp(param1:InstitutionInfo) : void
        {
            if (param1.grade == 0 && param1.upgradeEnd == 0 && UserDataManager.getInstance().isUnlockFacility(param1.id))
            {
                this._aInformationIcon[(param1.id - 1)].visible = true;
            }
            return;
        }// end function

        public static function setInitGiftCount(param1:int) : void
        {
            _giftCount = param1;
            return;
        }// end function

    }
}
