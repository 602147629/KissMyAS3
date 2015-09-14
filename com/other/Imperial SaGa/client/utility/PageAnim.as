package utility
{
    import flash.display.*;
    import flash.events.*;

    public class PageAnim extends Object
    {
        private var _mc:MovieClip;
        private var _cbPageChange:Function;
        private var _cbAnimEnd:Function;
        private var _nextPageIndex:int;
        private var _bScroll:Boolean;
        private static const _LABEL_PAGE_STAY:String = "inStay";
        private static const _LABEL_PAGE_LEFT_OUT:String = "leftOut";
        private static const _LABEL_PAGE_LEFT_OUT_END:String = "leftOutEnd";
        private static const _LABEL_PAGE_LEFT_IN:String = "leftIn";
        private static const _LABEL_PAGE_LEFT_IN_END:String = "leftInEnd";
        private static const _LABEL_PAGE_RIGHT_OUT:String = "rhigtOut";
        private static const _LABEL_PAGE_RIGHT_OUT_END:String = "rhigtOutEnd";
        private static const _LABEL_PAGE_RIGHT_IN:String = "rightIn";
        private static const _LABEL_PAGE_RIGHT_IN_END:String = "rightInEnd";

        public function PageAnim(param1:MovieClip, param2:Function, param3:Function)
        {
            this._mc = param1;
            this._mc.gotoAndStop(_LABEL_PAGE_STAY);
            this._mc.addEventListener(Event.ENTER_FRAME, this.enterFrame);
            this._cbPageChange = param2;
            this._cbAnimEnd = param3;
            this._nextPageIndex = Constant.UNDECIDED;
            this._bScroll = false;
            return;
        }// end function

        public function release() : void
        {
            this._mc.removeEventListener(Event.ENTER_FRAME, this.enterFrame);
            this._cbAnimEnd = null;
            this._cbPageChange = null;
            this._mc = null;
            return;
        }// end function

        private function enterFrame(event:Event) : void
        {
            if (this._bScroll == false)
            {
                return;
            }
            switch(this._mc.currentLabel)
            {
                case _LABEL_PAGE_LEFT_OUT_END:
                {
                    this._mc.gotoAndPlay(_LABEL_PAGE_LEFT_IN);
                    if (this._cbPageChange != null)
                    {
                        this._cbPageChange(this._nextPageIndex);
                    }
                    break;
                }
                case _LABEL_PAGE_RIGHT_OUT_END:
                {
                    this._mc.gotoAndPlay(_LABEL_PAGE_RIGHT_IN);
                    if (this._cbPageChange != null)
                    {
                        this._cbPageChange(this._nextPageIndex);
                    }
                    break;
                }
                case _LABEL_PAGE_RIGHT_IN_END:
                case _LABEL_PAGE_LEFT_IN_END:
                {
                    this._mc.gotoAndPlay(_LABEL_PAGE_STAY);
                    this._bScroll = false;
                    this._nextPageIndex = Constant.UNDECIDED;
                    if (this._cbAnimEnd != null)
                    {
                        this._cbAnimEnd();
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function stop() : void
        {
            this._bScroll = false;
            this._nextPageIndex = Constant.UNDECIDED;
            return;
        }// end function

        public function setLeft(param1:int) : void
        {
            this._nextPageIndex = param1;
            this._bScroll = true;
            this._mc.gotoAndPlay(_LABEL_PAGE_LEFT_OUT);
            return;
        }// end function

        public function setRight(param1:int) : void
        {
            this._nextPageIndex = param1;
            this._bScroll = true;
            this._mc.gotoAndPlay(_LABEL_PAGE_RIGHT_OUT);
            return;
        }// end function

        public function setStay() : void
        {
            this._nextPageIndex = Constant.UNDECIDED;
            this._bScroll = false;
            this._mc.gotoAndStop(_LABEL_PAGE_STAY);
            return;
        }// end function

    }
}
