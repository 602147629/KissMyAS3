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
    import utility.*;

    public class FeverAttackBase extends Object
    {
        protected const _MC_LABEL_START:String = "start";
        protected const _MC_LABEL_END:String = "end";
        protected const _MC_LABEL_STAY:String = "stay";
        protected const _MC_LABEL_DAMAGE:String = "damage";
        protected const _MC_LABEL_DAMAGE_LAST:String = "damageLast";
        protected const _MC_LABEL_OUT:String = "out";
        protected const _MC_NAME_START_ACT:String = "position_chara_startAct";
        protected const _MC_NAME_ADVANCE_ACT:String = "advance_chara_act";
        protected var _battleManager:BattleManager;
        protected var _mcBase:MovieClip;
        protected var _label:String;
        protected var _oldLabel:String;
        protected var _targetNullPos:Point;
        protected var _layer:LayerBattle;
        protected var _aSupportPlayerId:Array;
        protected var _cbHit:Function;
        protected var _target:BattleEnemy;
        protected var _targetDisplay:EnemyDisplay;
        protected var _targetPosition:Point;
        protected var _targetFacePos:Point;
        protected var _targetGrandPos:Point;
        protected var _bFeverTime:Boolean;
        protected var _bFeverRetainer:Boolean;
        protected var _bFeverDamagePlay:Boolean = false;
        protected var _bEnd:Boolean;
        private var _aEffect:Array;
        static const _WEAPON_PATH:String = ResourcePath.SKILL_PATH + "Weapons.swf";

        public function FeverAttackBase(param1:LayerBattle, param2:BattleManager, param3:Array, param4:Function)
        {
            this._cbHit = param4;
            this._mcBase = null;
            this._label = "";
            this._oldLabel = "";
            this._layer = param1;
            this._battleManager = param2;
            this._aSupportPlayerId = param3.concat();
            this.setTarget();
            this._aEffect = [];
            return;
        }// end function

        public function get bFeverTime() : Boolean
        {
            return this._bFeverTime;
        }// end function

        public function setFeverOut() : void
        {
            this._bFeverTime = false;
            return;
        }// end function

        public function get bFeverRetainer() : Boolean
        {
            return this._bFeverRetainer;
        }// end function

        public function setFeverRetainerOut() : void
        {
            this._bFeverRetainer = false;
            return;
        }// end function

        public function get bFeverDamagePlay() : Boolean
        {
            return this._bFeverDamagePlay;
        }// end function

        public function setFeverDamagePlayOut() : void
        {
            this._bFeverDamagePlay = false;
            return;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._bEnd;
        }// end function

        protected function setTarget() : void
        {
            var _loc_3:* = null;
            var _loc_6:* = null;
            this._target = null;
            var _loc_1:* = new LotList();
            var _loc_2:* = new LotList();
            for each (_loc_3 in this._battleManager.getEntryEnemy())
            {
                
                if (_loc_3.bBattleDead)
                {
                    continue;
                }
                _loc_6 = EnemyManager.getInstance().getEnemyInformation(_loc_3.enemyPersonal.infoId);
                if (_loc_6.bossFlag)
                {
                    _loc_1.addTarget(_loc_3, 10);
                    continue;
                }
                _loc_2.addTarget(_loc_3, 10);
            }
            this._target = Lot.lotTarget(_loc_1.aLotObject.length > 0 ? (_loc_1) : (_loc_2)) as BattleEnemy;
            this._targetDisplay = this._target.characterAction.characterDisplay as EnemyDisplay;
            this._targetDisplay.backupParent();
            var _loc_4:* = this._targetDisplay.getEffectNullMatrix();
            this._targetPosition = this._targetDisplay.pos.add(new Point(_loc_4.tx, _loc_4.ty));
            var _loc_5:* = this._targetDisplay.getfaceNullMatrix();
            this._targetFacePos = this._targetDisplay.pos.add(new Point(_loc_5.tx, _loc_5.ty));
            this._targetGrandPos = new Point(this._targetDisplay.pos.x, this._targetDisplay.pos.y);
            return;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            if (this._mcBase != null)
            {
                if (this._mcBase.parent)
                {
                    this._mcBase.parent.removeChild(this._mcBase);
                }
            }
            this._mcBase = null;
            this._layer = null;
            for each (_loc_1 in this._aEffect)
            {
                
                _loc_1.release();
            }
            this._aEffect = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            this.controlEffect(param1);
            return;
        }// end function

        protected function sendHit(param1:int = 1) : void
        {
            if (this._cbHit != null)
            {
                this._cbHit(param1);
            }
            return;
        }// end function

        protected function getSpeedVector(param1:Point, param2:Point, param3:int) : Point
        {
            var _loc_4:* = new Point(param2.x - param1.x, param2.y - param1.y);
            new Point(param2.x - param1.x, param2.y - param1.y).normalize(1);
            var _loc_5:* = new Matrix();
            new Matrix().scale(param3, param3);
            return _loc_5.transformPoint(_loc_4);
        }// end function

        protected function createWeaponMc(param1:int) : MovieClip
        {
            var _loc_2:* = "";
            switch(param1)
            {
                case CommonConstant.CHARACTER_WEAPONTYPE_SWORD:
                {
                    _loc_2 = "weapon_Sword1";
                    break;
                }
                case CommonConstant.CHARACTER_WEAPONTYPE_GREATSWORD:
                {
                    _loc_2 = "weapon_Sword_Big";
                    break;
                }
                case CommonConstant.CHARACTER_WEAPONTYPE_SPEAR:
                {
                    _loc_2 = "weapon_Spear";
                    break;
                }
                case CommonConstant.CHARACTER_WEAPONTYPE_AX:
                {
                    _loc_2 = "weapon_Axe";
                    break;
                }
                case CommonConstant.CHARACTER_WEAPONTYPE_SHORTSWORD:
                {
                    _loc_2 = "weapon_Sword_Small";
                    break;
                }
                case CommonConstant.CHARACTER_WEAPONTYPE_MATERIALARTS:
                {
                    break;
                }
                case CommonConstant.CHARACTER_WEAPONTYPE_BOW:
                {
                    _loc_2 = "weapon_Bow";
                    break;
                }
                case CommonConstant.CHARACTER_WEAPONTYPE_CLUB:
                {
                    _loc_2 = "weapon_Club";
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (_loc_2 == "")
            {
                return null;
            }
            var _loc_3:* = ResourceManager.getInstance().createMovieClip(_WEAPON_PATH, _loc_2);
            return _loc_3;
        }// end function

        protected function getHitTime(param1:Point, param2:Point, param3:int) : Number
        {
            var _loc_4:* = new Point(param2.x - param1.x, param2.y - param1.y);
            return new Point(param2.x - param1.x, param2.y - param1.y).length / param3;
        }// end function

        protected function bMoveing() : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_1:* = this._battleManager.getEntryPlayer();
            for each (_loc_2 in _loc_1)
            {
                
                _loc_3 = _loc_2.characterAction.characterDisplay as PlayerDisplay;
                if (_loc_3.bMoveing == true)
                {
                    return true;
                }
            }
            return false;
        }// end function

        protected function setMcPosition(param1:MovieClip, param2:Point) : void
        {
            param1.x = param2.x;
            param1.y = param2.y;
            return;
        }// end function

        protected function getTargetPosition(param1:MovieClip, param2:MovieClip = null) : Point
        {
            var _loc_3:* = new Point(param1.x, param1.y);
            if (param2 != null)
            {
                _loc_3 = _loc_3.add(new Point(param2.x, param2.y));
            }
            return _loc_3;
        }// end function

        protected function addEffect(param1:EffectManager, param2:EffectMc, param3:Function = null, param4:Function = null) : void
        {
            this._aEffect.push(new EffectData(param2, param3, param4));
            param1.addEffect(param2);
            return;
        }// end function

        private function controlEffect(param1:Number) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = this._aEffect.length - 1;
            while (_loc_2 >= 0)
            {
                
                _loc_3 = this._aEffect[_loc_2];
                _loc_3.checkSetCallback();
                _loc_3.callControlCallback(param1);
                if (_loc_3.isEnd())
                {
                    this.releaseEffect(_loc_3.effectMc);
                    _loc_3.release();
                    this._aEffect.splice(this._aEffect.indexOf(_loc_3), 1);
                }
                _loc_2 = _loc_2 - 1;
            }
            return;
        }// end function

        protected function releaseEffect(param1:EffectMc) : void
        {
            return;
        }// end function

    }
}

import battle.*;

import effect.*;

import enemy.*;

import flash.display.*;

import flash.geom.*;

import layer.*;

import player.*;

import resource.*;

import utility.*;

class EffectData extends Object
{
    private var _effectMc:EffectMc;
    private var _setCallback:Function;
    private var _controlCallback:Function;
    private var _markedFrame:int;

    function EffectData(param1:EffectMc, param2:Function = null, param3:Function = null)
    {
        this._effectMc = param1;
        this._setCallback = param2;
        this._controlCallback = param3;
        this._markedFrame = 0;
        return;
    }// end function

    public function get effectMc() : EffectMc
    {
        return this._effectMc;
    }// end function

    public function release() : void
    {
        if (this._effectMc)
        {
            this._effectMc.release();
        }
        this._effectMc = null;
        this._setCallback = null;
        this._controlCallback = null;
        return;
    }// end function

    public function checkSetCallback() : void
    {
        if (!this._effectMc)
        {
            return;
        }
        if (this._effectMc.isEnd())
        {
            if (this._setCallback != null)
            {
                this._setCallback(this._effectMc, "end");
            }
            return;
        }
        if (this._effectMc.mcEffect.currentFrameLabel != null)
        {
            if (this._effectMc.mcEffect.currentFrame != this._markedFrame)
            {
                this._markedFrame = this._effectMc.mcEffect.currentFrame;
                if (this._setCallback != null)
                {
                    this._setCallback(this._effectMc, this._effectMc.mcEffect.currentLabel);
                }
            }
        }
        return;
    }// end function

    public function callControlCallback(param1:Number) : void
    {
        if (!this._effectMc || this._effectMc.isEnd())
        {
            return;
        }
        if (this._controlCallback != null)
        {
            this._controlCallback(this._effectMc, this._effectMc.mcEffect.currentLabel, param1);
        }
        return;
    }// end function

    public function isEnd() : Boolean
    {
        if (!this._effectMc)
        {
            return true;
        }
        return this._effectMc.isEnd();
    }// end function

}

