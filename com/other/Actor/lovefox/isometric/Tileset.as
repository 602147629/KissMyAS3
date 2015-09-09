package lovefox.isometric
{

    public class Tileset extends Object
    {
        public static var _buff:Object = {};

        public function Tileset()
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

        public static function toBmp(param1)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            if (_buff[param1.id] != null)
            {
                return _buff[param1.id].clone();
            }
            _loc_3 = BitmapLoader.pick(param1.dir);
            if (param1.mirror != 0)
            {
                _loc_2 = new BitmapData(_loc_3.width, _loc_3.height, true, 0);
                _loc_4 = new Matrix();
                if (param1.mirror == 1)
                {
                    _loc_4.scale(-1, 1);
                    _loc_4.translate(_loc_3.width, 0);
                    _loc_2.draw(_loc_3, _loc_4);
                }
                else if (param1.mirror == 2)
                {
                    _loc_4.scale(1, -1);
                    _loc_4.translate(0, _loc_3.height);
                    _loc_2.draw(_loc_3, _loc_4);
                }
                else if (param1.mirror == 3)
                {
                    _loc_4.scale(-1, -1);
                    _loc_4.translate(_loc_3.width, _loc_3.height);
                    _loc_2.draw(_loc_3, _loc_4);
                }
                _loc_3.dispose();
            }
            else
            {
                _loc_2 = _loc_3;
            }
            _buff[param1.id] = _loc_2.clone();
            return _loc_2;
        }// end function

    }
}
