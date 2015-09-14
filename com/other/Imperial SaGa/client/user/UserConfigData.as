package user
{
    import develop.*;
    import flash.display.*;
    import flash.net.*;
    import sound.*;

    public class UserConfigData extends Object
    {
        private const _SPEED_NORMAL:Number = 1;
        private const _SPEED_DOUBLE_SPEED:Number = 2;
        private var _defaultFps:Number;
        private var _stage:Stage;
        private var _sharedObject:SharedObject;
        private var _bgmVolume:Number;
        private var _bBgmMute:Boolean;
        private var _seVolume:Number;
        private var _bSeMute:Boolean;
        private var _stageQuality:int;
        private var _battleSpeed:int;
        private var _callSpeed:int;
        private var _questSortType:int = 1;
        private var _bCheckedQuestDivide:Boolean;
        private static const SHARED_NAME:String = "ConfigData";
        private static const SHARED_PATH:String = "/";
        private static const BGM_NAME:String = "bgmVolume";
        private static const BGM_MUTE_NAME:String = "bgmMute";
        private static const BGM_VOLUME_DEFAULT:int = 100;
        public static const BGM_VOLUME_MIN:Number = 0;
        public static const BGM_VOLUME_MAX:Number = 100;
        private static const SE_NAME:String = "seVolume";
        private static const SE_MUTE_NAME:String = "seMute";
        private static const SE_VOLUME_DEFAULT:int = 100;
        public static const SE_VOLUME_MIN:Number = 0;
        public static const SE_VOLUME_MAX:Number = 100;
        private static const STAGE_QUALITY_NAME:String = "stageQuality";
        private static const STAGE_QUALITY_DEFAULT:int = 3;
        public static const STAGE_QUALITY_LOW:int = 1;
        public static const STAGE_QUALITY_MIDDLE:int = 2;
        public static const STAGE_QUALITY_HIGH:int = 3;
        private static const BATTLE_SPEED_NAME:String = "battleSpeed";
        private static const BATTLE_SPEED_DEFAULT:int = 0;
        public static const BATTLE_SPEED_NORMAL:int = 0;
        public static const BATTLE_SPEED_QUICK:int = 1;
        private static const CALL_SPEED_NAME:String = "callSpeed";
        private static const CALL_SPEED_DEFAULT:int = 0;
        public static const CALL_SPEED_NORMAL:int = 0;
        public static const CALL_SPEED_QUICK:int = 1;
        private static const QUEST_SORT_NAME:String = "questSort";
        private static const QUEST_SORT_TYPE_DEFAULT:int = 1;
        public static const QUEST_SORT_TYPE_NOW:int = 1;
        private static const CHECKED_QUEST_DIVIDE_NAME:String = "checkedQuestDiv";

        public function UserConfigData()
        {
            return;
        }// end function

        public function init(param1:Stage) : void
        {
            this._stage = param1;
            this._defaultFps = this._stage.frameRate;
            this.initStorage();
            return;
        }// end function

        public function clear() : void
        {
            this._sharedObject.clear();
            this.initStorage();
            return;
        }// end function

        private function initStorage() : void
        {
            var data:Object;
            this._bgmVolume = BGM_VOLUME_DEFAULT;
            this._bBgmMute = false;
            this._seVolume = SE_VOLUME_DEFAULT;
            this._bSeMute = false;
            this._stageQuality = STAGE_QUALITY_DEFAULT;
            this._battleSpeed = BATTLE_SPEED_DEFAULT;
            this._callSpeed = CALL_SPEED_DEFAULT;
            this._bCheckedQuestDivide = false;
            this._questSortType = QUEST_SORT_TYPE_DEFAULT;
            try
            {
                this._sharedObject = SharedObject.getLocal(SHARED_NAME, SHARED_PATH);
                data = this._sharedObject.data;
                if (data[BGM_NAME] != null)
                {
                    this._bgmVolume = this.checkMinMaxValue(data[BGM_NAME], BGM_VOLUME_MAX, BGM_VOLUME_MIN);
                }
                if (data[BGM_MUTE_NAME] != null)
                {
                    this._bBgmMute = data[BGM_MUTE_NAME] == 1;
                }
                if (data[SE_NAME] != null)
                {
                    this._seVolume = this.checkMinMaxValue(data[SE_NAME], SE_VOLUME_MAX, SE_VOLUME_MIN);
                }
                if (data[SE_MUTE_NAME] != null)
                {
                    this._bSeMute = data[SE_MUTE_NAME] == 1;
                }
                if (data[STAGE_QUALITY_NAME] != null)
                {
                    this._stageQuality = this.checkMinMaxValue(data[STAGE_QUALITY_NAME], STAGE_QUALITY_HIGH, STAGE_QUALITY_LOW);
                }
                if (data[BATTLE_SPEED_NAME] != null)
                {
                    this._battleSpeed = this.checkMinMaxValue(data[BATTLE_SPEED_NAME], BATTLE_SPEED_QUICK, BATTLE_SPEED_NORMAL);
                }
                if (data[CALL_SPEED_NAME] != null)
                {
                    this._callSpeed = this.checkMinMaxValue(data[CALL_SPEED_NAME], CALL_SPEED_QUICK, CALL_SPEED_NORMAL);
                }
                if (data[CHECKED_QUEST_DIVIDE_NAME] != null)
                {
                    this._bCheckedQuestDivide = data[CHECKED_QUEST_DIVIDE_NAME] == 1;
                }
                if (data[QUEST_SORT_NAME] != null)
                {
                    this._questSortType = data[QUEST_SORT_NAME];
                }
                this.updateStageQuality();
                this._sharedObject.data[BGM_NAME] = this._bgmVolume;
                this._sharedObject.data[BGM_MUTE_NAME] = this._bBgmMute == true ? (1) : (0);
                this._sharedObject.data[SE_NAME] = this._seVolume;
                this._sharedObject.data[SE_MUTE_NAME] = this._bSeMute == true ? (1) : (0);
                this._sharedObject.data[STAGE_QUALITY_NAME] = this._stageQuality;
                this._sharedObject.data[BATTLE_SPEED_NAME] = this._battleSpeed;
                this._sharedObject.data[CALL_SPEED_NAME] = this._callSpeed;
                this._sharedObject.data[CHECKED_QUEST_DIVIDE_NAME] = this._bCheckedQuestDivide == true ? (1) : (0);
                this._sharedObject.data[QUEST_SORT_NAME] = this._questSortType;
            }
            catch (error:Error)
            {
                DebugLog.print("シェアードオブジェクトの取得に失敗しました");
                DebugLog.print(error.message);
            }
            return;
        }// end function

        public function save() : void
        {
            this._sharedObject.data[BGM_NAME] = this._bgmVolume;
            this._sharedObject.data[BGM_MUTE_NAME] = this._bBgmMute == true ? (1) : (0);
            this._sharedObject.data[SE_NAME] = this._seVolume;
            this._sharedObject.data[SE_MUTE_NAME] = this._bSeMute == true ? (1) : (0);
            this._sharedObject.data[STAGE_QUALITY_NAME] = this._stageQuality;
            this._sharedObject.data[BATTLE_SPEED_NAME] = this._battleSpeed;
            this._sharedObject.data[CALL_SPEED_NAME] = this._callSpeed;
            this._sharedObject.data[CHECKED_QUEST_DIVIDE_NAME] = this._bCheckedQuestDivide == true ? (1) : (0);
            this._sharedObject.data[QUEST_SORT_NAME] = this._questSortType;
            this._sharedObject.flush();
            return;
        }// end function

        public function set bgmVolume(param1:Number) : void
        {
            param1 = this.checkMinMaxValue(param1, BGM_VOLUME_MAX, BGM_VOLUME_MIN);
            if (this._bgmVolume != param1)
            {
                this._bgmVolume = param1;
                this.updateBgmVolume(this._bgmVolume);
            }
            return;
        }// end function

        public function set bBgmMute(param1:Boolean) : void
        {
            if (this._bBgmMute != param1)
            {
                this._bBgmMute = param1;
                this.updateBgmVolume(this._bBgmMute ? (0) : (this._bgmVolume));
            }
            return;
        }// end function

        private function updateBgmVolume(param1:Number) : void
        {
            param1 = param1 * 0.01;
            SoundManager.getInstance().setVolumeBgm(param1);
            return;
        }// end function

        public function set seVolume(param1:Number) : void
        {
            param1 = this.checkMinMaxValue(param1, SE_VOLUME_MAX, SE_VOLUME_MIN);
            if (this._seVolume != param1)
            {
                this._seVolume = param1;
                this.updateSeVolume(this._seVolume);
            }
            return;
        }// end function

        public function set bSeMute(param1:Boolean) : void
        {
            if (this._bSeMute != param1)
            {
                this._bSeMute = param1;
                this.updateSeVolume(this._bSeMute ? (0) : (this._seVolume));
            }
            return;
        }// end function

        private function updateSeVolume(param1:Number) : void
        {
            param1 = param1 * 0.01;
            SoundManager.getInstance().setVolumeSe(param1);
            return;
        }// end function

        public function set stageQuality(param1:int) : void
        {
            param1 = this.checkMinMaxValue(param1, STAGE_QUALITY_HIGH, STAGE_QUALITY_LOW);
            if (this._stageQuality != param1)
            {
                this._stageQuality = param1;
                this.updateStageQuality();
            }
            return;
        }// end function

        public function set battleSpeed(param1:int) : void
        {
            param1 = this.checkMinMaxValue(param1, BATTLE_SPEED_QUICK, BATTLE_SPEED_NORMAL);
            if (this._battleSpeed != param1)
            {
                this._battleSpeed = param1;
            }
            return;
        }// end function

        public function set callSpeed(param1:int) : void
        {
            param1 = this.checkMinMaxValue(param1, CALL_SPEED_QUICK, CALL_SPEED_NORMAL);
            if (this._callSpeed != param1)
            {
                this._callSpeed = param1;
            }
            return;
        }// end function

        public function set bCheckedQuestDivide(param1:Boolean) : void
        {
            if (this._bCheckedQuestDivide != param1)
            {
                this._bCheckedQuestDivide = param1;
            }
            return;
        }// end function

        public function set questSortType(param1:int) : void
        {
            if (this._questSortType != param1)
            {
                this._questSortType = param1;
            }
            return;
        }// end function

        public function get bgmVolume() : Number
        {
            return this._bgmVolume;
        }// end function

        public function get bBgmMute() : Boolean
        {
            return this._bBgmMute;
        }// end function

        public function get seVolume() : Number
        {
            return this._seVolume;
        }// end function

        public function get bSeMute() : Boolean
        {
            return this._bSeMute;
        }// end function

        public function get stageQuality() : int
        {
            return this._stageQuality;
        }// end function

        public function get battleSpeed() : int
        {
            return this._battleSpeed;
        }// end function

        public function get callSpeed() : int
        {
            return this._callSpeed;
        }// end function

        public function get bCheckedQuestDivide() : Boolean
        {
            return this._bCheckedQuestDivide;
        }// end function

        public function get questSortType() : int
        {
            return this._questSortType;
        }// end function

        public function get bgmVolumeMag() : Number
        {
            return this._bgmVolume / BGM_VOLUME_MAX;
        }// end function

        public function get seVolumeMag() : Number
        {
            return this._seVolume / SE_VOLUME_MAX;
        }// end function

        private function checkMinMaxValue(param1:int, param2:int, param3:int) : int
        {
            return param1 < param3 ? (param3) : (param1 > param2 ? (param2) : (param1));
        }// end function

        private function updateStageQuality() : void
        {
            switch(this._stageQuality)
            {
                case Constant.STAGE_QUALITY_LOW:
                {
                    this._stage.quality = StageQuality.LOW;
                    break;
                }
                case Constant.STAGE_QUALITY_MIDDLE:
                {
                    this._stage.quality = StageQuality.MEDIUM;
                    break;
                }
                case Constant.STAGE_QUALITY_HIGH:
                {
                    this._stage.quality = StageQuality.HIGH;
                    break;
                }
                case Constant.STAGE_QUALITY_BEST:
                {
                    this._stage.quality = StageQuality.BEST;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function getBattleSpeed() : Number
        {
            var _loc_1:* = this._SPEED_NORMAL;
            if (this._battleSpeed == BATTLE_SPEED_QUICK)
            {
                _loc_1 = this._SPEED_DOUBLE_SPEED;
            }
            return _loc_1;
        }// end function

        public function setBattleSpeed() : Number
        {
            var _loc_1:* = this.getBattleSpeed();
            this._stage.frameRate = this._defaultFps * _loc_1;
            return _loc_1;
        }// end function

        public function resetBattleSpeed() : void
        {
            this._stage.frameRate = this._defaultFps;
            return;
        }// end function

        private function getSummonSpeed() : Number
        {
            var _loc_1:* = this._SPEED_NORMAL;
            if (this._callSpeed == CALL_SPEED_QUICK)
            {
                _loc_1 = this._SPEED_DOUBLE_SPEED;
            }
            return _loc_1;
        }// end function

        public function setSummonSpeed() : Number
        {
            var _loc_1:* = this.getSummonSpeed();
            this._stage.frameRate = this._defaultFps * _loc_1;
            return _loc_1;
        }// end function

        public function resetSummonSpeed() : void
        {
            this._stage.frameRate = this._defaultFps;
            return;
        }// end function

        public function getVolumeBgm() : Number
        {
            return this._bBgmMute ? (0) : (this._bgmVolume * 0.01);
        }// end function

        public function getVolumeSe() : Number
        {
            return this._bSeMute ? (0) : (this._seVolume * 0.01);
        }// end function

    }
}
