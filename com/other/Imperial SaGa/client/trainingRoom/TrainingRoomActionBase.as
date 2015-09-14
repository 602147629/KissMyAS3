package trainingRoom
{
    import effect.*;
    import flash.display.*;
    import flash.geom.*;
    import formation.*;
    import layer.*;
    import resource.*;
    import sound.*;

    public class TrainingRoomActionBase extends Object
    {
        protected var _effectManager:EffectManager;
        protected var _layer:LayerTrainingRoom;
        protected var _baseMc:MovieClip;
        protected const _EFFECT_MC_HIT:String = "hit_front";
        protected var _aBullet:Array;
        protected const _SHOT_SPEED:int = 1500;
        protected var _bulletFlag:Boolean = false;
        protected var _count:int;
        protected var _mc:MovieClip;
        protected var _actionFlag:Boolean = true;
        protected var _nowWeponType:int = 0;

        public function TrainingRoomActionBase()
        {
            return;
        }// end function

        public function release() : void
        {
            this._mc = null;
            this._baseMc = null;
            return;
        }// end function

        protected function weponSwitch(param1:Array) : void
        {
            var _loc_2:* = 0;
            for each (_loc_2 in param1)
            {
                
                switch(_loc_2)
                {
                    case CommonConstant.CHARACTER_WEAPONTYPE_SWORD:
                    {
                        ResourceManager.getInstance().loadResource(ResourcePath.SKILL_PATH + "Attack_Sword.swf");
                        SoundManager.getInstance().loadSound(SoundId.SE_RS3_SWORD_LONG_SWORD_NORMAL_ATTACK);
                        break;
                    }
                    case CommonConstant.CHARACTER_WEAPONTYPE_GREATSWORD:
                    {
                        ResourceManager.getInstance().loadResource(ResourcePath.SKILL_PATH + "Attack_Sword.swf");
                        SoundManager.getInstance().loadSound(SoundId.SE_RS3_BIGSWORD_NORMAL_ATTACK);
                        break;
                    }
                    case CommonConstant.CHARACTER_WEAPONTYPE_AX:
                    {
                        ResourceManager.getInstance().loadResource(ResourcePath.SKILL_PATH + "Attack_Axe.swf");
                        SoundManager.getInstance().loadSound(SoundId.SE_RS3_AXE_NORMAL_ATTACK);
                        break;
                    }
                    case CommonConstant.CHARACTER_WEAPONTYPE_CLUB:
                    {
                        ResourceManager.getInstance().loadResource(ResourcePath.SKILL_PATH + "Attack_Club.swf");
                        SoundManager.getInstance().loadSound(SoundId.SE_RS3_CLUB_NORMAL_ATTACK);
                        break;
                    }
                    case CommonConstant.CHARACTER_WEAPONTYPE_SPEAR:
                    case CommonConstant.CHARACTER_WEAPONTYPE_HALBERD:
                    {
                        ResourceManager.getInstance().loadResource(ResourcePath.SKILL_PATH + "Attack_Spear.swf");
                        SoundManager.getInstance().loadSound(SoundId.SE_RS3_SPEAR_NORMAL_ATTACK);
                        break;
                    }
                    case CommonConstant.CHARACTER_WEAPONTYPE_SHORTSWORD:
                    {
                        ResourceManager.getInstance().loadResource(ResourcePath.SKILL_PATH + "Attack_SmallSword.swf");
                        SoundManager.getInstance().loadSound(SoundId.SE_RS3_SWORD_LONG_SWORD_NORMAL_ATTACK);
                        break;
                    }
                    case CommonConstant.CHARACTER_WEAPONTYPE_MATERIALARTS:
                    case CommonConstant.CHARACTER_WEAPONTYPE_NAIL:
                    case 0:
                    {
                        ResourceManager.getInstance().loadResource(ResourcePath.SKILL_PATH + "Attack_MartialArt1.swf");
                        SoundManager.getInstance().loadSound(SoundId.SE_RS3_BLOW_PUNCH);
                        break;
                    }
                    case CommonConstant.CHARACTER_WEAPONTYPE_BOW:
                    {
                        ResourceManager.getInstance().loadResource(ResourcePath.SKILL_PATH + "Attack_Bow.swf");
                        SoundManager.getInstance().loadSound(SoundId.SE_RS3_BOW_BOW);
                        SoundManager.getInstance().loadSound(SoundId.SE_ARROW_HIT);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            ResourceManager.getInstance().loadResource(ResourcePath.SKILL_PATH + "Weapons.swf");
            return;
        }// end function

        protected function montinSettings(param1:int) : MovieClip
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            switch(param1)
            {
                case CommonConstant.CHARACTER_WEAPONTYPE_SWORD:
                case CommonConstant.CHARACTER_WEAPONTYPE_GREATSWORD:
                {
                    _loc_2 = ResourceManager.getInstance().createMovieClip(ResourcePath.SKILL_PATH + "Attack_Sword.swf", "position_chara_act");
                    break;
                }
                case CommonConstant.CHARACTER_WEAPONTYPE_AX:
                {
                    _loc_2 = ResourceManager.getInstance().createMovieClip(ResourcePath.SKILL_PATH + "Attack_Axe.swf", "position_chara_act");
                    break;
                }
                case CommonConstant.CHARACTER_WEAPONTYPE_CLUB:
                {
                    _loc_2 = ResourceManager.getInstance().createMovieClip(ResourcePath.SKILL_PATH + "Attack_Club.swf", "position_chara_act");
                    break;
                }
                case CommonConstant.CHARACTER_WEAPONTYPE_SPEAR:
                case CommonConstant.CHARACTER_WEAPONTYPE_HALBERD:
                {
                    _loc_2 = ResourceManager.getInstance().createMovieClip(ResourcePath.SKILL_PATH + "Attack_Spear.swf", "position_chara_act");
                    break;
                }
                case CommonConstant.CHARACTER_WEAPONTYPE_SHORTSWORD:
                {
                    _loc_2 = ResourceManager.getInstance().createMovieClip(ResourcePath.SKILL_PATH + "Attack_SmallSword.swf", "position_chara_act");
                    break;
                }
                case CommonConstant.CHARACTER_WEAPONTYPE_MATERIALARTS:
                case CommonConstant.CHARACTER_WEAPONTYPE_NAIL:
                case 0:
                {
                    _loc_2 = ResourceManager.getInstance().createMovieClip(ResourcePath.SKILL_PATH + "Attack_MartialArt1.swf", "position_chara_act");
                    break;
                }
                case CommonConstant.CHARACTER_WEAPONTYPE_BOW:
                {
                    _loc_2 = ResourceManager.getInstance().createMovieClip(ResourcePath.SKILL_PATH + "Attack_Bow.swf", "position_chara_act");
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (param1 == CommonConstant.CHARACTER_WEAPONTYPE_BOW)
            {
                _loc_3 = "weapon_Bow";
                _loc_4 = _loc_2.getChildByName("weaponNull1") as MovieClip;
                _loc_5 = _loc_2.getChildByName("weaponNull2") as MovieClip;
                if (_loc_4 != null && _loc_5 != null)
                {
                    _loc_6 = this.createWeapon(_loc_3);
                    _loc_7 = this.createWeapon(_loc_3);
                    _loc_6.gotoAndStop(1);
                    _loc_7.gotoAndStop(1);
                    _loc_4.addChild(_loc_6);
                    _loc_5.addChild(_loc_7);
                }
            }
            else if (param1 == CommonConstant.CHARACTER_WEAPONTYPE_MATERIALARTS || param1 == CommonConstant.CHARACTER_WEAPONTYPE_NAIL || param1 == 0)
            {
            }
            else
            {
                _loc_8 = _loc_2.getChildByName("weaponNull") as MovieClip;
                _loc_3 = FormationManager.getInstance().getWeaponClassName(param1);
                _loc_9 = this.createWeapon(_loc_3);
                _loc_9.gotoAndStop(1);
                _loc_8.addChild(_loc_9);
            }
            _loc_2.gotoAndStop(1);
            return _loc_2;
        }// end function

        protected function setEffect(param1:int, param2:Point, param3:Boolean) : EffectMc
        {
            var _loc_4:* = null;
            switch(param1)
            {
                case CommonConstant.CHARACTER_WEAPONTYPE_SWORD:
                {
                    _loc_4 = new EffectMc(this._layer.getLayer(LayerTrainingRoom.EFFECT), ResourcePath.SKILL_PATH + "Attack_Sword.swf", this._EFFECT_MC_HIT, param2);
                    SoundManager.getInstance().playSe(SoundId.SE_RS3_SWORD_LONG_SWORD_NORMAL_ATTACK);
                    break;
                }
                case CommonConstant.CHARACTER_WEAPONTYPE_GREATSWORD:
                {
                    _loc_4 = new EffectMc(this._layer.getLayer(LayerTrainingRoom.EFFECT), ResourcePath.SKILL_PATH + "Attack_Sword.swf", this._EFFECT_MC_HIT, param2);
                    SoundManager.getInstance().playSe(SoundId.SE_RS3_BIGSWORD_NORMAL_ATTACK);
                    break;
                }
                case CommonConstant.CHARACTER_WEAPONTYPE_SHORTSWORD:
                {
                    _loc_4 = new EffectMc(this._layer.getLayer(LayerTrainingRoom.EFFECT), ResourcePath.SKILL_PATH + "Attack_SmallSword.swf", this._EFFECT_MC_HIT, param2);
                    SoundManager.getInstance().playSe(SoundId.SE_RS3_SWORD_LONG_SWORD_NORMAL_ATTACK);
                    break;
                }
                case CommonConstant.CHARACTER_WEAPONTYPE_AX:
                {
                    _loc_4 = new EffectMc(this._layer.getLayer(LayerTrainingRoom.EFFECT), ResourcePath.SKILL_PATH + "Attack_Axe.swf", this._EFFECT_MC_HIT, param2);
                    SoundManager.getInstance().playSe(SoundId.SE_RS3_AXE_NORMAL_ATTACK);
                    break;
                }
                case CommonConstant.CHARACTER_WEAPONTYPE_CLUB:
                {
                    _loc_4 = new EffectMc(this._layer.getLayer(LayerTrainingRoom.EFFECT), ResourcePath.SKILL_PATH + "Attack_Club.swf", this._EFFECT_MC_HIT, param2);
                    SoundManager.getInstance().playSe(SoundId.SE_RS3_CLUB_NORMAL_ATTACK);
                    break;
                }
                case CommonConstant.CHARACTER_WEAPONTYPE_SPEAR:
                case CommonConstant.CHARACTER_WEAPONTYPE_HALBERD:
                {
                    _loc_4 = new EffectMc(this._layer.getLayer(LayerTrainingRoom.EFFECT), ResourcePath.SKILL_PATH + "Attack_Spear.swf", this._EFFECT_MC_HIT, param2);
                    SoundManager.getInstance().playSe(SoundId.SE_RS3_SPEAR_NORMAL_ATTACK);
                    break;
                }
                case CommonConstant.CHARACTER_WEAPONTYPE_MATERIALARTS:
                case CommonConstant.CHARACTER_WEAPONTYPE_NAIL:
                case 0:
                {
                    _loc_4 = new EffectMc(this._layer.getLayer(LayerTrainingRoom.EFFECT), ResourcePath.SKILL_PATH + "Attack_MartialArt1.swf", this._EFFECT_MC_HIT, param2);
                    SoundManager.getInstance().playSe(SoundId.SE_RS3_BLOW_PUNCH);
                    break;
                }
                case CommonConstant.CHARACTER_WEAPONTYPE_BOW:
                {
                    _loc_4 = new EffectMc(this._layer.getLayer(LayerTrainingRoom.EFFECT), ResourcePath.SKILL_PATH + "Attack_Bow.swf", this._EFFECT_MC_HIT, param2);
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (!param3)
            {
                _loc_4.mcEffect.scaleX = -1;
            }
            return _loc_4;
        }// end function

        protected function createWeapon(param1:String) : MovieClip
        {
            var _loc_2:* = ResourceManager.getInstance().createMovieClip(ResourcePath.SKILL_PATH + "Weapons.swf", param1);
            return _loc_2;
        }// end function

        protected function getSpeedVector(param1:Point, param2:Point, param3:int) : Point
        {
            var _loc_4:* = new Point(param2.x - param1.x, param2.y - param1.y);
            new Point(param2.x - param1.x, param2.y - param1.y).normalize(1);
            var _loc_5:* = new Matrix();
            new Matrix().scale(param3, param3);
            return _loc_5.transformPoint(_loc_4);
        }// end function

        protected function getHitTime(param1:Point, param2:Point, param3:int) : Number
        {
            var _loc_4:* = new Point(param2.x - param1.x, param2.y - param1.y);
            return new Point(param2.x - param1.x, param2.y - param1.y).length / param3;
        }// end function

    }
}
