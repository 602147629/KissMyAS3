package home
{
    import formation.*;
    import message.*;
    import player.*;
    import user.*;

    public class HomeSortieChecker extends Object
    {
        private var _bSortie:Boolean;
        private var _sortieType:int;
        private var _sortieWarning:int;
        private var _sortiePersonal:PlayerPersonal;
        public static const SORTIE_TYPE_OK:int = 0;
        public static const SORTIE_TYPE_DEAD:int = 1;
        public static const SORTIE_TYPE_NO_MEMBER:int = 2;
        public static const SORTIE_TYPE_COMMNADER_ONLY:int = 3;
        public static const SORTIE_WARNING_OK:int = 0;
        public static const SORTIE_WARNING_COMMNADER_NOT_ENOUGH:int = 1;

        public function HomeSortieChecker()
        {
            this.reset();
            return;
        }// end function

        public function get bSortie() : Boolean
        {
            return this._bSortie;
        }// end function

        public function get sortieType() : int
        {
            return this._sortieType;
        }// end function

        public function get sortieWarning() : int
        {
            return this._sortieWarning;
        }// end function

        public function isAny() : Boolean
        {
            return this._sortieType != SORTIE_TYPE_OK || this._sortieWarning != SORTIE_WARNING_OK;
        }// end function

        public function release() : void
        {
            this._sortiePersonal = null;
            return;
        }// end function

        public function reset() : void
        {
            this._bSortie = true;
            this._sortieType = SORTIE_TYPE_OK;
            this._sortieWarning = SORTIE_WARNING_OK;
            this._sortiePersonal = null;
            return;
        }// end function

        public function checkSortie() : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = null;
            this.reset();
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = UserDataManager.getInstance().userData.aFormationPlayerUniqueId;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3.length)
            {
                
                _loc_5 = _loc_3[_loc_4];
                if (_loc_5 == Constant.EMPTY_ID)
                {
                }
                else
                {
                    _loc_6 = UserDataManager.getInstance().userData.getPlayerPersonal(_loc_5);
                    if (_loc_6 == null)
                    {
                    }
                    else
                    {
                        if (FormationSetData.FORMATION_INDEX_POSITION_1 <= _loc_4 && _loc_4 <= FormationSetData.FORMATION_INDEX_POSITION_5)
                        {
                            _loc_1++;
                        }
                        if (_loc_4 == FormationSetData.FORMATION_INDEX_COMMANDER)
                        {
                            _loc_2++;
                            if (_loc_1 < 5)
                            {
                                this._sortieWarning = SORTIE_WARNING_COMMNADER_NOT_ENOUGH;
                                ;
                            }
                        }
                        if (_loc_6.bDead == true || _loc_6.hp == 0)
                        {
                            this._bSortie = false;
                            this._sortiePersonal = _loc_6;
                            this._sortieType = SORTIE_TYPE_DEAD;
                            break;
                        }
                        if (_loc_6.isUseFacility() == true)
                        {
                            this._bSortie = false;
                            this._sortiePersonal = _loc_6;
                            break;
                        }
                    }
                }
                _loc_4++;
            }
            if (_loc_1 + _loc_2 == 0)
            {
                this._bSortie = false;
                this._sortieType = SORTIE_TYPE_NO_MEMBER;
            }
            else if (_loc_1 == 0)
            {
                this._bSortie = false;
                this._sortieType = SORTIE_TYPE_COMMNADER_ONLY;
            }
            return;
        }// end function

        public function getSortieErrorMessage() : String
        {
            if (!this._bSortie)
            {
                return this.createSortieMessage(this._sortiePersonal, this._sortieType);
            }
            return "";
        }// end function

        public function getSortieWarningMessage() : String
        {
            return this.createWarningMessage(this._sortieWarning);
        }// end function

        public function getSortieBalloonMessageId() : int
        {
            var _loc_1:* = MessageId.FACILITY_BALOON_COMMAND_NO_SORTIE;
            if (this._sortieType == SORTIE_TYPE_NO_MEMBER || this._sortieType == SORTIE_TYPE_COMMNADER_ONLY)
            {
                _loc_1 = MessageId.FACILITY_BALOON_COMMAND_NO_CHARACTER;
            }
            return _loc_1;
        }// end function

        private function createSortieMessage(param1:PlayerPersonal, param2:int) : String
        {
            var _loc_3:* = MessageId.HOME_ERROR_SORTIE;
            if (param1 != null)
            {
                switch(param1.lastUseFacilityId)
                {
                    case CommonConstant.FACILITY_ID_BARRACKS:
                    {
                        _loc_3 = MessageId.HOME_ERROR_PARTY_WITH_REST;
                        break;
                    }
                    case CommonConstant.FACILITY_ID_MAGIC_DEVELOP:
                    {
                        _loc_3 = MessageId.HOME_ERROR_PARTY_WITH_STUDY;
                        break;
                    }
                    case CommonConstant.FACILITY_ID_TRAINING_ROOM:
                    {
                        if (param1.lastUseFacilitySubId == CommonConstant.FACILITY_ID_SUB_TRAINING_KUMITE)
                        {
                            _loc_3 = MessageId.HOME_ERROR_PARTY_WITH_TRANING;
                        }
                        if (param1.lastUseFacilitySubId == CommonConstant.FACILITY_ID_SUB_TRAINING_TRAINING)
                        {
                            _loc_3 = MessageId.HOME_ERROR_PARTY_WITH_PRACTICE;
                        }
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            if (param2 == SORTIE_TYPE_DEAD)
            {
                _loc_3 = MessageId.HOME_ERROR_PARTY_WITH_DEAD;
            }
            if (param2 == SORTIE_TYPE_NO_MEMBER)
            {
                _loc_3 = MessageId.HOME_ERROR_PARTY_NO_MEMBER;
            }
            if (param2 == SORTIE_TYPE_COMMNADER_ONLY)
            {
                _loc_3 = MessageId.HOME_ERROR_PARTY_COMMANDER_ONLY;
            }
            return MessageManager.getInstance().getMessage(_loc_3);
        }// end function

        private function createWarningMessage(param1:int) : String
        {
            var _loc_2:* = 0;
            if (param1 == SORTIE_WARNING_COMMNADER_NOT_ENOUGH)
            {
                _loc_2 = MessageId.HOME_ERROR_PARTY_NOT_ENOUGH_NUM;
                return MessageManager.getInstance().getMessage(_loc_2);
            }
            return "";
        }// end function

    }
}
