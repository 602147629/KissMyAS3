package lovefox.util
{
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import lovefox.buffer.*;

    public class PicZip extends EventDispatcher
    {
        private var _unzipObj:Object;

        public function PicZip()
        {
            this._unzipObj = {};
            return;
        }// end function

        public function unzip(param1:ByteArray)
        {
            var _loc_2:* = param1.readObject();
            param1 = _loc_2.pic;
            this._unzipObj = _loc_2.pos;
            BitmapLoader.setByteArray({piczipzhuanyong:param1});
            var _loc_3:* = new BitmapLoader();
            _loc_3.addEventListener(Event.COMPLETE, this.handleLoaderComplete);
            _loc_3.load(["piczipzhuanyong"]);
            return;
        }// end function

        private function handleLoaderComplete(param1)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_2:* = BitmapLoader.pick("piczipzhuanyong");
            var _loc_6:* = {};
            var _loc_7:* = 0;
            for (_loc_3 in this._unzipObj)
            {
                
                _loc_7 = _loc_7 + 1;
                _loc_4 = this._unzipObj[_loc_3];
                _loc_5 = new BitmapData(_loc_4[2], _loc_4[3], true, 0);
                _loc_5.copyPixels(_loc_2, new Rectangle(_loc_4[0], _loc_4[1], _loc_4[2], _loc_4[3]), new Point(), null, null, true);
                _loc_6[_loc_3] = _loc_5;
            }
            BitmapLoader.setPicBuff(_loc_6);
            _loc_2.dispose();
            dispatchEvent(new Event(Event.COMPLETE));
            return;
        }// end function

        public static function zip(param1:Array)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = null;
            trace(param1.length);
            trace(param1);
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = {};
            _loc_2 = 0;
            while (_loc_2 < param1.length)
            {
                
                _loc_4 = BitmapLoader.pick(param1[_loc_2]);
                trace(param1[_loc_2], _loc_4);
                if (_loc_5 + _loc_4.width <= 2880)
                {
                    _loc_5 = _loc_5 + _loc_4.width;
                    _loc_8 = Math.max(_loc_8, _loc_4.height);
                    _loc_9 = _loc_6 + _loc_8;
                }
                else
                {
                    _loc_7 = Math.max(_loc_7, _loc_5);
                    _loc_6 = _loc_8 + _loc_9;
                    _loc_8 = 0;
                    _loc_5 = 0;
                    _loc_8 = 0;
                    _loc_5 = _loc_5 + _loc_4.width;
                    _loc_8 = Math.max(_loc_8, _loc_4.height);
                    _loc_9 = _loc_6 + _loc_8;
                }
                _loc_4.dispose();
                _loc_2 = _loc_2 + 1;
            }
            _loc_7 = Math.max(_loc_7, _loc_5);
            trace(_loc_7, _loc_9);
            var _loc_11:* = new BitmapData(_loc_7, _loc_9, true, 0);
            _loc_5 = 0;
            _loc_6 = 0;
            _loc_7 = 0;
            _loc_8 = 0;
            _loc_9 = 0;
            _loc_2 = 0;
            while (_loc_2 < param1.length)
            {
                
                _loc_4 = BitmapLoader.pick(param1[_loc_2]);
                if (_loc_5 + _loc_4.width <= 2880)
                {
                    _loc_11.copyPixels(_loc_4, _loc_4.rect, new Point(_loc_5, _loc_6), null, null, true);
                    _loc_10[param1[_loc_2]] = [_loc_5, _loc_6, _loc_4.width, _loc_4.height];
                    _loc_5 = _loc_5 + _loc_4.width;
                    _loc_8 = Math.max(_loc_8, _loc_4.height);
                    _loc_9 = _loc_6 + _loc_8;
                }
                else
                {
                    _loc_7 = Math.max(_loc_7, _loc_5);
                    _loc_6 = _loc_9;
                    _loc_8 = 0;
                    _loc_5 = 0;
                    _loc_8 = 0;
                    _loc_11.copyPixels(_loc_4, _loc_4.rect, new Point(_loc_5, _loc_6), null, null, true);
                    _loc_10[param1[_loc_2]] = [_loc_5, _loc_6, _loc_4.width, _loc_4.height];
                    _loc_5 = _loc_5 + _loc_4.width;
                    _loc_8 = Math.max(_loc_8, _loc_4.height);
                    _loc_9 = _loc_6 + _loc_8;
                }
                _loc_4.dispose();
                _loc_2 = _loc_2 + 1;
            }
            var _loc_12:* = PNGEncoder.encode(_loc_11);
            var _loc_13:* = {};
            {}.pic = _loc_12;
            _loc_13.pos = _loc_10;
            var _loc_14:* = new ByteArray();
            new ByteArray().writeObject(_loc_13);
            _loc_14.position = 0;
            trace("PicZip", _loc_14.length);
            return _loc_14;
        }// end function

    }
}
