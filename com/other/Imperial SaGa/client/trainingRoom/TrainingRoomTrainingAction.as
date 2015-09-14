package trainingRoom
{
    import effect.*;
    import enemy.*;
    import flash.display.*;
    import flash.geom.*;
    import layer.*;
    import player.*;
    import resource.*;
    import skill.*;
    import sound.*;

    public class TrainingRoomTrainingAction extends TrainingRoomActionBase
    {
        private var _trainingPlayer:PlayerDisplay;
        private var _trainingEnemyArray:Array;
        private var _aTrainingEnemyWeaponType:Array;
        private var _trainingEnemy:EnemyDisplay;
        private var _trainingEnemyWeaponType:int;
        private var _enemyAttackCount:int;
        private var _popCount:int = 0;
        private var enemyPopFlag:Boolean = false;
        private var _tableCount:int = 0;
        private var _enemyCount:int = 0;
        private var enemyHeight:int = 300;
        private var _flag:Boolean = false;
        private static const ATTACK_NUMBER:int = 1;
        private static const ENEMY_POP_TABLE:int = 800;

        public function TrainingRoomTrainingAction(param1:LayerTrainingRoom, param2:MovieClip, param3:PlayerDisplay, param4:Array, param5:Array, param6:EffectManager)
        {
            _layer = param1;
            this._trainingPlayer = param3;
            _baseMc = param2.traningMenu2Mc;
            _effectManager = param6;
            this._trainingEnemyArray = [];
            this._aTrainingEnemyWeaponType = [];
            var _loc_7:* = this.shuffleIdxArray(param4.length);
            var _loc_8:* = 0;
            while (_loc_8 < _loc_7.length)
            {
                
                this._trainingEnemyArray.push(param4[_loc_7[_loc_8]]);
                this._aTrainingEnemyWeaponType.push(param5[_loc_7[_loc_8]]);
                _loc_8++;
            }
            this._trainingEnemy = this._trainingEnemyArray[this._enemyCount];
            this._trainingEnemyWeaponType = this._aTrainingEnemyWeaponType[this._enemyCount];
            _count = 0;
            return;
        }// end function

        override public function release() : void
        {
            super.release();
            this._trainingPlayer = null;
            this._trainingEnemyArray = null;
            this._aTrainingEnemyWeaponType = null;
            this._trainingEnemy = null;
            return;
        }// end function

        public function getResources() : void
        {
            var _loc_2:* = 0;
            var _loc_1:* = [this._trainingPlayer.info.weaponType];
            for each (_loc_2 in this._aTrainingEnemyWeaponType)
            {
                
                _loc_1.push(_loc_2);
            }
            weponSwitch(_loc_1);
            return;
        }// end function

        public function enemyJump() : void
        {
            this._trainingEnemy = this._trainingEnemyArray[this._enemyCount];
            this._trainingEnemyWeaponType = this._aTrainingEnemyWeaponType[this._enemyCount];
            this._trainingEnemy.setAnimDamage();
            this._trainingEnemy.mc.visible = true;
            var _loc_1:* = new Point(0, this.enemyHeight);
            this._trainingEnemy.setTargetPoint(_loc_1, 0.15);
            this._trainingEnemy.setAnimBattleWait();
            return;
        }// end function

        private function enemyLanding() : void
        {
            var resPath:String;
            var base:MovieClip;
            var shake:EffectShake;
            var bMoveing:* = this._trainingEnemy.bMoveing;
            if (bMoveing != this._flag)
            {
                this._flag = bMoveing;
                if (!this._flag)
                {
                    resPath = ResourcePath.FACILITY_PATH + "UI_Training.swf";
                    base = ResourceManager.getInstance().createMovieClip(resPath, "MonsterLandAni");
                    base.x = _baseMc.x + _baseMc.monsNull.x;
                    base.y = _baseMc.y + _baseMc.monsNull.y;
                    _layer.getLayer(2).addChild(base);
                    base.gotoAndPlay(1);
                    shake = new EffectShake(this._trainingEnemy.mc, 1, 1, 0.5);
                    _effectManager.addEffect(shake);
                    this._trainingPlayer.setAnimationWithCallback(PlayerDisplay.LABEL_ACTION_SELECT_START, function () : void
            {
                _trainingPlayer.setAnimSelected();
                return;
            }// end function
            );
                    this._trainingEnemy.setAnimBattleWait();
                    this._enemyAttackCount = 0;
                    this.enemyPopFlag = true;
                }
            }
            return;
        }// end function

        public function controlAction(param1:Number) : void
        {
            this._trainingEnemy.control(param1);
            var _loc_2:* = this;
            var _loc_3:* = this._popCount + 1;
            _loc_2._popCount = _loc_3;
            if (!this.enemyPopFlag && ENEMY_POP_TABLE < this._popCount)
            {
                this.enemyJump();
                this._popCount = 0;
                var _loc_2:* = this;
                var _loc_3:* = this._tableCount + 1;
                _loc_2._tableCount = _loc_3;
            }
            this.enemyLanding();
            if (this.enemyPopFlag)
            {
                if (this._enemyAttackCount < (ATTACK_NUMBER + 1))
                {
                    this.action(param1);
                }
            }
            if (this._enemyCount >= this._trainingEnemyArray.length)
            {
                this._enemyCount = 0;
            }
            return;
        }// end function

        private function action(param1:Number) : void
        {
            if (_count > 10 && _count % 100 == 0)
            {
                _mc = this.motionSetting(_actionFlag);
                if (_actionFlag)
                {
                    this._trainingPlayer.setAnimationPattern(_mc);
                    this._trainingPlayer.mc.addChild(_mc);
                    _nowWeponType = this._trainingPlayer.info.weaponType;
                }
                else
                {
                    this._trainingEnemy.setAnimAttack();
                    _nowWeponType = this._trainingEnemyWeaponType;
                }
                _mc.gotoAndPlay(1);
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
                    this._trainingEnemy.setAnimDamage();
                }
                else
                {
                    this._trainingPlayer.setAnimDamage();
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
            if (_mc != null && _mc.currentFrameLabel == "bullet")
            {
                this.setBullet();
                _bulletFlag = true;
            }
            return;
        }// end function

        public function setBullet() : void
        {
            _aBullet = [];
            var _loc_1:* = ResourceManager.getInstance().createMovieClip(ResourcePath.SKILL_PATH + "Attack_Bow.swf", "bullet");
            var _loc_2:* = this.getStartPosition();
            var _loc_3:* = new Point(_baseMc.x + _baseMc.monsNull.x, _baseMc.y + _baseMc.monsNull.y + this._trainingEnemy.effectNull.y);
            var _loc_4:* = getSpeedVector(_loc_2, _loc_3, _SHOT_SPEED);
            var _loc_5:* = getHitTime(_loc_2, _loc_3, _SHOT_SPEED);
            var _loc_6:* = new SkillPartsArrow(_layer.getLayer(LayerTrainingRoom.BULLET), _loc_1, _loc_2, _loc_4);
            new SkillPartsArrow(_layer.getLayer(LayerTrainingRoom.BULLET), _loc_1, _loc_2, _loc_4).setHitMake(_loc_5);
            _aBullet.push(_loc_6);
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
                    _loc_4 = new Point(_baseMc.x + _baseMc.monsNull.x, _baseMc.y + _baseMc.monsNull.y + this._trainingEnemy.effectNull.y);
                    this._trainingEnemy.setAnimDamage();
                    _loc_5 = new EffectMc(_layer.getLayer(LayerTrainingRoom.EFFECT), ResourcePath.SKILL_PATH + "Attack_Bow.swf", _EFFECT_MC_HIT, _loc_4);
                    _effectManager.addEffect(_loc_5);
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
                var _loc_2:* = this;
                var _loc_3:* = this._enemyAttackCount + 1;
                _loc_2._enemyAttackCount = _loc_3;
                if (this._enemyAttackCount > ATTACK_NUMBER)
                {
                    this._trainingEnemy.setAnimationWithCallback(PlayerDisplay.LABEL_DEAD, function () : void
            {
                var _loc_1:* = new Point(0, -enemyHeight);
                _trainingEnemy.setTargetPoint(_loc_1, 0.001);
                var _loc_3:* = _enemyCount + 1;
                _enemyCount = _loc_3;
                return;
            }// end function
            );
                    this._trainingPlayer.setAnimationWithCallback(PlayerDisplay.LABEL_WIN, function () : void
            {
                _trainingPlayer.setAnimation(PlayerDisplay.LABEL_SIDE_WALK);
                return;
            }// end function
            );
                    this._enemyAttackCount = 0;
                    this.enemyPopFlag = false;
                    _actionFlag = true;
                }
                else
                {
                    this._trainingPlayer.setAnimSelected();
                    this._trainingEnemy.setAnimBattleWait();
                    _actionFlag = false;
                }
            }
            else
            {
                this._trainingPlayer.setAnimSelected();
                this._trainingEnemy.setAnimBattleWait();
                _actionFlag = true;
            }
            _mc = null;
            return;
        }// end function

        public function motionSetting(param1:Boolean) : MovieClip
        {
            var _loc_2:* = 0;
            if (param1)
            {
                _loc_2 = this._trainingPlayer.info.weaponType;
            }
            else
            {
                _loc_2 = this._trainingEnemyWeaponType;
            }
            return montinSettings(_loc_2);
        }// end function

        public function weponEffect(param1:Boolean) : EffectMc
        {
            var _loc_2:* = null;
            if (param1)
            {
                _loc_2 = new Point(_baseMc.x + _baseMc.monsNull.x, _baseMc.y + _baseMc.monsNull.y + this._trainingEnemy.effectNull.y);
            }
            else
            {
                _loc_2 = new Point(_baseMc.x + _baseMc.charaNull2.x, _baseMc.y + _baseMc.charaNull2.y + this._trainingPlayer.effectNull.y);
            }
            return setEffect(_nowWeponType, _loc_2, param1);
        }// end function

        protected function getStartPosition() : Point
        {
            var _loc_1:* = _mc.bulletStartNullMc;
            var _loc_2:* = new Point(_baseMc.x + _baseMc.monsNull.x, _baseMc.y + _baseMc.monsNull.y + this._trainingPlayer.effectNull.y);
            var _loc_3:* = _loc_2;
            return new Point(_loc_3.x + _loc_1.x, _loc_3.y + _loc_1.y);
        }// end function

        private function shuffleIdxArray(param1:int) : Array
        {
            var _loc_5:* = 0;
            var _loc_2:* = new Array();
            var _loc_3:* = new Array();
            var _loc_4:* = 0;
            while (_loc_4 < param1)
            {
                
                _loc_2.push(_loc_4);
                _loc_4++;
            }
            while (_loc_2.length > 0)
            {
                
                _loc_5 = Math.random() * _loc_2.length;
                _loc_3.push(_loc_2[_loc_5]);
                _loc_2.splice(_loc_5, 1);
            }
            return _loc_3;
        }// end function

    }
}
