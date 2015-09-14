package skill
{
    import battle.*;
    import character.*;
    import effect.*;
    import flash.display.*;
    import flash.geom.*;
    import layer.*;
    import resource.*;

    public class SkillBase extends Object
    {
        protected var _baseMc:MovieClip;
        protected var _bossEffect:MovieClip;
        protected var _aWeaponMc:Array;
        protected var _bReverse:Boolean;
        private var _bEnd:Boolean;
        private var _bNextEnd:Boolean;
        protected var _bTerminate:Boolean;
        protected var _skillUser:BattleActionBase;
        protected var _skillUserDisplay:CharacterDisplayBase;
        protected var _skillUserBulletPos:Point;
        protected var _target:BattleActionBase;
        protected var _targetDisplay:CharacterDisplayBase;
        protected var _targetHitFrontPos:Point;
        protected var _targetGrandPos:Point;
        protected var _targetFacePos:Point;
        protected var _layer:LayerBattle;
        protected var _effectManager:EffectManager;
        protected var _aTarget:Array;
        protected var _battleManager:BattleManager;
        protected const _ACT_LABEL_STOP:String = "stop";
        protected const _ACT_LABEL_START:String = "start";
        protected const _ACT_LABEL_HIT:String = "hit";
        protected const _ACT_LABEL_BULLET_START:String = "bulletStart";
        protected const _ACT_LABEL_BULLET:String = "bullet";
        protected const _ACT_LABEL_BULLET_LOOP:String = "bulletLoop";
        protected const _ACT_LABEL_END:String = "end";
        protected const _EFFECT_LABEL_START:String = "start";
        protected const _EFFECT_LABEL_DAMAGE:String = "damage";
        protected const _EFFECT_LABEL_DAMAGE_LOOP_START:String = "damageLoopStart";
        protected const _EFFECT_LABEL_DAMAGE_LOOP_END:String = "damageLoopEnd";
        protected const _EFFECT_LABEL_DAMAGE_LOOP:String = "damageLoop";
        protected const _EFFECT_LABEL_DAMAGE_LAST:String = "damageLast";
        protected const _EFFECT_LABEL_SHAKE_START:String = "shake_start";
        protected const _EFFECT_LABEL_SHAKE_END:String = "shake_end";
        protected const _EFFECT_PLAY_SE:String = "play_se";
        protected const _EFFECT_LABEL_END:String = "end";
        protected const _EFFECT_MC_HIT:String = "hit_front";
        protected const _EFFECT_MC_GRAND:String = "hit_grand";
        protected const _EFFECT_MC_BULLET:String = "bullet";
        protected const _MONSTER_LABELNAME_ATTACK:String = "attack";
        protected const _MONSTER_LABELNAME_CHARGE:String = "charge";
        protected const _BOSS_ARIA_EARTH:String = "position_boss_earth";
        protected const _BOSS_ARIA_FIRE:String = "position_boss_fire";
        protected const _BOSS_ARIA_HADES:String = "position_boss_hades";
        protected const _BOSS_ARIA_HEAVEN:String = "position_boss_heaven";
        protected const _BOSS_ARIA_WATER:String = "position_boss_water";
        protected const _BOSS_ARIA_WIND:String = "position_boss_wind";

        public function SkillBase(param1:BattleActionBase, param2:Array, param3:EffectManager, param4:Boolean)
        {
            this._bReverse = param4;
            this._effectManager = param3;
            this._bEnd = false;
            this._skillUser = param1;
            this._skillUserDisplay = this._skillUser.characterDisplay;
            this._skillUser.setActionAttack();
            this._skillUserDisplay.backupParent();
            this._aTarget = param2;
            this._battleManager = null;
            this._aWeaponMc = [];
            return;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in _loc_1)
            {
                
                if (_loc_1.parent)
                {
                    _loc_1.parent.removeChild(_loc_1);
                }
            }
            _loc_1 = null;
            if (this._baseMc && this._baseMc.parent)
            {
                this._baseMc.parent.removeChild(this._baseMc);
            }
            this._baseMc = null;
            if (this._bossEffect && this._bossEffect.parent)
            {
                this._bossEffect.parent.removeChild(this._bossEffect);
            }
            this._bossEffect = null;
            this._battleManager = null;
            this._skillUser = null;
            this._skillUserDisplay = null;
            this._effectManager = null;
            this._aTarget = null;
            return;
        }// end function

        protected function init() : void
        {
            if (this._bReverse)
            {
                this._baseMc.scaleX = -1;
            }
            if (this._skillUserDisplay.type == CharacterDisplayBase.TYPE_ENEMY)
            {
                this._baseMc.visible = false;
            }
            return;
        }// end function

        protected function setEnd() : void
        {
            this._skillUserDisplay.returnParent();
            this._skillUser.disableActionEndWait();
            this._bNextEnd = true;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            if (this._bNextEnd)
            {
                if (this._skillUser.bAttackAnimation == false)
                {
                    this._bEnd = this._bNextEnd;
                }
            }
            return;
        }// end function

        public function setWeapon(param1:int) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = null;
            if (this._skillUserDisplay.type == CharacterDisplayBase.TYPE_ENEMY)
            {
                return;
            }
            if (this._baseMc && param1 != Constant.UNDECIDED)
            {
                _loc_2 = SkillManager.getInstance().getWeaponClassName(param1);
                if (_loc_2 != "")
                {
                    _loc_3 = this._baseMc;
                    if (this._baseMc.getChildByName("charaNull") != null)
                    {
                        _loc_3 = this._baseMc.getChildByName("charaNull") as MovieClip;
                    }
                    _loc_4 = _loc_3.getChildByName("weaponNull") as DisplayObjectContainer;
                    if (_loc_4 != null)
                    {
                        _loc_10 = this.createWeapon(_loc_2);
                        _loc_10.gotoAndStop(1);
                        _loc_4.addChild(_loc_10);
                        this._aWeaponMc.push(_loc_10);
                    }
                    _loc_5 = _loc_3.getChildByName("weaponNull1") as DisplayObjectContainer;
                    _loc_6 = _loc_3.getChildByName("weaponNull2") as DisplayObjectContainer;
                    if (_loc_5 != null && _loc_6 != null)
                    {
                        _loc_11 = this.createWeapon(_loc_2);
                        _loc_12 = this.createWeapon(_loc_2);
                        _loc_11.gotoAndStop(1);
                        _loc_12.gotoAndStop(2);
                        _loc_5.addChild(_loc_11);
                        _loc_6.addChild(_loc_12);
                        this._aWeaponMc.push(_loc_11);
                        this._aWeaponMc.push(_loc_12);
                    }
                    _loc_7 = _loc_3.getChildByName("weaponNullParts1") as DisplayObjectContainer;
                    _loc_8 = _loc_3.getChildByName("weaponNullParts2") as DisplayObjectContainer;
                    if (_loc_7 != null && _loc_8 != null)
                    {
                        _loc_13 = this.createWeapon(_loc_2);
                        _loc_14 = this.createWeapon(_loc_2);
                        _loc_13.gotoAndStop(3);
                        _loc_14.gotoAndStop(2);
                        _loc_7.addChild(_loc_13);
                        _loc_8.addChild(_loc_14);
                        this._aWeaponMc.push(_loc_13);
                        this._aWeaponMc.push(_loc_14);
                    }
                    _loc_9 = _loc_3.getChildByName("weaponNullMoveMc") as DisplayObjectContainer;
                    if (_loc_9 != null)
                    {
                        _loc_15 = _loc_9.getChildByName("weaponNull") as DisplayObjectContainer;
                        _loc_16 = this.createWeapon(_loc_2);
                        _loc_16.gotoAndStop(1);
                        _loc_15.addChild(_loc_16);
                        this._aWeaponMc.push(_loc_16);
                    }
                }
            }
            return;
        }// end function

        protected function createWeapon(param1:String) : MovieClip
        {
            var _loc_2:* = ResourceManager.getInstance().createMovieClip(ResourcePath.SKILL_PATH + "Weapons.swf", param1);
            return _loc_2;
        }// end function

        public function isEnd() : Boolean
        {
            return this._bEnd;
        }// end function

        public function setBattleManager(param1:BattleManager) : void
        {
            this._battleManager = param1;
            return;
        }// end function

        protected function playDamage(param1:BattleActionBase) : void
        {
            if (this._battleManager == null)
            {
                return;
            }
            this._battleManager.playDamage(param1.questUniqueId, this.cbDamageHp);
            return;
        }// end function

        protected function playDamageAll() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aTarget)
            {
                
                this.playDamage(_loc_1);
            }
            return;
        }// end function

        private function cbDamageHp(param1:DamageData) : void
        {
            var _loc_2:* = null;
            if (param1.bMiss == false)
            {
                _loc_2 = this._battleManager.getCharacter(param1.questUniqueId);
                if (param1.questUniqueId != this._skillUser.questUniqueId || BattleManager.isBadStatusCharm(_loc_2.status.badStatus) == false)
                {
                    _loc_2.characterAction.setActionDamage();
                }
            }
            return;
        }// end function

        private function cbPlayCounterDamage() : void
        {
            if (this._battleManager)
            {
                this.playDamage(this._skillUser);
            }
            return;
        }// end function

    }
}
