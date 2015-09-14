package window
{
    import flash.display.*;
    import flash.geom.*;

    public class WindowBase extends Sprite
    {
        protected var _baseMc:MovieClip;
        protected var _cbWindowClose:Function;
        private var _phase:int = 0;
        protected var _windowStyle:WindowStyle;
        protected var _size:Point;
        protected var _dispPoint:Point;
        protected var _aItem:Array;
        protected var _bEnd:Boolean;
        private static const PHASE_NONE:int = 0;
        private static const PHASE_OPEN:int = 1;
        private static const PHASE_EXEC:int = 2;
        private static const PHASE_CLOSE:int = 3;
        private static const PHASE_END:int = 4;
        private static const WINDOW_MINIMUM_SIZE:Number = 50;

        public function WindowBase(param1:Function = null, param2:int = 0, param3:WindowStyle = null)
        {
            this._windowStyle = param3;
            this._cbWindowClose = param1;
            this.init();
            return;
        }// end function

        public function release() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = this._aItem.length - 1;
            while (_loc_1 >= 0)
            {
                
                _loc_2 = this._aItem[_loc_1];
                _loc_2.release();
                this._aItem.splice(_loc_1, 1);
                _loc_1 = _loc_1 - 1;
            }
            if (this._baseMc && this._baseMc.parent)
            {
                this._baseMc.parent.removeChild(this._baseMc);
            }
            this._baseMc = null;
            return;
        }// end function

        public function control() : Boolean
        {
            switch(this._phase)
            {
                case PHASE_OPEN:
                {
                    this.controlOpen();
                    break;
                }
                case PHASE_EXEC:
                {
                    this.controlExec();
                    break;
                }
                case PHASE_CLOSE:
                {
                    this.controlClose();
                    break;
                }
                case PHASE_END:
                {
                    return false;
                }
                default:
                {
                    break;
                }
            }
            return true;
        }// end function

        public function addWindowItem(param1:WindowItemBase) : void
        {
            this._aItem.push(param1);
            param1.setWindowBase(this);
            this.itemRearrangement();
            return;
        }// end function

        public function get size() : Point
        {
            return this._size;
        }// end function

        public function windowCloseFunc() : void
        {
            if (this._cbWindowClose != null)
            {
                this._cbWindowClose();
            }
            this._cbWindowClose = null;
            return;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._bEnd;
        }// end function

        public function get bOpened() : Boolean
        {
            return this._phase == PHASE_EXEC;
        }// end function

        protected function setPhase(param1:int) : void
        {
            if (this._phase != param1)
            {
                this._phase = param1;
                switch(this._phase)
                {
                    case PHASE_OPEN:
                    {
                        this.phaseOpen();
                        break;
                    }
                    case PHASE_EXEC:
                    {
                        this.phaseExec();
                        break;
                    }
                    case PHASE_CLOSE:
                    {
                        this.phaseClose();
                        break;
                    }
                    case PHASE_END:
                    {
                        this.phaseEnd();
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        protected function phaseOpen() : void
        {
            this.windowOpen();
            return;
        }// end function

        protected function controlOpen() : void
        {
            this.setPhase(PHASE_EXEC);
            return;
        }// end function

        protected function windowOpen() : void
        {
            this.x = this._dispPoint.x;
            this.y = this._dispPoint.y;
            var _loc_1:* = 0;
            this._baseMc.scaleY = 0;
            this._baseMc.scaleX = _loc_1;
            var _loc_1:* = WINDOW_MINIMUM_SIZE;
            this._baseMc.height = WINDOW_MINIMUM_SIZE;
            this._baseMc.width = _loc_1;
            return;
        }// end function

        protected function phaseExec() : void
        {
            return;
        }// end function

        protected function controlExec() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aItem)
            {
                
                _loc_1.control();
            }
            return;
        }// end function

        protected function phaseClose() : void
        {
            this._baseMc.width = WINDOW_MINIMUM_SIZE;
            this._baseMc.height = WINDOW_MINIMUM_SIZE;
            this.setPhase(PHASE_END);
            return;
        }// end function

        protected function controlClose() : void
        {
            return;
        }// end function

        protected function phaseEnd() : void
        {
            if (parent != null)
            {
                parent.removeChild(this);
            }
            this._bEnd = true;
            return;
        }// end function

        protected function controlEnd() : void
        {
            return;
        }// end function

        protected function init() : void
        {
            this._aItem = new Array();
            this._size = new Point();
            this._dispPoint = new Point();
            return;
        }// end function

        public function open(param1:Number, param2:Number) : void
        {
            this.openInit(param1, param2);
            this.setPhase(PHASE_OPEN);
            return;
        }// end function

        protected function openInit(param1:Number, param2:Number) : void
        {
            this._dispPoint.x = param1;
            this._dispPoint.y = param2;
            this._baseMc.visible = true;
            this._bEnd = false;
            return;
        }// end function

        public function close() : void
        {
            this.setPhase(PHASE_CLOSE);
            return;
        }// end function

        protected function itemRearrangement() : void
        {
            return;
        }// end function

        protected function updateLabel(param1:Boolean) : void
        {
            return;
        }// end function

    }
}
