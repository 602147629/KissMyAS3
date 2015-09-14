package enemy
{
    import character.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import layer.*;
    import resource.*;

    public class EnemyDisplay extends CharacterDisplayBase
    {
        private var _info:EnemyInformation;
        protected var _labelAnim:String;
        protected var _OldLabelAnim:String;
        protected var _bLabelAnimChange:Boolean;
        protected var _labelAnimDetail:String;
        protected var _OldLabelAnimDetail:String;
        protected var _bLabelAnimDetailChange:Boolean;
        private var _bMoveing:Boolean;
        private var _cbAnimCompleted:Function;
        private var _targetPos:Point;
        private var _startPos:Point;
        private var _targetVec:Point;
        protected var _waitTimeMove:Number;
        protected var _time:Number;
        static const _LABEL_STAY:String = "stay";
        static const _LABEL_ATTACK:String = "attack";
        static const _LABEL_DAMAGE:String = "damage";
        static const _LABEL_DAMAGE_LOOP:String = "damage2";
        static const _LABEL_DEAD:String = "dead";
        static const _LABEL_MAGIC:String = "magic";
        static const _LABEL_DAMAGE_LOOP_RELEASE:String = "loopOut";
        static const _LABEL_CHANGE_OUT:String = "change_in";
        static const _LABEL_CHANGE_IN:String = "change_out";

        public function EnemyDisplay(param1:DisplayObjectContainer, param2:int, param3:int)
        {
            this._cbAnimCompleted = null;
            this._labelAnim = "";
            this._OldLabelAnim = this._labelAnim;
            this._bLabelAnimChange = false;
            this._labelAnimDetail = "";
            this._OldLabelAnimDetail = this._labelAnimDetail;
            this._bLabelAnimDetailChange = false;
            super(param1, param3);
            this._info = EnemyManager.getInstance().getEnemyInformation(param2);
            this.createResource();
            super.createResourceAfter();
            return;
        }// end function

        override public function get effectNull() : MovieClip
        {
            return _mc.effectNull;
        }// end function

        override public function get faceNull() : MovieClip
        {
            return _mc.faceNull;
        }// end function

        override public function get bulletStartNullMc() : MovieClip
        {
            return _mc.bulletStartNullMc;
        }// end function

        override public function get type() : int
        {
            return CharacterDisplayBase.TYPE_ENEMY;
        }// end function

        public function get info() : EnemyInformation
        {
            return this._info;
        }// end function

        public function get bMoveing() : Boolean
        {
            return this._bMoveing;
        }// end function

        override public function release() : void
        {
            super.release();
            this._info = null;
            return;
        }// end function

        override public function control(param1:Number) : void
        {
            var _loc_2:* = NaN;
            super.control(param1);
            if (this._bMoveing && this._targetPos != null)
            {
                this._time = this._time + param1;
                _loc_2 = this._time / this._waitTimeMove;
                pos = new Point(this._startPos.x + this._targetVec.x * _loc_2, this._startPos.y + this._targetVec.y * _loc_2);
                if (this._time >= this._waitTimeMove)
                {
                    this._waitTimeMove = 0;
                    this._time = 0;
                    pos = this._targetPos.clone();
                    this._targetPos = null;
                    this._startPos = null;
                    this._bMoveing = false;
                }
            }
            this._labelAnim = _mc.currentLabel;
            this._labelAnimDetail = _mc.monster.currentLabel;
            if (this._labelAnimDetail == null)
            {
                this._labelAnimDetail = "";
            }
            if (this._OldLabelAnim != this._labelAnim)
            {
                this._bLabelAnimChange = true;
            }
            if (this._OldLabelAnimDetail != this._labelAnimDetail)
            {
                this._bLabelAnimDetailChange = true;
            }
            this.controlAnim(param1);
            this._OldLabelAnim = this._labelAnim;
            this._OldLabelAnimDetail = this._labelAnimDetail;
            this._bLabelAnimChange = false;
            this._bLabelAnimDetailChange = false;
            return;
        }// end function

        protected function controlAnim(param1:Number) : void
        {
            return;
        }// end function

        override public function setAnimation(param1:String) : void
        {
            super.setAnimation(param1);
            this._OldLabelAnim = "";
            this._OldLabelAnimDetail = "";
            this._cbAnimCompleted = null;
            return;
        }// end function

        public function setAnimationWithCallback(param1:String, param2:Function) : void
        {
            this.setAnimation(param1);
            this._cbAnimCompleted = param2;
            return;
        }// end function

        override public function getEffectNullMatrix() : Matrix
        {
            var _loc_1:* = _mc.transform.concatenatedMatrix.clone();
            _loc_1.invert();
            var _loc_2:* = this.effectNull.transform.concatenatedMatrix.clone();
            _loc_2.concat(_loc_1);
            return _loc_2;
        }// end function

        override public function getfaceNullMatrix() : Matrix
        {
            var _loc_1:* = _mc.transform.concatenatedMatrix.clone();
            _loc_1.invert();
            var _loc_2:* = this.faceNull.transform.concatenatedMatrix.clone();
            _loc_2.concat(_loc_1);
            return _loc_2;
        }// end function

        override public function getbulletStartNullMcMatrix() : Matrix
        {
            var _loc_1:* = new Matrix();
            var _loc_2:* = this.bulletStartNullMc;
            var _loc_3:* = 0;
            while (_loc_3 < 3)
            {
                
                if (_loc_2 != null)
                {
                    _loc_1.concat(_loc_2.transform.matrix);
                    _loc_2 = _loc_2.parent;
                }
                _loc_3++;
            }
            return _loc_1;
        }// end function

        private function createResource() : void
        {
            _mc = ResourceManager.getInstance().createMovieClip(ResourcePath.ENEMY_PATH + this.info.swf, "MonsterMc");
            _layer.getLayer(LayerCharacter.CHARACTER).addChild(_mc);
            return;
        }// end function

        override protected function cbEnterFrame(event:Event) : void
        {
            var _loc_2:* = null;
            if (_bAnimationEnd == false && _mc.monster.currentFrame >= _mc.monster.totalFrames)
            {
                _bAnimationEnd = true;
                if (this._cbAnimCompleted != null)
                {
                    _loc_2 = this._cbAnimCompleted;
                    this._cbAnimCompleted = null;
                    _loc_2.call(this);
                }
            }
            return;
        }// end function

        public function chnge(param1:int) : void
        {
            this._info = EnemyManager.getInstance().getEnemyInformation(param1);
            return;
        }// end function

        override public function setTargetPoint(param1:Point, param2:Number) : void
        {
            this._targetPos = param1.clone();
            this._startPos = pos;
            this._targetVec = new Point(this._targetPos.x - this._startPos.x, this._targetPos.y - this._startPos.y);
            this._waitTimeMove = param2;
            this._time = 0;
            this._bMoveing = true;
            return;
        }// end function

        override public function setAnimStay() : void
        {
            this.setAnimation(_LABEL_STAY);
            return;
        }// end function

        override public function setAnimDamage() : void
        {
            this.setAnimation(_LABEL_DAMAGE);
            return;
        }// end function

        override public function setAnimDamageLoop() : void
        {
            this.setAnimation(_LABEL_DAMAGE_LOOP);
            return;
        }// end function

        override public function setAnimDamageLoopRelease() : void
        {
            if (_mc.currentLabel == _LABEL_DAMAGE_LOOP)
            {
                if (_mc.monster)
                {
                    _mc.monster.gotoAndPlay(_LABEL_DAMAGE_LOOP_RELEASE);
                }
            }
            return;
        }// end function

        override public function setAnimDamageDead() : void
        {
            this.setAnimation(_LABEL_DAMAGE);
            return;
        }// end function

        override public function setAnimDead() : void
        {
            this.setAnimation(_LABEL_DEAD);
            return;
        }// end function

        override public function setAnimBattleWait() : void
        {
            this.setAnimation(_LABEL_STAY);
            return;
        }// end function

        override public function setAnimAttack() : void
        {
            this.setAnimation(_LABEL_ATTACK);
            return;
        }// end function

        override public function setAnimMagic() : void
        {
            this.setAnimation(_LABEL_MAGIC);
            return;
        }// end function

        public function setAnimMetamorphoseOut() : void
        {
            return;
        }// end function

        public function setAnimMetamorphoseIn() : void
        {
            return;
        }// end function

    }
}
