package ending
{
    import button.*;
    import flash.display.*;

    public class EndingChronologyScrollBar extends Object
    {
        private var _baseMc:MovieClip;
        private var _pointerMc:MovieClip;
        private var _aButton:Array;
        private var _referPoint:int;
        private var _guideHeight:int;
        private var _aChapterIndex:Array;
        private var _currentChapter:int;
        private var _currentNum:int;
        private var _maxNum:int;
        private var _bButtonEnable:Boolean;

        public function EndingChronologyScrollBar(param1:MovieClip)
        {
            this._baseMc = param1;
            var _loc_2:* = this._baseMc.barGuid;
            this._pointerMc = this._baseMc.barMc;
            var _loc_3:* = _loc_2.y + _loc_2.height - this._pointerMc.y;
            this._referPoint = _loc_2.y + _loc_3;
            this._guideHeight = this._pointerMc.y - this._referPoint;
            this._aChapterIndex = [];
            this.createButton();
            return;
        }// end function

        public function get currentNum() : int
        {
            return this._currentNum;
        }// end function

        public function get maxNum() : int
        {
            return this._maxNum;
        }// end function

        private function createButton() : void
        {
            var _loc_2:* = null;
            this._aButton = [];
            var _loc_1:* = [{mc:this._baseMc.upBtn2, callback:this.cbUpButton2}, {mc:this._baseMc.upBtn, callback:this.cbUpButton}, {mc:this._baseMc.downBtn, callback:this.cbDownButton}, {mc:this._baseMc.downBtn2, callback:this.cbDownButton2}];
            for each (_loc_2 in _loc_1)
            {
                
                this._aButton.push(ButtonManager.getInstance().addButton(_loc_2.mc, _loc_2.callback));
            }
            this._bButtonEnable = true;
            return;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            if (this._aButton)
            {
                for each (_loc_1 in this._aButton)
                {
                    
                    ButtonManager.getInstance().removeButton(_loc_1);
                }
            }
            return;
        }// end function

        public function setItemNum(param1:int, param2:int = -1) : void
        {
            this._maxNum = param1;
            this._currentNum = (param2 + param1 + 1) % (param1 + 1);
            var _loc_3:* = 0;
            while (_loc_3 < this._aChapterIndex.length)
            {
                
                if (this._currentNum >= this._aChapterIndex[_loc_3])
                {
                    this._currentChapter = _loc_3;
                }
                _loc_3++;
            }
            return;
        }// end function

        public function setChapterIndex(param1:Array) : void
        {
            this._aChapterIndex = param1;
            return;
        }// end function

        public function updateView(param1:Number) : void
        {
            this._pointerMc.y = this._referPoint + this._guideHeight * param1;
            return;
        }// end function

        public function setVisible(param1:Boolean) : void
        {
            this._baseMc.visible = param1;
            this.setButtonEnable(param1);
            return;
        }// end function

        public function setButtonEnable(param1:Boolean) : void
        {
            var _loc_2:* = null;
            if (this._bButtonEnable != param1)
            {
                this._bButtonEnable = param1;
                for each (_loc_2 in this._aButton)
                {
                    
                    _loc_2.setDisable(!param1);
                }
            }
            return;
        }// end function

        private function cbUpButton2(param1:int) : void
        {
            if (this._currentChapter > 0)
            {
                var _loc_2:* = this;
                var _loc_3:* = this._currentChapter - 1;
                _loc_2._currentChapter = _loc_3;
                this._currentNum = this._aChapterIndex[this._currentChapter];
            }
            return;
        }// end function

        private function cbUpButton(param1:int) : void
        {
            if (this._currentNum > 0)
            {
                var _loc_2:* = this;
                var _loc_3:* = this._currentNum - 1;
                _loc_2._currentNum = _loc_3;
                if (this._currentNum < this._aChapterIndex[this._currentChapter])
                {
                    var _loc_2:* = this;
                    var _loc_3:* = this._currentChapter - 1;
                    _loc_2._currentChapter = _loc_3;
                }
            }
            return;
        }// end function

        private function cbDownButton(param1:int) : void
        {
            if (this._currentNum < this._maxNum)
            {
                var _loc_2:* = this;
                var _loc_3:* = this._currentNum + 1;
                _loc_2._currentNum = _loc_3;
                if (this._currentChapter < this._aChapterIndex.length - 2 && this._currentNum >= this._aChapterIndex[(this._currentChapter + 1)])
                {
                    var _loc_2:* = this;
                    var _loc_3:* = this._currentChapter + 1;
                    _loc_2._currentChapter = _loc_3;
                }
            }
            return;
        }// end function

        private function cbDownButton2(param1:int) : void
        {
            if (this._currentChapter < (this._aChapterIndex.length - 1))
            {
                var _loc_2:* = this;
                var _loc_3:* = this._currentChapter + 1;
                _loc_2._currentChapter = _loc_3;
                this._currentNum = this._aChapterIndex[this._currentChapter];
            }
            return;
        }// end function

    }
}
