package fever
{
    import battle.*;
    import develop.*;
    import flash.display.*;
    import layer.*;
    import player.*;
    import quest.*;
    import resource.*;
    import sound.*;
    import user.*;
    import utility.*;

    public class FeverModeAction extends Object
    {
        private const _CLICK_COUNT_MAX:int = 9999;
        private const _PHASE_WAIT:int = 1;
        private const _PHASE_RESOURCE_LOAD:int = 90;
        private const _PHASE_ASSAULT_DISPLAY:int = 10;
        private const _PHASE_PLAY_FEVER_ATTACK:int = 20;
        private const _PHASE_PLAY_DAMAGE:int = 30;
        private const _FEVER_PLAYER_COUNT:int = 20;
        private var _bgmId:int;
        private var _phase:int;
        private var _layer:LayerBattle;
        private var _battleManager:BattleManager;
        private var _mcBattleUi:MovieClip;
        private var _mcFeverCutinUi:MovieClip;
        private var _mcAssaultDsiplay:MovieClip;
        private var _mcAssaultEmperor:FeverEmperorMc;
        private var _feverTime:Number;
        private var _feverTimeWait:Number;
        private var _feverGaugePersent:Number;
        private var _feverAttack:FeverAttackBase;
        private var _comboCount:int;
        private var _feverComboCount:NumericNumberMc;
        private var _isoFeverComboCount:InStayOut;
        private var _aTarget:Array;
        private var _aSupportPlayerId:Array;
        private var _clickCount:int;
        private var _bExecuted:Boolean;
        private var _bFeverMode:Boolean;
        private var _bCall_ComboSetOut:Boolean;
        private var _bCall_PlayDamage:Boolean;

        public function FeverModeAction(param1:MovieClip, param2:LayerBattle, param3:BattleManager)
        {
            this._bgmId = SoundId.BGM_BATTLE_ARMYATTACK_RS1;
            this._battleManager = param3;
            this._mcBattleUi = param1;
            this._layer = param2;
            var _loc_4:* = UserDataManager.getInstance().userData.emperorId;
            this._feverGaugePersent = 0;
            this._comboCount = 0;
            this._feverComboCount = new NumericNumberMc(this._mcBattleUi.comboTopMc.comboNumMc, this._comboCount, 0.1, false);
            this._isoFeverComboCount = new InStayOut(this._mcBattleUi.comboTopMc);
            this._bFeverMode = false;
            this._bExecuted = false;
            this._aTarget = [];
            this._aSupportPlayerId = [];
            var _loc_5:* = 0;
            this._feverTimeWait = 0;
            this._feverTime = _loc_5;
            this.setPhase(this._PHASE_WAIT);
            return;
        }// end function

        public function set bgmId(param1:int) : void
        {
            this._bgmId = param1;
            return;
        }// end function

        public function get bExecuted() : Boolean
        {
            return this._bExecuted;
        }// end function

        public function get bFeverMode() : Boolean
        {
            return this._bFeverMode;
        }// end function

        public function setFeverStart() : void
        {
            this._bFeverMode = true;
            this.setPhase(this._PHASE_RESOURCE_LOAD);
            return;
        }// end function

        public function release() : void
        {
            if (this._feverComboCount)
            {
                this._feverComboCount.release();
            }
            this._feverComboCount = null;
            if (this._isoFeverComboCount)
            {
                this._isoFeverComboCount.release();
            }
            this._isoFeverComboCount = null;
            if (this._mcFeverCutinUi && this._mcFeverCutinUi.parent)
            {
                this._mcFeverCutinUi.parent.removeChild(this._mcFeverCutinUi);
            }
            this._mcFeverCutinUi = null;
            if (this._mcAssaultEmperor)
            {
                this._mcAssaultEmperor.release();
            }
            this._mcAssaultEmperor = null;
            this._mcAssaultDsiplay = null;
            this._aTarget = [];
            return;
        }// end function

        public function control(param1:Number) : void
        {
            this._feverComboCount.control(param1);
            if (this._mcAssaultEmperor)
            {
                this._mcAssaultEmperor.control(param1);
            }
            switch(this._phase)
            {
                case this._PHASE_WAIT:
                {
                    this.controlWait(param1);
                    break;
                }
                case this._PHASE_ASSAULT_DISPLAY:
                {
                    this.controlAssaultDisplay(param1);
                    break;
                }
                case this._PHASE_PLAY_FEVER_ATTACK:
                {
                    this.controlPlayFeverAttack(param1);
                    break;
                }
                case this._PHASE_PLAY_DAMAGE:
                {
                    this.controlPlayDamage(param1);
                    break;
                }
                case this._PHASE_RESOURCE_LOAD:
                {
                    this.controlResourceLoad(param1);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function setPhase(param1:int) : void
        {
            this._phase = param1;
            switch(this._phase)
            {
                case this._PHASE_WAIT:
                {
                    this.phaseWait();
                    break;
                }
                case this._PHASE_ASSAULT_DISPLAY:
                {
                    this.phaseAssaultDisplay();
                    break;
                }
                case this._PHASE_PLAY_FEVER_ATTACK:
                {
                    this.phasePlayFeverAttack();
                    break;
                }
                case this._PHASE_PLAY_DAMAGE:
                {
                    this.phasePlayDamage();
                    break;
                }
                case this._PHASE_RESOURCE_LOAD:
                {
                    this.phaseResourceLoad();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function phaseWait() : void
        {
            return;
        }// end function

        private function controlWait(param1:Number) : void
        {
            return;
        }// end function

        private function phaseAssaultDisplay() : void
        {
            var _loc_1:* = 0;
            this._mcFeverCutinUi = ResourceManager.getInstance().createMovieClip(FeverModeAction.getResourcePath(), "FeverEnperorMc");
            this._mcBattleUi.feverEnperorNull.addChild(this._mcFeverCutinUi);
            if (this._mcAssaultEmperor == null)
            {
                _loc_1 = UserDataManager.getInstance().userData.emperorId;
                this._mcAssaultEmperor = new FeverEmperorMc(this._mcFeverCutinUi, _loc_1);
            }
            this._mcAssaultEmperor.visible(true);
            this._mcAssaultEmperor.start();
            this._feverTime = this.calcFeverTime();
            this._feverTimeWait = this._feverTime;
            SoundManager.getInstance().playSe(SoundId.SE_REV_ZENGUNTOTSUGEKI);
            return;
        }// end function

        private function controlAssaultDisplay(param1:Number) : void
        {
            var _loc_2:* = null;
            if (this._mcAssaultEmperor.bEnd)
            {
                for each (_loc_2 in this._battleManager.getEntryPlayer())
                {
                    
                    _loc_2.status.badStatusClear();
                }
                this._mcAssaultEmperor.visible(false);
                this.setPhase(this._PHASE_PLAY_FEVER_ATTACK);
            }
            return;
        }// end function

        private function phasePlayFeverAttack() : void
        {
            var _loc_1:* = null;
            this._bCall_ComboSetOut = false;
            this._bCall_PlayDamage = false;
            if (this._bgmId != Constant.EMPTY_ID)
            {
                SoundManager.getInstance().playBgm(this._bgmId);
            }
            this._feverGaugePersent = QuestManager.getInstance().getFeverGaugePersent();
            this._isoFeverComboCount.setIn();
            for each (_loc_1 in this._battleManager.getEntryEnemy())
            {
                
                if (_loc_1.personal.bDead)
                {
                    continue;
                }
                this._aTarget.push(_loc_1);
            }
            this._feverAttack = this.createFeverAttack();
            return;
        }// end function

        private function controlPlayFeverAttack(param1:Number) : void
        {
            if (this._feverAttack)
            {
                this._feverAttack.control(param1);
                if (this._feverAttack.bFeverTime)
                {
                    this._feverTimeWait = this._feverTimeWait - param1;
                    if (this._feverTimeWait <= 0)
                    {
                        this._feverTimeWait = 0;
                    }
                    if (this._feverTimeWait <= 0)
                    {
                        this._feverAttack.setFeverOut();
                    }
                }
                if (this._feverAttack.bFeverRetainer)
                {
                    this._feverAttack.setFeverRetainerOut();
                    this.outComboCount();
                }
                if (this._feverAttack.bFeverDamagePlay)
                {
                    this._feverAttack.setFeverDamagePlayOut();
                    this.playDamage();
                }
                if (this._feverAttack.bEnd)
                {
                    if (this._bCall_ComboSetOut == false)
                    {
                        this.outComboCount();
                    }
                    if (this._bCall_PlayDamage == false)
                    {
                        this.playDamage();
                    }
                    this._feverAttack.release();
                    this._feverAttack = null;
                    this.setPhase(this._PHASE_PLAY_DAMAGE);
                }
            }
            return;
        }// end function

        protected function outComboCount() : void
        {
            this._isoFeverComboCount.setOut();
            this._bCall_ComboSetOut = true;
            return;
        }// end function

        protected function playDamage() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = BattleCalc.calcFeverDamage(this._battleManager.getEntryPlayer());
            for each (_loc_2 in this._aTarget)
            {
                
                this._battleManager.createDamageHp(_loc_2.personal.questUniqueId, Constant.EMPTY_ID, _loc_1, BattleConstant.HIT_TYPE_NORMAL, false, false, true);
                this._battleManager.playDamage(_loc_2.personal.questUniqueId, null);
                _loc_2.characterAction.setActionDamage();
            }
            this._bCall_PlayDamage = true;
            return;
        }// end function

        private function phasePlayDamage() : void
        {
            return;
        }// end function

        private function controlPlayDamage(param1:Number) : void
        {
            if (this._feverComboCount.isCountEnd)
            {
                this._bFeverMode = false;
                this._bExecuted = true;
                this.setPhase(this._PHASE_WAIT);
            }
            return;
        }// end function

        private function phaseResourceLoad() : void
        {
            var _loc_1:* = 0;
            ResourceManager.getInstance().loadArray(this.getResource());
            this._aSupportPlayerId = this.getSupportPlayerId();
            for each (_loc_1 in this._aSupportPlayerId)
            {
                
                ResourceManager.getInstance().loadArray(PlayerManager.getInstance().getResourcePath(_loc_1));
            }
            ResourceManager.getInstance().loadArray(this.getResource());
            SoundManager.getInstance().loadSoundArray(this.getSeId());
            return;
        }// end function

        private function controlResourceLoad(param1:Number) : void
        {
            if (ResourceManager.getInstance().isLoaded() && SoundManager.getInstance().isLoaded())
            {
                this.setPhase(this._PHASE_ASSAULT_DISPLAY);
            }
            return;
        }// end function

        private function calcFeverTime() : Number
        {
            var _loc_1:* = 0;
            var _loc_2:* = QuestManager.getInstance().getFeverGaugePersent();
            _loc_1 = Math.pow(2.1, _loc_2 / 35);
            if (_loc_2 == 100)
            {
                _loc_1 = 10;
            }
            return _loc_1;
        }// end function

        private function calcFeverDamage(param1:Number, param2:int) : int
        {
            var _loc_3:* = [750, 850, 900, 950, 1000, 1100, 1200, 1300, 1500];
            var _loc_4:* = Math.floor(this._feverTime * 100) / 100;
            var _loc_5:* = 0;
            var _loc_6:* = UserDataManager.getInstance().getEmperorLv();
            if (UserDataManager.getInstance().getEmperorLv() >= 1 && _loc_6 <= 10)
            {
                _loc_5 = _loc_3[0];
            }
            if (_loc_6 >= 11 && _loc_6 <= 30)
            {
                _loc_5 = _loc_3[1];
            }
            if (_loc_6 >= 31 && _loc_6 <= 50)
            {
                _loc_5 = _loc_3[2];
            }
            if (_loc_6 >= 51 && _loc_6 <= 80)
            {
                _loc_5 = _loc_3[3];
            }
            if (_loc_6 >= 81 && _loc_6 <= 120)
            {
                _loc_5 = _loc_3[4];
            }
            if (_loc_6 >= 121 && _loc_6 <= 170)
            {
                _loc_5 = _loc_3[5];
            }
            if (_loc_6 >= 171 && _loc_6 <= 250)
            {
                _loc_5 = _loc_3[6];
            }
            if (_loc_6 >= 251 && _loc_6 <= 450)
            {
                _loc_5 = _loc_3[7];
            }
            if (_loc_6 >= 451)
            {
                _loc_5 = _loc_3[8];
            }
            _loc_5 = int(_loc_5 * _loc_4);
            DebugLog.print("damage:" + _loc_5);
            _loc_5 = _loc_5 * (1 + this.calcFeverClickDamgeUp(param2));
            DebugLog.print("damageUp:" + _loc_5);
            return _loc_5;
        }// end function

        private function calcFeverClickDamgeUp(param1:int) : Number
        {
            var _loc_2:* = [0, 1, 2, 3, 5, 10, 12, 15];
            var _loc_3:* = 0;
            if (param1 >= 1 && param1 <= 30)
            {
                _loc_3 = _loc_2[1];
            }
            if (param1 >= 31 && param1 <= 60)
            {
                _loc_3 = _loc_2[2];
            }
            if (param1 >= 61 && param1 <= 90)
            {
                _loc_3 = _loc_2[3];
            }
            if (param1 >= 91 && param1 <= 120)
            {
                _loc_3 = _loc_2[4];
            }
            if (param1 >= 111 && param1 <= 150)
            {
                _loc_3 = _loc_2[5];
            }
            if (param1 >= 151 && param1 <= 200)
            {
                _loc_3 = _loc_2[6];
            }
            if (param1 >= 201)
            {
                _loc_3 = _loc_2[7];
            }
            DebugLog.print("clickCount:" + param1);
            DebugLog.print("damageUp -> " + _loc_3);
            return _loc_3 / 100;
        }// end function

        private function cbHit(param1:int) : void
        {
            this._comboCount = this._comboCount + param1;
            this._feverComboCount.startCount(this._comboCount, 3);
            return;
        }// end function

        private function getEmperorWeaponType() : int
        {
            return FeverModeAction.getFeverEffectId();
        }// end function

        private function getResource() : Array
        {
            var _loc_1:* = [];
            var _loc_2:* = this.getEmperorWeaponType();
            switch(_loc_2)
            {
                case FeverConstant.FEVER_EFFECT_ID_ARSLAN:
                {
                    _loc_1 = FeverAttackArslan.getResource();
                    break;
                }
                case FeverConstant.FEVER_EFFECT_ID_AZART:
                {
                }
                default:
                {
                    _loc_1 = FeverAttackAzart.getResource();
                    break;
                    break;
                }
            }
            _loc_1.push(getResourceCutinPath(_loc_2));
            return _loc_1;
        }// end function

        private function getSeId() : Array
        {
            var _loc_1:* = [];
            var _loc_2:* = this.getEmperorWeaponType();
            switch(_loc_2)
            {
                case FeverConstant.FEVER_EFFECT_ID_ARSLAN:
                {
                    _loc_1 = FeverAttackArslan.getSeId();
                    break;
                }
                case FeverConstant.FEVER_EFFECT_ID_AZART:
                {
                }
                default:
                {
                    _loc_1 = FeverAttackAzart.getSeId();
                    break;
                    break;
                }
            }
            return _loc_1;
        }// end function

        private function createFeverAttack() : FeverAttackBase
        {
            var _loc_1:* = null;
            var _loc_2:* = this.getEmperorWeaponType();
            switch(_loc_2)
            {
                case FeverConstant.FEVER_EFFECT_ID_ARSLAN:
                {
                    _loc_1 = new FeverAttackArslan(this._layer, this._battleManager, this._aSupportPlayerId, this.cbHit);
                    break;
                }
                case FeverConstant.FEVER_EFFECT_ID_AZART:
                {
                }
                default:
                {
                    _loc_1 = new FeverAttackAzart(this._layer, this._battleManager, this._aSupportPlayerId, this.cbHit);
                    break;
                    break;
                }
            }
            return _loc_1;
        }// end function

        private function getSupportPlayerId() : Array
        {
            var _loc_1:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_2:* = [];
            var _loc_3:* = [];
            var _loc_4:* = UserDataManager.getInstance().userData;
            for each (_loc_5 in _loc_4.aPlayerPersonal)
            {
                
                if (_loc_5.isEmperor())
                {
                    continue;
                }
                _loc_6 = PlayerManager.getInstance().getPlayerInformation(_loc_5.playerId);
                if (_loc_4.aFormationPlayerUniqueId.indexOf(_loc_5.uniqueId) == -1 && BattleConstant.IGNORE_FEVER_SUPPORT.indexOf(_loc_6.characterId) == -1)
                {
                    _loc_3.push(_loc_5.playerId);
                }
            }
            _loc_3 = Random.shuffleArray(_loc_3);
            _loc_1 = 0;
            while (_loc_1 < _loc_3.length && _loc_1 < this._FEVER_PLAYER_COUNT)
            {
                
                _loc_2.push(_loc_3[_loc_1]);
                _loc_1++;
            }
            if (_loc_2.length < this._FEVER_PLAYER_COUNT)
            {
                for each (_loc_7 in BattleConstant.DEFAULT_FEVER_SUPPORT)
                {
                    
                    if (_loc_2.length >= this._FEVER_PLAYER_COUNT)
                    {
                        break;
                    }
                    _loc_2.push(_loc_7);
                }
            }
            return _loc_2;
        }// end function

        public function click() : void
        {
            if (this._phase == this._PHASE_PLAY_FEVER_ATTACK && this._feverAttack.bFeverTime)
            {
                var _loc_1:* = this;
                var _loc_2:* = this._clickCount + 1;
                _loc_1._clickCount = _loc_2;
                if (this._clickCount > this._CLICK_COUNT_MAX)
                {
                    this._clickCount = this._CLICK_COUNT_MAX;
                }
                DebugLog.print("Fever Click!!");
            }
            return;
        }// end function

        public static function getFeverEffectId() : int
        {
            var _loc_1:* = UserDataManager.getInstance().userData;
            var _loc_2:* = PlayerManager.getInstance().getPlayerInformation(_loc_1.emperorId);
            var _loc_3:* = _loc_2.feverType;
            return _loc_3;
        }// end function

        public static function getResourcePath() : String
        {
            var _loc_1:* = "";
            var _loc_2:* = getFeverEffectId();
            return getResourceCutinPath(_loc_2);
        }// end function

        private static function getResourceCutinPath(param1:int) : String
        {
            var _loc_2:* = "";
            switch(param1)
            {
                case FeverConstant.FEVER_EFFECT_ID_ARSLAN:
                {
                    _loc_2 = "FeverCutIn000100.swf";
                    break;
                }
                case FeverConstant.FEVER_EFFECT_ID_TITAN:
                {
                    _loc_2 = "FeverCutIn000000.swf";
                    break;
                }
                case FeverConstant.FEVER_EFFECT_ID_AZART:
                {
                }
                default:
                {
                    _loc_2 = "FeverCutIn000000.swf";
                    break;
                    break;
                }
            }
            return ResourcePath.BATTLE_PATH + "FeverCutIn/" + _loc_2;
        }// end function

    }
}
