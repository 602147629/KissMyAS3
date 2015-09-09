package lovefox.isometric
{
    import flash.display.*;
    import flash.filters.*;

    public class MapEffect extends Object
    {
        private static var _lockZoom:Boolean = false;
        private static var _zoomObj:Object;
        private static var _quakeObj:Object;
        private static var _grayObj:Object;
        private static var _darkObj:Object = {};
        private static var _lightStack:Array = [];
        private static var _fireworkStack:Array = [];
        private static var _lockDark:Boolean = false;
        private static var _lockBlur:Boolean = false;
        private static var _lockColorTransform:Boolean = false;

        public function MapEffect()
        {
            return;
        }// end function

        public static function line(param1:Map, param2 = null, param3 = null, param4 = 16711680)
        {
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            if (param1._textMap != null)
            {
                param1._textMap.graphics.clear();
                if (param2 == null)
                {
                    return;
                }
                _loc_5 = param1.mapToUnit(param2);
                _loc_6 = param1.mapToUnit(param3);
                param1._textMap.graphics.lineStyle(2, param4, 1);
                param1._textMap.graphics.moveTo(_loc_5._x, _loc_5._y);
                param1._textMap.graphics.lineTo(_loc_6._x, _loc_6._y);
            }
            return;
        }// end function

        public static function quake(param1:Map, param2 = 3, param3 = 0)
        {
            if (param1 != null && param1._state == "ready")
            {
                param1.removeEventListener(Event.ENTER_FRAME, subQuake);
                if (_quakeObj != null)
                {
                    param1.x = _quakeObj.initX;
                    param1.y = _quakeObj.initY;
                }
                _quakeObj = {map:param1, initX:param1.x, initY:param1.y, x:0, y:0, ySpeed:param2, xSpeed:Math.random() * param2 / 2, count:param3};
                param1.addEventListener(Event.ENTER_FRAME, subQuake);
            }
            return;
        }// end function

        private static function subQuake(param1)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            _loc_2 = _quakeObj.map;
            if (_loc_2 == null || _loc_2._state != "ready" || _quakeObj == null)
            {
                _loc_2.removeEventListener(Event.ENTER_FRAME, subQuake);
                return;
            }
            _quakeObj.x = _quakeObj.x + _quakeObj.xSpeed;
            _quakeObj.y = _quakeObj.y + _quakeObj.ySpeed;
            _loc_3 = _quakeObj.x;
            _loc_4 = _quakeObj.y;
            if (Math.abs(_quakeObj.ySpeed) < 1 && Math.abs(_loc_4) < 1)
            {
                _loc_2.x = _quakeObj.initX;
                _loc_2.y = _quakeObj.initY;
                _loc_2._mask.x = 0;
                _loc_2._mask.y = 0;
                _quakeObj = null;
                _loc_2.removeEventListener(Event.ENTER_FRAME, subQuake);
                return;
            }
            _loc_2.x = _quakeObj.initX + _loc_3;
            _loc_2.y = _quakeObj.initY + _loc_4;
            _loc_2._mask.x = _quakeObj.initX - _loc_2.x;
            _loc_2._mask.y = _quakeObj.initY - _loc_2.y;
            if (_quakeObj.count <= 0)
            {
                _quakeObj.xSpeed = _quakeObj.xSpeed - _loc_3 / 0.6;
                _quakeObj.ySpeed = _quakeObj.ySpeed - _loc_4 / 0.3;
                _quakeObj.xSpeed = _quakeObj.xSpeed * 0.75;
                _quakeObj.ySpeed = _quakeObj.ySpeed * 0.75;
            }
            else
            {
                _quakeObj.xSpeed = _quakeObj.xSpeed - _loc_3 / 0.6;
                _quakeObj.ySpeed = _quakeObj.ySpeed - _loc_4 / 0.3;
                var _loc_5:* = _quakeObj;
                var _loc_6:* = _quakeObj.count - 1;
                _loc_5.count = _loc_6;
            }
            return;
        }// end function

        public static function zoom(param1, param2 = 2, param3 = 3, param4 = null, param5 = null)
        {
            if (param5 != null)
            {
                clearTimeout(param5);
            }
            param1.removeEventListener(Event.ENTER_FRAME, subZoom);
            _zoomObj = {map:param1, zoom:param2, split:param3, release:param4};
            param1.addEventListener(Event.ENTER_FRAME, subZoom);
            return;
        }// end function

        private static function subZoom(param1)
        {
            if (Math.abs(_zoomObj.map.zoom - _zoomObj.zoom) < 0.1)
            {
                _zoomObj.map.zoom = _zoomObj.zoom;
                _zoomObj.map.removeEventListener(Event.ENTER_FRAME, subZoom);
                if (_zoomObj.release != null)
                {
                    _zoomObj.releaseTimer = setTimeout(zoom, _zoomObj.release, _zoomObj.map, 1, _zoomObj.split, null, _zoomObj.releaseTimer);
                }
            }
            else
            {
                _zoomObj.map.zoom = (_zoomObj.zoom - _zoomObj.map.zoom) / _zoomObj.split + _zoomObj.map.zoom;
            }
            return;
        }// end function

        public static function gray(param1, param2 = true, param3 = 10)
        {
            if (param2)
            {
                param1.removeEventListener(Event.ENTER_FRAME, subGray);
                _grayObj = {map:param1, time:param3, count:0};
                param1.addEventListener(Event.ENTER_FRAME, subGray);
            }
            else
            {
                param1.filters = [];
                param1.removeEventListener(Event.ENTER_FRAME, subGray);
            }
            return;
        }// end function

        private static function subGray(param1)
        {
            _grayObj.count = _grayObj.count + 1 / _grayObj.time;
            var _loc_2:* = Math.max(0, 1 - _grayObj.count);
            var _loc_3:* = [0.3 + 0.7 * _loc_2, 0.59 - 0.59 * _loc_2, 0.11 - 0.11 * _loc_2, 0, 0, 0.3 - 0.3 * _loc_2, 0.59 + 0.41 * _loc_2, 0.11 - 0.11 * _loc_2, 0, 0, 0.3 - 0.3 * _loc_2, 0.59 - 0.59 * _loc_2, 0.11 + 0.89 * _loc_2, 0, 0, 0, 0, 0, 1, 0];
            var _loc_4:* = new ColorMatrixFilter(_loc_3);
            _grayObj.map.filters = [_loc_4];
            if (_grayObj.count >= 1)
            {
                _grayObj.map.removeEventListener(Event.ENTER_FRAME, subGray);
            }
            return;
        }// end function

        public static function dark(param1:Map, param2 = 0, param3 = 3)
        {
            var _loc_4:* = null;
            if (_darkObj.mc == null && param2 != 0)
            {
                _loc_4 = new Shape();
                param1._mc.addChild(_loc_4);
                _loc_4.x = -param1._mc.x;
                _loc_4.y = -param1._mc.y;
                param1._mc.swapChildren(_loc_4, param1._textMap);
                _loc_4.graphics.lineStyle(0, 0, 0);
                _loc_4.graphics.beginFill(0, 1);
                _loc_4.graphics.drawRect(0, 0, param1.width, param1.height);
                _loc_4.graphics.endFill();
                _loc_4.alpha = 0;
                _darkObj.mc = _loc_4;
                param1.removeEventListener("resize", darkHandleMapResize);
                param1.addEventListener("resize", darkHandleMapResize);
            }
            _darkObj.map = param1;
            _darkObj.alpha = param2;
            _darkObj.step = param3;
            _darkObj.map.removeEventListener(Event.ENTER_FRAME, subDark);
            _darkObj.map.addEventListener(Event.ENTER_FRAME, subDark);
            return;
        }// end function

        private static function darkHandleMapResize(param1)
        {
            if (_darkObj.mc != null)
            {
                _darkObj.mc.graphics.clear();
                _darkObj.mc.graphics.lineStyle(0, 0, 0);
                _darkObj.mc.graphics.beginFill(0, 1);
                _darkObj.mc.graphics.drawRect(0, 0, _darkObj.map.width, _darkObj.map.height);
                _darkObj.mc.graphics.endFill();
                _darkObj.mc.x = -_darkObj.map._mc.x;
                _darkObj.mc.y = -_darkObj.map._mc.y;
            }
            return;
        }// end function

        private static function subDark(param1)
        {
            if (_darkObj.mc != null)
            {
                _darkObj.mc.alpha = _darkObj.mc.alpha + (_darkObj.alpha - _darkObj.mc.alpha) / _darkObj.step;
                if (Math.abs(_darkObj.alpha - _darkObj.mc.alpha) < 0.1)
                {
                    _darkObj.mc.alpha = _darkObj.alpha;
                    _darkObj.map.removeEventListener(Event.ENTER_FRAME, subDark);
                    if (_darkObj.alpha == 0)
                    {
                        _darkObj.mc.parent.removeChild(_darkObj.mc);
                        _darkObj.map.removeEventListener("resize", darkHandleMapResize);
                        delete _darkObj.mc;
                    }
                }
            }
            return;
        }// end function

        public static function blur(param1, param2 = 20, param3 = 10, param4 = 3)
        {
            var count:*;
            var filter:*;
            var perStep:*;
            var per:*;
            var subBlur:*;
            var map:* = param1;
            var max:* = param2;
            var time:* = param3;
            var step:* = param4;
            if (!_lockBlur)
            {
                subBlur = function ()
            {
                var _loc_2:* = count - 1;
                count = _loc_2;
                if (count >= step + time)
                {
                    per = step * 2 - count + time;
                    var _loc_1:* = per * perStep;
                    filter.blurY = per * perStep;
                    filter.blurX = _loc_1;
                    map.filters = [filter];
                }
                else if (count > step)
                {
                }
                else if (count > 0)
                {
                    per = count;
                    var _loc_1:* = per * perStep;
                    filter.blurY = per * perStep;
                    filter.blurX = _loc_1;
                    map.filters = [filter];
                }
                else
                {
                    map.filters = [];
                    map.removeEventListener(Event.ENTER_FRAME, subBlur);
                    _lockBlur = false;
                }
                return;
            }// end function
            ;
                _lockBlur = true;
                count = step * 2 + time;
                filter = new BlurFilter(0, 0, 1);
                map.filters = [filter];
                perStep = max / step;
                map.addEventListener(Event.ENTER_FRAME, subBlur);
            }
            return;
        }// end function

        public static function colorTransform(param1, param2 = 16711680, param3 = 10, param4 = 10)
        {
            var r:*;
            var g:*;
            var b:*;
            var count:*;
            var rStep:*;
            var gStep:*;
            var bStep:*;
            var per:*;
            var subColorTransform:*;
            var map:* = param1;
            var color:* = param2;
            var time:* = param3;
            var step:* = param4;
            if (!_lockColorTransform)
            {
                subColorTransform = function ()
            {
                var _loc_2:* = count - 1;
                count = _loc_2;
                if (count >= step + time)
                {
                    per = step * 2 - count + time;
                    map.transform.colorTransform = new ColorTransform(1 - per * rStep, 1 - per * gStep, 1 - per * bStep, 1, 0, 0, 0, 0);
                }
                else if (count > step)
                {
                }
                else if (count > 0)
                {
                    per = count;
                    map.transform.colorTransform = new ColorTransform(1 - per * rStep, 1 - per * gStep, 1 - per * bStep, 1, 0, 0, 0, 0);
                }
                else
                {
                    map.transform.colorTransform = new ColorTransform();
                    map.removeEventListener(Event.ENTER_FRAME, subColorTransform);
                    _lockColorTransform = false;
                }
                return;
            }// end function
            ;
                _lockColorTransform = true;
                r = 255 - (color >> 16 & 255);
                g = 255 - (color >> 8 & 255);
                b = 255 - (color & 255);
                count = step * 2 + time;
                rStep = r / step / 255;
                gStep = g / step / 255;
                bStep = b / step / 255;
                map.addEventListener(Event.ENTER_FRAME, subColorTransform);
            }
            return;
        }// end function

        public static function randomEffect(param1)
        {
            var _loc_2:* = [quake, zoom, dark, blur, colorTransform];
            var _loc_3:* = _loc_2[Math.floor(Math.random() * _loc_2.length)];
            MapEffect._loc_3(param1);
            return;
        }// end function

    }
}
