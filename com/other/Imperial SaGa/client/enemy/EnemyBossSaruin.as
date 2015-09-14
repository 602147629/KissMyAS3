package enemy
{
    import effect.*;
    import flash.display.*;
    import flash.geom.*;
    import layer.*;
    import resource.*;
    import sound.*;
    import utility.*;

    public class EnemyBossSaruin extends EnemyDisplay
    {
        private var _WAIT_EFFECT:Number = 2;
        private var _effectMistMainFront:EffectParticleBossMistMain;
        private var _effectMistMainBack:EffectParticleBossMistMain;
        private var _effectManager:EffectManager;
        private var _effectWaitTime:Number;
        private static const _EFFECT_PATH:String = ResourcePath.ENEMY_EFFECT_SWF_PATH + "Effect_Saruin_EF00.swf";
        private static const _WAIT_TIME:Number = 0.1;
        private static const _MIST_EFFECT_PATH:String = ResourcePath.ENEMY_EFFECT_PATH + "cloudBlack.png";

        public function EnemyBossSaruin(param1:DisplayObjectContainer, param2:int, param3:int)
        {
            super(param1, param2, param3);
            this._effectMistMainFront = new EffectParticleBossMistMain(null, _layer.getLayer(LayerCharacter.FRONT_EFFECT), this.cbMistCreateFront, _WAIT_TIME, _MIST_EFFECT_PATH, new Point(0.4, 0.4));
            this._effectMistMainFront.waitTime = Random.range(0.83, 1.5);
            this._effectMistMainBack = new EffectParticleBossMistMain(null, _layer.getLayer(LayerCharacter.BACK_EFFECT), this.cbMistCreateBack, _WAIT_TIME, _MIST_EFFECT_PATH, new Point(0.4, 0.4));
            this._effectMistMainBack.waitTime = Random.range(0.83, 1.5);
            this._effectManager = new EffectManager();
            this._effectWaitTime = this._WAIT_EFFECT;
            return;
        }// end function

        override public function release() : void
        {
            super.release();
            if (this._effectManager)
            {
                this._effectManager.release();
            }
            this._effectManager = null;
            if (this._effectMistMainFront)
            {
                this._effectMistMainFront.release();
            }
            this._effectMistMainFront = null;
            if (this._effectMistMainBack)
            {
                this._effectMistMainBack.release();
            }
            this._effectMistMainBack = null;
            return;
        }// end function

        override public function control(param1:Number) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            super.control(param1);
            this._effectWaitTime = this._effectWaitTime - param1;
            if (this._effectWaitTime <= 0)
            {
                this._effectWaitTime = this._WAIT_EFFECT + Random.range(0, 20) * 0.1;
                if (_mc.currentLabel != _LABEL_DEAD && _mc.currentLabel != _LABEL_ATTACK && _mc.currentLabel != _LABEL_MAGIC)
                {
                    _loc_2 = new EffectMc(_layer.getLayer(LayerCharacter.FRONT_EFFECT), _EFFECT_PATH, "effectFrontMc", new Point());
                    this._effectManager.addEffect(_loc_2);
                    _loc_3 = new EffectMc(_layer.getLayer(LayerCharacter.BACK_EFFECT), _EFFECT_PATH, "effectBackMc", new Point());
                    this._effectManager.addEffect(_loc_3);
                }
            }
            if (this._effectManager)
            {
                this._effectManager.control(param1);
            }
            if (this._effectMistMainFront)
            {
                this._effectMistMainFront.control(param1);
            }
            if (this._effectMistMainBack)
            {
                this._effectMistMainBack.control(param1);
            }
            return;
        }// end function

        override protected function controlAnim(param1:Number) : void
        {
            super.controlAnim(param1);
            this.playSeMotion();
            return;
        }// end function

        private function cbMistCreateFront() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (_mc.currentLabel != _LABEL_DEAD)
            {
                this._effectMistMainFront.waitTime = 0.3;
                _loc_1 = [_mc.monster.SteamGuideNull1, _mc.monster.SteamGuideNull2, _mc.monster.SteamGuideNull3, _mc.monster.SteamGuideNull4, _mc.monster.SteamGuideNull5];
                _loc_2 = _loc_1[Random.range(0, (_loc_1.length - 1))];
                _loc_3 = this.createMistParts(_loc_2, this._effectMistMainFront.bmpData, this._effectMistMainFront.mistBitmapData);
                this._effectMistMainFront.addEffect(_loc_3);
            }
            return;
        }// end function

        private function cbMistCreateBack() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (_mc.currentLabel != _LABEL_DEAD)
            {
                this._effectMistMainBack.waitTime = 0.3;
                _loc_1 = [_mc.monster.SteamGuideNull6, _mc.monster.SteamGuideNull7, _mc.monster.SteamGuideNull8, _mc.monster.SteamGuideNull9, _mc.monster.SteamGuideNull10];
                _loc_2 = _loc_1[Random.range(0, (_loc_1.length - 1))];
                _loc_3 = this.createMistParts(_loc_2, this._effectMistMainBack.bmpData, this._effectMistMainBack.mistBitmapData);
                this._effectMistMainBack.addEffect(_loc_3);
            }
            return;
        }// end function

        private function createMistParts(param1:MovieClip, param2:BitmapData, param3:BitmapData) : EffectParticleMistParts
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            _loc_4 = new Matrix();
            _loc_5 = _mc.transform.concatenatedMatrix.clone();
            _loc_5.invert();
            _loc_4 = param1.transform.concatenatedMatrix.clone();
            _loc_4.concat(_loc_5);
            _loc_6 = new Point(_loc_4.tx, _loc_4.ty);
            _loc_6 = this._effectMistMainBack.offset.add(_loc_6);
            _loc_7 = new EffectParticleMistParts(param2, param3, _loc_6, 0);
            _loc_7.setLiveTime(4, 4);
            _loc_7.vanishWaitTime = 2;
            _loc_7.rotAdd = 0;
            _loc_7.scale = Random.range(50, 150) * 0.01;
            if (Random.range(1, 2) == 1)
            {
                _loc_7.blendMode = BlendMode.SUBTRACT;
                _loc_7.bReverse = false;
            }
            else
            {
                _loc_7.blendMode = BlendMode.ADD;
                _loc_7.bReverse = true;
            }
            _loc_7.bSmoothing = true;
            return _loc_7;
        }// end function

        private function playSeMotion() : void
        {
            if (_bLabelAnimDetailChange == false)
            {
                return;
            }
            if (_labelAnimDetail == "se1001")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_SARUIN_ATTACK_START);
            }
            if (_labelAnimDetail == "se1002")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_SARUIN_ATTACK_SWORDSET);
            }
            if (_labelAnimDetail == "se1003")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_SARUIN_ATTACK_SWISH);
                SoundManager.getInstance().playSe(SoundId.SE_REV_SARUIN_ATTACK_ZANGEKI);
            }
            if (_labelAnimDetail == "se1004")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_SARUIN_ATTACK_TAME);
            }
            if (_labelAnimDetail == "se2001")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_SARUIN_ATTACK_START);
            }
            if (_labelAnimDetail == "se2002")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_SARUIN_ATTACK_SWORDSET);
                SoundManager.getInstance().playSe(SoundId.SE_REV_SARUIN_MAGIC_TAME);
            }
            return;
        }// end function

        public static function getResource() : Array
        {
            var _loc_1:* = [];
            _loc_1.push(_MIST_EFFECT_PATH);
            _loc_1.push(_EFFECT_PATH);
            return _loc_1;
        }// end function

        public static function getSoundResource() : Array
        {
            return [SoundId.SE_REV_SARUIN_ATTACK_START, SoundId.SE_REV_SARUIN_ATTACK_SWORDSET, SoundId.SE_REV_SARUIN_ATTACK_SWISH, SoundId.SE_REV_SARUIN_ATTACK_ZANGEKI, SoundId.SE_REV_SARUIN_ATTACK_TAME, SoundId.SE_REV_SARUIN_MAGIC_TAME];
        }// end function

    }
}
