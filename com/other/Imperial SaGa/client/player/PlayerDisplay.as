package player
{
    import character.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.geom.*;
    import layer.*;
    import resource.*;

    public class PlayerDisplay extends CharacterDisplayBase
    {
        private var _mcPattern:MovieClip;
        protected var _info:PlayerInformation;
        private var _filterSelect:GlowFilter;
        private var _aFilter:Array;
        private var _bMoveing:Boolean;
        private var _cbAnimCompleted:Function;
        private var _targetPos:Point;
        private var _startPos:Point;
        private var _targetVec:Point;
        protected var _waitTime:Number;
        protected var _time:Number;
        private var _jumpFrame:int;
        private var _landFrame:int;
        public static const LABEL_FRONT_STOP:String = "frontStop";
        public static const LABEL_FRONT_WALK:String = "frontWalk";
        public static const LABEL_SIDE_STOP:String = "sideStop";
        public static const LABEL_SIDE_WALK:String = "sideWark";
        public static const LABEL_BACK_STOP:String = "backStop";
        public static const LABEL_BACK_WALK:String = "backWark";
        public static const LABEL_SIDE_DASH:String = "sideDash";
        public static const LABEL_JUMP:String = "jump";
        public static const LABEL_WIN:String = "winJump";
        public static const LABEL_STATUS_UP:String = "winStatusUp";
        public static const LABEL_ACTION_SELECT_START:String = "actionSelectStart";
        public static const LABEL_ACTION_SELECT_MAGIC:String = "actionSelectMagic";
        public static const LABEL_ACTION_SELECT_END:String = "actionSelectEnd";
        public static const LABEL_ACTION_SELECT_END_MAGIC:String = "magicStop";
        public static const LABEL_ACTION_SELECT_END_GUARD:String = "guard";
        public static const LABEL_HIRAMEKI:String = "hirameki";
        public static const LABEL_ACTION_END:String = "sideStop";
        public static const LABEL_DAMAGE:String = "damage";
        public static const LABEL_DAMAGE_DEAD:String = "damageDead";
        public static const LABEL_DAMAGE_GUARD:String = "guardDamage";
        public static const LABEL_CROUCH:String = "crouchStop";
        public static const LABEL_DEAD:String = "dead";
        public static const LABEL_SIDE_DASH_FEVER:String = "sideDashCharge";
        public static const LABEL_SIDE_DASH_MERGE:String = "sideDashMerge";
        public static const LABEL_GUARD:String = "guard";
        public static const LABEL_LOST:String = "lost";
        public static const LABEL_MAGIC_STOP:String = "magicStop";
        public static const WIN_JUMP_WAIT:Number = 0.2;

        public function PlayerDisplay(param1:DisplayObjectContainer, param2:int, param3:int)
        {
            super(param1, param3);
            this._mcPattern = null;
            this._filterSelect = null;
            this._aFilter = [];
            this._cbAnimCompleted = null;
            this.createResource();
            super.createResourceAfter();
            this.setId(param2, _uniqueId);
            return;
        }// end function

        public function get info() : PlayerInformation
        {
            return this._info;
        }// end function

        override public function get type() : int
        {
            return CharacterDisplayBase.TYPE_PLAYER;
        }// end function

        override public function get effectNull() : MovieClip
        {
            return _mc.effectNull;
        }// end function

        override public function get faceNull() : MovieClip
        {
            return _mc.faceNull;
        }// end function

        public function get bMoveing() : Boolean
        {
            return this._bMoveing;
        }// end function

        protected function get labelJump() : String
        {
            return LABEL_JUMP;
        }// end function

        override public function release() : void
        {
            super.release();
            if (this._mcPattern)
            {
                if (this._mcPattern.parent)
                {
                    this._mcPattern.parent.removeChild(this._mcPattern);
                }
            }
            this._mcPattern = null;
            this._info = null;
            return;
        }// end function

        override public function control(param1:Number) : void
        {
            var _loc_2:* = NaN;
            var _loc_3:* = null;
            super.control(param1);
            if (_mc.currentLabel != this.labelJump)
            {
                if (this._bMoveing && this._targetPos != null)
                {
                    this._time = this._time + param1;
                    _loc_2 = this._time / this._waitTime;
                    pos = new Point(this._startPos.x + this._targetVec.x * _loc_2, this._startPos.y + this._targetVec.y * _loc_2);
                    if (this._time >= this._waitTime)
                    {
                        this._waitTime = 0;
                        this._time = 0;
                        pos = this._targetPos.clone();
                        this._targetPos = null;
                        this._startPos = null;
                        this._bMoveing = false;
                    }
                }
            }
            else if (_mc.currentLabel == this.labelJump)
            {
                if (this._bMoveing)
                {
                    _loc_3 = _mc.character;
                    if (this._targetPos != null)
                    {
                        if (_loc_3.currentLabel == "jump")
                        {
                            _loc_2 = (_loc_3.currentFrame - this._jumpFrame) / (this._landFrame - this._jumpFrame);
                            pos = new Point(this._startPos.x + this._targetVec.x * _loc_2, this._startPos.y + this._targetVec.y * _loc_2);
                        }
                        if (_loc_3.currentFrame >= this._landFrame)
                        {
                            pos = this._targetPos.clone();
                            this._targetPos = null;
                            this._startPos = null;
                        }
                    }
                    if (_loc_3.currentFrame >= _loc_3.totalFrames)
                    {
                        this._bMoveing = false;
                    }
                }
            }
            return;
        }// end function

        override public function setAnimation(param1:String) : void
        {
            super.setAnimation(param1);
            this.setCharacterPattern(_mc, this._mcPattern);
            this._cbAnimCompleted = null;
            return;
        }// end function

        public function setAnimationWithCallback(param1:String, param2:Function) : void
        {
            this.setAnimation(param1);
            this._cbAnimCompleted = param2;
            return;
        }// end function

        override public function setAnimStay() : void
        {
            this.setAnimation(LABEL_SIDE_STOP);
            return;
        }// end function

        override public function setAnimDamage() : void
        {
            this.setAnimation(LABEL_DAMAGE);
            return;
        }// end function

        override public function setAnimDamageLoop() : void
        {
            this.setAnimation(LABEL_DAMAGE);
            return;
        }// end function

        override public function setAnimDamageDead() : void
        {
            this.setAnimation(LABEL_DAMAGE_DEAD);
            return;
        }// end function

        override public function setAnimDamageGuard() : void
        {
            this.setAnimation(LABEL_DAMAGE_GUARD);
            return;
        }// end function

        override public function setAnimCrouch() : void
        {
            this.setAnimation(LABEL_CROUCH);
            return;
        }// end function

        override public function setAnimDead() : void
        {
            this.setAnimation(LABEL_DEAD);
            return;
        }// end function

        override public function setAnimBattleWait() : void
        {
            return;
        }// end function

        override public function setAnimSelect() : void
        {
            this.setAnimation(LABEL_ACTION_SELECT_START);
            return;
        }// end function

        override public function setAnimSelectMagic() : void
        {
            this.setAnimation(LABEL_ACTION_SELECT_MAGIC);
            return;
        }// end function

        override public function setAnimSelected() : void
        {
            this.setAnimation(LABEL_ACTION_SELECT_END);
            return;
        }// end function

        override public function setAnimSelectedMagic() : void
        {
            this.setAnimation(LABEL_ACTION_SELECT_END_MAGIC);
            return;
        }// end function

        override public function setAnimSelectedGuard() : void
        {
            this.setAnimation(LABEL_ACTION_SELECT_END_GUARD);
            return;
        }// end function

        override public function setAnimWin() : void
        {
            this.setAnimation(LABEL_WIN);
            return;
        }// end function

        override public function setAnimStatusUp() : void
        {
            this.setAnimation(LABEL_STATUS_UP);
            return;
        }// end function

        override public function setAnimSideDash() : void
        {
            this.setAnimation(LABEL_SIDE_DASH);
            return;
        }// end function

        override public function setAnimSideDashMerge() : void
        {
            this.setAnimation(LABEL_SIDE_DASH_MERGE);
            return;
        }// end function

        override public function setAnimLost() : void
        {
            this.setAnimation(LABEL_LOST);
            return;
        }// end function

        public function setAnimationPattern(param1:MovieClip) : void
        {
            _mc.character = param1;
            if (_mc.numChildren > 0)
            {
                _mc.removeChildAt(0);
            }
            this.setCharacterPattern(_mc, this._mcPattern);
            return;
        }// end function

        public function setCharacterAnimation(param1:String) : void
        {
            _mc.character.gotoAndPlay(param1);
            return;
        }// end function

        public function setPattern() : void
        {
            this.setCharacterPattern(_mc, this._mcPattern);
            return;
        }// end function

        public function setParent(param1:DisplayObjectContainer) : void
        {
            param1.addChild(_layer);
            return;
        }// end function

        public function removeParent() : void
        {
            if (_layer.parent)
            {
                _layer.parent.removeChild(_layer);
            }
            return;
        }// end function

        override public function getEffectNullMatrix() : Matrix
        {
            var _loc_1:* = new Matrix();
            var _loc_2:* = this.effectNull;
            var _loc_3:* = 0;
            while (_loc_3 < 2)
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

        override public function getfaceNullMatrix() : Matrix
        {
            var _loc_1:* = new Matrix();
            var _loc_2:* = this.faceNull;
            var _loc_3:* = 0;
            while (_loc_3 < 2)
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

        public function set dragMovePoint(param1:Point) : void
        {
            return;
        }// end function

        public function setSelect(param1:Boolean) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            if (param1)
            {
                if (this._filterSelect == null)
                {
                    this._filterSelect = new GlowFilter(65472, 1, 4, 4, 30);
                    this._aFilter.push(this._filterSelect);
                    _mc.filters = this._aFilter;
                }
            }
            else if (this._filterSelect != null)
            {
                _loc_2 = this._aFilter.length - 1;
                while (_loc_2 >= 0)
                {
                    
                    _loc_3 = this._aFilter[_loc_2];
                    if (_loc_3 == this._filterSelect)
                    {
                        this._aFilter.splice(_loc_2, 1);
                        _mc.filters = this._aFilter;
                        this._filterSelect = null;
                    }
                    _loc_2 = _loc_2 - 1;
                }
            }
            return;
        }// end function

        public function isSelect() : Boolean
        {
            return this._filterSelect != null;
        }// end function

        protected function createResource() : void
        {
            _mc = ResourceManager.getInstance().createMovieClip(ResourcePath.PLAYER_ANIM_PATH + "CharaAnim.swf", "CharacterMc");
            _layer.getLayer(LayerCharacter.CHARACTER).addChild(_mc);
            return;
        }// end function

        private function setCharacterPattern(param1:MovieClip, param2:MovieClip) : void
        {
            if (param2 == null)
            {
                return;
            }
            if (param1.character != null && param1.character.pattern01 != null && param2.pattern01 != null)
            {
                this.setPatternData(param1.character.pattern01, param2.pattern01);
            }
            if (param1.character != null && param1.character.pattern02 != null && param2.pattern02 != null)
            {
                this.setPatternData(param1.character.pattern02, param2.pattern02);
            }
            if (param1.character != null && param1.character.pattern03 != null && param2.pattern03 != null)
            {
                this.setPatternData(param1.character.pattern03, param2.pattern03);
            }
            if (param1.character != null && param1.character.pattern04 != null && param2.pattern04 != null)
            {
                this.setPatternData(param1.character.pattern04, param2.pattern04);
            }
            if (param1.character != null && param1.character.pattern05 != null && param2.pattern05 != null)
            {
                this.setPatternData(param1.character.pattern05, param2.pattern05);
            }
            if (param1.character != null && param1.character.pattern06 != null && param2.pattern06 != null)
            {
                this.setPatternData(param1.character.pattern06, param2.pattern06);
            }
            if (param1.character != null && param1.character.pattern07 != null && param2.pattern07 != null)
            {
                this.setPatternData(param1.character.pattern07, param2.pattern07);
            }
            if (param1.character != null && param1.character.pattern08 != null && param2.pattern08 != null)
            {
                this.setPatternData(param1.character.pattern08, param2.pattern08);
            }
            if (param1.character != null && param1.character.pattern09 != null && param2.pattern09 != null)
            {
                this.setPatternData(param1.character.pattern09, param2.pattern09);
            }
            if (param1.character != null && param1.character.pattern10 != null && param2.pattern10 != null)
            {
                this.setPatternData(param1.character.pattern10, param2.pattern10);
            }
            if (param1.character != null && param1.character.pattern11 != null && param2.pattern11 != null)
            {
                this.setPatternData(param1.character.pattern11, param2.pattern11);
            }
            if (param1.character != null && param1.character.pattern12 != null && param2.pattern12 != null)
            {
                this.setPatternData(param1.character.pattern12, param2.pattern12);
            }
            if (param1.character != null && param1.character.pattern13 != null && param2.pattern13 != null)
            {
                this.setPatternData(param1.character.pattern13, param2.pattern13);
            }
            if (param1.character != null && param1.character.pattern14 != null && param2.pattern14 != null)
            {
                this.setPatternData(param1.character.pattern14, param2.pattern14);
            }
            if (param1.character != null && param1.character.pattern15 != null && param2.pattern15 != null)
            {
                this.setPatternData(param1.character.pattern15, param2.pattern15);
            }
            if (param1.character != null && param1.character.pattern16 != null && param2.pattern16 != null)
            {
                this.setPatternData(param1.character.pattern16, param2.pattern16);
            }
            if (param1.character != null && param1.character.pattern17 != null && param2.pattern17 != null)
            {
                this.setPatternData(param1.character.pattern17, param2.pattern17);
            }
            if (param1.character != null && param1.character.pattern18 != null && param2.pattern18 != null)
            {
                this.setPatternData(param1.character.pattern18, param2.pattern18);
            }
            if (param1.character != null && param1.character.pattern19 != null && param2.pattern19 != null)
            {
                this.setPatternData(param1.character.pattern19, param2.pattern19);
            }
            if (param1.character != null && param1.character.pattern20 != null && param2.pattern20 != null)
            {
                this.setPatternData(param1.character.pattern20, param2.pattern20);
            }
            if (param1.character != null && param1.character.pattern21 != null && param2.pattern21 != null)
            {
                this.setPatternData(param1.character.pattern21, param2.pattern21);
            }
            if (param1.character != null && param1.character.pattern22 != null && param2.pattern22 != null)
            {
                this.setPatternData(param1.character.pattern22, param2.pattern22);
            }
            if (param1.character != null && param1.character.pattern23 != null && param2.pattern23 != null)
            {
                this.setPatternData(param1.character.pattern23, param2.pattern23);
            }
            return;
        }// end function

        private function setPatternData(param1:DisplayObjectContainer, param2:DisplayObjectContainer) : void
        {
            if (param1.numChildren > 0)
            {
                param1.removeChildren(0, (param1.numChildren - 1));
            }
            param1.addChild(param2);
            return;
        }// end function

        override public function setTargetPoint(param1:Point, param2:Number) : void
        {
            if (_mc.currentLabel == this.labelJump)
            {
                this.setTargetJump(param1);
                return;
            }
            this._targetPos = param1.clone();
            this._startPos = pos;
            this._targetVec = new Point(this._targetPos.x - this._startPos.x, this._targetPos.y - this._startPos.y);
            this._waitTime = param2;
            this._time = 0;
            this._bMoveing = true;
            return;
        }// end function

        public function setTargetJump(param1:Point) : void
        {
            var _loc_2:* = null;
            this._targetPos = param1.clone();
            this._startPos = pos;
            this._targetVec = new Point(this._targetPos.x - this._startPos.x, this._targetPos.y - this._startPos.y);
            this.setAnimation(this.labelJump);
            this._jumpFrame = 0;
            this._landFrame = 0;
            for each (_loc_2 in _mc.character.currentLabels)
            {
                
                if (_loc_2.name == "jump")
                {
                    this._jumpFrame = _loc_2.frame;
                }
                if (_loc_2.name == "land")
                {
                    this._landFrame = _loc_2.frame;
                }
            }
            this._bMoveing = true;
            return;
        }// end function

        override protected function cbEnterFrame(event:Event) : void
        {
            var _loc_2:* = null;
            if (_bAnimationEnd == false && _mc.character.currentFrame >= _mc.character.totalFrames)
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

        public function setId(param1:int, param2:int) : void
        {
            if (this._mcPattern)
            {
                if (this._mcPattern.parent)
                {
                    this._mcPattern.parent.removeChild(this._mcPattern);
                }
            }
            this._mcPattern = null;
            this._info = PlayerManager.getInstance().getPlayerInformation(param1);
            _mc.visible = false;
            if (this._info)
            {
                this._mcPattern = ResourceManager.getInstance().createMovieClip(ResourcePath.PLAYER_PATH + this._info.swf, "CharaPatternMc");
                _mc.visible = true;
            }
            this.setCharacterPattern(_mc, this._mcPattern);
            _uniqueId = param2;
            return;
        }// end function

        public static function getAnimResource() : String
        {
            return ResourcePath.PLAYER_ANIM_PATH + "CharaAnim.swf";
        }// end function

    }
}
