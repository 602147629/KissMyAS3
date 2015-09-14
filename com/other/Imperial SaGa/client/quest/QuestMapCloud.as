package quest
{
    import flash.display.*;
    import flash.geom.*;
    import resource.*;
    import utility.*;

    public class QuestMapCloud extends QuestMapObjectBase
    {
        private var _bmpShadow:Bitmap;
        private static const _IN_TIME:Number = 0.3;
        private static const _OUT_TIME:Number = 0.3;
        private static const _aResource:Array = [ResourcePath.QUEST_MAP_PARTS_PATH + "kumo1.png", ResourcePath.QUEST_MAP_PARTS_PATH + "kumo2.png", ResourcePath.QUEST_MAP_PARTS_PATH + "kumo3.png"];

        public function QuestMapCloud(param1:DisplayObjectContainer, param2:Point, param3:Number)
        {
            super(param1, param2, new Point(1, 0), param3);
            _phase = _PHASE_IN;
            _time = 0;
            this.createCloud();
            this.setVec();
            return;
        }// end function

        override public function release() : void
        {
            this._bmpShadow.bitmapData.dispose();
            if (this._bmpShadow.parent)
            {
                this._bmpShadow.parent.removeChild(this._bmpShadow);
            }
            this._bmpShadow = null;
            super.release();
            return;
        }// end function

        override public function control(param1:Number) : void
        {
            if (_bEnd)
            {
                return;
            }
            _layer.x = _layer.x + _vec.x * param1;
            _layer.y = _layer.y + _vec.y * param1;
            _time = _time + param1;
            super.control(param1);
            return;
        }// end function

        override protected function controlIn() : void
        {
            var _loc_1:* = _time / _IN_TIME;
            if (_loc_1 > 1)
            {
                _loc_1 = 1;
            }
            _layer.alpha = _loc_1;
            if (_time >= _IN_TIME)
            {
                _phase = _PHASE_LIFE;
                _time = 0;
            }
            return;
        }// end function

        override protected function controlLife() : void
        {
            if (_time >= _lifeTime)
            {
                _phase = _PHASE_OUT;
                _time = 0;
            }
            if (_layer.x > Constant.SCREEN_WIDTH + _bmp.width * 0.5)
            {
                _phase = _PHASE_OUT;
                _time = 0;
            }
            return;
        }// end function

        override protected function controlOut() : void
        {
            var _loc_1:* = 1 - _time / _OUT_TIME;
            if (_loc_1 < 0)
            {
                _loc_1 = 0;
            }
            _layer.alpha = _loc_1;
            if (_time >= _OUT_TIME)
            {
                this.reset();
            }
            return;
        }// end function

        private function createCloud() : void
        {
            var _loc_1:* = Random.range(0, (_aResource.length - 1));
            _bmp = ResourceManager.getInstance().createBitmap(_aResource[_loc_1]);
            if (_loc_1 == 0)
            {
                _bmp.width = _bmp.width * 0.5;
                _bmp.height = _bmp.height * 0.5;
            }
            _bmp.x = _bmp.width * -0.5;
            _bmp.y = _bmp.height * -0.5;
            var _loc_2:* = _bmp.bitmapData.clone();
            _loc_2.colorTransform(new Rectangle(0, 0, _loc_2.width, _loc_2.height), new ColorTransform(1, 1, 1, 1, -255, -255, -255, -150));
            this._bmpShadow = new Bitmap(_loc_2);
            this._bmpShadow.x = _bmp.x + 150;
            this._bmpShadow.y = _bmp.y + 200;
            this._bmpShadow.width = _bmp.width * 0.5;
            this._bmpShadow.height = _bmp.height * 0.5;
            _layer.addChild(_bmp);
            _layer.addChild(this._bmpShadow);
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
            if (this._bmpShadow)
            {
                if (this._bmpShadow.bitmapData != null)
                {
                    this._bmpShadow.bitmapData.dispose();
                }
                if (this._bmpShadow.parent != null)
                {
                    this._bmpShadow.parent.removeChild(this._bmpShadow);
                }
            }
            this._bmpShadow = null;
            return;
        }// end function

        private function reset() : void
        {
            _phase = _PHASE_IN;
            this.removeCloud();
            this.createCloud();
            this.setVec();
            _time = 0;
            _layer.x = -200;
            _layer.y = _backupPos.y;
            return;
        }// end function

        private function setVec() : void
        {
            var _loc_1:* = new Point(1, 0);
            var _loc_2:* = new Matrix();
            _loc_2.scale(8 * 5, 1);
            _loc_2.rotate(15 * Math.PI / 180);
            _vec = _loc_2.deltaTransformPoint(_loc_1);
            return;
        }// end function

        public static function getResource() : Array
        {
            return _aResource;
        }// end function

    }
}
