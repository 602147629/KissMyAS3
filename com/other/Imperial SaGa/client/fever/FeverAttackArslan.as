package fever
{
    import battle.*;
    import effect.*;
    import enemy.*;
    import flash.display.*;
    import flash.geom.*;
    import layer.*;
    import player.*;
    import resource.*;
    import sound.*;
    import utility.*;

    public class FeverAttackArslan extends FeverAttackBase
    {
        private const _LEADER_INDEX:int = 0;
        private const _MOB_POP_INTERVAL:Number = 0;
        private const _MOB_HIT_EFFECT_INTERVAL_MIN:Number = 0;
        private const _MOB_HIT_EFFECT_INTERVAL_MAX:Number = 0.5;
        private const _MOB_HIT_EFFECT_POS_MIN:Point;
        private const _MOB_HIT_EFFECT_POS_MAX:Point;
        private const _LD_MOVE_SPEED_VEC:Point;
        private const _PT_MOVE_SPEED_VEC:Point;
        private const _MOB_MOVE_SPEED_VEC:Point;
        private const _MOB_WEAPON_LIST:Array;
        private const _DELETE_POINT_X:int = 0;
        private const _PHASE_INIT:int = 1;
        private const _PHASE_START:int = 2;
        private const _PHASE_END:int = 99;
        private var _phase:int;
        private var _effectManager:EffectManager;
        private var _aFormationCharaDisplay:Array;
        private var _aWaitUnit:Array;
        private var _aEntryPlayer:Array;
        private var _aEntryEnemy:Array;
        private var _timelineMc:MovieClip;
        private var _formationActMc:MovieClip;
        private var _advansCharaLdMc:MovieClip;
        private var _formationNullMc:MovieClip;
        private var _formationBasePosEnemy:Point;
        private var _aPtDisplay:Array;
        private var _timer:Number;
        private var _aMobDisplay:Array;
        private var _aMobHitEffectTimer:Array;
        private var _lbMovePos:Point;
        private var _feverLayer:Sprite;
        private var _isPlaySeCrossSlash:Boolean = false;
        private var _mobHitCnt:int = 0;
        private var _bPtMove:Boolean = false;
        private var _bPtIn:Boolean = false;
        private var _bLdMove:Boolean = false;
        private var _bLdAttack:Boolean = false;
        private var _bPtDash:Boolean = false;
        private var _bMobEffect:Boolean = false;
        private var _bMobPop:Boolean = false;
        private var _shake:EffectShake;
        private var _shakeBg:EffectShake;
        public static const _ATTACK_MOTION_PATH:String = ResourcePath.CHARGE_EFFECT_PATH + "ChargeEffect_Arslan.swf";
        private static const _FORMATION_POSITION_PATH:String = ResourcePath.BATTLE_PATH + "UI_BattleMain.swf";

        public function FeverAttackArslan(param1:LayerBattle, param2:BattleManager, param3:Array, param4:Function)
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            this._MOB_HIT_EFFECT_POS_MIN = new Point(-50, -50);
            this._MOB_HIT_EFFECT_POS_MAX = new Point(50, 50);
            this._LD_MOVE_SPEED_VEC = new Point(-20, 0);
            this._PT_MOVE_SPEED_VEC = new Point(-20, 0);
            this._MOB_MOVE_SPEED_VEC = new Point(-20, 0);
            this._MOB_WEAPON_LIST = [CommonConstant.CHARACTER_WEAPONTYPE_SWORD, CommonConstant.CHARACTER_WEAPONTYPE_SPEAR];
            this._aWaitUnit = [];
            this._aPtDisplay = [];
            this._aMobDisplay = [];
            this._aMobHitEffectTimer = [];
            super(param1, param2, param3, param4);
            this._effectManager = new EffectManager();
            this._aFormationCharaDisplay = [];
            this._feverLayer = new Sprite();
            _layer.getLayer(LayerBattle.CHARACTER).addChild(this._feverLayer);
            var _loc_5:* = _battleManager.getEntryPlayer();
            for each (_loc_7 in _loc_5)
            {
                
                _loc_7.characterAction.characterDisplay.backupParent();
                _loc_6 = new PlayerDisplay(this._feverLayer, _loc_7.playerPersonal.playerId, Constant.EMPTY_ID);
                _loc_6.pos = _loc_7.characterAction.characterDisplay.pos.clone();
                _loc_6.setAnimStay();
                this._aFormationCharaDisplay.push(new FeverCharaAnimationData(_loc_6));
                _loc_7.characterAction.characterDisplay.pos = new Point(Constant.SCREEN_WIDTH + 50, _loc_6.pos.y);
            }
            this.checkPriority(this._aFormationCharaDisplay);
            this._aWaitUnit = [];
            this._aWaitUnit = Random.shuffleArray(_aSupportPlayerId);
            this._aEntryPlayer = _battleManager.getEntryPlayer();
            this._aEntryEnemy = _battleManager.getEntryEnemy();
            this._aMobDisplay = [];
            this._aMobHitEffectTimer = [];
            for each (_loc_8 in this._aEntryEnemy)
            {
                
                this._aMobHitEffectTimer.push(0);
            }
            this._timelineMc = ResourceManager.getInstance().createMovieClip(_ATTACK_MOTION_PATH, "TimeLine");
            this._formationActMc = ResourceManager.getInstance().createMovieClip(_ATTACK_MOTION_PATH, "position_formation_act");
            this._advansCharaLdMc = ResourceManager.getInstance().createMovieClip(_ATTACK_MOTION_PATH, "advance_chara_act_LD");
            this._formationNullMc = ResourceManager.getInstance().createMovieClip(_ATTACK_MOTION_PATH, "nullPosition");
            this._formationBasePosEnemy = new Point(this._formationNullMc.enemyNullMc.x, this._formationNullMc.enemyNullMc.y);
            _loc_9 = ResourceManager.getInstance().createMovieClip(_FORMATION_POSITION_PATH, "BattleMainMc");
            _loc_10 = _loc_9.allMoveMc.formationCaraNull;
            _loc_11 = new Rectangle(_loc_10.x, _loc_10.y, _loc_10.width, _loc_10.height);
            this._formationActMc.x = this._formationActMc.x + _loc_11.x;
            this._formationActMc.y = this._formationActMc.y + _loc_11.y;
            this._isPlaySeCrossSlash = false;
            this._mobHitCnt = 0;
            this.setPhase(this._PHASE_INIT);
            return;
        }// end function

        override public function release() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aMobDisplay)
            {
                
                _loc_1.release();
            }
            this._aMobDisplay = null;
            for each (_loc_1 in this._aFormationCharaDisplay)
            {
                
                _loc_1.release();
            }
            this._aFormationCharaDisplay = null;
            if (this._effectManager)
            {
                this._effectManager.release();
            }
            this._effectManager = null;
            if (this._lbMovePos)
            {
                this._lbMovePos = null;
            }
            if (this._feverLayer && this._feverLayer.parent)
            {
                this._feverLayer.parent.removeChild(this._feverLayer);
            }
            this._feverLayer = null;
            this._aWaitUnit = null;
            _aSupportPlayerId = null;
            this._timelineMc = null;
            this._advansCharaLdMc = null;
            this._formationActMc = null;
            this._formationNullMc = null;
            this._formationBasePosEnemy = null;
            super.release();
            return;
        }// end function

        override public function control(param1:Number) : void
        {
            if (this._effectManager)
            {
                this._effectManager.control(param1);
            }
            super.control(param1);
            switch(this._phase)
            {
                case this._PHASE_START:
                {
                    this.controlStart(param1);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function setPhase(param1:int) : void
        {
            if (param1 != this._phase)
            {
                this._phase = param1;
                switch(this._phase)
                {
                    case this._PHASE_INIT:
                    {
                        this.phaseInit();
                        break;
                    }
                    case this._PHASE_START:
                    {
                        this.phaseStart();
                        break;
                    }
                    case this._PHASE_END:
                    {
                        this.phaseEnd();
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

        private function phaseInit() : void
        {
            this.setPhase(this._PHASE_START);
            return;
        }// end function

        private function phaseStart() : void
        {
            this._timelineMc.gotoAndPlay("start");
            return;
        }// end function

        private function controlStart(param1:Number) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aFormationCharaDisplay)
            {
                
                _loc_2.playerDisplay.control(param1);
            }
            this.bgEffectControl(param1);
            if (this._bPtMove)
            {
                this.controlPtMove01(param1);
            }
            if (this._bPtIn)
            {
                this.controlPtIn(param1);
            }
            if (this._bMobEffect)
            {
                this.controlMobEffect(param1);
            }
            if (this._bMobPop)
            {
                this.controlMobPop(param1);
            }
            this.controlMobMove(param1);
            if (this._bPtDash)
            {
                this.controlPtDash(param1);
            }
            if (this._bLdMove)
            {
                this.controlLdMove(param1);
            }
            if (this._bLdAttack)
            {
                this.controlLdAttack(param1);
            }
            switch(this._timelineMc.currentFrameLabel)
            {
                case "PT_move01":
                {
                    this.setPtMove01();
                    break;
                }
                case "LD_start":
                {
                    this.setLdStart();
                    break;
                }
                case "PT_start":
                {
                    this.setPtStart();
                    break;
                }
                case "PT_dash":
                {
                    this.setPtDash();
                    break;
                }
                case "LD_move":
                {
                    this.setLdMove();
                    break;
                }
                case "LD_attack":
                {
                    this.setLdAttack();
                    break;
                }
                case "PT_In":
                {
                    this.setPtIn();
                    break;
                }
                case "end":
                {
                    this.setEnd();
                    break;
                }
                case "MOB_In":
                {
                    this.setMobIn();
                    break;
                }
                case "MOB_Out":
                {
                    this.setMobOut();
                    break;
                }
                case "MOB_hit_effect_start":
                {
                    this.setMobHitEffectStart();
                    break;
                }
                case "MOB_hit_effect_end":
                {
                    this.setMobHitEffectEnd();
                    break;
                }
                case "shake_start01":
                {
                    this.setShakeStart();
                    break;
                }
                case "shake_end01":
                {
                    this.setShakeEnd();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function phaseEnd() : void
        {
            _bEnd = true;
            return;
        }// end function

        private function bgEffectControl(param1:Number) : void
        {
            if (_layer.getLayer(LayerBattle.BACKGROUND).numChildren != Constant.EMPTY_ID)
            {
                _layer.getLayer(LayerBattle.BACKGROUND).transform.colorTransform = this._timelineMc.bgColorMc.transform.colorTransform;
            }
            else
            {
                _battleManager.battleScreen.getChildByName("bgMc").transform.colorTransform = this._timelineMc.bgColorMc.transform.colorTransform;
            }
            return;
        }// end function

        private function setPtMove01() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_1:* = 0;
            var _loc_2:* = [this._formationActMc.charaNull1, this._formationActMc.charaNull2, this._formationActMc.charaNull3, this._formationActMc.charaNull4, this._formationActMc.charaNull5];
            var _loc_5:* = 0;
            while (_loc_5 < this._aFormationCharaDisplay.length)
            {
                
                _loc_4 = this._aFormationCharaDisplay[_loc_5];
                _loc_4.playerDisplay.setAnimStay();
                _loc_4.playerDisplay.setTargetJump(_loc_2[_loc_5].localToGlobal(new Point()));
                _loc_5++;
            }
            this.checkPriority(this._aFormationCharaDisplay);
            SoundManager.getInstance().playSe(SoundId.SE_JUMP1);
            this._bPtMove = true;
            return;
        }// end function

        private function controlPtMove01(param1:Number) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            for each (_loc_3 in this._aFormationCharaDisplay)
            {
                
                _loc_2 = _loc_3.playerDisplay;
                if (_loc_2.bMoveing)
                {
                    return;
                }
            }
            this.checkPriority(this._aFormationCharaDisplay);
            this._bPtMove = false;
            return;
        }// end function

        private function setPtIn() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_1:* = _battleManager.getEntryPlayer();
            for each (_loc_2 in _loc_1)
            {
                
                _loc_3 = _loc_2.characterAction.characterDisplay as PlayerDisplay;
                _loc_3.setTargetJump(_loc_3.backupPosition);
            }
            SoundManager.getInstance().playSe(SoundId.SE_JUMP1);
            this._bPtIn = true;
            return;
        }// end function

        private function controlPtIn(param1:Number) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_2:* = true;
            var _loc_3:* = _battleManager.getEntryPlayer();
            for each (_loc_4 in _loc_3)
            {
                
                _loc_5 = _loc_4.characterAction.characterDisplay as PlayerDisplay;
                if (_loc_5.bMoveing)
                {
                    _loc_2 = false;
                }
            }
            if (_loc_2)
            {
                for each (_loc_4 in _loc_3)
                {
                    
                    _loc_5 = _loc_4.characterAction.characterDisplay as PlayerDisplay;
                    _loc_5.setAnimStay();
                }
                this._bPtIn = false;
                this.setPhase(this._PHASE_END);
            }
            return;
        }// end function

        private function setLdStart() : void
        {
            var _loc_1:* = ResourceManager.getInstance().createMovieClip(_ATTACK_MOTION_PATH, "position_chara_act_LD");
            var _loc_2:* = this._aFormationCharaDisplay[this._LEADER_INDEX];
            _loc_2.releaseAnimationMc();
            this.setCharaAnimationData(_loc_2, _loc_1, CommonConstant.CHARACTER_WEAPONTYPE_SWORD);
            setMcPosition(_loc_1, _loc_2.playerDisplay.pos);
            this._feverLayer.addChild(_loc_1);
            _loc_1.gotoAndPlay("start");
            SoundManager.getInstance().playSe(SoundId.SE_REV_FLURET_LIGHTNINGPIERCE_FLASH);
            return;
        }// end function

        private function ctrlLdStart(param1:Number) : void
        {
            return;
        }// end function

        private function setLdMove() : void
        {
            if (this._bLdMove)
            {
                return;
            }
            setMcPosition(this._advansCharaLdMc, this._formationBasePosEnemy);
            this._lbMovePos = new Point(this._formationBasePosEnemy.x + this._advansCharaLdMc.charaNull.x, this._formationBasePosEnemy.y + this._advansCharaLdMc.charaNull.y);
            var _loc_1:* = this._aFormationCharaDisplay[this._LEADER_INDEX];
            _loc_1.releaseAnimationMc();
            _loc_1.playerDisplay.setAnimSideDash();
            this._bLdMove = true;
            return;
        }// end function

        private function controlLdMove(param1:Number) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (this._bLdMove)
            {
                _loc_2 = this._aFormationCharaDisplay[this._LEADER_INDEX];
                _loc_3 = _loc_2.playerDisplay.pos;
                if (_loc_3.x > this._lbMovePos.x)
                {
                    _loc_2.playerDisplay.pos = _loc_2.playerDisplay.pos.add(this._MOB_MOVE_SPEED_VEC);
                    if (_loc_2.playerDisplay.pos.x <= this._lbMovePos.x)
                    {
                        _loc_2.playerDisplay.pos.x = this._lbMovePos.x;
                        this._timelineMc.gotoAndPlay("LD_attack");
                        this._bLdMove = false;
                    }
                }
            }
            return;
        }// end function

        private function setLdAttack() : void
        {
            var _loc_1:* = this._aFormationCharaDisplay[this._LEADER_INDEX];
            var _loc_2:* = this._advansCharaLdMc.charaNull;
            _loc_1.releaseAnimationMc();
            this.setCharaAnimationData(_loc_1, this._advansCharaLdMc.charaNull, CommonConstant.CHARACTER_WEAPONTYPE_SWORD);
            this._feverLayer.addChild(this._advansCharaLdMc);
            this._advansCharaLdMc.gotoAndPlay("start");
            this._advansCharaLdMc.charaNull.gotoAndPlay("start");
            this._bLdAttack = true;
            return;
        }// end function

        private function controlLdAttack(param1:Number) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = this._aFormationCharaDisplay[this._LEADER_INDEX];
            switch(this._advansCharaLdMc.currentFrameLabel)
            {
                case "hit":
                {
                    _loc_3 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), _ATTACK_MOTION_PATH, "hit_front", this._formationBasePosEnemy, false);
                    addEffect(this._effectManager, _loc_3, this.cbLdAttackEffect);
                    break;
                }
                case "end":
                {
                    this._bLdAttack = false;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function cbLdAttackEffect(param1:EffectMc, param2:String) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            switch(param2)
            {
                case "damage":
                {
                    sendHit();
                    if (!this._isPlaySeCrossSlash)
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_REV_FEVER_ARSLAN_CROSSSLASH);
                        this._isPlaySeCrossSlash = true;
                    }
                    for each (_loc_3 in this._aEntryEnemy)
                    {
                        
                        if (_loc_3 && _loc_3.bBattleDead)
                        {
                            continue;
                        }
                        _loc_4 = _loc_3.characterAction.characterDisplay as EnemyDisplay;
                        _loc_4.setAnimDamage();
                    }
                    break;
                }
                case "damageLast":
                {
                    sendHit();
                    SoundManager.getInstance().playSe(SoundId.SE_REV_FEVER_ARSLAN_FINALHIT);
                    for each (_loc_3 in this._aEntryEnemy)
                    {
                        
                        if (_loc_3 && _loc_3.bBattleDead)
                        {
                            continue;
                        }
                        _loc_4 = _loc_3.characterAction.characterDisplay as EnemyDisplay;
                        _loc_4.setAnimDamage();
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function setPtStart() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = 0;
            while (_loc_3 < this._aFormationCharaDisplay.length)
            {
                
                if (_loc_3 != this._LEADER_INDEX)
                {
                    _loc_1 = ResourceManager.getInstance().createMovieClip(_ATTACK_MOTION_PATH, "position_chara_act_PT");
                    _loc_2 = this._aFormationCharaDisplay[_loc_3];
                    _loc_2.releaseAnimationMc();
                    this.setCharaAnimationData(_loc_2, _loc_1, CommonConstant.CHARACTER_WEAPONTYPE_SWORD);
                    setMcPosition(_loc_1, _loc_2.playerDisplay.pos);
                    this._feverLayer.addChild(_loc_1);
                    _loc_1.gotoAndPlay("start");
                }
                _loc_3++;
            }
            SoundManager.getInstance().playSe(SoundId.SE_REV_BIGSWORD_HOSSYA_KAMAE);
            return;
        }// end function

        private function setPtDash() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = 0;
            while (_loc_3 < this._aFormationCharaDisplay.length)
            {
                
                if (_loc_3 != this._LEADER_INDEX)
                {
                    _loc_1 = this.createMobDashEffect(CommonConstant.CHARACTER_WEAPONTYPE_SWORD);
                    _loc_2 = this._aFormationCharaDisplay[_loc_3];
                    _loc_2.releaseAnimationMc();
                    this.setCharaAnimationData(_loc_2, _loc_1, CommonConstant.CHARACTER_WEAPONTYPE_SWORD);
                    setMcPosition(_loc_1, _loc_2.playerDisplay.pos);
                    this._feverLayer.addChild(_loc_1);
                    _loc_1.gotoAndPlay("start");
                }
                _loc_3++;
            }
            this._bPtDash = true;
            return;
        }// end function

        private function controlPtDash(param1:Number) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (this._aFormationCharaDisplay && this._aFormationCharaDisplay.length == 0)
            {
                return;
            }
            var _loc_4:* = 0;
            while (_loc_4 < this._aFormationCharaDisplay.length)
            {
                
                if (_loc_4 != this._LEADER_INDEX)
                {
                    _loc_2 = this._aFormationCharaDisplay[_loc_4];
                    if (_loc_2.animationMc)
                    {
                        _loc_3 = _loc_2.animationMc;
                        if (_loc_3.x > this._DELETE_POINT_X)
                        {
                            _loc_2.animationMc.x = _loc_2.animationMc.x + this._MOB_MOVE_SPEED_VEC.x;
                            _loc_2.animationMc.y = _loc_2.animationMc.y + this._MOB_MOVE_SPEED_VEC.y;
                            _loc_2.playerDisplay.pos = _loc_2.playerDisplay.pos.add(this._MOB_MOVE_SPEED_VEC);
                            if (_loc_2.animationMc.x < this._DELETE_POINT_X)
                            {
                                _loc_2.animationMc.x = this._DELETE_POINT_X;
                            }
                        }
                    }
                }
                _loc_4++;
            }
            var _loc_5:* = 0;
            _loc_4 = 0;
            while (_loc_4 < this._aFormationCharaDisplay.length)
            {
                
                if (_loc_4 != this._LEADER_INDEX)
                {
                    _loc_2 = this._aFormationCharaDisplay[_loc_4];
                    if (_loc_2.animationMc && _loc_2.animationMc.x == this._DELETE_POINT_X)
                    {
                        this._aPtDisplay.splice(this._aPtDisplay.indexOf(_loc_2), 1);
                        _loc_2.releaseAnimationMc();
                        _loc_5++;
                    }
                }
                _loc_4++;
            }
            if (_loc_5 == (this._aFormationCharaDisplay.length - 1))
            {
                this._bPtDash = false;
            }
            return;
        }// end function

        private function setMobHitEffectStart() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            this._bMobEffect = true;
            var _loc_3:* = 0;
            while (_loc_3 < this._aEntryEnemy.length)
            {
                
                _loc_1 = this._aEntryEnemy[_loc_3];
                if (_loc_1 && _loc_1.bBattleDead)
                {
                }
                else
                {
                    _loc_2 = _loc_1.characterAction.characterDisplay as EnemyDisplay;
                    _loc_2.setAnimDamageLoop();
                }
                _loc_3++;
            }
            SoundManager.getInstance().playSe(SoundId.SE_REV_FEVER_ARSLAN_MOB_HIT);
            return;
        }// end function

        private function setMobHitEffectEnd() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            this._bMobEffect = false;
            var _loc_3:* = 0;
            while (_loc_3 < this._aEntryEnemy.length)
            {
                
                _loc_1 = this._aEntryEnemy[_loc_3];
                if (_loc_1 && _loc_1.bBattleDead)
                {
                }
                else
                {
                    _loc_2 = _loc_1.characterAction.characterDisplay as EnemyDisplay;
                    _loc_2.setAnimDamageLoopRelease();
                }
                _loc_3++;
            }
            return;
        }// end function

        private function controlMobEffect(param1:Number) : void
        {
            var battleEnemy:BattleEnemy;
            var enemyDisplay:EnemyDisplay;
            var randPos:Point;
            var mtx:Matrix;
            var pos:Point;
            var mcName:String;
            var hitEffect:EffectMc;
            var t:* = param1;
            var i:int;
            while (i < this._aEntryEnemy.length)
            {
                
                battleEnemy = this._aEntryEnemy[i];
                if (battleEnemy && battleEnemy.bBattleDead)
                {
                }
                else
                {
                    this._aMobHitEffectTimer[i] = this._aMobHitEffectTimer[i] - t;
                    if (this._aMobHitEffectTimer[i] < 0)
                    {
                        enemyDisplay = battleEnemy.characterAction.characterDisplay as EnemyDisplay;
                        enemyDisplay.getEffectNullMatrix();
                        randPos = new Point(Random.range(this._MOB_HIT_EFFECT_POS_MIN.x, this._MOB_HIT_EFFECT_POS_MAX.x), Random.range(this._MOB_HIT_EFFECT_POS_MIN.y, this._MOB_HIT_EFFECT_POS_MAX.y));
                        mtx = enemyDisplay.getEffectNullMatrix();
                        pos = enemyDisplay.pos.add(new Point(mtx.tx + randPos.x, mtx.ty + randPos.y));
                        mcName = "Mob_hit_Front" + Random.range(0, 1);
                        hitEffect = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), _ATTACK_MOTION_PATH, mcName, pos, false);
                        with ({})
                        {
                            {}.cbEffect = function (param1:EffectMc, param2:String) : void
            {
                switch(param2)
                {
                    case "damage":
                    {
                        addMobHit();
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                return;
            }// end function
            ;
                        }
                        addEffect(this._effectManager, hitEffect, function (param1:EffectMc, param2:String) : void
            {
                switch(param2)
                {
                    case "damage":
                    {
                        addMobHit();
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                return;
            }// end function
            );
                        this._aMobHitEffectTimer[i] = Random.range(this._MOB_HIT_EFFECT_INTERVAL_MIN, this._MOB_HIT_EFFECT_INTERVAL_MAX);
                    }
                }
                i = (i + 1);
            }
            return;
        }// end function

        private function setMobIn() : void
        {
            this._bMobPop = true;
            this._timer = 0;
            SoundManager.getInstance().playSe(SoundId.SE_REV_FEVER_ARSLAN_MOB_RUN);
            return;
        }// end function

        private function setMobOut() : void
        {
            this._bMobPop = false;
            return;
        }// end function

        private function controlMobPop(param1:Number) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            (this._timer - 1);
            if (this._timer < 0)
            {
                _loc_2 = this._MOB_WEAPON_LIST[Random.range(0, (this._MOB_WEAPON_LIST.length - 1))];
                _loc_3 = this._formationActMc.mobNullAmbit;
                _loc_4 = new Point(this._formationActMc.x + _loc_3.x, Random.range(this._formationActMc.y + _loc_3.y, this._formationActMc.y + _loc_3.height));
                _loc_5 = this.createPlayerChara(_aSupportPlayerId[Random.range(0, (_aSupportPlayerId.length - 1))], _loc_4);
                _loc_6 = this.createMobDashEffect(_loc_2);
                _loc_7 = new FeverCharaAnimationData(_loc_5);
                this.setCharaAnimationData(_loc_7, _loc_6, _loc_2);
                setMcPosition(_loc_6, _loc_7.playerDisplay.pos);
                this._feverLayer.addChild(_loc_6);
                _loc_6.gotoAndPlay("start");
                this._aMobDisplay.push(_loc_7);
                _loc_8 = this._aFormationCharaDisplay.concat();
                this.checkPriority(_loc_8.concat(this._aMobDisplay));
                this._timer = this._MOB_POP_INTERVAL;
            }
            return;
        }// end function

        private function controlMobMove(param1:Number) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (this._aMobDisplay && this._aMobDisplay.length == 0)
            {
                return;
            }
            for each (_loc_2 in this._aMobDisplay)
            {
                
                _loc_3 = _loc_2.animationMc;
                if (_loc_3.x > this._DELETE_POINT_X)
                {
                    _loc_2.animationMc.x = _loc_2.animationMc.x + this._MOB_MOVE_SPEED_VEC.x;
                    _loc_2.animationMc.y = _loc_2.animationMc.y + this._MOB_MOVE_SPEED_VEC.y;
                    _loc_2.playerDisplay.pos = _loc_2.playerDisplay.pos.add(this._MOB_MOVE_SPEED_VEC);
                    if (_loc_2.animationMc.x < this._DELETE_POINT_X)
                    {
                        _loc_2.animationMc.x = this._DELETE_POINT_X;
                    }
                }
            }
            for each (_loc_2 in this._aMobDisplay)
            {
                
                if (_loc_2.animationMc.x == this._DELETE_POINT_X)
                {
                    this._aMobDisplay.splice(this._aMobDisplay.indexOf(_loc_2), 1);
                    _loc_2.releaseAnimationMc();
                }
            }
            return;
        }// end function

        private function setShakeStart() : void
        {
            if (this._shake == null)
            {
                this._shake = new EffectShake(_layer.parent, 3, 6, 10000);
                this._effectManager.addEffect(this._shake);
            }
            if (this._shakeBg == null)
            {
                this._shakeBg = new EffectShake(_battleManager.battleScreen, 3, 6, 10000);
                this._effectManager.addEffect(this._shakeBg);
            }
            return;
        }// end function

        private function setShakeEnd() : void
        {
            if (this._shakeBg != null)
            {
                this._effectManager.releaseEffect(this._shakeBg);
            }
            this._shakeBg = null;
            if (this._shake != null)
            {
                this._effectManager.releaseEffect(this._shake);
            }
            this._shake = null;
            return;
        }// end function

        private function setEnd() : void
        {
            return;
        }// end function

        private function createMobDashEffect(param1:int) : MovieClip
        {
            if (param1 == CommonConstant.CHARACTER_WEAPONTYPE_SPEAR)
            {
                return ResourceManager.getInstance().createMovieClip(_ATTACK_MOTION_PATH, "Mob_Dash_Spear");
            }
            return ResourceManager.getInstance().createMovieClip(_ATTACK_MOTION_PATH, "Mob_Dash_Sword");
        }// end function

        private function createPlayerChara(param1:int, param2:Point) : PlayerDisplay
        {
            var _loc_3:* = new PlayerDisplay(this._feverLayer, param1, Constant.EMPTY_ID);
            _loc_3.pos = param2;
            return _loc_3;
        }// end function

        private function setCharaAnimationData(param1:FeverCharaAnimationData, param2:MovieClip, param3:int) : void
        {
            var _loc_4:* = null;
            param1.animationMc = param2;
            if (param3 > 0)
            {
                if (param2.weaponNull)
                {
                    _loc_4 = createWeaponMc(param3);
                    _loc_4.gotoAndStop(1);
                    param1.addSetWeapon(param2.weaponNull, _loc_4);
                }
                if (param2.weaponNull0)
                {
                    _loc_4 = createWeaponMc(param3);
                    _loc_4.gotoAndStop(1);
                    param1.addSetWeapon(param2.weaponNull0, _loc_4);
                }
                if (param2.weaponNull1)
                {
                    _loc_4 = createWeaponMc(param3);
                    _loc_4.gotoAndStop(1);
                    param1.addSetWeapon(param2.weaponNull1, _loc_4);
                }
            }
            param1.playerDisplay.setAnimationPattern(param2);
            return;
        }// end function

        private function checkPriority(param1:Array) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_7:* = null;
            var _loc_2:* = [];
            var _loc_5:* = this._feverLayer.numChildren;
            var _loc_6:* = 0;
            while (_loc_6 < _loc_5)
            {
                
                _loc_4 = this._feverLayer.getChildAt(_loc_6);
                _loc_2.push({idx:_loc_6, y:_loc_4.y, mc:_loc_4});
                _loc_6++;
            }
            _loc_2.sortOn("y", Array.NUMERIC);
            _loc_6 = 0;
            while (_loc_6 < _loc_2.length)
            {
                
                _loc_7 = _loc_2[_loc_6];
                _loc_4 = _loc_7.mc;
                if (_loc_4 && _loc_4.parent)
                {
                    _loc_4.parent.setChildIndex(_loc_4, _loc_6);
                }
                _loc_6++;
            }
            return;
        }// end function

        private function addMobHit() : void
        {
            var _loc_1:* = this;
            var _loc_2:* = this._mobHitCnt + 1;
            _loc_1._mobHitCnt = _loc_2;
            if (this._mobHitCnt % this._aEntryEnemy.length == 0)
            {
                sendHit();
            }
            return;
        }// end function

        public static function getResource() : Array
        {
            var _loc_1:* = [];
            _loc_1.push(_ATTACK_MOTION_PATH);
            _loc_1.push(_FORMATION_POSITION_PATH);
            _loc_1.push(FeverAttackBase._WEAPON_PATH);
            _loc_1.push(EffectFeverHit.getResourcePath());
            return _loc_1;
        }// end function

        public static function getSeId() : Array
        {
            var _loc_1:* = [SoundId.SE_JUMP1, SoundId.SE_REV_FLURET_LIGHTNINGPIERCE_FLASH, SoundId.SE_REV_BIGSWORD_HOSSYA_KAMAE, SoundId.SE_REV_FEVER_ARSLAN_MOB_RUN, SoundId.SE_REV_FEVER_ARSLAN_MOB_HIT, SoundId.SE_REV_FEVER_ARSLAN_CROSSSLASH, SoundId.SE_REV_FEVER_ARSLAN_FINALHIT];
            _loc_1 = _loc_1.concat(EffectFeverHit.getSeId());
            return _loc_1;
        }// end function

    }
}
