package storage
{
    import button.*;
    import flash.display.*;
    import flash.events.*;
    import message.*;

    public class StorageFilterButton extends Object
    {
        private const _FILTER_FRAME_OFF:int = 1;
        private const _FILTER_FRAME_ON:int = 2;
        private var _mc:MovieClip;
        private var _onButton:ButtonBase;
        private var _offButton:ButtonBase;
        private var _callback:Function;
        private var _filterId:int;

        public function StorageFilterButton(param1:MovieClip, param2:int, param3:int, param4:Function)
        {
            this._mc = param1;
            this._filterId = param2;
            this._callback = param4;
            this.init(param3);
            return;
        }// end function

        public function release() : void
        {
            if (this._onButton)
            {
                ButtonManager.getInstance().removeButton(this._onButton);
                this._onButton.release();
            }
            this._onButton = null;
            if (this._offButton)
            {
                ButtonManager.getInstance().removeButton(this._offButton);
                this._offButton.release();
            }
            this._offButton = null;
            this._mc.removeEventListener(MouseEvent.CLICK, this.cbClickHandler);
            this._mc.removeEventListener(MouseEvent.MOUSE_OVER, this.cbOverHandler);
            this._mc.removeEventListener(MouseEvent.MOUSE_OUT, this.cbOutHandler);
            this._mc = null;
            return;
        }// end function

        private function init(param1:int) : void
        {
            this._offButton = ButtonManager.getInstance().addButton(this._mc.filterOffBtnMc, null);
            this._offButton.enterSeId = ButtonBase.SE_CURSOR_ID;
            TextControl.setIdText(this._mc.filterOffBtnMc.textMc.textDt, param1);
            this._onButton = ButtonManager.getInstance().addButton(this._mc.filterOnBtnMc, null);
            this._onButton.enterSeId = ButtonBase.SE_CURSOR_ID;
            TextControl.setIdText(this._mc.filterOnBtnMc.textMc.textDt, param1);
            this._mc.addEventListener(MouseEvent.CLICK, this.cbClickHandler);
            this._mc.addEventListener(MouseEvent.MOUSE_OVER, this.cbOverHandler);
            this._mc.addEventListener(MouseEvent.MOUSE_OUT, this.cbOutHandler);
            return;
        }// end function

        public function setButtonEnable(param1:Boolean) : void
        {
            this._offButton.setDisable(!param1);
            this._onButton.setDisable(!param1);
            if (param1 == true)
            {
                if (this._mc.hasEventListener(MouseEvent.MOUSE_OVER) == false)
                {
                    this._mc.addEventListener(MouseEvent.MOUSE_OVER, this.cbOverHandler);
                }
                if (this._mc.hasEventListener(MouseEvent.MOUSE_OUT) == false)
                {
                    this._mc.addEventListener(MouseEvent.MOUSE_OUT, this.cbOutHandler);
                }
            }
            if (param1 == false)
            {
                if (this._mc.hasEventListener(MouseEvent.MOUSE_OVER))
                {
                    this._mc.removeEventListener(MouseEvent.MOUSE_OVER, this.cbOverHandler);
                }
                if (this._mc.hasEventListener(MouseEvent.MOUSE_OUT))
                {
                    this._mc.removeEventListener(MouseEvent.MOUSE_OUT, this.cbOutHandler);
                }
            }
            return;
        }// end function

        public function setButtonState(param1:int) : void
        {
            this._mc.gotoAndStop(param1 == this._filterId ? (this._FILTER_FRAME_ON) : (this._FILTER_FRAME_OFF));
            this._onButton.setVisible(param1 == this._filterId);
            return;
        }// end function

        private function cbClickHandler(event:MouseEvent) : void
        {
            if (this._callback != null)
            {
                this._callback(this._filterId);
            }
            return;
        }// end function

        private function cbOverHandler(event:MouseEvent) : void
        {
            this._offButton._mc.gotoAndStop("onMouse");
            return;
        }// end function

        private function cbOutHandler(event:MouseEvent) : void
        {
            this._offButton._mc.gotoAndStop("offMouse");
            return;
        }// end function

    }
}
