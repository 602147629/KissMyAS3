package skill
{
    import battle.*;
    import character.*;
    import effect.*;
    import enemy.*;
    import flash.display.*;
    import flash.geom.*;
    import layer.*;
    import resource.*;
    import sound.*;
    import utility.*;

    public class SkillMagicBase extends SkillPositionBase
    {
        protected const _ACT_LABEL_BACK:String = "back";
        protected const _ACT_LABEL_START_FRONT:String = "start_front";
        protected const _EFFECT_ACTTION_FRONT:String = "action_front";
        static const _TEMP_CASTING_SE:int = 2117;
        public static var _bossMagicPath:String = ResourcePath.SKILL_PATH + "Magic_Boss_Magic.swf";

        public function SkillMagicBase(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager, param6:String)
        {
            super(param1, param2, param3, param4, param5, param6);
            return;
        }// end function

        override protected function createBaseMc(param1:String) : void
        {
            switch(_skillUser.type)
            {
                case CharacterDisplayBase.TYPE_PLAYER:
                {
                    _baseMc = ResourceManager.getInstance().createMovieClip(param1, "position_chara_act");
                    break;
                }
                case CharacterDisplayBase.TYPE_ENEMY:
                {
                    _baseMc = ResourceManager.getInstance().createMovieClip(param1, "magic_chant_monster");
                    _enemyType = _skillUser.characterDisplay as EnemyDisplay;
                    if (isBoss())
                    {
                        _baseMc.visible = false;
                    }
                    break;
                }
                default:
                {
                    Assert.print("魔法エラー：使用者のtype値が異常です");
                    break;
                }
            }
            _layer.getLayer(LayerBattle.CHARACTER).addChild(_baseMc);
            return;
        }// end function

        override protected function init() : void
        {
            if (_bReverse)
            {
                _baseMc.scaleX = -1;
            }
            return;
        }// end function

        public function bossEffectCreate(param1:String) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (_skillUser.type == CharacterDisplayBase.TYPE_ENEMY && isBoss())
            {
                _bossEffect = ResourceManager.getInstance().createMovieClip(_bossMagicPath, param1);
                _layer.getLayer(LayerBattle.FRONT_EFFECT).addChild(_bossEffect);
                _loc_2 = _skillUserDisplay.pos;
                _loc_3 = new Matrix();
                _loc_3.translate(_loc_2.x, _loc_2.y);
                _bossEffect.transform.matrix = _loc_3;
                return true;
            }
            return false;
        }// end function

        public function getMagicBulletStartNull(param1:MovieClip) : Point
        {
            var _loc_2:* = null;
            var _loc_3:* = param1;
            var _loc_4:* = _skillUserDisplay.pos;
            if (_bReverse)
            {
                if (_skillUserBulletPos != null)
                {
                    if (isBoss())
                    {
                        _loc_3.x = _skillUserBulletPos.x;
                        _loc_3.y = _skillUserBulletPos.y;
                        _loc_2 = new Point(_loc_4.x + _loc_3.x, _loc_4.y + _loc_3.y);
                    }
                    else
                    {
                        _loc_2 = new Point(_loc_4.x - _loc_3.x, _loc_4.y + _loc_3.y);
                    }
                }
                else
                {
                    _loc_2 = new Point(_loc_4.x - _loc_3.x, _loc_4.y + _loc_3.y);
                }
            }
            else
            {
                _loc_2 = new Point(_loc_4.x + _loc_3.x, _loc_4.y + _loc_3.y);
            }
            return _loc_2;
        }// end function

        protected function playCastingSE() : void
        {
            SoundManager.getInstance().playSe(_TEMP_CASTING_SE);
            return;
        }// end function

    }
}
