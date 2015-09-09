package lovefox.isometric
{

    public class Picset extends Object
    {
        public static var _buff:Object = {};

        public function Picset()
        {
            return;
        }// end function

        public static function clearBuff()
        {
            var _loc_1:* = undefined;
            for (_loc_1 in _buff)
            {
                
                _buff[_loc_1].dispose();
                delete _buff[_loc_1];
            }
            _buff = {};
            return;
        }// end function

        private static function mirrorBmpd(param1)
        {
            var _loc_2:* = param1.clone();
            var _loc_3:* = new Matrix();
            _loc_3.scale(-1, 1);
            _loc_3.translate(_loc_2.width, 0);
            var _loc_4:* = new BitmapData(_loc_2.width, _loc_2.height, true, 0);
            param1.copyPixels(_loc_4, _loc_4.rect, new Point());
            param1.draw(_loc_2, _loc_3);
            _loc_2.dispose();
            _loc_4.dispose();
            return;
        }// end function

        public static function toBmp(param1)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            var _loc_9:* = undefined;
            var _loc_10:* = undefined;
            var _loc_11:* = undefined;
            var _loc_12:* = undefined;
            var _loc_13:* = undefined;
            var _loc_14:* = undefined;
            var _loc_15:* = undefined;
            if (_buff[param1.id] != null)
            {
                return _buff[param1.id].clone();
            }
            _loc_2 = [];
            _loc_3 = Number(param1.width);
            _loc_4 = Number(param1.height);
            var _loc_16:* = Number.MAX_VALUE;
            _loc_8 = Number.MAX_VALUE;
            _loc_7 = _loc_16;
            var _loc_16:* = -Number.MAX_VALUE;
            _loc_10 = -Number.MAX_VALUE;
            _loc_9 = _loc_16;
            if (param1.pic is Array)
            {
                _loc_5 = 0;
                while (_loc_5 < param1.pic.length)
                {
                    
                    _loc_11 = BitmapLoader.pick(String(param1.pic[_loc_5].dir));
                    _loc_12 = Number(param1.pic[_loc_5].x);
                    _loc_13 = Number(param1.pic[_loc_5].y);
                    _loc_14 = Number(param1.pic[_loc_5].mirror);
                    if (_loc_14 == 1)
                    {
                        mirrorBmpd(_loc_11);
                    }
                    _loc_2.push({bmpd:_loc_11, x:_loc_12, y:_loc_13});
                    _loc_7 = Math.min(_loc_12, _loc_7);
                    _loc_8 = Math.min(_loc_13, _loc_8);
                    _loc_9 = Math.max(_loc_12 + _loc_11.width, _loc_9);
                    _loc_10 = Math.max(_loc_13 + _loc_11.height, _loc_10);
                    _loc_5 = _loc_5 + 1;
                }
            }
            else
            {
                _loc_11 = BitmapLoader.pick(String(param1.pic.dir));
                _loc_12 = Number(param1.pic.x);
                _loc_13 = Number(param1.pic.y);
                _loc_14 = Number(param1.pic.mirror);
                if (_loc_14 == 1)
                {
                    mirrorBmpd(_loc_11);
                }
                _loc_2.push({bmpd:_loc_11, x:_loc_12, y:_loc_13});
                _loc_7 = Math.min(_loc_12, _loc_7);
                _loc_8 = Math.min(_loc_13, _loc_8);
                _loc_9 = Math.max(_loc_12 + _loc_11.width, _loc_9);
                _loc_10 = Math.max(_loc_13 + _loc_11.height, _loc_10);
            }
            if ((-_loc_7) / _loc_3 > _loc_9 / _loc_4)
            {
                _loc_9 = (-_loc_7) / _loc_3 * _loc_4;
            }
            else
            {
                _loc_7 = (-_loc_9) / _loc_4 * _loc_3;
            }
            if (_loc_9 - _loc_7 > 0 && -_loc_8 > 0)
            {
                _loc_15 = new BitmapData(_loc_9 - _loc_7, -_loc_8, true, 0);
            }
            else
            {
                _loc_15 = new BitmapData(10, 10, true, 1717960704);
            }
            _loc_5 = _loc_2.length - 1;
            while (_loc_5 >= 0)
            {
                
                _loc_15.copyPixels(_loc_2[_loc_5].bmpd, _loc_2[_loc_5].bmpd.rect, new Point(_loc_2[_loc_5].x - _loc_7, _loc_2[_loc_5].y - _loc_8), null, null, true);
                _loc_2[_loc_5].bmpd.dispose();
                _loc_5 = _loc_5 - 1;
            }
            _buff[param1.id] = _loc_15.clone();
            return _loc_15;
        }// end function

    }
}
