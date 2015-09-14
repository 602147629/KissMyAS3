package makeEquip
{
    import button.*;
    import flash.display.*;
    import resource.*;
    import utility.*;

    public class MakeEquipBase extends Object
    {
        public var _mc:MovieClip;
        protected var _isoMain:InStayOut;
        protected var _aButton:Array;

        public function MakeEquipBase(param1:DisplayObjectContainer, param2:String, param3:Boolean)
        {
            this._aButton = [];
            this._mc = ResourceManager.getInstance().createMovieClip(MakeEquipConstant.RESOURCE_PATH, param2);
            this._isoMain = new InStayOut(this._mc);
            param1.addChild(this._mc);
            if (param3)
            {
                this._isoMain.setIn(this.cbMainIn);
            }
            return;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._isoMain.bEnd;
        }// end function

        protected function cbMainIn() : void
        {
            return;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aButton)
            {
                
                ButtonManager.getInstance().removeButton(_loc_1);
            }
            this._aButton = [];
            if (this._isoMain)
            {
                this._isoMain.release();
            }
            this._isoMain = null;
            if (this._mc != null && this._mc.parent != null)
            {
                this._mc.parent.removeChild(this._mc);
            }
            this._mc = null;
            return;
        }// end function

        public function open() : void
        {
            this._isoMain.setIn(this.cbMainIn);
            return;
        }// end function

        public function setButtonDisable(param1:Boolean) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (param1)
            {
                for each (_loc_2 in this._aButton)
                {
                    
                    _loc_2.setDisable(true);
                }
            }
            if (!param1)
            {
                for each (_loc_3 in this._aButton)
                {
                    
                    _loc_3.setDisable(false);
                }
            }
            return;
        }// end function

        public function buttonNotIdPress(param1:int) : void
        {
            var _loc_2:* = 0;
            while (_loc_2 < this._aButton.length)
            {
                
                if (_loc_2 != param1)
                {
                    this._aButton[_loc_2].setDisable(true);
                }
                _loc_2++;
            }
            return;
        }// end function

        public function buttonSeal(param1:Boolean) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aButton)
            {
                
                if (param1)
                {
                    _loc_2.seal(true);
                    continue;
                }
                _loc_2.unseal(true);
            }
            return;
        }// end function

        public function close() : void
        {
            this.setButtonDisable(true);
            this._isoMain.setOut();
            return;
        }// end function

    }
}
