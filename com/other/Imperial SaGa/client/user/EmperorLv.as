package user
{

    public class EmperorLv extends Object
    {
        private var _lv:int;
        private var _totalExp:uint;
        private var _reserveMax:uint;
        private var _aUnlockData:Array;

        public function EmperorLv()
        {
            this._aUnlockData = null;
            return;
        }// end function

        public function get lv() : int
        {
            return this._lv;
        }// end function

        public function get totalExp() : uint
        {
            return this._totalExp;
        }// end function

        public function get reserveMax() : uint
        {
            return this._reserveMax;
        }// end function

        public function get aUnlockData() : Array
        {
            return this._aUnlockData;
        }// end function

        public function setXml(param1:XML) : void
        {
            var xml:* = param1;
            this._lv = int(xml.lv);
            this._totalExp = uint(xml.totalExp);
            this._reserveMax = uint(xml.reserveLimit);
            var setUnlockDataFunc:* = function (param1:int, param2:XMLList) : void
            {
                var _loc_3:* = null;
                var _loc_4:* = 0;
                if (param2.length() == 0)
                {
                    return;
                }
                if (_aUnlockData == null)
                {
                    _aUnlockData = [];
                }
                for each (_loc_3 in param2)
                {
                    
                    _loc_4 = int(_loc_3);
                    if (param1 == EmperorLvUnlockData.UNLOCK_TYPE_FACILITY)
                    {
                        switch(_loc_4)
                        {
                            case 1:
                            {
                                _loc_4 = CommonConstant.FACILITY_ID_MYPAGE;
                                break;
                            }
                            case 2:
                            {
                                _loc_4 = CommonConstant.FACILITY_ID_WEARHOUSE;
                                break;
                            }
                            case 3:
                            {
                                _loc_4 = CommonConstant.FACILITY_ID_SKILL_INITIATE;
                                break;
                            }
                            case 4:
                            {
                                _loc_4 = CommonConstant.FACILITY_ID_MAGIC_DEVELOP;
                                break;
                            }
                            case 5:
                            {
                                _loc_4 = CommonConstant.FACILITY_ID_TRAINING_ROOM;
                                break;
                            }
                            case 6:
                            {
                                _loc_4 = CommonConstant.FACILITY_ID_COMMAND_ROOM;
                                break;
                            }
                            case 7:
                            {
                                _loc_4 = CommonConstant.FACILITY_ID_BARRACKS;
                                break;
                            }
                            case 8:
                            {
                                _loc_4 = CommonConstant.FACILITY_ID_SORTIE;
                                break;
                            }
                            case 9:
                            {
                                _loc_4 = CommonConstant.FACILITY_ID_MAKE_EQUIP;
                                break;
                            }
                            case 10:
                            {
                                _loc_4 = CommonConstant.FACILITY_ID_PRACTICE;
                                break;
                            }
                            case 11:
                            {
                                _loc_4 = CommonConstant.FACILITY_ID_TRADING;
                                break;
                            }
                            default:
                            {
                                break;
                            }
                        }
                    }
                    _aUnlockData.push(new EmperorLvUnlockData(param1, _loc_4));
                }
                return;
            }// end function
            ;
            this.setUnlockDataFunc(EmperorLvUnlockData.UNLOCK_TYPE_FACILITY, xml.unlockFacility);
            this.setUnlockDataFunc(EmperorLvUnlockData.UNLOCK_TYPE_FORMATION, xml.unlockFormation);
            this.setUnlockDataFunc(EmperorLvUnlockData.UNLOCK_TYPE_ITEM, xml.unlockItem);
            return;
        }// end function

    }
}
