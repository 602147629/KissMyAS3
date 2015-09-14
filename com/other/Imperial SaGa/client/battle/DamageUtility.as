package battle
{
    import flash.display.*;
    import flash.geom.*;
    import resource.*;
    import utility.*;

    public class DamageUtility extends Object
    {
        private const _COUNTER_MAX:int = 5;
        private const _COUNTER_BIG_MAX:int = 8;
        protected var _mc:MovieClip;
        protected var _mcBase:MovieClip;
        private var _damage:DamageData;
        protected var _waitTime:Number;
        protected var _isoMain:InStayOut;
        protected var _bEnd:Boolean;
        private static const _SHOW_BAD_STATUS:Array = [BattleConstant.BAD_STATUS_ID_POISON, BattleConstant.BAD_STATUS_ID_PARALYSIS, BattleConstant.BAD_STATUS_ID_DARKNESS, BattleConstant.BAD_STATUS_ID_SLEEP, BattleConstant.BAD_STATUS_ID_CONFUSION, BattleConstant.BAD_STATUS_ID_STAN, BattleConstant.BAD_STATUS_ID_CHARM, BattleConstant.BAD_STATUS_ID_INSTANT_DEATH, BattleConstant.BAD_STATUS_ID_STONE, BattleConstant.BAD_STATUS_ID_ATTACK_DOWN, BattleConstant.BAD_STATUS_ID_ATTACK_UP, BattleConstant.BAD_STATUS_ID_DEFENSE_DOWN, BattleConstant.BAD_STATUS_ID_DEFENSE_UP, BattleConstant.BAD_STATUS_ID_SPEED_DOWN, BattleConstant.BAD_STATUS_ID_SPEED_UP, BattleConstant.BAD_STATUS_ID_MAGIC_DOWN, BattleConstant.BAD_STATUS_ID_MAGIC_UP];
        public static const COLOR_NORMAL:String = "normal";
        public static const COLOR_RED:String = "red";
        public static const COLOR_GREEN:String = "green";
        private static const _LABEL_ATK_UP:String = "atkUp";
        private static const _LABEL_DEF_UP:String = "defUp";
        private static const _LABEL_AGI_UP:String = "agiUp";
        private static const _LABEL_MAG_UP:String = "intUp";
        private static const _LABEL_ATK_DOWN:String = "atkDown";
        private static const _LABEL_DEF_DOWN:String = "defDown";
        private static const _LABEL_AGI_DOWN:String = "agiDown";
        private static const _LABEL_MAG_DOWN:String = "intDown";

        public function DamageUtility(param1:DisplayObjectContainer, param2:DamageData, param3:Point, param4:String = "normal")
        {
            this._bEnd = false;
            this._damage = param2;
            this._waitTime = 0;
            switch(this._damage.type)
            {
                case DamageData.TYPE_HP:
                case DamageData.TYPE_RECOVERY_HP:
                {
                    if (this._damage.hitType != BattleConstant.HIT_TYPE_MISS)
                    {
                        this._mc = this.createHpDamage(param2, param4);
                    }
                    else
                    {
                        this._mc = this.createMiss();
                    }
                    break;
                }
                case DamageData.TYPE_LP:
                {
                    this._mc = this.createLpDamage(param2, COLOR_RED);
                    break;
                }
                case DamageData.TYPE_BAD_STATUS:
                {
                    this._mc = this.createBadStatus(param2.dispStatusId);
                    break;
                }
                case DamageData.TYPE_BAD_STATUS_RESIST:
                {
                    this._mc = this.createBadStatusResist();
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (this._mcBase == null)
            {
                this._mcBase = this._mc;
            }
            param1.addChild(this._mcBase);
            this._mcBase.x = param3.x;
            this._mcBase.y = param3.y;
            this._isoMain = new InStayOut(this._mc);
            this._isoMain.setIn();
            return;
        }// end function

        public function clearWaitTime() : void
        {
            this._waitTime = 0;
            return;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._bEnd;
        }// end function

        public function release() : void
        {
            if (this._isoMain)
            {
                this._isoMain.release();
            }
            this._isoMain = null;
            if (this._mcBase && this._mcBase.parent)
            {
                this._mcBase.parent.removeChild(this._mcBase);
            }
            this._mcBase = null;
            this._mc = null;
            this._damage = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            if (this._isoMain.bOpened)
            {
                this._waitTime = this._waitTime - param1;
                if (this._waitTime <= 0)
                {
                    this._isoMain.setOut();
                }
            }
            if (this._isoMain.bEnd)
            {
                this._bEnd = true;
            }
            return;
        }// end function

        protected function createLpDamage(param1:DamageData, param2:String) : MovieClip
        {
            var _loc_3:* = this.createHpDamage(param1, param2);
            _loc_3.numBG.statusTitleMc.gotoAndStop("lp");
            return _loc_3;
        }// end function

        private function createHpDamage(param1:DamageData, param2:String) : MovieClip
        {
            var _loc_3:* = null;
            var _loc_5:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = NaN;
            var _loc_11:* = null;
            var _loc_12:* = 0;
            var _loc_4:* = this._damage.damage;
            if (this._damage.damage <= 99999 && param1.bBigDisp == false)
            {
                if (param1.hitType == BattleConstant.HIT_TYPE_REFUSE)
                {
                    _loc_9 = "CenterBattleNumGoofMc";
                }
                else if (param1.hitType == BattleConstant.HIT_TYPE_CRITICAL)
                {
                    _loc_9 = "CenterBattleNumCriticalMc";
                }
                else
                {
                    _loc_9 = "CenterBattleNumMc";
                }
                _loc_3 = ResourceManager.getInstance().createMovieClip(ResourcePath.BATTLE_PATH + "BattleNum.swf", _loc_9);
                _loc_3.scaleX = 1;
                _loc_3.scaleY = 1;
                this._waitTime = 0;
                _loc_5 = this._COUNTER_MAX;
            }
            else
            {
                _loc_10 = 1;
                if (param1.hitType == BattleConstant.HIT_TYPE_REFUSE)
                {
                    _loc_10 = 0.8;
                }
                if (param1.hitType == BattleConstant.HIT_TYPE_CRITICAL)
                {
                    _loc_10 = 1.2;
                }
                _loc_3 = ResourceManager.getInstance().createMovieClip(ResourcePath.BATTLE_PATH + "BattleNum.swf", "CenterBattleNumMc_B");
                _loc_3.scaleX = 0.9 * _loc_10;
                _loc_3.scaleY = 0.9 * _loc_10;
                this._waitTime = 0.5;
                _loc_5 = this._COUNTER_BIG_MAX;
                if (_loc_4 > 9999999)
                {
                    _loc_4 = 9999999;
                }
            }
            this._mcBase = _loc_3;
            this._mcBase.gotoAndPlay("" + _loc_4.toString().length);
            _loc_3 = _loc_3.battleNumMc;
            var _loc_6:* = _loc_4.toString().length;
            _loc_3.numBG.gotoAndStop(_loc_6 + "column");
            var _loc_7:* = _loc_4;
            var _loc_8:* = _loc_5;
            while (_loc_8 > 0)
            {
                
                _loc_11 = _loc_3.getChildByName("num" + _loc_8.toString()) as MovieClip;
                if (_loc_11 == null)
                {
                }
                else if (_loc_6 >= _loc_8)
                {
                    _loc_12 = _loc_7 % 10;
                    _loc_7 = _loc_7 / 10;
                    _loc_11.battleNum.gotoAndStop((_loc_12 + 1));
                    _loc_11.gotoAndStop(param2);
                    _loc_6 = _loc_7.toString().length;
                }
                else
                {
                    _loc_11.visible = false;
                }
                _loc_8 = _loc_8 - 1;
            }
            return _loc_3;
        }// end function

        private function createMiss() : MovieClip
        {
            var _loc_1:* = ResourceManager.getInstance().createMovieClip(ResourcePath.BATTLE_PATH + "BattleNum.swf", "BattleNumMissMc");
            return _loc_1;
        }// end function

        private function createBadStatus(param1:int) : MovieClip
        {
            var _loc_2:* = null;
            if (param1 == BattleConstant.BAD_STATUS_ID_STAN)
            {
                _loc_2 = ResourceManager.getInstance().createMovieClip(ResourcePath.BATTLE_PATH + "BattleNum.swf", "StanMc");
                this._waitTime = 0.5;
            }
            if (param1 == BattleConstant.BAD_STATUS_ID_CONFUSION)
            {
                _loc_2 = ResourceManager.getInstance().createMovieClip(ResourcePath.BATTLE_PATH + "BattleNum.swf", "TextConfusionMc");
                this._waitTime = 0.5;
            }
            if (param1 == BattleConstant.BAD_STATUS_ID_DARKNESS)
            {
                _loc_2 = ResourceManager.getInstance().createMovieClip(ResourcePath.BATTLE_PATH + "BattleNum.swf", "TextDarknessMc");
                this._waitTime = 0.5;
            }
            if (param1 == BattleConstant.BAD_STATUS_ID_CHARM)
            {
                _loc_2 = ResourceManager.getInstance().createMovieClip(ResourcePath.BATTLE_PATH + "BattleNum.swf", "TextFascinationMc");
                this._waitTime = 0.5;
            }
            if (param1 == BattleConstant.BAD_STATUS_ID_PARALYSIS)
            {
                _loc_2 = ResourceManager.getInstance().createMovieClip(ResourcePath.BATTLE_PATH + "BattleNum.swf", "TextParalyzeMc");
                this._waitTime = 0.5;
            }
            if (param1 == BattleConstant.BAD_STATUS_ID_POISON)
            {
                _loc_2 = ResourceManager.getInstance().createMovieClip(ResourcePath.BATTLE_PATH + "BattleNum.swf", "TextPoisonMc");
                this._waitTime = 0.5;
            }
            if (param1 == BattleConstant.BAD_STATUS_ID_SLEEP)
            {
                _loc_2 = ResourceManager.getInstance().createMovieClip(ResourcePath.BATTLE_PATH + "BattleNum.swf", "TextSleepMc");
                this._waitTime = 0.5;
            }
            if (param1 == BattleConstant.BAD_STATUS_ID_INSTANT_DEATH)
            {
                _loc_2 = ResourceManager.getInstance().createMovieClip(ResourcePath.BATTLE_PATH + "BattleNum.swf", "TextDeathMc");
                this._waitTime = 0.5;
            }
            if (param1 == BattleConstant.BAD_STATUS_ID_STONE)
            {
                _loc_2 = ResourceManager.getInstance().createMovieClip(ResourcePath.BATTLE_PATH + "BattleNum.swf", "TextStoneMc");
                this._waitTime = 0.5;
            }
            if (param1 == BattleConstant.BAD_STATUS_ID_ATTACK_DOWN)
            {
                _loc_2 = ResourceManager.getInstance().createMovieClip(ResourcePath.BATTLE_PATH + "BattleNum.swf", "StatusDownMc");
                _loc_2.statusDownIcon1.gotoAndStop(_LABEL_ATK_DOWN);
                _loc_2.statusDownIcon2.visible = false;
                _loc_2.statusDownIcon3.visible = false;
            }
            if (param1 == BattleConstant.BAD_STATUS_ID_ATTACK_UP)
            {
                _loc_2 = ResourceManager.getInstance().createMovieClip(ResourcePath.BATTLE_PATH + "BattleNum.swf", "StatusUpMc");
                _loc_2.statusUpIcon1.gotoAndStop(_LABEL_ATK_UP);
                _loc_2.statusUpIcon2.visible = false;
                _loc_2.statusUpIcon3.visible = false;
            }
            if (param1 == BattleConstant.BAD_STATUS_ID_DEFENSE_DOWN)
            {
                _loc_2 = ResourceManager.getInstance().createMovieClip(ResourcePath.BATTLE_PATH + "BattleNum.swf", "StatusDownMc");
                _loc_2.statusDownIcon1.gotoAndStop(_LABEL_DEF_DOWN);
                _loc_2.statusDownIcon2.visible = false;
                _loc_2.statusDownIcon3.visible = false;
            }
            if (param1 == BattleConstant.BAD_STATUS_ID_DEFENSE_UP)
            {
                _loc_2 = ResourceManager.getInstance().createMovieClip(ResourcePath.BATTLE_PATH + "BattleNum.swf", "StatusUpMc");
                _loc_2.statusUpIcon1.gotoAndStop(_LABEL_DEF_UP);
                _loc_2.statusUpIcon2.visible = false;
                _loc_2.statusUpIcon3.visible = false;
            }
            if (param1 == BattleConstant.BAD_STATUS_ID_SPEED_DOWN)
            {
                _loc_2 = ResourceManager.getInstance().createMovieClip(ResourcePath.BATTLE_PATH + "BattleNum.swf", "StatusDownMc");
                _loc_2.statusDownIcon1.gotoAndStop(_LABEL_AGI_DOWN);
                _loc_2.statusDownIcon2.visible = false;
                _loc_2.statusDownIcon3.visible = false;
            }
            if (param1 == BattleConstant.BAD_STATUS_ID_SPEED_UP)
            {
                _loc_2 = ResourceManager.getInstance().createMovieClip(ResourcePath.BATTLE_PATH + "BattleNum.swf", "StatusUpMc");
                _loc_2.statusUpIcon1.gotoAndStop(_LABEL_AGI_UP);
                _loc_2.statusUpIcon2.visible = false;
                _loc_2.statusUpIcon3.visible = false;
            }
            if (param1 == BattleConstant.BAD_STATUS_ID_MAGIC_DOWN)
            {
                _loc_2 = ResourceManager.getInstance().createMovieClip(ResourcePath.BATTLE_PATH + "BattleNum.swf", "StatusDownMc");
                _loc_2.statusDownIcon1.gotoAndStop(_LABEL_MAG_DOWN);
                _loc_2.statusDownIcon2.visible = false;
                _loc_2.statusDownIcon3.visible = false;
            }
            if (param1 == BattleConstant.BAD_STATUS_ID_MAGIC_UP)
            {
                _loc_2 = ResourceManager.getInstance().createMovieClip(ResourcePath.BATTLE_PATH + "BattleNum.swf", "StatusUpMc");
                _loc_2.statusUpIcon1.gotoAndStop(_LABEL_MAG_UP);
                _loc_2.statusUpIcon2.visible = false;
                _loc_2.statusUpIcon3.visible = false;
            }
            return _loc_2;
        }// end function

        private function createBadStatusResist() : MovieClip
        {
            var _loc_1:* = ResourceManager.getInstance().createMovieClip(ResourcePath.BATTLE_PATH + "BattleNum.swf", "ResistMc");
            this._waitTime = 0.5;
            return _loc_1;
        }// end function

        public static function isBadStatusDisplay(param1:int) : Boolean
        {
            return _SHOW_BAD_STATUS.indexOf(param1) >= 0;
        }// end function

        public static function getSoundId() : Array
        {
            return [];
        }// end function

    }
}
