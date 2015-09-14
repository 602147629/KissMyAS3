package trainingRoom
{
    import effect.*;
    import flash.display.*;
    import flash.geom.*;
    import layer.*;
    import player.*;
    import resource.*;
    import skill.*;
    import sound.*;

    public class TrainingRoomKumiteAction extends TrainingRoomActionBase
    {
        private var _traineePlayer:PlayerDisplay;
        private var _kumitePlayer:PlayerDisplay;

        public function TrainingRoomKumiteAction(param1:LayerTrainingRoom, param2:MovieClip, param3:PlayerDisplay, param4:PlayerDisplay, param5:EffectManager)
        {
            _layer = param1;
            this._traineePlayer = param3;
            this._kumitePlayer = param4;
            _baseMc = param2.traningMenu1Mc;
            _effectManager = param5;
            _count = 0;
            return;
        }// end function

        override public function release() : void
        {
            super.release();
            this._traineePlayer = null;
            this._kumitePlayer = null;
            return;
        }// end function

        public function getResources() : void
        {
            var _loc_1:* = [this._traineePlayer.info.weaponType, this._kumitePlayer.info.weaponType];
            weponSwitch(_loc_1);
            return;
        }// end function

        public function controlAction(param1:Number) : void
        {
            if (_count > 5 && _count % 100 == 0)
            {
                _mc = this.motionSettings(_actionFlag);
                if (_actionFlag)
                {
                    this._traineePlayer.setAnimationPattern(_mc);
                    this._traineePlayer.mc.addChild(_mc);
                    _nowWeponType = this._traineePlayer.info.weaponType;
                }
                else
                {
                    this._kumitePlayer.setAnimationPattern(_mc);
                    this._kumitePlayer.mc.addChild(_mc);
                    _nowWeponType = this._kumitePlayer.info.weaponType;
                }
                _mc.gotoAndPlay("start");
                _mc.visible = true;
            }
            if (_nowWeponType != CommonConstant.CHARACTER_WEAPONTYPE_BOW)
            {
                this.meleeAttack();
            }
            else
            {
                this.rangedAttack();
                if (_bulletFlag)
                {
                    this.controlBullet(param1);
                }
            }
            var _loc_3:* = _count + 1;
            _count = _loc_3;
            return;
        }// end function

        private function meleeAttack() : void
        {
            if (_mc != null && _mc.currentFrameLabel == "hit")
            {
                if (_actionFlag)
                {
                    this._kumitePlayer.setAnimDamage();
                }
                else
                {
                    this._traineePlayer.setAnimDamage();
                }
                _effectManager.addEffect(this.weponEffect(_actionFlag));
            }
            if (_mc != null && _mc.currentFrameLabel == "end")
            {
                this.mcEnd();
            }
            return;
        }// end function

        private function rangedAttack() : void
        {
            var _loc_1:* = null;
            if (_mc != null && _mc.currentFrameLabel == "bullet")
            {
                if (_actionFlag)
                {
                    _loc_1 = new Point(_baseMc.x + _baseMc.charaNull2.x, _baseMc.y + _baseMc.charaNull2.y + this._kumitePlayer.effectNull.y);
                }
                else
                {
                    _loc_1 = new Point(_baseMc.x + _baseMc.charaNull1.x, _baseMc.y + _baseMc.charaNull1.y + this._traineePlayer.effectNull.y);
                }
                this.setBullet(_loc_1);
                _bulletFlag = true;
            }
            return;
        }// end function

        public function setBullet(param1:Point) : void
        {
            _aBullet = [];
            var _loc_2:* = ResourceManager.getInstance().createMovieClip(ResourcePath.SKILL_PATH + "Attack_Bow.swf", "bullet");
            var _loc_3:* = this.getStartPosition();
            var _loc_4:* = param1;
            var _loc_5:* = getSpeedVector(_loc_3, _loc_4, _SHOT_SPEED);
            var _loc_6:* = getHitTime(_loc_3, _loc_4, _SHOT_SPEED);
            var _loc_7:* = new SkillPartsArrow(_layer.getLayer(LayerTrainingRoom.BULLET), _loc_2, _loc_3, _loc_5);
            new SkillPartsArrow(_layer.getLayer(LayerTrainingRoom.BULLET), _loc_2, _loc_3, _loc_5).setHitMake(_loc_6);
            _aBullet.push(_loc_7);
            SoundManager.getInstance().playSe(SoundId.SE_RS3_BOW_BOW);
            return;
        }// end function

        public function controlBullet(param1:Number) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_2:* = _aBullet.length - 1;
            while (_loc_2 >= 0)
            {
                
                _loc_3 = _aBullet[_loc_2];
                _loc_3.control(param1);
                if (_loc_3.bHit)
                {
                    if (_actionFlag)
                    {
                        _loc_4 = new Point(_baseMc.x + _baseMc.charaNull2.x, _baseMc.y + _baseMc.charaNull2.y + this._kumitePlayer.effectNull.y);
                        this._kumitePlayer.setAnimDamage();
                    }
                    else
                    {
                        _loc_4 = new Point(_baseMc.x + _baseMc.charaNull1.x, _baseMc.y + _baseMc.charaNull1.y + this._traineePlayer.effectNull.y);
                        this._traineePlayer.setAnimDamage();
                    }
                    _loc_5 = new EffectMc(_layer.getLayer(LayerTrainingRoom.EFFECT), ResourcePath.SKILL_PATH + "Attack_Bow.swf", _EFFECT_MC_HIT, _loc_4);
                    if (!_actionFlag)
                    {
                        _loc_5.mcEffect.scaleX = -1;
                    }
                    _effectManager.addEffect(_loc_5);
                    SoundManager.getInstance().playSe(SoundId.SE_ARROW_HIT);
                    _loc_3.release();
                    _aBullet.splice(_loc_2, 1);
                }
                _loc_2 = _loc_2 - 1;
            }
            if (_aBullet.length == 0)
            {
                if (_mc != null && _mc.currentFrameLabel == "end")
                {
                    this.mcEnd();
                    _bulletFlag = false;
                }
            }
            return;
        }// end function

        private function mcEnd() : void
        {
            _mc.visible = false;
            if (_actionFlag)
            {
                _actionFlag = false;
            }
            else
            {
                _actionFlag = true;
            }
            this._traineePlayer.setAnimSelected();
            this._kumitePlayer.setAnimSelected();
            _mc = null;
            return;
        }// end function

        public function motionSettings(param1:Boolean) : MovieClip
        {
            var _loc_2:* = 0;
            if (param1)
            {
                _loc_2 = this._traineePlayer.info.weaponType;
            }
            else
            {
                _loc_2 = this._kumitePlayer.info.weaponType;
            }
            return montinSettings(_loc_2);
        }// end function

        public function weponEffect(param1:Boolean) : EffectMc
        {
            var _loc_2:* = null;
            if (param1)
            {
                _loc_2 = new Point(_baseMc.x + _baseMc.charaNull2.x, _baseMc.y + _baseMc.charaNull2.y + this._kumitePlayer.effectNull.y);
            }
            else
            {
                _loc_2 = new Point(_baseMc.x + _baseMc.charaNull1.x, _baseMc.y + _baseMc.charaNull1.y + this._traineePlayer.effectNull.y);
            }
            return setEffect(_nowWeponType, _loc_2, param1);
        }// end function

        protected function getStartPosition() : Point
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_1:* = _mc.bulletStartNullMc;
            if (_actionFlag)
            {
                _loc_2 = new Point(_baseMc.x + _baseMc.charaNull2.x, _baseMc.y + _baseMc.charaNull2.y);
            }
            else
            {
                _loc_2 = new Point(_baseMc.x + _baseMc.charaNull1.x, _baseMc.y + _baseMc.charaNull1.y);
            }
            var _loc_4:* = _loc_2;
            return new Point(_loc_4.x + _loc_1.x, _loc_4.y + _loc_1.y);
        }// end function

    }
}
