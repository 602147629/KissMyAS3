package tutorial
{
    import asset.*;
    import flash.display.*;
    import flash.geom.*;
    import item.*;
    import message.*;
    import network.*;
    import player.*;
    import popup.*;
    import resource.*;
    import user.*;
    import utility.*;

    public class TutorialManager extends Object
    {
        private var _basicTutorial1EndFlag:uint;
        private var _basicTutorialQuestSelectEndFlag:uint;
        private var _basicTutorial2EndFlag:uint;
        private var _basicTutorial3EndFlag:uint;
        private var _bTutorialProtocol:Boolean;
        private var _facilityTutorialEndServerFlag:uint;
        private var _aFacilityTutorialEndFlag:Array;
        private var _facilityNoCostFlag:uint;
        private var _mcArrow:MovieClip;
        private var _isoArrow:InStayOut;
        private var _mcBalloon:MovieClip;
        private var _isoNavi:InStayOut;
        private var _isoBalloon:InStayOut;
        private var _step:int;
        private var _preStep:int;
        private var _aAfterTutorialFrontMemberUniqueId:Array;
        private var _afterTutorialFormationId:int;
        private static var _instance:TutorialManager = null;
        public static const BASIC_TUTORIAL_FLAG_TUTORIAL_QUEST_START:int = 1;
        public static const BASIC_TUTORIAL_FLAG_FIRST_BATTLE_START:int = 2;
        public static const BASIC_TUTORIAL_FLAG_SKILL_COMES_UP:int = 4;
        public static const BASIC_TUTORIAL_FLAG_FIRST_BATTLE_END:int = 8;
        public static const BASIC_TUTORIAL_FLAG_QUEST_JUNCTION_REACH:int = 16;
        public static const BASIC_TUTORIAL_FLAG_QUEST_JUNCTION_DIVIDE_UNIT:int = 32;
        public static const BASIC_TUTORIAL_FLAG_SKILL_CHAIN_BEFORE:int = 64;
        public static const BASIC_TUTORIAL_FLAG_SKILL_CHAIN_AFTER:int = 128;
        public static const BASIC_TUTORIAL_FLAG_PICKUP_ITEM:int = 256;
        public static const BASIC_TUTORIAL_FLAG_BOSS_BATTLE:int = 512;
        public static const BASIC_TUTORIAL_FLAG_TUTORIAL_QUEST_END:int = 1024;
        public static const BASIC_TUTORIAL_FLAG_QUEST_LIST:int = 1;
        public static const BASIC_TUTORIAL_FLAG_FEVER_ITEM:int = 2;
        public static const BASIC_TUTORIAL_FLAG_QUEST_SELECT_END:int = 4;
        public static const BASIC_TUTORIAL_FLAG_MAIN_QUEST_START:int = 1;
        public static const BASIC_TUTORIAL_FLAG_FORMATION_SKILL_BEFORE:int = 2;
        public static const BASIC_TUTORIAL_FLAG_FORMATION_SKILL_AFTER:int = 4;
        public static const BASIC_TUTORIAL_FLAG_QUEST_JUNCTION_ROUTE_CHECK_BEFORE:int = 8;
        public static const BASIC_TUTORIAL_FLAG_QUEST_JUNCTION_ROUTE_CHECK_AFTER:int = 16;
        public static const BASIC_TUTORIAL_FLAG_CHRONOLOGY:int = 32;
        public static const BASIC_TUTORIAL_FLAG_MAIN_QUEST_END:int = 64;
        public static const BASIC_TUTORIAL_FLAG_HOME_1:int = 1;
        public static const BASIC_TUTORIAL_FLAG_EMPLOY_1:int = 2;
        public static const BASIC_TUTORIAL_FLAG_EMPLOY_2:int = 4;
        public static const BASIC_TUTORIAL_FLAG_EMPLOY_3:int = 8;
        public static const BASIC_TUTORIAL_FLAG_HOME_2:int = 16;
        public static const BASIC_TUTORIAL_FLAG_COMMAND_POST_1:int = 32;
        public static const BASIC_TUTORIAL_FLAG_COMMAND_POST_2:int = 64;
        public static const BASIC_TUTORIAL_FLAG_HOME_3:int = 128;
        public static const BASIC_TUTORIAL_FLAG_WORLD_MAP:int = 256;
        public static const BASIC_TUTORIAL_FLAG_HOME_4:int = 512;
        public static const FACILITY_TUTORIAL_FLAG_MYPAGE:Array = [0, 1];
        public static const FACILITY_TUTORIAL_FLAG_DAILY_MISSION:Array = [0, 2];
        public static const FACILITY_TUTORIAL_FLAG_MYPAGE_ALBUM:Array = [0, 4];
        public static const FACILITY_TUTORIAL_FLAG_MYPAGE_CHRONOLOGY:Array = [0, 8];
        public static const FACILITY_TUTORIAL_FLAG_MYPAGE_CODE_INPUT:Array = [0, 16];
        public static const FACILITY_TUTORIAL_FLAG_MYPAGE_CROWN_HISTORY:Array = [0, 32];
        public static const FACILITY_TUTORIAL_FLAG_WEARHOUSE:Array = [0, 64];
        public static const FACILITY_TUTORIAL_FLAG_TRADING_POST:Array = [0, 128];
        public static const FACILITY_TUTORIAL_FLAG_BARRACKS_FIRST:Array = [0, 256];
        public static const FACILITY_TUTORIAL_FLAG_BARRACKS_1:Array = [0, 512];
        public static const FACILITY_TUTORIAL_FLAG_BARRACKS_2:Array = [0, 1024];
        public static const FACILITY_TUTORIAL_FLAG_BARRACKS_3:Array = [0, 2048];
        public static const FACILITY_TUTORIAL_FLAG_TRAINING_ROOM:Array = [0, 4096];
        public static const FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_KUMITE_1:Array = [0, 8192];
        public static const FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_KUMITE_2:Array = [0, 16384];
        public static const FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_KUMITE_3:Array = [0, 32768];
        public static const FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_KUMITE_4:Array = [0, 65536];
        public static const FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_KUMITE_5:Array = [0, 131072];
        public static const FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_KUMITE_6:Array = [0, 262144];
        public static const FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_TRAINING_1:Array = [0, 524288];
        public static const FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_TRAINING_2:Array = [0, 1048576];
        public static const FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_TRAINING_3:Array = [0, 2097152];
        public static const FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_TRAINING_4:Array = [0, 4194304];
        public static const FACILITY_TUTORIAL_FLAG_MAGIC_LABO:Array = [0, 8388608];
        public static const FACILITY_TUTORIAL_FLAG_MAGIC_LABO_DEVELOP:Array = [0, 16777216];
        public static const FACILITY_TUTORIAL_FLAG_MAGIC_LABO_DEVELOP_2:Array = [0, 33554432];
        public static const FACILITY_TUTORIAL_FLAG_MAGIC_LABO_DEVELOP_3:Array = [0, 67108864];
        public static const FACILITY_TUTORIAL_FLAG_MAGIC_LABO_LEARNING_1:Array = [0, 134217728];
        public static const FACILITY_TUTORIAL_FLAG_MAGIC_LABO_LEARNING_2:Array = [0, 268435456];
        public static const FACILITY_TUTORIAL_FLAG_MAGIC_LABO_LEARNING_3:Array = [0, 536870912];
        public static const FACILITY_TUTORIAL_FLAG_MAGIC_LABO_LEARNING_INSTANT:Array = [0, 1073741824];
        public static const FACILITY_TUTORIAL_FLAG_MAGIC_LABO_LEARNING_4:Array = [0, 2147483648];
        public static const FACILITY_TUTORIAL_FLAG_SKILL_INITIATE_1:Array = [1, 0];
        public static const FACILITY_TUTORIAL_FLAG_SKILL_INITIATE_2:Array = [2, 0];
        public static const FACILITY_TUTORIAL_FLAG_SKILL_INITIATE_3:Array = [4, 0];
        public static const FACILITY_TUTORIAL_FLAG_SKILL_INITIATE_4:Array = [8, 0];
        public static const FACILITY_TUTORIAL_FLAG_SKILL_INITIATE_5:Array = [16, 0];
        public static const FACILITY_TUTORIAL_FLAG_MAKE_EQUIP:Array = [32, 0];
        public static const FACILITY_TUTORIAL_FLAG_MAKE_EQUIP_SYNTHETIC_1:Array = [64, 0];
        public static const FACILITY_TUTORIAL_FLAG_MAKE_EQUIP_SYNTHETIC_2:Array = [128, 0];
        public static const FACILITY_TUTORIAL_FLAG_MAKE_EQUIP_SYNTHETIC_3:Array = [256, 0];
        public static const FACILITY_TUTORIAL_FLAG_MAKE_EQUIP_DECOMPOSITION_1:Array = [512, 0];
        public static const FACILITY_TUTORIAL_FLAG_FACILITY_UPGRADE_1:Array = [1024, 0];
        public static const FACILITY_TUTORIAL_FLAG_FACILITY_UPGRADE_2:Array = [2048, 0];
        public static const FACILITY_TUTORIAL_FLAG_FACILITY_UPGRADE_3:Array = [4096, 0];
        public static const FACILITY_TUTORIAL_FLAG_FACILITY_UPGRADE_4:Array = [8192, 0];
        public static const FACILITY_TUTORIAL_FLAG_FACILITY_UPGRADE_5:Array = [16384, 0];
        public static const FACILITY_TUTORIAL_FLAG_CAMPAIGN_QUEST:Array = [32768, 0];
        public static const FACILITY_TUTORIAL_FLAG_COMMAND_POST_COMMANDER:Array = [65536, 0];
        private static const FACILITY_NO_COST_FLAG_KUMIT:uint = 1;
        private static const FACILITY_NO_COST_FLAG_TRAINING:uint = 2;
        private static const FACILITY_NO_COST_FLAG_MAGIC_DEVELOP:uint = 4;
        private static const FACILITY_NO_COST_FLAG_MAGIC_LEARN:uint = 8;
        public static const TUTORIAL_ARROW_DIRECTION_DOWN:String = "below2";
        public static const TUTORIAL_ARROW_DIRECTION_DOWN_LEFT:String = "below1";
        public static const TUTORIAL_ARROW_DIRECTION_DOWN_RIGHT:String = "below3";
        public static const TUTORIAL_ARROW_DIRECTION_LEFT:String = "left";
        public static const TUTORIAL_ARROW_DIRECTION_RIGHT:String = "right";
        public static const TUTORIAL_ARROW_DIRECTION_UP:String = "up2";
        public static const TUTORIAL_ARROW_DIRECTION_UP_LEFT:String = "up3";
        public static const TUTORIAL_ARROW_DIRECTION_UP_RIGHT:String = "up1";
        public static const TUTORIAL_ARROW_POS_DEFAULT:int = 0;
        public static const TUTORIAL_ARROW_POS_CENTER:int = 1;
        public static const TUTORIAL_ARROW_POS_UP:int = 2;
        public static const TUTORIAL_ARROW_POS_LEFT_UP:int = 3;
        public static const TUTORIAL_ARROW_POS_LEFT_UP_2:int = 4;
        public static const TUTORIAL_BALLOON_POS_TOP:int = 0;
        public static const TUTORIAL_BALLOON_POS_BOTTOM:int = 355;

        public function TutorialManager()
        {
            this._bTutorialProtocol = false;
            this._basicTutorial1EndFlag = 0;
            this._basicTutorialQuestSelectEndFlag = 0;
            this._basicTutorial2EndFlag = 0;
            this._basicTutorial3EndFlag = 0;
            this._aFacilityTutorialEndFlag = [0, 0];
            this._mcArrow = null;
            this._isoArrow = null;
            this._mcBalloon = null;
            this._isoNavi = null;
            this._isoBalloon = null;
            this._step = Constant.UNDECIDED;
            this._preStep = Constant.UNDECIDED;
            this._aAfterTutorialFrontMemberUniqueId = null;
            this.afterTutorialFormationId = 0;
            return;
        }// end function

        public function loadResource() : void
        {
            ResourceManager.getInstance().loadResource(ResourcePath.COMMON_DATA_PATH + "UI_Popup.swf");
            ResourceManager.getInstance().loadResource(ResourcePath.COMMON_DATA_PATH + "UI_Tutorial.swf");
            ResourceManager.getInstance().loadResource(ResourcePath.NAVI_CHARACTER_PATH);
            return;
        }// end function

        public function isBasicTutorial(param1:int, param2:int) : Boolean
        {
            if (param1 != UserDataManager.getInstance().userData.statusType)
            {
                return false;
            }
            switch(param1)
            {
                case CommonConstant.USER_STATE_TUTORIAL:
                {
                    return this.isBasicTutorial1(param2);
                }
                case CommonConstant.USER_STATE_TUTORIAL_QUEST_SELECT:
                {
                    return this.isBasicTutorialQuestSelect(param2);
                }
                case CommonConstant.USER_STATE_TUTORIAL_2:
                {
                    return this.isBasicTutorial2(param2);
                }
                case CommonConstant.USER_STATE_TUTORIAL_3:
                {
                    return this.isBasicTutorial3(param2);
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

        private function isBasicTutorial1(param1:int) : Boolean
        {
            return (this._basicTutorial1EndFlag & param1) == 0;
        }// end function

        private function isBasicTutorialQuestSelect(param1:int) : Boolean
        {
            return (this._basicTutorialQuestSelectEndFlag & param1) == 0;
        }// end function

        private function isBasicTutorial2(param1:int) : Boolean
        {
            return (this._basicTutorial2EndFlag & param1) == 0;
        }// end function

        private function isBasicTutorial3(param1:int) : Boolean
        {
            return (this._basicTutorial3EndFlag & param1) == 0;
        }// end function

        public function addBasicTutorialEnd(param1:int) : void
        {
            switch(UserDataManager.getInstance().userData.statusType)
            {
                case CommonConstant.USER_STATE_TUTORIAL:
                {
                    this._basicTutorial1EndFlag = this._basicTutorial1EndFlag | param1;
                    break;
                }
                case CommonConstant.USER_STATE_TUTORIAL_QUEST_SELECT:
                {
                    this._basicTutorialQuestSelectEndFlag = this._basicTutorialQuestSelectEndFlag | param1;
                    break;
                }
                case CommonConstant.USER_STATE_TUTORIAL_2:
                {
                    this._basicTutorial2EndFlag = this._basicTutorial2EndFlag | param1;
                    break;
                }
                case CommonConstant.USER_STATE_TUTORIAL_3:
                {
                    this._basicTutorial3EndFlag = this._basicTutorial3EndFlag | param1;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function clearBasicTutorial() : void
        {
            this._basicTutorial1EndFlag = 0;
            this._basicTutorialQuestSelectEndFlag = 0;
            this._basicTutorial2EndFlag = 0;
            this._basicTutorial3EndFlag = 0;
            this._aAfterTutorialFrontMemberUniqueId = null;
            return;
        }// end function

        public function clearBasicTutorial2End() : void
        {
            this._basicTutorial2EndFlag = 0;
            return;
        }// end function

        public function set bTutorialProtocol(param1:Boolean) : void
        {
            this._bTutorialProtocol = param1;
            return;
        }// end function

        public function isUseTutorialProtocol() : Boolean
        {
            return this._bTutorialProtocol;
        }// end function

        public function isNoCost_Kumite() : Boolean
        {
            return (this._facilityNoCostFlag & FACILITY_NO_COST_FLAG_KUMIT) != 0;
        }// end function

        public function ClearNoCost_Kumite() : void
        {
            this._facilityNoCostFlag = this._facilityNoCostFlag & ~FACILITY_NO_COST_FLAG_KUMIT;
            return;
        }// end function

        public function isNoCost_Training() : Boolean
        {
            return (this._facilityNoCostFlag & FACILITY_NO_COST_FLAG_TRAINING) != 0;
        }// end function

        public function ClearNoCost_Training() : void
        {
            this._facilityNoCostFlag = this._facilityNoCostFlag & ~FACILITY_NO_COST_FLAG_TRAINING;
            return;
        }// end function

        public function isNoCost_MagicDevelop() : Boolean
        {
            return (this._facilityNoCostFlag & FACILITY_NO_COST_FLAG_MAGIC_DEVELOP) != 0;
        }// end function

        public function ClearNoCost_MagicDevelop() : void
        {
            this._facilityNoCostFlag = this._facilityNoCostFlag & ~FACILITY_NO_COST_FLAG_MAGIC_DEVELOP;
            return;
        }// end function

        public function isNoCost_MagicLearn() : Boolean
        {
            return (this._facilityNoCostFlag & FACILITY_NO_COST_FLAG_MAGIC_LEARN) != 0;
        }// end function

        public function ClearNoCost_MagicLearn() : void
        {
            this._facilityNoCostFlag = this._facilityNoCostFlag & ~FACILITY_NO_COST_FLAG_MAGIC_LEARN;
            return;
        }// end function

        public function isFacilityTutorial(param1:Array) : Boolean
        {
            return (this._aFacilityTutorialEndFlag[0] & param1[0]) == 0 && (this._aFacilityTutorialEndFlag[1] & param1[1]) == 0;
        }// end function

        public function addFacilityTutorialEnd(param1:Array) : void
        {
            this._aFacilityTutorialEndFlag[0] = this._aFacilityTutorialEndFlag[0] | param1[0];
            this._aFacilityTutorialEndFlag[1] = this._aFacilityTutorialEndFlag[1] | param1[1];
            return;
        }// end function

        public function setFacilityTutorialEndServerFlag(param1:uint) : void
        {
            this._facilityTutorialEndServerFlag = param1;
            this._aFacilityTutorialEndFlag = [0, 0];
            this._facilityNoCostFlag = 0;
            if (param1 & CommonConstant.FACILITY_TUTORIAL_FLAG_MYPAGE)
            {
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_MYPAGE);
            }
            if (param1 & CommonConstant.FACILITY_TUTORIAL_FLAG_MYPAGE_ALBUM)
            {
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_MYPAGE_ALBUM);
            }
            if (param1 & CommonConstant.FACILITY_TUTORIAL_FLAG_MYPAGE_CHRONOLOGY)
            {
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_MYPAGE_CHRONOLOGY);
            }
            if (param1 & CommonConstant.FACILITY_TUTORIAL_FLAG_MYPAGE_CODE_INPUT)
            {
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_MYPAGE_CODE_INPUT);
            }
            if (param1 & CommonConstant.FACILITY_TUTORIAL_FLAG_MYPAGE_CROWN_HISTORY)
            {
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_MYPAGE_CROWN_HISTORY);
            }
            if (param1 & CommonConstant.FACILITY_TUTORIAL_FLAG_DAILY_MISSION)
            {
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_DAILY_MISSION);
            }
            if (param1 & CommonConstant.FACILITY_TUTORIAL_FLAG_WEARHOUSE)
            {
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_WEARHOUSE);
            }
            if (param1 & CommonConstant.FACILITY_TUTORIAL_FLAG_TRADING_POST)
            {
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_TRADING_POST);
            }
            if (param1 & CommonConstant.FACILITY_TUTORIAL_FLAG_BARRACKS_FIRST)
            {
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_BARRACKS_FIRST);
            }
            if (param1 & CommonConstant.FACILITY_TUTORIAL_FLAG_BARRACKS_1)
            {
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_BARRACKS_1);
            }
            if (param1 & CommonConstant.FACILITY_TUTORIAL_FLAG_BARRACKS_2_USE)
            {
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_BARRACKS_FIRST);
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_BARRACKS_1);
            }
            if (param1 & CommonConstant.FACILITY_TUTORIAL_FLAG_BARRACKS_3_INSTANT)
            {
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_BARRACKS_FIRST);
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_BARRACKS_1);
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_BARRACKS_2);
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_BARRACKS_3);
            }
            if (param1 & CommonConstant.FACILITY_TUTORIAL_FLAG_TRAINING_ROOM)
            {
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_TRAINING_ROOM);
            }
            if (param1 & CommonConstant.FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_KUMITE_1_USE)
            {
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_KUMITE_1);
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_KUMITE_2);
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_KUMITE_3);
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_KUMITE_4);
            }
            else
            {
                this._facilityNoCostFlag = this._facilityNoCostFlag | FACILITY_NO_COST_FLAG_KUMIT;
            }
            if (param1 & CommonConstant.FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_KUMITE_2_INSTANT)
            {
                this.ClearNoCost_Kumite();
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_KUMITE_1);
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_KUMITE_2);
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_KUMITE_3);
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_KUMITE_4);
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_KUMITE_5);
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_KUMITE_6);
            }
            if (param1 & CommonConstant.FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_TRAINING_1_USE)
            {
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_TRAINING_1);
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_TRAINING_2);
            }
            else
            {
                this._facilityNoCostFlag = this._facilityNoCostFlag | FACILITY_NO_COST_FLAG_TRAINING;
            }
            if (param1 & CommonConstant.FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_TRAINING_2)
            {
                this.ClearNoCost_Training();
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_TRAINING_1);
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_TRAINING_2);
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_TRAINING_3);
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_TRAINING_4);
            }
            if (param1 & CommonConstant.FACILITY_TUTORIAL_FLAG_MAGIC_LABO)
            {
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_MAGIC_LABO);
            }
            if (param1 & CommonConstant.FACILITY_TUTORIAL_FLAG_MAGIC_LABO_DEVELOP_1)
            {
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_MAGIC_LABO_DEVELOP);
            }
            else
            {
                this._facilityNoCostFlag = this._facilityNoCostFlag | FACILITY_NO_COST_FLAG_MAGIC_DEVELOP;
            }
            if (param1 & CommonConstant.FACILITY_TUTORIAL_FLAG_MAGIC_LABO_DEVELOP_2)
            {
                this.ClearNoCost_MagicDevelop();
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_MAGIC_LABO_DEVELOP);
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_MAGIC_LABO_DEVELOP_2);
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_MAGIC_LABO_DEVELOP_3);
            }
            if (param1 & CommonConstant.FACILITY_TUTORIAL_FLAG_MAGIC_LABO_LEARNING_1_USE)
            {
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_MAGIC_LABO_LEARNING_1);
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_MAGIC_LABO_LEARNING_2);
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_MAGIC_LABO_LEARNING_3);
            }
            else
            {
                this._facilityNoCostFlag = this._facilityNoCostFlag | FACILITY_NO_COST_FLAG_MAGIC_LEARN;
            }
            if (param1 & CommonConstant.FACILITY_TUTORIAL_FLAG_MAGIC_LABO_LEARNING_2)
            {
                this.ClearNoCost_MagicLearn();
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_MAGIC_LABO_LEARNING_1);
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_MAGIC_LABO_LEARNING_2);
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_MAGIC_LABO_LEARNING_3);
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_MAGIC_LABO_LEARNING_INSTANT);
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_MAGIC_LABO_LEARNING_4);
            }
            if (param1 & CommonConstant.FACILITY_TUTORIAL_FLAG_SKILL_INITIATE_1_USE)
            {
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_SKILL_INITIATE_1);
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_SKILL_INITIATE_2);
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_SKILL_INITIATE_3);
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_SKILL_INITIATE_4);
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_SKILL_INITIATE_5);
            }
            if (param1 & CommonConstant.FACILITY_TUTORIAL_FLAG_MAKE_EQUIP)
            {
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_MAKE_EQUIP);
            }
            if (param1 & CommonConstant.FACILITY_TUTORIAL_FLAG_MAKE_EQUIP_SYNTHETIC_1_USE)
            {
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_MAKE_EQUIP_SYNTHETIC_1);
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_MAKE_EQUIP_SYNTHETIC_2);
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_MAKE_EQUIP_SYNTHETIC_3);
            }
            if (param1 & CommonConstant.FACILITY_TUTORIAL_FLAG_MAKE_EQUIP_DECOMPOSITION_1)
            {
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_MAKE_EQUIP_DECOMPOSITION_1);
            }
            if (param1 & CommonConstant.FACILITY_TUTORIAL_FLAG_FACILITY_UPGRADE_1)
            {
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_FACILITY_UPGRADE_1);
            }
            if (param1 & CommonConstant.FACILITY_TUTORIAL_FLAG_FACILITY_UPGRADE_2)
            {
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_FACILITY_UPGRADE_1);
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_FACILITY_UPGRADE_2);
            }
            if (param1 & CommonConstant.FACILITY_TUTORIAL_FLAG_FACILITY_UPGRADE_3)
            {
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_FACILITY_UPGRADE_1);
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_FACILITY_UPGRADE_2);
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_FACILITY_UPGRADE_3);
            }
            if (param1 & CommonConstant.FACILITY_TUTORIAL_FLAG_FACILITY_UPGRADE_4_USE)
            {
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_FACILITY_UPGRADE_1);
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_FACILITY_UPGRADE_2);
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_FACILITY_UPGRADE_3);
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_FACILITY_UPGRADE_4);
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_FACILITY_UPGRADE_5);
            }
            if (param1 & CommonConstant.FACILITY_TUTORIAL_FLAG_CAMPAIGN_QUEST)
            {
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_CAMPAIGN_QUEST);
            }
            if (param1 & CommonConstant.FACILITY_TUTORIAL_FLAG_COMMANDER)
            {
                this.addFacilityTutorialEnd(FACILITY_TUTORIAL_FLAG_COMMAND_POST_COMMANDER);
            }
            return;
        }// end function

        public function isFacilityUpgradeGuide() : Boolean
        {
            if (this.isFacilityTutorial(FACILITY_TUTORIAL_FLAG_FACILITY_UPGRADE_1) && UserDataManager.getInstance().userData.aPlayerPersonal.length > 10)
            {
                return true;
            }
            return false;
        }// end function

        public function get step() : int
        {
            return this._step;
        }// end function

        public function stepChange(param1:int) : void
        {
            this._step = param1;
            return;
        }// end function

        public function stepReset() : void
        {
            this._step = Constant.UNDECIDED;
            this._preStep = Constant.UNDECIDED;
            return;
        }// end function

        public function isStepChange() : Boolean
        {
            var _loc_1:* = this._step != this._preStep;
            this._preStep = this._step;
            return _loc_1;
        }// end function

        public function set aAfterTutorialFrontMemberUniqueId(param1:Array) : void
        {
            var _loc_2:* = 0;
            this._aAfterTutorialFrontMemberUniqueId = [];
            for each (_loc_2 in param1)
            {
                
                this._aAfterTutorialFrontMemberUniqueId.push(_loc_2);
            }
            return;
        }// end function

        public function get aAfterTutorialFrontMemberUniqueId() : Array
        {
            return this._aAfterTutorialFrontMemberUniqueId.concat();
        }// end function

        public function isGotAfterTutorialFrontMember() : Boolean
        {
            return this._aAfterTutorialFrontMemberUniqueId != null;
        }// end function

        public function set afterTutorialFormationId(param1:int) : void
        {
            this._afterTutorialFormationId = param1;
            return;
        }// end function

        public function get afterTutorialFormationId() : int
        {
            return this._afterTutorialFormationId;
        }// end function

        public function release() : void
        {
            if (this._isoArrow)
            {
                this._isoArrow.release();
            }
            this._isoArrow = null;
            if (this._mcArrow && this._mcArrow.parent)
            {
                this._mcArrow.parent.removeChild(this._mcArrow);
            }
            this._mcArrow = null;
            if (this._isoNavi)
            {
                this._isoNavi.release();
            }
            this._isoNavi = null;
            if (this._isoBalloon)
            {
                this._isoBalloon.release();
            }
            this._isoBalloon = null;
            if (this._mcBalloon && this._mcBalloon.parent)
            {
                this._mcBalloon.parent.removeChild(this._mcBalloon);
            }
            this._mcBalloon = null;
            return;
        }// end function

        public function isTutorial() : Boolean
        {
            return UserDataManager.getInstance().userData.statusType == CommonConstant.USER_STATE_TUTORIAL || UserDataManager.getInstance().userData.statusType == CommonConstant.USER_STATE_TUTORIAL_QUEST_SELECT || UserDataManager.getInstance().userData.statusType == CommonConstant.USER_STATE_TUTORIAL_2 || UserDataManager.getInstance().userData.statusType == CommonConstant.USER_STATE_TUTORIAL_3;
        }// end function

        public function isComesUpPlayer(param1:PlayerPersonal) : Boolean
        {
            var _loc_2:* = UserDataManager.getInstance().userData.aFormationPlayerUniqueId[(CommonConstant.TUTORIAL_COMES_UP_PLAYER_INDEX - 1)];
            return param1.uniqueId == _loc_2;
        }// end function

        public function getTutorialPlayerIdx(param1:PlayerPersonal) : int
        {
            var _loc_2:* = UserDataManager.getInstance().userData.aFormationPlayerUniqueId.indexOf(param1.uniqueId);
            return _loc_2;
        }// end function

        public function setTutorialArrow(param1:MovieClip, param2:String = "below2", param3:int = 0) : void
        {
            if (this._mcArrow == null)
            {
                this._mcArrow = ResourceManager.getInstance().createMovieClip(ResourcePath.COMMON_DATA_PATH + "UI_Tutorial.swf", "arrowMc");
                this._mcArrow.mouseEnabled = false;
                this._mcArrow.mouseChildren = false;
                this._isoArrow = new InStayOut(this._mcArrow.arrow);
            }
            Main.GetProcess().addChild(this._mcArrow);
            var _loc_4:* = new Point();
            if (param3 == TUTORIAL_ARROW_POS_CENTER)
            {
                _loc_4 = param1.localToGlobal(new Point(param1.width / 2, param1.height / 2));
            }
            else if (param3 == TUTORIAL_ARROW_POS_UP)
            {
                _loc_4 = param1.localToGlobal(new Point(param1.width / 2, 0));
            }
            else if (param3 == TUTORIAL_ARROW_POS_LEFT_UP)
            {
                _loc_4 = param1.localToGlobal(new Point(0, 0));
            }
            else if (param3 == TUTORIAL_ARROW_POS_LEFT_UP_2)
            {
                _loc_4 = param1.localToGlobal(new Point(0, -param1.height / 2));
            }
            else if (param3 == TUTORIAL_ARROW_POS_DEFAULT)
            {
                switch(param2)
                {
                    case TUTORIAL_ARROW_DIRECTION_DOWN:
                    {
                        _loc_4 = param1.localToGlobal(new Point(param1.width / 2, 8));
                        break;
                    }
                    case TUTORIAL_ARROW_DIRECTION_DOWN_LEFT:
                    {
                        _loc_4 = param1.localToGlobal(new Point(param1.width, 0));
                        break;
                    }
                    case TUTORIAL_ARROW_DIRECTION_DOWN_RIGHT:
                    {
                        _loc_4 = param1.localToGlobal(new Point(0, 0));
                        break;
                    }
                    case TUTORIAL_ARROW_DIRECTION_LEFT:
                    {
                        _loc_4 = param1.localToGlobal(new Point(param1.width - 8, param1.height / 2));
                        break;
                    }
                    case TUTORIAL_ARROW_DIRECTION_RIGHT:
                    {
                        _loc_4 = param1.localToGlobal(new Point(8, param1.height / 2));
                        break;
                    }
                    case TUTORIAL_ARROW_DIRECTION_UP:
                    {
                        _loc_4 = param1.localToGlobal(new Point(param1.width / 2, param1.height - 16));
                        break;
                    }
                    case TUTORIAL_ARROW_DIRECTION_UP_LEFT:
                    {
                        _loc_4 = param1.localToGlobal(new Point(param1.width, param1.height));
                        break;
                    }
                    case TUTORIAL_ARROW_DIRECTION_UP_RIGHT:
                    {
                        _loc_4 = param1.localToGlobal(new Point(0, param1.height));
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            this._mcArrow.x = _loc_4.x;
            this._mcArrow.y = _loc_4.y;
            this._mcArrow.visible = true;
            this._mcArrow.gotoAndStop(param2);
            this._isoArrow.setIn();
            var _loc_5:* = this._mcArrow.eff_anm;
            this._mcArrow.eff_anm.gotoAndPlay(1);
            _loc_5.visible = true;
            if (param3 == TUTORIAL_ARROW_POS_DEFAULT)
            {
                _loc_4 = param1.localToGlobal(new Point(param1.width / 2, param1.height / 2));
                _loc_5.x = _loc_4.x - this._mcArrow.x;
                _loc_5.y = _loc_4.y - this._mcArrow.y;
            }
            else if (param3 == TUTORIAL_ARROW_POS_LEFT_UP_2)
            {
                _loc_5.x = 0;
                _loc_5.y = param1.height / 2;
            }
            else
            {
                _loc_5.x = 0;
                _loc_5.y = 0;
            }
            return;
        }// end function

        public function setTutorialArrowPos(param1:Point, param2:String = "below2") : void
        {
            if (this._mcArrow == null)
            {
                this._mcArrow = ResourceManager.getInstance().createMovieClip(ResourcePath.COMMON_DATA_PATH + "UI_Tutorial.swf", "arrowMc");
                this._mcArrow.mouseEnabled = false;
                this._mcArrow.mouseChildren = false;
            }
            Main.GetProcess().addChild(this._mcArrow);
            this._mcArrow.x = param1.x;
            this._mcArrow.y = param1.y;
            this._mcArrow.visible = true;
            this._mcArrow.gotoAndStop(param2);
            this._isoArrow.setIn();
            var _loc_3:* = this._mcArrow.eff_anm;
            _loc_3.x = 0;
            _loc_3.y = 0;
            _loc_3.gotoAndPlay(1);
            _loc_3.visible = true;
            return;
        }// end function

        public function hideTutorialArrow() : void
        {
            var mcEff:MovieClip;
            if (this._mcArrow)
            {
                if (this._isoArrow.bOpened || this._isoArrow.bAnimetionOpen)
                {
                    this._isoArrow.setOut(function () : void
            {
                _mcArrow.visible = false;
                return;
            }// end function
            );
                    mcEff = this._mcArrow.eff_anm;
                    mcEff.gotoAndStop(1);
                    mcEff.visible = false;
                }
            }
            return;
        }// end function

        public function setTutorialBalloon(param1:String, param2:int = 0) : void
        {
            var naviCharaBmp:Bitmap;
            var str:* = param1;
            var pos:* = param2;
            if (this._mcBalloon == null)
            {
                this._mcBalloon = ResourceManager.getInstance().createMovieClip(ResourcePath.COMMON_DATA_PATH + "UI_Popup.swf", "CharaPopupMini");
                this._mcBalloon.mouseEnabled = false;
                this._mcBalloon.mouseChildren = false;
                naviCharaBmp = ResourceManager.getInstance().createBitmap(ResourcePath.NAVI_CHARACTER_PATH);
                if (naviCharaBmp)
                {
                    naviCharaBmp.smoothing = true;
                    naviCharaBmp.x = -naviCharaBmp.width / 2;
                    naviCharaBmp.y = -naviCharaBmp.height;
                    (this._mcBalloon.naviCharaNull as MovieClip).addChild(naviCharaBmp);
                }
                Main.GetProcess().addChild(this._mcBalloon);
                this._isoNavi = new InStayOut(this._mcBalloon);
                this._isoBalloon = new InStayOut(this._mcBalloon.chrInfoBalloonTopMc);
            }
            this._mcBalloon.y = pos;
            if (this._isoNavi.bOpened)
            {
                this._isoBalloon.setOut(function () : void
            {
                TextControl.setText(_mcBalloon.chrInfoBalloonTopMc.chrInfoBalloonMc.textMc.textDt, str);
                _isoBalloon.setIn();
                return;
            }// end function
            );
            }
            else
            {
                this._isoNavi.setIn(function () : void
            {
                TextControl.setText(_mcBalloon.chrInfoBalloonTopMc.chrInfoBalloonMc.textMc.textDt, str);
                _isoBalloon.setIn();
                return;
            }// end function
            );
            }
            return;
        }// end function

        public function hideTutorialBalloon() : void
        {
            if (this._mcBalloon)
            {
                if (this._isoNavi.bOpened || this._isoNavi.bAnimetionOpen)
                {
                    this._isoNavi.setOut();
                }
                if (this._isoBalloon.bOpened || this._isoBalloon.bAnimetionOpen)
                {
                    this._isoBalloon.setOut();
                }
            }
            return;
        }// end function

        public function hideTutorial() : void
        {
            this.hideTutorialArrow();
            this.hideTutorialBalloon();
            return;
        }// end function

        public function basicTutorialPopup(param1:int, param2:int, param3:Function = null) : void
        {
            var userState:* = param1;
            var flag:* = param2;
            var cbClose:* = param3;
            if (cbClose == null)
            {
                cbClose = function () : void
            {
                return;
            }// end function
            ;
            }
            switch(flag)
            {
                case BASIC_TUTORIAL_FLAG_TUTORIAL_QUEST_START:
                {
                    break;
                }
                case BASIC_TUTORIAL_FLAG_FIRST_BATTLE_START:
                {
                    break;
                }
                case BASIC_TUTORIAL_FLAG_SKILL_COMES_UP:
                {
                    break;
                }
                case BASIC_TUTORIAL_FLAG_FIRST_BATTLE_END:
                {
                    break;
                }
                case BASIC_TUTORIAL_FLAG_QUEST_JUNCTION_REACH:
                {
                    break;
                }
                case BASIC_TUTORIAL_FLAG_QUEST_JUNCTION_DIVIDE_UNIT:
                {
                    break;
                }
                case BASIC_TUTORIAL_FLAG_SKILL_CHAIN_BEFORE:
                {
                    break;
                }
                case BASIC_TUTORIAL_FLAG_SKILL_CHAIN_AFTER:
                {
                    break;
                }
                case BASIC_TUTORIAL_FLAG_PICKUP_ITEM:
                {
                    break;
                }
                case BASIC_TUTORIAL_FLAG_BOSS_BATTLE:
                {
                    break;
                }
                case BASIC_TUTORIAL_FLAG_TUTORIAL_QUEST_END:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            switch(flag)
            {
                case BASIC_TUTORIAL_FLAG_QUEST_LIST:
                {
                    break;
                }
                case BASIC_TUTORIAL_FLAG_FEVER_ITEM:
                {
                    break;
                }
                case BASIC_TUTORIAL_FLAG_QUEST_SELECT_END:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            switch(flag)
            {
                case BASIC_TUTORIAL_FLAG_MAIN_QUEST_START:
                {
                    break;
                }
                case BASIC_TUTORIAL_FLAG_FORMATION_SKILL_BEFORE:
                {
                    break;
                }
                case BASIC_TUTORIAL_FLAG_FORMATION_SKILL_AFTER:
                {
                    break;
                }
                case BASIC_TUTORIAL_FLAG_QUEST_JUNCTION_ROUTE_CHECK_BEFORE:
                {
                    break;
                }
                case BASIC_TUTORIAL_FLAG_QUEST_JUNCTION_ROUTE_CHECK_AFTER:
                {
                    break;
                }
                case BASIC_TUTORIAL_FLAG_CHRONOLOGY:
                {
                    break;
                }
                case BASIC_TUTORIAL_FLAG_MAIN_QUEST_END:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (userState == CommonConstant.USER_STATE_TUTORIAL_3)
            {
                switch(flag)
                {
                    case BASIC_TUTORIAL_FLAG_HOME_1:
                    {
                        break;
                    }
                    case BASIC_TUTORIAL_FLAG_EMPLOY_1:
                    {
                        break;
                    }
                    case BASIC_TUTORIAL_FLAG_EMPLOY_2:
                    {
                        break;
                    }
                    case BASIC_TUTORIAL_FLAG_EMPLOY_3:
                    {
                        break;
                    }
                    case BASIC_TUTORIAL_FLAG_HOME_2:
                    {
                        break;
                    }
                    case BASIC_TUTORIAL_FLAG_COMMAND_POST_1:
                    {
                        break;
                    }
                    case BASIC_TUTORIAL_FLAG_COMMAND_POST_2:
                    {
                        break;
                    }
                    case BASIC_TUTORIAL_FLAG_HOME_3:
                    {
                        break;
                    }
                    case BASIC_TUTORIAL_FLAG_WORLD_MAP:
                    {
                        break;
                    }
                    case BASIC_TUTORIAL_FLAG_HOME_4:
                    {
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        public function facilityTutorialPopup(param1:Array, param2:Function = null) : void
        {
            var flag:* = param1;
            var cbClose:* = param2;
            if (cbClose == null)
            {
                cbClose = function () : void
            {
                return;
            }// end function
            ;
            }
            switch(flag)
            {
                case FACILITY_TUTORIAL_FLAG_MYPAGE:
                {
                    this.addFacilityTutorialEnd(flag);
                    NetManager.getInstance().request(new NetTaskTutorialFacilityCheck(CommonConstant.FACILITY_TUTORIAL_FLAG_MYPAGE, function (param1:NetResult) : void
            {
                return;
            }// end function
            ));
                    CommonPopup.getInstance().openTutorialPopup(CommonPopup.POPUP_TYPE_NAVI, [MessageId.FACILITY_TUTORIAL_MESSAGE_PALACE_001], [MessageId.FACILITY_TUTORIAL_ANSWER_PALACE_001], cbClose);
                    break;
                }
                case FACILITY_TUTORIAL_FLAG_DAILY_MISSION:
                {
                    this.addFacilityTutorialEnd(flag);
                    NetManager.getInstance().request(new NetTaskTutorialFacilityCheck(CommonConstant.FACILITY_TUTORIAL_FLAG_DAILY_MISSION, function (param1:NetResult) : void
            {
                return;
            }// end function
            ));
                    CommonPopup.getInstance().openTutorialPopup(CommonPopup.POPUP_TYPE_NAVI, [MessageId.DAILY_MISSION_POPUP_NAVI_MESSAGE], [MessageId.FACILITY_TUTORIAL_ANSWER_PALACE_001], cbClose);
                    break;
                }
                case FACILITY_TUTORIAL_FLAG_MYPAGE_ALBUM:
                {
                    this.addFacilityTutorialEnd(flag);
                    NetManager.getInstance().request(new NetTaskTutorialFacilityCheck(CommonConstant.FACILITY_TUTORIAL_FLAG_MYPAGE_ALBUM, function (param1:NetResult) : void
            {
                return;
            }// end function
            ));
                    CommonPopup.getInstance().openTutorialPopup(CommonPopup.POPUP_TYPE_NAVI, [MessageId.FACILITY_TUTORIAL_MESSAGE_PALACE_ALBUM_001], [MessageId.FACILITY_TUTORIAL_ANSWER_PALACE_001], cbClose);
                    break;
                }
                case FACILITY_TUTORIAL_FLAG_MYPAGE_CHRONOLOGY:
                {
                    this.addFacilityTutorialEnd(flag);
                    NetManager.getInstance().request(new NetTaskTutorialFacilityCheck(CommonConstant.FACILITY_TUTORIAL_FLAG_MYPAGE_CHRONOLOGY, function (param1:NetResult) : void
            {
                return;
            }// end function
            ));
                    CommonPopup.getInstance().openTutorialPopup(CommonPopup.POPUP_TYPE_NAVI, [MessageId.FACILITY_TUTORIAL_MESSAGE_PALACE_CHRONOLOZY_001], [MessageId.FACILITY_TUTORIAL_ANSWER_PALACE_001], cbClose);
                    break;
                }
                case FACILITY_TUTORIAL_FLAG_MYPAGE_CODE_INPUT:
                {
                    this.addFacilityTutorialEnd(flag);
                    NetManager.getInstance().request(new NetTaskTutorialFacilityCheck(CommonConstant.FACILITY_TUTORIAL_FLAG_MYPAGE_CODE_INPUT, function (param1:NetResult) : void
            {
                return;
            }// end function
            ));
                    CommonPopup.getInstance().openTutorialPopup(CommonPopup.POPUP_TYPE_NAVI, [MessageId.FACILITY_TUTORIAL_MESSAGE_PALACE_CODE_INPUT_001], [MessageId.FACILITY_TUTORIAL_ANSWER_PALACE_001], cbClose);
                    break;
                }
                case FACILITY_TUTORIAL_FLAG_MYPAGE_CROWN_HISTORY:
                {
                    this.addFacilityTutorialEnd(flag);
                    NetManager.getInstance().request(new NetTaskTutorialFacilityCheck(CommonConstant.FACILITY_TUTORIAL_FLAG_MYPAGE_CROWN_HISTORY, function (param1:NetResult) : void
            {
                return;
            }// end function
            ));
                    CommonPopup.getInstance().openTutorialPopup(CommonPopup.POPUP_TYPE_NAVI, [MessageId.FACILITY_TUTORIAL_MESSAGE_PALACE_CROWN_HISTORY_001], [MessageId.FACILITY_TUTORIAL_ANSWER_PALACE_001], cbClose);
                    break;
                }
                case FACILITY_TUTORIAL_FLAG_WEARHOUSE:
                {
                    this.addFacilityTutorialEnd(flag);
                    NetManager.getInstance().request(new NetTaskTutorialFacilityCheck(CommonConstant.FACILITY_TUTORIAL_FLAG_WEARHOUSE, function (param1:NetResult) : void
            {
                return;
            }// end function
            ));
                    CommonPopup.getInstance().openTutorialPopup(CommonPopup.POPUP_TYPE_NAVI, [MessageId.FACILITY_TUTORIAL_MESSAGE_STORAGE_001], [MessageId.FACILITY_TUTORIAL_ANSWER_STORAGE_001], cbClose);
                    break;
                }
                case FACILITY_TUTORIAL_FLAG_TRADING_POST:
                {
                    this.addFacilityTutorialEnd(flag);
                    NetManager.getInstance().request(new NetTaskTutorialFacilityCheck(CommonConstant.FACILITY_TUTORIAL_FLAG_TRADING_POST, function (param1:NetResult) : void
            {
                return;
            }// end function
            ));
                    CommonPopup.getInstance().openTutorialPopup(CommonPopup.POPUP_TYPE_NAVI_FULBRIGHT, [MessageId.FACILITY_TUTORIAL_MESSAGE_TRADING_POST_001], [MessageId.FACILITY_TUTORIAL_ANSWER_TRADING_POST_001], cbClose);
                    break;
                }
                case FACILITY_TUTORIAL_FLAG_BARRACKS_FIRST:
                {
                    this.addFacilityTutorialEnd(flag);
                    NetManager.getInstance().request(new NetTaskTutorialFacilityCheck(CommonConstant.FACILITY_TUTORIAL_FLAG_BARRACKS_FIRST, function (param1:NetResult) : void
            {
                return;
            }// end function
            ));
                    CommonPopup.getInstance().openTutorialPopup(CommonPopup.POPUP_TYPE_NAVI, [MessageId.SUB_TUTORIAL_MESSAGE__BARRACKS], [MessageId.SUB_TUTORIAL_MESSAGE_BARRACKS_BUTTON], cbClose);
                    break;
                }
                case FACILITY_TUTORIAL_FLAG_BARRACKS_1:
                {
                    this.addFacilityTutorialEnd(flag);
                    NetManager.getInstance().request(new NetTaskTutorialFacilityCheck(CommonConstant.FACILITY_TUTORIAL_FLAG_BARRACKS_1, function (param1:NetResult) : void
            {
                return;
            }// end function
            ));
                    CommonPopup.getInstance().openTutorialPopup(CommonPopup.POPUP_TYPE_NAVI, [MessageId.FACILITY_TUTORIAL_MESSAGE_BARRACKS_001, MessageId.FACILITY_TUTORIAL_MESSAGE_BARRACKS_002], [MessageId.FACILITY_TUTORIAL_ANSWER_BARRACKS_001, MessageId.FACILITY_TUTORIAL_ANSWER_BARRACKS_002], cbClose);
                    break;
                }
                case FACILITY_TUTORIAL_FLAG_BARRACKS_2:
                {
                    this.addFacilityTutorialEnd(flag);
                    CommonPopup.getInstance().openTutorialPopup(CommonPopup.POPUP_TYPE_NAVI, [MessageId.FACILITY_TUTORIAL_MESSAGE_BARRACKS_003, MessageId.FACILITY_TUTORIAL_MESSAGE_BARRACKS_004], [MessageId.FACILITY_TUTORIAL_ANSWER_BARRACKS_003, MessageId.FACILITY_TUTORIAL_ANSWER_BARRACKS_004], cbClose);
                    break;
                }
                case FACILITY_TUTORIAL_FLAG_BARRACKS_3:
                {
                    this.addFacilityTutorialEnd(flag);
                    CommonPopup.getInstance().openTutorialPopup(CommonPopup.POPUP_TYPE_NAVI, [MessageId.FACILITY_TUTORIAL_MESSAGE_BARRACKS_005], [MessageId.FACILITY_TUTORIAL_ANSWER_BARRACKS_005], cbClose);
                    break;
                }
                case FACILITY_TUTORIAL_FLAG_TRAINING_ROOM:
                {
                    this.addFacilityTutorialEnd(flag);
                    NetManager.getInstance().request(new NetTaskTutorialFacilityCheck(CommonConstant.FACILITY_TUTORIAL_FLAG_TRAINING_ROOM, function (param1:NetResult) : void
            {
                return;
            }// end function
            ));
                    CommonPopup.getInstance().openTutorialPopup(CommonPopup.POPUP_TYPE_NAVI_SEKISHUSAI, [MessageId.FACILITY_TUTORIAL_MESSAGE_TRAINING_ROOM_001], [MessageId.FACILITY_TUTORIAL_ANSWER_TRAINING_ROOM_001], cbClose);
                    break;
                }
                case FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_KUMITE_1:
                {
                    this.addFacilityTutorialEnd(flag);
                    CommonPopup.getInstance().openTutorialPopup(CommonPopup.POPUP_TYPE_NAVI_SEKISHUSAI, [MessageId.FACILITY_TUTORIAL_MESSAGE_TRAINING_ROOM_KUMITE_001], [MessageId.FACILITY_TUTORIAL_ANSWER_TRAINING_ROOM_KUMITE_001], cbClose);
                    break;
                }
                case FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_KUMITE_2:
                {
                    this.addFacilityTutorialEnd(flag);
                    CommonPopup.getInstance().openTutorialPopup(CommonPopup.POPUP_TYPE_NAVI_SEKISHUSAI, [MessageId.FACILITY_TUTORIAL_MESSAGE_TRAINING_ROOM_KUMITE_002], [MessageId.FACILITY_TUTORIAL_ANSWER_TRAINING_ROOM_KUMITE_002], cbClose);
                    break;
                }
                case FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_KUMITE_3:
                {
                    this.addFacilityTutorialEnd(flag);
                    CommonPopup.getInstance().openTutorialPopup_StringArray(CommonPopup.POPUP_TYPE_NAVI_SEKISHUSAI, [TextControl.formatIdText(MessageId.FACILITY_TUTORIAL_MESSAGE_TRAINING_ROOM_KUMITE_003, AssetListManager.getInstance().getAssetName(AssetId.ASSET_TRAINING))], [MessageId.FACILITY_TUTORIAL_ANSWER_TRAINING_ROOM_KUMITE_003], cbClose);
                    break;
                }
                case FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_KUMITE_4:
                {
                    this.addFacilityTutorialEnd(flag);
                    CommonPopup.getInstance().openTutorialPopup(CommonPopup.POPUP_TYPE_NAVI_SEKISHUSAI, [MessageId.FACILITY_TUTORIAL_MESSAGE_TRAINING_ROOM_KUMITE_004], [MessageId.FACILITY_TUTORIAL_ANSWER_TRAINING_ROOM_KUMITE_004], cbClose);
                    break;
                }
                case FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_KUMITE_5:
                {
                    this.addFacilityTutorialEnd(flag);
                    CommonPopup.getInstance().openTutorialPopup(CommonPopup.POPUP_TYPE_NAVI_SEKISHUSAI, [MessageId.FACILITY_TUTORIAL_MESSAGE_TRAINING_ROOM_KUMITE_005, MessageId.FACILITY_TUTORIAL_MESSAGE_TRAINING_ROOM_KUMITE_006], [MessageId.FACILITY_TUTORIAL_ANSWER_TRAINING_ROOM_KUMITE_005, MessageId.FACILITY_TUTORIAL_ANSWER_TRAINING_ROOM_KUMITE_006], cbClose);
                    break;
                }
                case FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_KUMITE_6:
                {
                    this.addFacilityTutorialEnd(flag);
                    CommonPopup.getInstance().openTutorialPopup(CommonPopup.POPUP_TYPE_NAVI_SEKISHUSAI, [MessageId.FACILITY_TUTORIAL_MESSAGE_TRAINING_ROOM_KUMITE_007], [MessageId.FACILITY_TUTORIAL_ANSWER_TRAINING_ROOM_KUMITE_007], cbClose);
                    break;
                }
                case FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_TRAINING_1:
                {
                    this.addFacilityTutorialEnd(flag);
                    CommonPopup.getInstance().openTutorialPopup(CommonPopup.POPUP_TYPE_NAVI_SEKISHUSAI, [MessageId.FACILITY_TUTORIAL_MESSAGE_TRAINING_ROOM_TRAINING_001], [MessageId.FACILITY_TUTORIAL_ANSWER_TRAINING_ROOM_TRAINING_001], cbClose);
                    break;
                }
                case FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_TRAINING_2:
                {
                    this.addFacilityTutorialEnd(flag);
                    CommonPopup.getInstance().openTutorialPopup_StringArray(CommonPopup.POPUP_TYPE_NAVI_SEKISHUSAI, [TextControl.formatIdText(MessageId.FACILITY_TUTORIAL_MESSAGE_TRAINING_ROOM_TRAINING_002, AssetListManager.getInstance().getAssetName(AssetId.ASSET_TRAINING))], [MessageId.FACILITY_TUTORIAL_ANSWER_TRAINING_ROOM_TRAINING_002], cbClose);
                    break;
                }
                case FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_TRAINING_3:
                {
                    this.addFacilityTutorialEnd(flag);
                    CommonPopup.getInstance().openTutorialPopup_StringArray(CommonPopup.POPUP_TYPE_NAVI_SEKISHUSAI, [TextControl.formatIdText(MessageId.FACILITY_TUTORIAL_MESSAGE_TRAINING_ROOM_TRAINING_003, ItemManager.getInstance().getItemName(CommonConstant.ITEM_KIND_PAYMENT_ITEM, PaymentItemId.ITEM_INSTANT_LEARNING)), MessageManager.getInstance().getMessage(MessageId.FACILITY_TUTORIAL_MESSAGE_TRAINING_ROOM_TRAINING_FREE)], [MessageId.FACILITY_TUTORIAL_ANSWER_TRAINING_ROOM_TRAINING_003, MessageId.FACILITY_TUTORIAL_ANSWER_TRAINING_ROOM_TRAINING_FREE], cbClose);
                    break;
                }
                case FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_TRAINING_4:
                {
                    this.addFacilityTutorialEnd(flag);
                    CommonPopup.getInstance().openTutorialPopup(CommonPopup.POPUP_TYPE_NAVI_SEKISHUSAI, [MessageId.FACILITY_TUTORIAL_MESSAGE_TRAINING_ROOM_TRAINING_004], [MessageId.FACILITY_TUTORIAL_ANSWER_TRAINING_ROOM_TRAINING_004], cbClose);
                    break;
                }
                case FACILITY_TUTORIAL_FLAG_MAGIC_LABO:
                {
                    this.addFacilityTutorialEnd(flag);
                    NetManager.getInstance().request(new NetTaskTutorialFacilityCheck(CommonConstant.FACILITY_TUTORIAL_FLAG_MAGIC_LABO, function (param1:NetResult) : void
            {
                return;
            }// end function
            ));
                    CommonPopup.getInstance().openTutorialPopup(CommonPopup.POPUP_TYPE_NAVI_EMERALD, [MessageId.FACILITY_TUTORIAL_MESSAGE_MAGIC_LABO_001], [MessageId.FACILITY_TUTORIAL_ANSWER_MAGIC_LABO_001], cbClose);
                    break;
                }
                case FACILITY_TUTORIAL_FLAG_MAGIC_LABO_DEVELOP:
                {
                    this.addFacilityTutorialEnd(flag);
                    CommonPopup.getInstance().openTutorialPopup_StringArray(CommonPopup.POPUP_TYPE_NAVI_EMERALD, [MessageManager.getInstance().getMessage(MessageId.FACILITY_TUTORIAL_MESSAGE_MAGIC_LABO_DEVELOP_001), TextControl.formatIdText(MessageId.FACILITY_TUTORIAL_MESSAGE_MAGIC_LABO_DEVELOP_002, AssetListManager.getInstance().getAssetName(AssetId.ASSET_MAGIC_DEVELOP))], [MessageId.FACILITY_TUTORIAL_ANSWER_MAGIC_LABO_DEVELOP_001, MessageId.FACILITY_TUTORIAL_ANSWER_MAGIC_LABO_DEVELOP_002], cbClose);
                    break;
                }
                case FACILITY_TUTORIAL_FLAG_MAGIC_LABO_DEVELOP_2:
                {
                    this.addFacilityTutorialEnd(flag);
                    CommonPopup.getInstance().openTutorialPopup(CommonPopup.POPUP_TYPE_NAVI_EMERALD, [MessageId.FACILITY_TUTORIAL_MESSAGE_MAGIC_LABO_DEVELOP_FREE], [MessageId.FACILITY_TUTORIAL_ANSWER_MAGIC_LABO_DEVELOP_FREE], cbClose);
                    break;
                }
                case FACILITY_TUTORIAL_FLAG_MAGIC_LABO_DEVELOP_3:
                {
                    this.addFacilityTutorialEnd(flag);
                    CommonPopup.getInstance().openTutorialPopup(CommonPopup.POPUP_TYPE_NAVI_EMERALD, [MessageId.FACILITY_TUTORIAL_MESSAGE_MAGIC_LABO_DEVELOP_003], [MessageId.FACILITY_TUTORIAL_ANSWER_MAGIC_LABO_DEVELOP_003], cbClose);
                    break;
                }
                case FACILITY_TUTORIAL_FLAG_MAGIC_LABO_LEARNING_1:
                {
                    this.addFacilityTutorialEnd(flag);
                    CommonPopup.getInstance().openTutorialPopup(CommonPopup.POPUP_TYPE_NAVI_EMERALD, [MessageId.FACILITY_TUTORIAL_MESSAGE_MAGIC_LABO_LERNING_001], [MessageId.FACILITY_TUTORIAL_ANSWER_MAGIC_LABO_LERNING_001], cbClose);
                    break;
                }
                case FACILITY_TUTORIAL_FLAG_MAGIC_LABO_LEARNING_2:
                {
                    this.addFacilityTutorialEnd(flag);
                    CommonPopup.getInstance().openTutorialPopup_StringArray(CommonPopup.POPUP_TYPE_NAVI_EMERALD, [TextControl.formatIdText(MessageId.FACILITY_TUTORIAL_MESSAGE_MAGIC_LABO_LERNING_002, AssetListManager.getInstance().getAssetName(AssetId.ASSET_MAGIC_DEVELOP))], [MessageId.FACILITY_TUTORIAL_ANSWER_MAGIC_LABO_LERNING_002], cbClose);
                    break;
                }
                case FACILITY_TUTORIAL_FLAG_MAGIC_LABO_LEARNING_3:
                {
                    this.addFacilityTutorialEnd(flag);
                    CommonPopup.getInstance().openTutorialPopup(CommonPopup.POPUP_TYPE_NAVI_EMERALD, [MessageId.FACILITY_TUTORIAL_MESSAGE_MAGIC_LABO_LERNING_003], [MessageId.FACILITY_TUTORIAL_ANSWER_MAGIC_LABO_LERNING_003], cbClose);
                    break;
                }
                case FACILITY_TUTORIAL_FLAG_MAGIC_LABO_LEARNING_INSTANT:
                {
                    this.addFacilityTutorialEnd(flag);
                    CommonPopup.getInstance().openTutorialPopup(CommonPopup.POPUP_TYPE_NAVI_EMERALD, [MessageId.FACILITY_TUTORIAL_MESSAGE_MAGIC_LABO_LERNING_FREE], [MessageId.FACILITY_TUTORIAL_ANSWER_MAGIC_LABO_LERNING_FREE], cbClose);
                    break;
                }
                case FACILITY_TUTORIAL_FLAG_MAGIC_LABO_LEARNING_4:
                {
                    this.addFacilityTutorialEnd(flag);
                    CommonPopup.getInstance().openTutorialPopup(CommonPopup.POPUP_TYPE_NAVI_EMERALD, [MessageId.FACILITY_TUTORIAL_MESSAGE_MAGIC_LABO_LERNING_004], [MessageId.FACILITY_TUTORIAL_ANSWER_MAGIC_LABO_LERNING_004], cbClose);
                    break;
                }
                case FACILITY_TUTORIAL_FLAG_SKILL_INITIATE_1:
                {
                    this.addFacilityTutorialEnd(flag);
                    CommonPopup.getInstance().openTutorialPopup(CommonPopup.POPUP_TYPE_NAVI, [MessageId.FACILITY_TUTORIAL_MESSAGE_SKILL_INITIATE_001], [MessageId.FACILITY_TUTORIAL_ANSWER_SKILL_INITIATE_001], cbClose);
                    break;
                }
                case FACILITY_TUTORIAL_FLAG_SKILL_INITIATE_2:
                {
                    this.addFacilityTutorialEnd(flag);
                    CommonPopup.getInstance().openTutorialPopup(CommonPopup.POPUP_TYPE_NAVI, [MessageId.FACILITY_TUTORIAL_MESSAGE_SKILL_INITIATE_002], [MessageId.FACILITY_TUTORIAL_ANSWER_SKILL_INITIATE_002], cbClose);
                    break;
                }
                case FACILITY_TUTORIAL_FLAG_SKILL_INITIATE_3:
                {
                    this.addFacilityTutorialEnd(flag);
                    CommonPopup.getInstance().openTutorialPopup(CommonPopup.POPUP_TYPE_NAVI, [MessageId.FACILITY_TUTORIAL_MESSAGE_SKILL_INITIATE_003], [MessageId.FACILITY_TUTORIAL_ANSWER_SKILL_INITIATE_003], cbClose);
                    break;
                }
                case FACILITY_TUTORIAL_FLAG_SKILL_INITIATE_4:
                {
                    this.addFacilityTutorialEnd(flag);
                    CommonPopup.getInstance().openTutorialPopup(CommonPopup.POPUP_TYPE_NAVI, [MessageId.FACILITY_TUTORIAL_MESSAGE_SKILL_INITIATE_004, MessageId.FACILITY_TUTORIAL_MESSAGE_SKILL_INITIATE_005], [MessageId.FACILITY_TUTORIAL_ANSWER_SKILL_INITIATE_004, MessageId.FACILITY_TUTORIAL_ANSWER_SKILL_INITIATE_005], cbClose);
                    break;
                }
                case FACILITY_TUTORIAL_FLAG_SKILL_INITIATE_5:
                {
                    this.addFacilityTutorialEnd(flag);
                    CommonPopup.getInstance().openTutorialPopup(CommonPopup.POPUP_TYPE_NAVI, [MessageId.FACILITY_TUTORIAL_MESSAGE_SKILL_INITIATE_006, MessageId.FACILITY_TUTORIAL_MESSAGE_SKILL_INITIATE_007, MessageId.FACILITY_TUTORIAL_MESSAGE_SKILL_INITIATE_008], [MessageId.FACILITY_TUTORIAL_ANSWER_SKILL_INITIATE_006, MessageId.FACILITY_TUTORIAL_ANSWER_SKILL_INITIATE_007, MessageId.FACILITY_TUTORIAL_ANSWER_SKILL_INITIATE_008], cbClose);
                    break;
                }
                case FACILITY_TUTORIAL_FLAG_MAKE_EQUIP:
                {
                    this.addFacilityTutorialEnd(flag);
                    NetManager.getInstance().request(new NetTaskTutorialFacilityCheck(CommonConstant.FACILITY_TUTORIAL_FLAG_MAKE_EQUIP, function (param1:NetResult) : void
            {
                return;
            }// end function
            ));
                    CommonPopup.getInstance().openTutorialPopup(CommonPopup.POPUP_TYPE_NAVI_NORA, [MessageId.FACILITY_TUTORIAL_MESSAGE_MAKE_EQUIP_001], [MessageId.FACILITY_TUTORIAL_ANSWER_MAKE_EQUIP_001], cbClose);
                    break;
                }
                case FACILITY_TUTORIAL_FLAG_MAKE_EQUIP_SYNTHETIC_1:
                {
                    this.addFacilityTutorialEnd(flag);
                    CommonPopup.getInstance().openTutorialPopup(CommonPopup.POPUP_TYPE_NAVI_NORA, [MessageId.FACILITY_TUTORIAL_MESSAGE_MAKE_EQUIP_SYNTHETIC_001], [MessageId.FACILITY_TUTORIAL_ANSWER_MAKE_EQUIP_SYNTHETIC_001], cbClose);
                    break;
                }
                case FACILITY_TUTORIAL_FLAG_MAKE_EQUIP_SYNTHETIC_2:
                {
                    this.addFacilityTutorialEnd(flag);
                    CommonPopup.getInstance().openTutorialPopup(CommonPopup.POPUP_TYPE_NAVI_NORA, [MessageId.FACILITY_TUTORIAL_MESSAGE_MAKE_EQUIP_SYNTHETIC_002], [MessageId.FACILITY_TUTORIAL_ANSWER_MAKE_EQUIP_SYNTHETIC_002], cbClose);
                    break;
                }
                case FACILITY_TUTORIAL_FLAG_MAKE_EQUIP_SYNTHETIC_3:
                {
                    this.addFacilityTutorialEnd(flag);
                    CommonPopup.getInstance().openTutorialPopup(CommonPopup.POPUP_TYPE_NAVI_NORA, [MessageId.FACILITY_TUTORIAL_MESSAGE_MAKE_EQUIP_SYNTHETIC_003], [MessageId.FACILITY_TUTORIAL_ANSWER_MAKE_EQUIP_SYNTHETIC_003], cbClose);
                    break;
                }
                case FACILITY_TUTORIAL_FLAG_MAKE_EQUIP_DECOMPOSITION_1:
                {
                    this.addFacilityTutorialEnd(flag);
                    NetManager.getInstance().request(new NetTaskTutorialFacilityCheck(CommonConstant.FACILITY_TUTORIAL_FLAG_MAKE_EQUIP_DECOMPOSITION_1, function (param1:NetResult) : void
            {
                return;
            }// end function
            ));
                    CommonPopup.getInstance().openTutorialPopup(CommonPopup.POPUP_TYPE_NAVI_NORA, [MessageId.FACILITY_TUTORIAL_MESSAGE_MAKE_EQUIP_DECOMPOSITION_001], [MessageId.FACILITY_TUTORIAL_ANSWER_MAKE_EQUIP_DECOMPOSITION_001], cbClose);
                    break;
                }
                case FACILITY_TUTORIAL_FLAG_FACILITY_UPGRADE_1:
                {
                    this.addFacilityTutorialEnd(flag);
                    CommonPopup.getInstance().openTutorialPopup(CommonPopup.POPUP_TYPE_NAVI, [MessageId.FACILITY_TUTORIAL_MESSAGE_UPGRADE_001], [MessageId.FACILITY_TUTORIAL_ANSWER_UPGRADE_001], cbClose);
                    break;
                }
                case FACILITY_TUTORIAL_FLAG_FACILITY_UPGRADE_2:
                {
                    this.addFacilityTutorialEnd(flag);
                    NetManager.getInstance().request(new NetTaskTutorialFacilityCheck(CommonConstant.FACILITY_TUTORIAL_FLAG_FACILITY_UPGRADE_2, function (param1:NetResult) : void
            {
                return;
            }// end function
            ));
                    CommonPopup.getInstance().openTutorialPopup(CommonPopup.POPUP_TYPE_NAVI, [MessageId.FACILITY_TUTORIAL_MESSAGE_UPGRADE_002], [MessageId.FACILITY_TUTORIAL_ANSWER_UPGRADE_002], cbClose);
                    break;
                }
                case FACILITY_TUTORIAL_FLAG_FACILITY_UPGRADE_3:
                {
                    this.addFacilityTutorialEnd(flag);
                    CommonPopup.getInstance().openTutorialPopup(CommonPopup.POPUP_TYPE_NAVI, [MessageId.FACILITY_TUTORIAL_MESSAGE_UPGRADE_003], [MessageId.FACILITY_TUTORIAL_ANSWER_UPGRADE_003], cbClose);
                    break;
                }
                case FACILITY_TUTORIAL_FLAG_FACILITY_UPGRADE_4:
                {
                    this.addFacilityTutorialEnd(flag);
                    NetManager.getInstance().request(new NetTaskTutorialFacilityCheck(CommonConstant.FACILITY_TUTORIAL_FLAG_FACILITY_UPGRADE_3, function (param1:NetResult) : void
            {
                return;
            }// end function
            ));
                    CommonPopup.getInstance().openTutorialPopup(CommonPopup.POPUP_TYPE_NAVI, [MessageId.FACILITY_TUTORIAL_MESSAGE_UPGRADE_004], [MessageId.FACILITY_TUTORIAL_ANSWER_UPGRADE_004], cbClose);
                    break;
                }
                case FACILITY_TUTORIAL_FLAG_FACILITY_UPGRADE_5:
                {
                    this.addFacilityTutorialEnd(flag);
                    CommonPopup.getInstance().openTutorialPopup(CommonPopup.POPUP_TYPE_NAVI, [MessageId.FACILITY_TUTORIAL_MESSAGE_UPGRADE_005], [MessageId.FACILITY_TUTORIAL_ANSWER_UPGRADE_005], cbClose);
                    break;
                }
                case FACILITY_TUTORIAL_FLAG_CAMPAIGN_QUEST:
                {
                    this.addFacilityTutorialEnd(flag);
                    NetManager.getInstance().request(new NetTaskTutorialFacilityCheck(CommonConstant.FACILITY_TUTORIAL_FLAG_CAMPAIGN_QUEST, function (param1:NetResult) : void
            {
                return;
            }// end function
            ));
                    CommonPopup.getInstance().openTutorialPopup(CommonPopup.POPUP_TYPE_NAVI, [MessageId.NEW_EVENT_QUEST_NOTICE], [MessageId.COMMON_BUTTON_CLOSE], cbClose);
                    break;
                }
                case FACILITY_TUTORIAL_FLAG_COMMAND_POST_COMMANDER:
                {
                    this.addFacilityTutorialEnd(flag);
                    NetManager.getInstance().request(new NetTaskTutorialFacilityCheck(CommonConstant.FACILITY_TUTORIAL_FLAG_COMMANDER, function (param1:NetResult) : void
            {
                return;
            }// end function
            ));
                    CommonPopup.getInstance().openTutorialPopup(CommonPopup.POPUP_TYPE_NAVI, [MessageId.FACILITY_TUTORIAL_MESSAGE_COMMAND_POST_001, MessageId.FACILITY_TUTORIAL_MESSAGE_COMMAND_POST_002], [MessageId.COMMON_BUTTON_NEXT, MessageId.COMMON_BUTTON_CLOSE], cbClose);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function sendFacilityTutorialCheck(param1:uint) : void
        {
            var flag:* = param1;
            if ((this._facilityTutorialEndServerFlag & flag) == 0)
            {
                this._facilityTutorialEndServerFlag = this._facilityTutorialEndServerFlag | flag;
                NetManager.getInstance().request(new NetTaskTutorialFacilityCheck(this._facilityTutorialEndServerFlag, function (param1:NetResult) : void
            {
                return;
            }// end function
            ));
            }
            return;
        }// end function

        public static function getInstance() : TutorialManager
        {
            if (_instance == null)
            {
                _instance = new TutorialManager;
            }
            return _instance;
        }// end function

    }
}
