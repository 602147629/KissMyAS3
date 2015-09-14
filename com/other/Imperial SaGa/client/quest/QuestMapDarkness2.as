package quest
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import resource.*;
    import utility.*;

    public class QuestMapDarkness2 extends QuestMapObjectBase
    {
        private const ALPHA_UP:int = 1;
        private const ALPHA_STAY:int = 2;
        private const ALPHA_DOWN:int = 3;
        private const AlPHA_CHANGE_POSITION:int = 4;
        private const SPEED_OF_CLOUD_MAX:int = 20;
        private const SPEED_OF_CLOUD_MIN:int = 5;
        public var _index:int;
        private var _targetAlpha:Number;
        private var _alphaPhase:int = 1;
        private var _alphaTimer:Timer;
        private var _alphaStayDarkCounter:int = 0;
        private var _alphaStayInvisibleCounter:int = 0;
        private var _mask:Bitmap;
        private var _change_alpha:Boolean = true;
        private var _parent:DisplayObjectContainer;
        private var _maxHeight:Number;
        private static const _aResource:Array = [ResourcePath.QUEST_MAP_PARTS_PATH + "kumo1.png", ResourcePath.QUEST_MAP_PARTS_PATH + "kumo2.png", ResourcePath.QUEST_MAP_PARTS_PATH + "kumo3.png"];

        public function QuestMapDarkness2(param1:DisplayObjectContainer, param2:int, param3:Point, param4:Bitmap, param5:Number)
        {
            super(param1, param3, new Point(0, 0), 10);
            this._index = param2;
            this._mask = param4;
            this._parent = param1;
            this._maxHeight = param5;
            _layer.alpha = Random.range(0, 50) / 100;
            this._alphaPhase = Random.range(1, 3);
            this._alphaStayDarkCounter = Random.range(0, 25);
            this._alphaStayInvisibleCounter = 0;
            this._alphaTimer = new Timer(40);
            this._alphaTimer.addEventListener(TimerEvent.TIMER, this.changeAlpha);
            this.reset();
            this._alphaTimer.start();
            return;
        }// end function

        override public function release() : void
        {
            if (this._alphaTimer.hasEventListener(TimerEvent.TIMER))
            {
                this._alphaTimer.removeEventListener(TimerEvent.TIMER, this.changeAlpha);
            }
            super.release();
            return;
        }// end function

        private function changeAlpha(event:TimerEvent) : void
        {
            if (this._alphaPhase == this.ALPHA_UP)
            {
                this._alphaStayDarkCounter = 0;
                _layer.alpha = _layer.alpha + 0.01;
                if (_layer.alpha > 0.5)
                {
                    _layer.alpha = 0.5;
                }
                if (_layer.alpha >= 0.5)
                {
                    this._alphaPhase = this.ALPHA_STAY;
                }
            }
            if (this._alphaPhase == this.ALPHA_STAY)
            {
                _layer.alpha = 0.5;
                var _loc_2:* = this;
                var _loc_3:* = this._alphaStayDarkCounter + 1;
                _loc_2._alphaStayDarkCounter = _loc_3;
                if (this._alphaStayDarkCounter == 40)
                {
                    this._alphaPhase = this.ALPHA_DOWN;
                }
            }
            if (this._alphaPhase == this.ALPHA_DOWN)
            {
                this._alphaStayDarkCounter = 0;
                _layer.alpha = _layer.alpha - 0.01;
                if (_layer.alpha < 0)
                {
                    _layer.alpha = 0;
                }
                if (_layer.alpha <= 0)
                {
                    this._alphaPhase = this.AlPHA_CHANGE_POSITION;
                }
            }
            if (this._alphaPhase == this.AlPHA_CHANGE_POSITION)
            {
                this.newPoint();
                _layer.alpha = 0;
                this._alphaPhase = this.ALPHA_UP;
            }
            return;
        }// end function

        override public function control(param1:Number) : void
        {
            if (_bEnd)
            {
                if (this._alphaTimer.hasEventListener(TimerEvent.TIMER))
                {
                    this._alphaTimer.removeEventListener(TimerEvent.TIMER, this.changeAlpha);
                }
                return;
            }
            _layer.x = _layer.x + _vec.x * param1;
            _layer.y = _layer.y + _vec.y * param1;
            super.control(param1);
            return;
        }// end function

        private function createCloud() : void
        {
            var _loc_1:* = Random.range(0, (_aResource.length - 1));
            _bmp = ResourceManager.getInstance().createBitmap(_aResource[_loc_1]);
            _bmp.width = _bmp.width * (1 + 0.1 * (this._index & 7));
            _bmp.height = _bmp.height * (0.5 + 0.1 * (this._index & 7));
            _bmp.bitmapData.colorTransform(new Rectangle(0, 0, _bmp.bitmapData.width, _bmp.bitmapData.height), new ColorTransform(1, 1, 1, 1, -255, -255, -255, -10));
            _layer.addChild(_bmp);
            return;
        }// end function

        private function newPoint() : void
        {
            var _loc_1:* = 2 * this._maxHeight / 100;
            var _loc_2:* = Random.range(0, 10);
            var _loc_3:* = Constant.SCREEN_WIDTH / 50;
            var _loc_4:* = this._maxHeight + 99;
            if (_loc_2 < 4)
            {
                _layer.x = Random.range(-_layer.x, _loc_3) * 10;
            }
            if (_loc_2 >= 4 && _loc_2 <= 6)
            {
                _layer.x = Random.range(-_layer.x, _loc_3) * 25;
            }
            if (_loc_2 > 6)
            {
                _layer.x = Random.range(0, _loc_3) * 40;
            }
            _layer.y = Random.range(0, _loc_4);
            this.setVec();
            return;
        }// end function

        private function removeCloud() : void
        {
            if (_bmp)
            {
                if (_bmp.bitmapData != null)
                {
                    _bmp.bitmapData.dispose();
                }
                if (_bmp.parent != null)
                {
                    _bmp.parent.removeChild(_bmp);
                }
            }
            _bmp = null;
            return;
        }// end function

        private function reset() : void
        {
            _phase = _PHASE_LIFE;
            this.removeCloud();
            this.createCloud();
            this.setVec();
            _time = 0;
            _layer.x = _backupPos.x - _bmp.width * 0.5;
            _layer.y = _backupPos.y - _bmp.height * 0.5;
            return;
        }// end function

        private function setVec() : void
        {
            var _loc_1:* = Random.range(this.SPEED_OF_CLOUD_MIN, this.SPEED_OF_CLOUD_MAX);
            var _loc_2:* = Random.range(this.SPEED_OF_CLOUD_MAX * -1, this.SPEED_OF_CLOUD_MIN * -1);
            var _loc_3:* = Random.range(1, 2);
            if (_loc_3 == 1)
            {
                _vec = new Point(_loc_1, 0);
            }
            if (_loc_3 == 2)
            {
                _vec = new Point(_loc_2, 0);
            }
            return;
        }// end function

        public static function getResource() : Array
        {
            return _aResource;
        }// end function

    }
}
