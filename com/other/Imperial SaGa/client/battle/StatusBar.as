package battle
{
    import effect.*;
    import flash.display.*;
    import flash.geom.*;
    import icon.*;
    import message.*;
    import player.*;
    import resource.*;
    import skill.*;
    import utility.*;

    public class StatusBar extends Object
    {
        private const UPDATE_INTERVAL:Number = 0.03;
        private const UPDATE_TIME:Number = 0.3;
        private const NUMERIC_MC_HP:int = 0;
        private const NUMERIC_MC_MAXHP:int = 1;
        private const NUMERIC_MC_LP:int = 2;
        private const NUMERIC_MC_SP:int = 3;
        private const NUMERIC_MC_MAXSP:int = 4;
        private var _phase:int;
        private var _isoUi:InStayOut;
        private var _aNumericMc:Array;
        private var _baseMc:MovieClip;
        private var _bustUp:MovieClip;
        private var _bmBustUp:Bitmap;
        private var _battlePlayer:BattlePlayer;
        private var _personal:PlayerPersonal;
        private var _spGauge:Gauge;
        private var _openTime:Number;
        private var _bOpenRequest:Boolean;
        private var _bOpen:Boolean;
        private var _bOpenSe:Boolean;
        private var _nowHp:int;
        private var _nowAfterHp:int;
        private var _maxHp:int;
        private var _nowLp:int;
        private var _nowSp:int;
        private var _formationIndex:int;
        private var _effectManager:EffectManager;
        private var _shake:EffectShake;
        private var _requestSelect:int;
        private var _setupedSelect:int;
        private var _bValidHpGauge:Boolean;
        private var _bValidAfterHpGauge:Boolean;
        private var _bValidSpGauge:Boolean;
        private var _bValidDead:Boolean;
        private var _hpStep:Number = 0;
        private var _afterHpStep:Number = 0;
        private var _spStep:Number = 0;
        private var _currentHpGaugeNum:int;
        private var _currentAfterHpGaugeNum:int;
        private var _currentSpGaugeNum:int;
        private var _bPreviewSpMode:Boolean;
        private var _useSkillId:int;
        private var _useSp:int;
        private var _haveSkillCount:int;
        private var _hpMainGauge:Gauge;
        private var _hpWarnGauge:Gauge;
        private var _hpAfterGauge:Gauge;
        private var _spMainGauge:Gauge;
        private var _spCostGauge:Gauge;
        public static const PHASE_HIDE:int = 1;
        public static const PHASE_OPEN:int = 2;
        public static const PHASE_SHOW:int = 10;
        public static const PHASE_CLOSE:int = 99;
        public static const LABEL_SELECT_START:String = "selectStart";
        public static const LABEL_SELECT_STAY:String = "selectStay";
        public static const LABEL_SELECT_END:String = "selectEnd";
        public static const LABEL_STAY:String = "stay";
        public static const SETUP_SELECT_LABEL_UNSELECT:int = 0;
        public static const SETUP_SELECT_LABEL_SELECT:int = 1;
        private static var _aSynchronizeLamp:Array = [];

        public function StatusBar(param1:MovieClip)
        {
            this._baseMc = param1;
            this._isoUi = new InStayOut(this._baseMc);
            this._haveSkillCount = Constant.UNDECIDED;
            this.initNumericText();
            this._effectManager = new EffectManager();
            this._requestSelect = SETUP_SELECT_LABEL_UNSELECT;
            this._setupedSelect = SETUP_SELECT_LABEL_UNSELECT;
            return;
        }// end function

        public function get uniqueId() : int
        {
            return this._personal ? (this._personal.uniqueId) : (Constant.EMPTY_ID);
        }// end function

        public function get questUniqueId() : int
        {
            return this._personal ? (this._personal.questUniqueId) : (Constant.EMPTY_ID);
        }// end function

        public function get bWait() : Boolean
        {
            return this._isoUi.bWait;
        }// end function

        public function get bOpened() : Boolean
        {
            return this._isoUi.bOpened;
        }// end function

        public function get bClose() : Boolean
        {
            return !this._bOpen;
        }// end function

        public function release() : void
        {
            this.removeSynchronizeAll();
            if (this._isoUi)
            {
                this._isoUi.release();
            }
            this._isoUi = null;
            if (this._bustUp && this._bustUp.parent)
            {
                this._bustUp.parent.removeChild(this._bustUp);
            }
            this._bustUp = null;
            this._baseMc = null;
            if (this._effectManager)
            {
                this._effectManager.release();
            }
            this._effectManager = null;
            if (this._shake)
            {
                if (!this._shake.isEnd())
                {
                    this._shake.release();
                }
            }
            this._shake = null;
            if (this._hpMainGauge)
            {
                this._hpMainGauge.release();
            }
            this._hpMainGauge = null;
            if (this._hpWarnGauge)
            {
                this._hpWarnGauge.release();
            }
            this._hpWarnGauge = null;
            if (this._hpAfterGauge)
            {
                this._hpAfterGauge.release();
            }
            this._hpAfterGauge = null;
            if (this._spMainGauge)
            {
                this._spMainGauge.release();
            }
            this._spMainGauge = null;
            if (this._spCostGauge)
            {
                this._spCostGauge.release();
            }
            this._spCostGauge = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            if (this._personal == null)
            {
                return;
            }
            switch(this._phase)
            {
                case PHASE_OPEN:
                {
                    this.controlOpen(param1);
                    break;
                }
                case PHASE_SHOW:
                {
                    this.controlShow(param1);
                    break;
                }
                case PHASE_CLOSE:
                {
                    this.controlClose();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function setStatus() : void
        {
            var rank:PlayerRarityIcon;
            var weaponTypeIcon:WeaponTypeIcon;
            var playerInfo:* = PlayerManager.getInstance().getPlayerInformation(this._personal.playerId);
            this._baseMc.statusWindowMc.statusBGMc.gotoAndStop((this._formationIndex + 1));
            TextControl.setText(this._baseMc.statusWindowMc.charaNameMc.textDt, playerInfo.name);
            var bEmperor:* = this._personal.isEmperor();
            this._baseMc.statusWindowMc.lpSet.visible = !bEmperor;
            this._baseMc.statusWindowMc.emperorIcon.visible = bEmperor;
            try
            {
                rank = new PlayerRarityIcon(this._baseMc.statusWindowMc.charaRankMc, playerInfo.rarity);
            }
            catch (e:Error)
            {
                _baseMc.statusWindowMc.charaRankMc.gotoAndStop(1);
                try
                {
                }
                weaponTypeIcon = new WeaponTypeIcon(this._baseMc.statusWindowMc.weaponTypeMc, playerInfo.weaponType);
            }
            catch (e:Error)
            {
                _baseMc.statusWindowMc.weaponTypeMc.gotoAndStop(1);
            }
            this._nowHp = this._personal.hp;
            this._nowAfterHp = BattleCalc.calcAfterHp(this._battlePlayer);
            this._nowLp = this._personal.lp;
            this._nowSp = this._personal.sp;
            this._currentHpGaugeNum = this._nowHp;
            this._currentAfterHpGaugeNum = this._nowAfterHp;
            this._currentSpGaugeNum = this._nowSp;
            this._maxHp = this._personal.hpMax;
            this.checkSkillLamp();
            this._hpMainGauge = new Gauge(this._baseMc.statusWindowMc.hpDisplayMc.hpBerGreenMc, this._maxHp, this._nowHp);
            this._hpWarnGauge = new Gauge(this._baseMc.statusWindowMc.hpDisplayMc.hpBerYellowMc, this._maxHp, this._nowHp);
            this._hpAfterGauge = new Gauge(this._baseMc.statusWindowMc.hpDisplayMc.hpBerRedMc, this._maxHp, this._nowAfterHp);
            this._spMainGauge = new Gauge(this._baseMc.statusWindowMc.spDisplayMc.spBerMc, this._personal.spMax, this._nowSp);
            this._spCostGauge = new Gauge(this._baseMc.statusWindowMc.spDisplayMc.spCostBerMc, this._personal.spMax, 0);
            this._spCostGauge.hide();
            this.immediateParams();
            this.updateParams(1);
            this._bmBustUp = ResourceManager.getInstance().createBitmap(ResourcePath.PLAYER_BUSTUP_PATH + playerInfo.bustUpFileName);
            this._bmBustUp.smoothing = true;
            this._bmBustUp.x = this._bmBustUp.x - this._bmBustUp.width / 2;
            this._bmBustUp.y = this._bmBustUp.y - this._bmBustUp.height;
            this._baseMc.statusWindowMc.characterNull.addChild(this._bmBustUp);
            this.setDead(this._personal.bDead);
            return;
        }// end function

        private function initNumericText() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_1:* = [this._baseMc.statusWindowMc.hpDisplayMc.quoNumMc, this._baseMc.statusWindowMc.hpDisplayMc.maxNumMc, this._baseMc.statusWindowMc.lpSet.lpNumMc, this._baseMc.statusWindowMc.spDisplayMc.quoNumMc, this._baseMc.statusWindowMc.spDisplayMc.maxNumMc];
            this._aNumericMc = [];
            for each (_loc_2 in _loc_1)
            {
                
                _loc_3 = new NumericNumberMc(_loc_2, 0, this.UPDATE_INTERVAL, false);
                this._aNumericMc.push(_loc_3);
            }
            return;
        }// end function

        private function immediateParams() : void
        {
            this.setValue(this.NUMERIC_MC_MAXHP, this._personal.hpMax, 99999);
            this.setValue(this.NUMERIC_MC_MAXSP, this._personal.spMax, 99999);
            this.setValue(this.NUMERIC_MC_HP, this._personal.hp, 99999);
            this.setValue(this.NUMERIC_MC_LP, this._personal.lp, 99999);
            this.setValue(this.NUMERIC_MC_SP, this._personal.sp, 99999);
            return;
        }// end function

        public function openWindow(param1:Number = 0, param2:Boolean = false) : void
        {
            if (!this._personal)
            {
                return;
            }
            if (this._isoUi.bClosed)
            {
                this._openTime = param1;
                this._bOpenSe = param2;
                this.setPhase(PHASE_OPEN);
            }
            else
            {
                this._bOpenRequest = true;
            }
            return;
        }// end function

        public function closeWindow() : void
        {
            this._bOpenRequest = false;
            if (this._isoUi.bOpened)
            {
                this.setPhase(PHASE_CLOSE);
            }
            return;
        }// end function

        public function setPreviewMode(param1:Boolean) : void
        {
            if (this._personal == null)
            {
                return;
            }
            if (this._personal.bDead)
            {
                return;
            }
            this._bPreviewSpMode = param1;
            if (param1)
            {
                this._spCostGauge.setGauge(this._useSp);
                this._baseMc.statusWindowMc.spDisplayMc.spCostBerMc.x = this._baseMc.statusWindowMc.spDisplayMc.spBerMc.x + this._baseMc.statusWindowMc.spDisplayMc.spBerMc.width - this._baseMc.statusWindowMc.spDisplayMc.spCostBerMc.width;
                this._spCostGauge.show();
            }
            else
            {
                this._spCostGauge.hide();
                this.setValue(this.NUMERIC_MC_SP, this._nowSp, 999);
            }
            return;
        }// end function

        public function setPlayer(param1:BattlePlayer, param2:int) : void
        {
            if (this._battlePlayer == param1)
            {
                return;
            }
            this._battlePlayer = param1;
            this._personal = this._battlePlayer.playerPersonal;
            this._formationIndex = param2;
            this.setStatus();
            return;
        }// end function

        public function setSelect(param1:Boolean) : void
        {
            this._requestSelect = param1 ? (SETUP_SELECT_LABEL_SELECT) : (SETUP_SELECT_LABEL_UNSELECT);
            return;
        }// end function

        private function setPhase(param1:int) : void
        {
            if (param1 != this._phase)
            {
                this._phase = param1;
                switch(this._phase)
                {
                    case PHASE_OPEN:
                    {
                        this.phaseOpen();
                        break;
                    }
                    case PHASE_SHOW:
                    {
                        this.phaseShow();
                        break;
                    }
                    case PHASE_CLOSE:
                    {
                        this.phaseClose();
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

        private function phaseOpen() : void
        {
            return;
        }// end function

        private function controlOpen(param1:Number) : void
        {
            if (this._isoUi.bClosed)
            {
                if (this._openTime <= 0)
                {
                    this._setupedSelect = SETUP_SELECT_LABEL_UNSELECT;
                    this._isoUi.setIn(this.cbOpen);
                }
                else
                {
                    this._openTime = this._openTime - param1;
                }
            }
            return;
        }// end function

        private function cbOpen() : void
        {
            this.setPhase(PHASE_SHOW);
            return;
        }// end function

        private function phaseShow() : void
        {
            return;
        }// end function

        private function controlShow(param1:Number) : void
        {
            this.checkMaxHp();
            this.updateHp();
            this.updateLp();
            this.updateSp();
            this.updateUseSkill();
            this.updateHaveSkill();
            this.updateGauges(param1);
            this.updateParams(param1);
            this.updateSelect();
            this._effectManager.control(param1);
            if (this._effectManager.isExist(this._shake))
            {
                this._baseMc.transform.colorTransform = new ColorTransform(1, 0.5, 0.5, 1, 0, 0, 0);
            }
            else if (this._shake)
            {
                this._shake = null;
                this.setDead(this._personal.bDead);
            }
            return;
        }// end function

        private function phaseClose() : void
        {
            this._setupedSelect = SETUP_SELECT_LABEL_UNSELECT;
            this._isoUi.setOut(this.cbClose);
            return;
        }// end function

        private function controlClose() : void
        {
            return;
        }// end function

        private function cbClose() : void
        {
            if (this._bOpenRequest)
            {
                this._bOpenRequest = false;
                this.openWindow();
                return;
            }
            this._bOpen = false;
            this.setPhase(PHASE_HIDE);
            return;
        }// end function

        private function updateSelect() : void
        {
            if (this._setupedSelect != this._requestSelect && !this._isoUi.bAnimetion)
            {
                if (this._requestSelect == SETUP_SELECT_LABEL_SELECT)
                {
                    if (this._baseMc.currentLabel == LABEL_SELECT_END)
                    {
                        return;
                    }
                    if (this._baseMc.currentLabel != LABEL_SELECT_START && this._baseMc.currentLabel != LABEL_SELECT_STAY)
                    {
                        this._baseMc.gotoAndPlay(LABEL_SELECT_START);
                    }
                    this._setupedSelect = this._requestSelect;
                }
                else
                {
                    if (this._baseMc.currentLabel == LABEL_SELECT_START)
                    {
                        return;
                    }
                    if (this._baseMc.currentLabel != LABEL_SELECT_END && this._baseMc.currentLabel != LABEL_STAY)
                    {
                        this._baseMc.gotoAndPlay(LABEL_SELECT_END);
                    }
                    this._setupedSelect = this._requestSelect;
                }
            }
            return;
        }// end function

        private function updateParams(param1:Number) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aNumericMc)
            {
                
                _loc_2.control(param1);
            }
            if (PlayerPersonal.isDying(this._currentHpGaugeNum, this._maxHp))
            {
                this.setColor(this.NUMERIC_MC_HP, 16711680);
                this._baseMc.statusWindowMc.hpDisplayMc.gotoAndStop("danger");
            }
            else
            {
                this.setColor(this.NUMERIC_MC_HP);
                this._baseMc.statusWindowMc.hpDisplayMc.gotoAndStop("safety");
            }
            if (this._personal.lp > 1)
            {
                this.setColor(this.NUMERIC_MC_LP);
            }
            else
            {
                this.setColor(this.NUMERIC_MC_LP, 16711680);
            }
            if (this._bValidDead && NumericNumberMc(this._aNumericMc[this.NUMERIC_MC_HP]).isCountEnd)
            {
                this.setDead(this._personal.bDead);
                this._bValidDead = false;
            }
            return;
        }// end function

        private function updateGauges(param1:Number) : void
        {
            if (this._bValidHpGauge)
            {
                if (Math.abs(this._currentHpGaugeNum - this._nowHp) < this._hpStep)
                {
                    this._currentHpGaugeNum = this._nowHp;
                    this._bValidHpGauge = false;
                }
                else if (this._currentHpGaugeNum < this._nowHp)
                {
                    this._currentHpGaugeNum = this._currentHpGaugeNum + this._hpStep;
                }
                else
                {
                    this._currentHpGaugeNum = this._currentHpGaugeNum - this._hpStep;
                }
                this._hpMainGauge.setGauge(this._currentHpGaugeNum);
                this._hpWarnGauge.setGauge(this._currentHpGaugeNum);
            }
            if (this._bValidAfterHpGauge)
            {
                if (Math.abs(this._currentAfterHpGaugeNum - this._nowAfterHp) < this._afterHpStep)
                {
                    this._currentAfterHpGaugeNum = this._nowAfterHp;
                    this._bValidAfterHpGauge = false;
                }
                else if (this._currentAfterHpGaugeNum < this._nowAfterHp)
                {
                    this._currentAfterHpGaugeNum = this._currentAfterHpGaugeNum + this._afterHpStep;
                }
                else
                {
                    this._currentAfterHpGaugeNum = this._currentAfterHpGaugeNum - this._afterHpStep;
                }
                this._hpAfterGauge.setGauge(this._currentAfterHpGaugeNum);
            }
            if (this._bValidSpGauge)
            {
                if (Math.abs(this._currentSpGaugeNum - this._nowSp) < this._spStep)
                {
                    this._currentSpGaugeNum = this._nowSp;
                    this._bValidSpGauge = false;
                }
                else if (this._currentSpGaugeNum < this._nowSp)
                {
                    this._currentSpGaugeNum = this._currentSpGaugeNum + this._spStep;
                }
                else
                {
                    this._currentSpGaugeNum = this._currentSpGaugeNum - this._spStep;
                }
                this._spMainGauge.setGauge(this._currentSpGaugeNum);
                this._spCostGauge.setGauge(this._currentSpGaugeNum - this._nowSp);
            }
            return;
        }// end function

        private function updateHp() : void
        {
            var _loc_1:* = 0;
            if (this._nowHp != this._personal.hp)
            {
                this._hpStep = Math.ceil(Math.abs(this._nowHp - this._personal.hp) / this.UPDATE_TIME * this.UPDATE_INTERVAL);
                this.setValue(this.NUMERIC_MC_HP, this._personal.hp, this._hpStep);
                this._bValidHpGauge = true;
                this._bValidAfterHpGauge = true;
                this._bValidDead = true;
                if (this._nowHp > this._personal.hp)
                {
                    this._shake = new EffectShake(this._baseMc, 7, 2, 0.5);
                    this._effectManager.addEffect(this._shake);
                }
                this._nowHp = this._personal.hp;
                _loc_1 = this._nowAfterHp;
                this._nowAfterHp = BattleCalc.calcAfterHp(this._battlePlayer);
                this._afterHpStep = Math.ceil(Math.abs(_loc_1 - this._nowAfterHp) / this.UPDATE_TIME * this.UPDATE_INTERVAL);
            }
            return;
        }// end function

        private function updateLp() : void
        {
            if (this._nowLp != this._personal.lp)
            {
                this.setValue(this.NUMERIC_MC_LP, this._personal.lp);
                if (this._personal.lp > 1)
                {
                    this.setColor(this.NUMERIC_MC_LP);
                }
                else
                {
                    this.setColor(this.NUMERIC_MC_LP, 16711680);
                }
                this._nowLp = this._personal.lp;
            }
            return;
        }// end function

        private function updateSp() : void
        {
            if (this._nowSp != this._personal.sp)
            {
                this._spStep = Math.ceil(Math.abs(this._nowSp - this._personal.sp) / this.UPDATE_TIME * this.UPDATE_INTERVAL);
                this.setValue(this.NUMERIC_MC_SP, this._personal.sp, this._spStep);
                this._nowSp = this._personal.sp;
                this._bValidSpGauge = true;
                this.checkSkillLamp();
            }
            return;
        }// end function

        private function updateHaveSkill() : void
        {
            var _loc_2:* = 0;
            var _loc_1:* = 0;
            for each (_loc_2 in this._personal.aSetSkillId)
            {
                
                if (_loc_2 > 0)
                {
                    _loc_1++;
                }
            }
            if (this._haveSkillCount != _loc_1)
            {
                this._haveSkillCount = _loc_1;
                this.checkSkillLamp();
            }
            return;
        }// end function

        private function updateUseSkill() : void
        {
            if (this._useSkillId != this._personal.useSkillId)
            {
                this._useSkillId = this._personal.useSkillId;
                this._useSp = this.getUseSp(this._useSkillId);
                this._spCostGauge.setGauge(this._useSp);
                this.setPreviewMode(this._bPreviewSpMode);
            }
            return;
        }// end function

        private function checkSkillLamp() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_1:* = [this._baseMc.statusWindowMc.skillLamp1, this._baseMc.statusWindowMc.skillLamp2, this._baseMc.statusWindowMc.skillLamp3];
            var _loc_2:* = 0;
            while (_loc_2 < this._personal.aSetSkillId.length)
            {
                
                _loc_3 = _loc_1[_loc_2];
                if (this._personal.aSetSkillId[_loc_2] > 0)
                {
                    _loc_4 = this.getUseSp(this._personal.aSetSkillId[_loc_2]);
                    if (_loc_4 > this._nowSp)
                    {
                        _loc_3.gotoAndStop("equipArts");
                        this.removeSynchronizeLamp(_loc_3);
                    }
                    else
                    {
                        _loc_3.gotoAndStop("usebleArts");
                        this.addSynchronizeLamp(_loc_3);
                    }
                }
                else
                {
                    _loc_3.gotoAndStop("noArts");
                    this.removeSynchronizeLamp(_loc_3);
                }
                _loc_2++;
            }
            return;
        }// end function

        private function addSynchronizeLamp(param1:MovieClip) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_2:* = _aSynchronizeLamp.indexOf(param1);
            if (_loc_2 < 0)
            {
                _loc_3 = _aSynchronizeLamp[0];
                if (_loc_3)
                {
                    _loc_4 = _loc_3.getChildAt(0) as MovieClip;
                    _loc_5 = param1.getChildAt(0) as MovieClip;
                    if (_loc_4 && _loc_5)
                    {
                        _loc_5.gotoAndPlay(_loc_4.currentFrame);
                    }
                }
                _aSynchronizeLamp.push(param1);
            }
            return;
        }// end function

        private function removeSynchronizeLamp(param1:MovieClip) : void
        {
            var _loc_2:* = _aSynchronizeLamp.indexOf(param1);
            if (_loc_2 >= 0)
            {
                _aSynchronizeLamp.splice(_loc_2, 1);
            }
            return;
        }// end function

        private function removeSynchronizeAll() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = [this._baseMc.statusWindowMc.skillLamp1, this._baseMc.statusWindowMc.skillLamp2, this._baseMc.statusWindowMc.skillLamp3];
            for each (_loc_2 in _loc_1)
            {
                
                this.removeSynchronizeLamp(_loc_2);
            }
            return;
        }// end function

        private function checkMaxHp() : void
        {
            if (this._maxHp != this._personal.hpMax)
            {
                this.setValue(this.NUMERIC_MC_MAXHP, this._personal.hpMax, this._personal.hpMax);
                this._maxHp = this._personal.hpMax;
            }
            return;
        }// end function

        private function setValue(param1:int, param2:int, param3:int = 1) : void
        {
            NumericNumberMc(this._aNumericMc[param1]).startCount(param2, param3);
            return;
        }// end function

        private function setColor(param1:int, param2:uint = 0) : void
        {
            NumericNumberMc(this._aNumericMc[param1]).setColor(param2);
            return;
        }// end function

        private function setDead(param1:Boolean) : void
        {
            if (param1)
            {
                this._baseMc.transform.colorTransform = new ColorTransform(0.5, 0.5, 0.5, 1);
            }
            else
            {
                this._baseMc.transform.colorTransform = new ColorTransform();
            }
            return;
        }// end function

        private function getUseSp(param1:int) : int
        {
            var _loc_2:* = this._personal.getOwnSkillData(param1);
            if (_loc_2)
            {
                return _loc_2.spTotal;
            }
            var _loc_3:* = SkillManager.getInstance().getSkillInformation(param1);
            if (_loc_3)
            {
                return _loc_3.sp;
            }
            return 0;
        }// end function

    }
}
