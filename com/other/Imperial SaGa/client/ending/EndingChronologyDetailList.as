package ending
{
    import flash.display.*;

    public class EndingChronologyDetailList extends Object
    {
        private var _displaySprite:Sprite;
        private var _scrollBar:EndingChronologyScrollBar;
        private const _DETAIL_HEIGHT:int = 96;
        private var _speed:int;
        private var _referPos:int;
        private var _bScrollable:Boolean;
        private var _aChrolonogy:Array;
        private var _bMoving:Boolean;

        public function EndingChronologyDetailList(param1:DisplayObjectContainer, param2:MovieClip, param3:int, param4:Array)
        {
            var _loc_8:* = null;
            this._displaySprite = new Sprite();
            param1.addChild(this._displaySprite);
            this._scrollBar = new EndingChronologyScrollBar(param2);
            this._referPos = param3;
            this._bMoving = false;
            this._bScrollable = false;
            this._displaySprite.removeChildren();
            var _loc_5:* = 0;
            var _loc_6:* = [];
            var _loc_7:* = 0;
            while (_loc_7 < param4.length)
            {
                
                _loc_8 = new EndingChronologyDetail(this._displaySprite);
                _loc_8.setQuestData(param4[_loc_7]);
                _loc_8.setPosition(0, this._DETAIL_HEIGHT * _loc_7);
                if (param4[_loc_7].chapter != _loc_5)
                {
                    _loc_6.push(_loc_7);
                    _loc_5 = param4[_loc_7].chapter;
                }
                _loc_7++;
            }
            this._scrollBar.setChapterIndex(_loc_6);
            this._scrollBar.setItemNum(param4.length - 2);
            this._aChrolonogy = param4;
            return;
        }// end function

        public function get bMoving() : Boolean
        {
            return this._bMoving;
        }// end function

        public function release() : void
        {
            this._displaySprite.removeChildren();
            if (this._displaySprite.parent)
            {
                this._displaySprite.parent.removeChild(this._displaySprite);
            }
            if (this._scrollBar)
            {
                this._scrollBar.release();
            }
            return;
        }// end function

        public function control(param1:Number) : void
        {
            if (this._bScrollable == false)
            {
                return;
            }
            var _loc_2:* = this.getLastPos();
            if (this._displaySprite.y != _loc_2)
            {
                this._displaySprite.y = this._displaySprite.y + (this._displaySprite.y < _loc_2 ? (this._speed) : (-this._speed));
                if (Math.abs(this._displaySprite.y - _loc_2) < this._speed)
                {
                    this._displaySprite.y = _loc_2;
                }
            }
            this._bMoving = this._displaySprite.y != _loc_2;
            this._scrollBar.setButtonEnable(!this._bMoving);
            this._scrollBar.updateView(Math.abs(this._displaySprite.y - this._referPos) / (this._scrollBar.maxNum * this._DETAIL_HEIGHT));
            return;
        }// end function

        public function setQuestHistory(param1:Array) : void
        {
            var _loc_3:* = null;
            this._displaySprite.removeChildren();
            var _loc_2:* = 0;
            while (_loc_2 < param1.length)
            {
                
                _loc_3 = new EndingChronologyDetail(this._displaySprite);
                _loc_3.setQuestData(param1[_loc_2]);
                _loc_3.setPosition(0, this._DETAIL_HEIGHT * _loc_2);
                _loc_2++;
            }
            this._scrollBar.setItemNum(param1.length - 2);
            return;
        }// end function

        public function getLastPos() : Number
        {
            var _loc_1:* = this._scrollBar.currentNum * (-this._DETAIL_HEIGHT) + this._referPos;
            return _loc_1;
        }// end function

        public function setPos(param1:int) : void
        {
            this._displaySprite.y = param1;
            return;
        }// end function

        public function setScrollable(param1:Boolean) : void
        {
            this._bScrollable = param1;
            return;
        }// end function

        public function setSpeed(param1:int) : void
        {
            if (param1 > 0)
            {
                this._speed = param1;
            }
            return;
        }// end function

        public function setScrollBarVisible(param1:Boolean) : void
        {
            this._scrollBar.setVisible(param1);
            return;
        }// end function

        public function getPointedChapter() : int
        {
            var _loc_1:* = this._aChrolonogy[this._scrollBar.currentNum];
            if (_loc_1)
            {
                return _loc_1.chapter;
            }
            return Constant.UNDECIDED;
        }// end function

        public function getPositionChapter() : int
        {
            if (this._displaySprite.y - this._referPos > 0)
            {
                return Constant.UNDECIDED;
            }
            var _loc_1:* = Math.abs(this._displaySprite.y - this._referPos) / this._DETAIL_HEIGHT;
            var _loc_2:* = this._aChrolonogy[_loc_1];
            if (_loc_2)
            {
                return _loc_2.chapter;
            }
            return Constant.UNDECIDED;
        }// end function

    }
}
