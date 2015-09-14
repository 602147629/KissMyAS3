package quest
{
    import flash.display.*;
    import flash.geom.*;
    import message.*;
    import user.*;

    public class QuestHistoryBar extends Object
    {
        private var _sprite:Sprite;
        private var _mc:MovieClip;
        private var _index:int;
        private var _autoScrollMax:Number;
        private var _startPos:Point;
        private var _targetPos:Point;
        private var _targetVec:Point;
        private var _bRemove:Boolean;
        private var _bMoveing:Boolean;
        public static const NORMAL:String = "normal";
        public static const TARGET:String = "hiLights";

        public function QuestHistoryBar(param1:Sprite, param2:MovieClip, param3:int, param4:Number)
        {
            this._sprite = param1;
            this._mc = param2;
            this._index = param3;
            this._autoScrollMax = param4;
            this._sprite.addChild(this._mc);
            this._targetPos = null;
            this._targetVec = null;
            this._bMoveing = false;
            this._bRemove = false;
            return;
        }// end function

        public function release() : void
        {
            if (this._mc && this._mc.parent != null)
            {
                this._mc.parent.removeChild(this._mc);
            }
            this._mc = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            var _loc_2:* = false;
            var _loc_3:* = false;
            if (this._bMoveing == true && this._targetPos != null)
            {
                _loc_2 = true;
                _loc_3 = true;
                this.setPos(new Point(this._mc.x + this._targetVec.x, this._mc.y + this._targetVec.y));
                if (this._targetVec.x > 0)
                {
                    if (this._mc.x < this._targetPos.x)
                    {
                        _loc_2 = false;
                    }
                }
                else if (this._mc.x > this._targetPos.x)
                {
                    _loc_2 = false;
                }
                if (this._targetVec.y > 0)
                {
                    if (this._mc.y < this._targetPos.y)
                    {
                        _loc_3 = false;
                    }
                }
                else if (this._mc.y > this._targetPos.y)
                {
                    _loc_3 = false;
                }
                if (_loc_2 == true && _loc_3 == true)
                {
                    this._mc.x = this._targetPos.x;
                    this._mc.y = this._targetPos.y;
                    this._bMoveing = false;
                    this._startPos = null;
                    this._targetPos = null;
                }
            }
            if (this._mc != null && this._mc.parent != null && this._mc.visible == true && this._bRemove == false)
            {
                if (this._mc.y + this._mc.parent.y < this._autoScrollMax)
                {
                    this._bRemove = true;
                }
            }
            return;
        }// end function

        public function setMoveing(param1:Boolean) : void
        {
            this._bMoveing = param1;
            return;
        }// end function

        public function setPos(param1:Point) : void
        {
            if (this._mc != null)
            {
                this._mc.x = param1.x;
                this._mc.y = param1.y;
            }
            return;
        }// end function

        public function setTargetPos(param1:Point) : void
        {
            this._startPos = new Point(this._mc.x, this._mc.y);
            this._targetPos = param1.clone();
            var _loc_2:* = QuestConstant.HISTORY_FADE_SPEED;
            if (this._startPos.x > this._targetPos.x)
            {
                _loc_2 = _loc_2 * -1;
            }
            this._targetVec = new Point(_loc_2, 0);
            return;
        }// end function

        public function setHistoryData(param1:QuestHistoryData) : void
        {
            TextControl.setAgYearText(this._mc.questEra, this._mc.questYear, QuestManager.getYear(UserDataManager.getInstance().userData.chapter, param1.year));
            TextControl.setText(this._mc.questNameMc.textDt, param1.questTitle);
            var _loc_2:* = QuestManager.questRankLabel(param1.totalComplete);
            this._mc.resultRankMc.gotoAndStop(_loc_2);
            return;
        }// end function

        public function invisible() : void
        {
            this._mc.visible = false;
            return;
        }// end function

        public function setLabel(param1:String) : void
        {
            this._mc.gotoAndStop(param1);
            return;
        }// end function

        public function addParent() : void
        {
            if (this._mc != null && this._mc.parent == null)
            {
                this._sprite.addChild(this._mc);
            }
            return;
        }// end function

        public function removeParent() : void
        {
            if (this._mc != null && this._mc.parent != null)
            {
                this._mc.parent.removeChild(this._mc);
            }
            return;
        }// end function

        public function get index() : int
        {
            return this._index;
        }// end function

        public function get bRemove() : Boolean
        {
            return this._bRemove;
        }// end function

        public function get bMoveing() : Boolean
        {
            return this._bMoveing;
        }// end function

        public function get bVisible() : Boolean
        {
            return this._mc.visible;
        }// end function

        public function get pos() : Point
        {
            return new Point(this._mc.x, this._mc.y);
        }// end function

        public function get width() : Number
        {
            return this._mc.width;
        }// end function

    }
}
