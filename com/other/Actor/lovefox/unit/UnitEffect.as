package lovefox.unit
{
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.utils.*;
    import lovefox.isometric.*;
    import lovefox.unit.lightning.*;

    public class UnitEffect extends Object
    {
        private static var _colorTransformDict:Dictionary = new Dictionary(true);
        private static var _shockDict:Dictionary = new Dictionary(true);
        private static var _grayDict:Dictionary = new Dictionary(true);
        private static var _smashDict:Dictionary = new Dictionary(true);
        private static var _extractDict:Dictionary = new Dictionary(true);
        private static var _afterimageDict:Dictionary = new Dictionary(true);
        private static var _jumpDict:Dictionary = new Dictionary(true);
        private static var _whirlDict:Dictionary = new Dictionary(true);
        private static var _stiffDict:Dictionary = new Dictionary(true);
        private static var _twitchDict:Dictionary = new Dictionary(true);
        private static var _turnDict:Dictionary = new Dictionary(true);
        private static var _jitterDict:Dictionary = new Dictionary(true);
        private static var _chargeDict:Dictionary = new Dictionary(true);
        private static var _chargeFilter:BlurFilter = new BlurFilter(5, 5);
        private static var _burstDict:Dictionary = new Dictionary(true);
        private static var _chainDict:Dictionary = new Dictionary(true);
        private static var _drillOutDict:Dictionary = new Dictionary(true);
        private static var _inDarkDict:Dictionary = new Dictionary(true);
        private static var _outDarkDict:Dictionary = new Dictionary(true);
        private static var _waveDict:Dictionary = new Dictionary(true);
        private static var _lightningDict:Dictionary = new Dictionary(true);
        private static var _burstFilter:BlurFilter = new BlurFilter(5, 5);
        private static var _burstCMF:Object = new ColorMatrixFilter([0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0]);
        private static var _freezeCMF:Object = new ColorMatrixFilter([0.3, 0.3, 0.3, 0, -40, 0.4, 0.4, 0.4, 0, -30, 0.6, 0.6, 0.6, 0, 30, 0, 0, 0, 1, 0]);
        private static var _freezeGlowFilter1:Object = new GlowFilter(1057897, 1, 6, 6, 2, 1, true);
        private static var _freezeGlowFilter2:Object = new GlowFilter(5273287, 1, 6, 6, 1, 1);
        public static var _stoneCMF:Object = new ColorMatrixFilter([0.3, 0.59, 0.11, 0, 0, 0.3, 0.59, 0.11, 0, 0, 0.3, 0.59, 0.11, 0, 0, 0, 0, 0, 1, 0]);
        private static var _poisonCMF:Object = new ColorMatrixFilter([0, 0, 0, 0, 0, 0.4, 0.4, 0.4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0]);
        private static var _curseCMF:Object = new ColorMatrixFilter([0.4, 0.4, 0.4, 0, 0, 0, 0, 0, 0, 0, 0.4, 0.4, 0.4, 0, 0, 0, 0, 0, 1, 0]);
        private static var _goldCMF:Object = new ColorMatrixFilter([0.4, 0.4, 0.4, 0, 0, 0.3, 0.3, 0.3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0]);
        private static var _bleedCMF:Object = new ColorMatrixFilter([0.4, 0.4, 0.4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0]);
        private static var _goldGlow:Object = new GlowFilter(16769024, 1, 10, 10);
        private static var _poisonBmpd:BitmapData;
        private static var _vampireBmpd:BitmapData;
        private static var _curseBmpd:BitmapData;
        private static var _vampireDict:Dictionary = new Dictionary();
        private static var _avatars:Array = [];
        private static var _avatarDict:Dictionary = new Dictionary();
        private static var _lightningLayers:Object = {};
        private static var _lightnings:Array = [];

        public function UnitEffect()
        {
            return;
        }// end function

        public static function vampire(param1:Unit)
        {
            var oriBmpd:BitmapData;
            var matrix:Matrix;
            var bmpObj:*;
            var rect:Rectangle;
            var bmpPts:Array;
            var i:*;
            var j:*;
            var unit:* = param1;
            try
            {
                if (unit != null && unit._img != null && unit._img._bitmap != null && unit._img._bitmap.bitmapData != null && unit._map != null && unit._map._state == "ready")
                {
                    unit.removeEventListener("destroy", vampireDestroy);
                    unit.addEventListener("destroy", vampireDestroy);
                    unit._mc.removeEventListener(Event.ENTER_FRAME, vampireLoop);
                    unit._mc.addEventListener(Event.ENTER_FRAME, vampireLoop);
                    bmpObj = unit._img.bitmap;
                    if (unit._img._bitmap.scaleX == 1)
                    {
                        oriBmpd = bmpObj.bmpd;
                    }
                    else
                    {
                        matrix = new Matrix();
                        matrix.scale(-1, 1);
                        matrix.translate(bmpObj.w, 0);
                        oriBmpd = new BitmapData(bmpObj.bmpd.width, bmpObj.bmpd.height, true, 0);
                        oriBmpd.draw(bmpObj.bmpd, matrix);
                        bmpObj.bmpd.dispose();
                    }
                    i;
                    while (i < unit._img._bitmap.filters.length)
                    {
                        
                        oriBmpd.applyFilter(oriBmpd, oriBmpd.rect, Config._point0, unit._img._bitmap.filters[i]);
                        i = (i + 1);
                    }
                    i;
                    while (i < unit._img.filters.length)
                    {
                        
                        oriBmpd.applyFilter(oriBmpd, oriBmpd.rect, Config._point0, unit._img.filters[i]);
                        i = (i + 1);
                    }
                    rect = oriBmpd.getColorBoundsRect(4278190080, 0, false);
                    bmpPts;
                    i = rect.x;
                    while (i < rect.x + rect.width)
                    {
                        
                        j = rect.y;
                        while (j < rect.y + rect.height)
                        {
                            
                            if (oriBmpd.getPixel32(i, j) >> 24 & 255 != 0)
                            {
                                bmpPts.push({_x:i, _y:j});
                            }
                            j = (j + 1);
                        }
                        i = (i + 1);
                    }
                    oriBmpd.dispose();
                    _vampireDict[unit._mc] = {unit:unit, count:0, bmpPts:bmpPts, pts:[]};
                }
            }
            catch (e)
            {
            }
            return;
        }// end function

        public static function vampireDestroy(event:Event)
        {
            killVampire(Unit(event.target));
            return;
        }// end function

        public static function killVampire(param1:Unit)
        {
            var _loc_3:* = 0;
            param1.removeEventListener("destroy", vampireDestroy);
            param1._mc.removeEventListener(Event.ENTER_FRAME, vampireLoop);
            var _loc_2:* = _vampireDict[param1._mc];
            if (_loc_2 != null)
            {
                _loc_3 = 0;
                while (_loc_3 < _loc_2.pts.length)
                {
                    
                    if (_loc_2.pts[_loc_3].bmp.parent != null)
                    {
                        _loc_2.pts[_loc_3].bmp.parent.removeChild(_loc_2.pts[_loc_3].bmp);
                    }
                    _loc_3++;
                }
                delete _vampireDict[param1._mc];
            }
            return;
        }// end function

        public static function vampireLoop(param1)
        {
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = undefined;
            var _loc_11:* = undefined;
            var _loc_12:* = undefined;
            var _loc_13:* = undefined;
            var _loc_14:* = undefined;
            var _loc_15:* = undefined;
            var _loc_16:* = undefined;
            var _loc_17:* = undefined;
            var _loc_18:* = undefined;
            var _loc_19:* = undefined;
            var _loc_20:* = undefined;
            var _loc_21:* = undefined;
            var _loc_22:* = undefined;
            var _loc_23:* = undefined;
            var _loc_24:* = undefined;
            var _loc_2:* = _vampireDict[param1.target];
            var _loc_3:* = _vampireDict[param1.target].unit;
            var _loc_4:* = _vampireDict[param1.target].pts;
            if (_vampireBmpd == null)
            {
                _loc_7 = 2;
                _loc_8 = new Shape();
                _loc_9 = new Matrix();
                _loc_9.createGradientBox(_loc_7 * 2, _loc_7 * 2, 0, _loc_7 / 3, (-_loc_7) / 2);
                _loc_8.graphics.beginGradientFill(GradientType.RADIAL, [16777215, 16777215, 16711680, 16711680, 6684672], [0.1, 0.2, 0.8, 0.8, 0.8], [0, 50, 100, 230, 255], _loc_9);
                _loc_8.graphics.drawCircle(_loc_7, _loc_7, _loc_7);
                _loc_8.graphics.endFill();
                _vampireBmpd = new BitmapData(_loc_7 * 2, _loc_7 * 2, true, 0);
                _vampireBmpd.draw(_loc_8);
            }
            if (_loc_3._mc != null && _loc_3._img != null)
            {
                _loc_10 = _loc_2.bmpPts[int(_loc_2.bmpPts.length * Math.random())];
                _loc_11 = -60;
                _loc_12 = new Bitmap(_vampireBmpd);
                if (_loc_3._img.bitmap.scale == 1)
                {
                    _loc_13 = _loc_3._mc.x + _loc_3._img.x + _loc_3._img.bitmap.x + _loc_10._x;
                }
                else
                {
                    _loc_13 = _loc_3._mc.x + _loc_3._img.x + _loc_3._img.bitmap.x - _loc_3._img.bitmap.w + _loc_10._x;
                }
                _loc_14 = _loc_3._mc.y + _loc_3._img.y + _loc_3._img.bitmap.y + _loc_10._y;
                _loc_15 = _loc_11;
                _loc_12.x = _loc_13;
                _loc_12.y = _loc_14;
                _loc_16 = 10;
                _loc_17 = Math.random() * Math.PI * 2;
                _loc_18 = Math.random() * 32;
                _loc_19 = Math.floor(Math.random() * _loc_16) + _loc_16;
                _loc_20 = Math.max(_loc_19, _loc_20);
                _loc_3._map._textMap.addChild(_loc_12);
                _loc_21 = Math.cos(_loc_17) * _loc_18 / _loc_19;
                _loc_22 = Math.sin(_loc_17) * _loc_18 / _loc_19;
                _loc_23 = -0.5;
                _loc_24 = (-(_loc_15 - _loc_23 * _loc_19 * _loc_19 / 2)) / _loc_19;
                _loc_4.push({bmp:_loc_12, count:_loc_19, initX:_loc_13, initY:_loc_14, initZ:_loc_15, x:0, y:0, z:_loc_15, xSpeed:_loc_21, ySpeed:_loc_22, zSpeed:_loc_24, gravity:_loc_23});
            }
            var _loc_5:* = 5;
            _loc_6 = 0;
            while (_loc_6 < _loc_4.length)
            {
                
                if (_loc_4[_loc_6].count >= 0)
                {
                    _loc_4[_loc_6].x = _loc_4[_loc_6].x + _loc_4[_loc_6].xSpeed;
                    _loc_4[_loc_6].y = _loc_4[_loc_6].y + _loc_4[_loc_6].ySpeed;
                    _loc_4[_loc_6].z = _loc_4[_loc_6].z - _loc_4[_loc_6].zSpeed;
                    _loc_4[_loc_6].bmp.x = _loc_4[_loc_6].initX + _loc_4[_loc_6].x - _loc_4[_loc_6].y;
                    _loc_4[_loc_6].bmp.y = _loc_4[_loc_6].initY + (_loc_4[_loc_6].x + _loc_4[_loc_6].y) / 2 + _loc_4[_loc_6].z - _loc_4[_loc_6].initZ;
                    _loc_4[_loc_6].zSpeed = _loc_4[_loc_6].zSpeed - _loc_4[_loc_6].gravity;
                    var _loc_25:* = _loc_4[_loc_6];
                    var _loc_26:* = _loc_4[_loc_6].count - 1;
                    _loc_25.count = _loc_26;
                    if (_loc_5 > 0)
                    {
                        if (_loc_4[_loc_6].count <= _loc_5)
                        {
                            _loc_4[_loc_6].bmp.alpha = _loc_4[_loc_6].bmp.alpha - Math.ceil(1 / _loc_5 * 10) / 10;
                            if (_loc_4[_loc_6].bmp.alpha <= 0)
                            {
                                if (_loc_4[_loc_6].bmp.parent != null)
                                {
                                    _loc_4[_loc_6].bmp.parent.removeChild(_loc_4[_loc_6].bmp);
                                    _loc_4.splice(_loc_6, 1);
                                    _loc_6 = _loc_6 - 1;
                                }
                            }
                        }
                    }
                }
                _loc_6 = _loc_6 + 1;
            }
            return;
        }// end function

        public static function avatar(param1:Unit) : void
        {
            if (_avatarDict[param1] != null)
            {
                return;
            }
            var _loc_2:* = new UnitClip();
            _loc_2.alpha = 0.5;
            _loc_2.shadow = true;
            var _loc_5:* = false;
            _loc_2.mouseEnabled = false;
            _loc_2.mouseChildren = _loc_5;
            _loc_2.changeStateTo("idle");
            _loc_2.changeDirectionTo(1);
            var _loc_3:* = new UnitClip();
            _loc_3.alpha = 0.5;
            _loc_3.shadow = true;
            var _loc_5:* = false;
            _loc_3.mouseEnabled = false;
            _loc_3.mouseChildren = _loc_5;
            _loc_3.changeStateTo("idle");
            _loc_3.changeDirectionTo(1);
            if (param1._img != null && param1._img._ready)
            {
                _loc_2.clone(param1._img);
                _loc_3.clone(param1._img);
            }
            var _loc_4:* = {unit:param1, avatar1:_loc_2, avatar2:_loc_3, x1:param1._x, y1:param1._y, x2:param1._x, y2:param1._y};
            _avatars.push(_loc_4);
            _avatarDict[param1] = _loc_4;
            param1.removeEventListener("redraw", handleUnitRedraw);
            param1.removeEventListener("angle", handleUnitAngle);
            param1.removeEventListener("action", handleUnitAction);
            param1.removeEventListener("missleEvent", handleUnitMissle);
            param1.removeEventListener("destroy", handleUnitAvatarDestroy);
            param1.addEventListener("redraw", handleUnitRedraw);
            param1.addEventListener("angle", handleUnitAngle);
            param1.addEventListener("action", handleUnitAction);
            param1.addEventListener("missleEvent", handleUnitMissle);
            param1.addEventListener("destroy", handleUnitAvatarDestroy);
            Config.startLoop(avatarLoop);
            return;
        }// end function

        private static function handleUnitAvatarDestroy(param1)
        {
            var _loc_2:* = Unit(param1.target);
            if (_loc_2 != null)
            {
                killAvatar(_loc_2);
            }
            return;
        }// end function

        private static function handleUnitAngle(param1)
        {
            var _loc_3:* = undefined;
            var _loc_2:* = Unit(param1.target);
            if (_loc_2 != null)
            {
                _loc_3 = _avatarDict[_loc_2];
                if (_loc_3 != null && _loc_2._img != null && _loc_2._img.ready)
                {
                    UnitClip(_loc_3.avatar1).changeDirectionTo(_loc_2._img._direction);
                    UnitClip(_loc_3.avatar2).changeDirectionTo(_loc_2._img._direction);
                }
            }
            return;
        }// end function

        private static function handleUnitAction(param1)
        {
            var _loc_3:* = undefined;
            var _loc_2:* = Unit(param1.target);
            if (_loc_2 != null)
            {
                _loc_3 = _avatarDict[_loc_2];
                if (_loc_3 != null && _loc_2._img != null && _loc_2._img.ready)
                {
                    UnitClip(_loc_3.avatar1).changeStateTo(_loc_2._img._state);
                    UnitClip(_loc_3.avatar2).changeStateTo(_loc_2._img._state);
                }
            }
            return;
        }// end function

        private static function handleUnitRedraw(param1)
        {
            var _loc_3:* = undefined;
            var _loc_2:* = Unit(param1.target);
            if (_loc_2 != null)
            {
                _loc_3 = _avatarDict[_loc_2];
                if (_loc_3 != null && _loc_2._img != null && _loc_2._img.ready)
                {
                    _loc_3.avatar1.clone(_loc_2._img);
                    _loc_3.avatar2.clone(_loc_2._img);
                }
            }
            return;
        }// end function

        private static function handleUnitMissle(event:MissleEvent)
        {
            var _loc_2:* = Unit(event.target);
            if (_loc_2 != null)
            {
                setTimeout(delayMissle, 450, _loc_2, event);
            }
            return;
        }// end function

        private static function delayMissle(param1, param2)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = null;
            if (param1 != null)
            {
                _loc_3 = _avatarDict[param1];
                if (_loc_3 != null && param1._img != null && param1._img.ready)
                {
                    _loc_4 = Missle.newMissle(param2._model, param1._map, _loc_3.x1, _loc_3.y1, param2._speed, param2._target, param2._pierce, param2._hue, param2._z);
                    _loc_4 = Missle.newMissle(param2._model, param1._map, _loc_3.x2, _loc_3.y2, param2._speed, param2._target, param2._pierce, param2._hue, param2._z);
                }
            }
            return;
        }// end function

        public static function avatarLoop(event:Event) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = undefined;
            var _loc_14:* = undefined;
            var _loc_2:* = 0;
            while (_loc_2 < _avatars.length)
            {
                
                _loc_3 = _avatars[_loc_2].unit;
                _loc_4 = _avatars[_loc_2].avatar1;
                _loc_5 = _avatars[_loc_2].avatar2;
                if (_loc_3._map == null || _loc_3._img == null)
                {
                }
                else
                {
                    if (_loc_4.parent == null)
                    {
                        _loc_3._map._rootMap.addChild(_loc_4);
                        _loc_3._map._rootMap.addChild(_loc_5);
                    }
                    _loc_6 = 64;
                    _loc_7 = _loc_3._angle - Math.PI / 3 * 2;
                    _loc_8 = _loc_3._angle + Math.PI / 3 * 2;
                    _loc_9 = Math.cos(_loc_7) * _loc_6 + _loc_3._x;
                    _loc_10 = Math.sin(_loc_7) * _loc_6 + _loc_3._y;
                    _loc_11 = Math.cos(_loc_8) * _loc_6 + _loc_3._x;
                    _loc_12 = Math.sin(_loc_8) * _loc_6 + _loc_3._y;
                    _avatars[_loc_2].x1 = _loc_9;
                    _avatars[_loc_2].y1 = _loc_10;
                    _avatars[_loc_2].x2 = _loc_11;
                    _avatars[_loc_2].y2 = _loc_12;
                    _loc_13 = _loc_3._map.mapToUnit({_x:_loc_9, _y:_loc_10});
                    _loc_14 = _loc_3._map.mapToUnit({_x:_loc_11, _y:_loc_12});
                    _loc_4.x = (_loc_13._x - _loc_4.x) / 3 + _loc_4.x;
                    _loc_4.y = (_loc_13._y - _loc_4.y) / 3 + _loc_4.y;
                    _loc_5.x = (_loc_14._x - _loc_5.x) / 3 + _loc_5.x;
                    _loc_5.y = (_loc_14._y - _loc_5.y) / 3 + _loc_5.y;
                }
                _loc_2++;
            }
            return;
        }// end function

        public static function killAvatar(param1:Unit) : void
        {
            var _loc_2:* = undefined;
            var _loc_3:* = 0;
            param1.removeEventListener("redraw", handleUnitRedraw);
            param1.removeEventListener("angle", handleUnitAngle);
            param1.removeEventListener("action", handleUnitAction);
            param1.removeEventListener("missleEvent", handleUnitMissle);
            param1.removeEventListener("destroy", handleUnitAvatarDestroy);
            if (_avatarDict[param1] != null)
            {
                _loc_2 = _avatarDict[param1];
                if (_loc_2.avatar1.parent != null)
                {
                    _loc_2.avatar1.parent.removeChild(_loc_2.avatar1);
                }
                if (_loc_2.avatar2.parent != null)
                {
                    _loc_2.avatar2.parent.removeChild(_loc_2.avatar2);
                }
                _loc_2.avatar1.destroy();
                _loc_2.avatar2.destroy();
                delete _avatarDict[param1];
                _loc_3 = 0;
                while (_loc_3 < _avatars.length)
                {
                    
                    if (_avatars[_loc_3].unit == param1)
                    {
                        _avatars.splice(_loc_3, 1);
                        if (_avatars.length == 0)
                        {
                            Config.stopLoop(avatarLoop);
                        }
                        return;
                    }
                    _loc_3++;
                }
            }
            return;
        }// end function

        public static function lightning(param1:Unit, param2:Unit, param3:int = 16777215) : void
        {
            var _loc_6:* = null;
            if (_lightningLayers[param3] == null)
            {
                _lightningLayers[param3] = new Shape();
                _lightningLayers[param3].filters = [new GlowFilter(param3, 1, 6, 6, 2, 2)];
                _lightningLayers[param3].blendMode = BlendMode.ADD;
            }
            var _loc_4:* = int(Math.random() * 2 + 2);
            var _loc_5:* = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_6 = new Lightning();
                _loc_6.init(_lightningLayers[param3]);
                _loc_6._alpha = 1 - _loc_5 / _loc_4;
                _lightnings.push({lightning:_loc_6, unit:param1, target:param2, life:20, color:param3});
                _loc_5++;
            }
            if (_lightningLayers[param3].parent == null)
            {
                Config.map._textMap.addChild(_lightningLayers[param3]);
            }
            Config.startLoop(lightningLinkLoop);
            return;
        }// end function

        public static function lightningLinkLoop(event:Event) : void
        {
            var _loc_2:* = undefined;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            for (_loc_2 in _lightningLayers)
            {
                
                _lightningLayers[_loc_2].graphics.clear();
            }
            _loc_3 = 0;
            while (_loc_3 < _lightnings.length)
            {
                
                var _loc_7:* = _lightnings[_loc_3];
                var _loc_8:* = _lightnings[_loc_3].life - 1;
                _loc_7.life = _loc_8;
                if (_lightnings[_loc_3].life <= 0)
                {
                    _lightnings.splice(_loc_3, 1);
                    _loc_3 = _loc_3 - 1;
                }
                else
                {
                    _loc_4 = _lightnings[_loc_3].lightning;
                    _loc_5 = _lightnings[_loc_3].unit;
                    _loc_6 = _lightnings[_loc_3].target;
                    if (_loc_5._mc != null && _loc_5._img != null)
                    {
                        _loc_4._startX = _loc_5._mc.x;
                        _loc_4._startY = _loc_5._mc.y + _loc_5._img.y - _loc_5._img.zoff - _loc_5._img._bitmapRectY / 2 - 18;
                    }
                    if (_loc_6._mc != null && _loc_6._img != null)
                    {
                        _loc_4._endX = _loc_6._mc.x;
                        _loc_4._endY = _loc_6._mc.y + _loc_6._img.y - _loc_6._img._bitmapRectY / 3;
                    }
                    if (_lightnings[_loc_3].life < 10)
                    {
                        _loc_4._alpha = _lightnings[_loc_3].life / 10;
                    }
                    _loc_4.update();
                }
                _loc_3++;
            }
            if (_lightnings.length == 0)
            {
                for (_loc_2 in _lightningLayers)
                {
                    
                    if (_lightningLayers[_loc_2].parent != null)
                    {
                        _lightningLayers[_loc_2].parent.removeChild(_lightningLayers[_loc_2]);
                    }
                }
                Config.stopLoop(lightningLinkLoop);
            }
            return;
        }// end function

        public static function drillOut(param1:Unit)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = null;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = null;
            var _loc_7:* = null;
            if (param1 != null && param1._img != null && param1._img._bitmap != null && param1._map != null && param1._map._state == "ready")
            {
                _loc_2 = param1._img._bitmapRectW / 2 + 2;
                _loc_3 = new Shape();
                _loc_3.graphics.beginFill(0, 1);
                _loc_3.graphics.drawEllipse(0, 0, _loc_2 * 2, _loc_2);
                _loc_3.graphics.endFill();
                _loc_4 = param1._mc.x + param1._map._rootMap.x - param1._map._tileLayer.x - _loc_2;
                _loc_5 = param1._mc.y + param1._map._rootMap.y - param1._map._tileLayer.y - _loc_2 / 2;
                _loc_6 = param1._map.getSketch(_loc_3, _loc_4, _loc_5);
                _loc_7 = new Bitmap(_loc_6);
                _loc_3.x = -_loc_2;
                _loc_7.x = -_loc_2;
                param1._mc.addChild(_loc_3);
                param1._mc.addChild(_loc_7);
                _drillOutDict[param1._mc] = {unit:param1, bmpd:_loc_6, bmp:_loc_7, shape:_loc_3, frame:0};
                param1._mc.removeEventListener(Event.ENTER_FRAME, drillOutLoop);
                param1._mc.addEventListener(Event.ENTER_FRAME, drillOutLoop);
                param1.removeEventListener("destroy", drillOutDestroy);
                param1.addEventListener("destroy", drillOutDestroy);
            }
            return;
        }// end function

        public static function drillOutDestroy(param1)
        {
            killDrillOut(param1.target);
            return;
        }// end function

        public static function killDrillOut(param1)
        {
            if (_drillOutDict[param1._mc] != null)
            {
                param1._mc.removeEventListener(Event.ENTER_FRAME, drillOutLoop);
                param1.removeEventListener("destroy", drillOutDestroy);
                _drillOutDict[param1._mc].bmpd.dispose();
                if (_drillOutDict[param1._mc].bmp.parent != null)
                {
                    _drillOutDict[param1._mc].bmp.parent.removeChild(_drillOutDict[param1._mc].bmp);
                }
                if (_drillOutDict[param1._mc].shape.parent != null)
                {
                    _drillOutDict[param1._mc].shape.parent.removeChild(_drillOutDict[param1._mc].shape);
                }
                delete _drillOutDict[param1._mc];
            }
            return;
        }// end function

        public static function drillOutLoop(param1 = null, param2 = null)
        {
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
            if (param1 != null)
            {
                _loc_3 = _drillOutDict[param1.target];
                _loc_4 = _loc_3.unit;
            }
            else
            {
                _loc_3 = _drillOutDict[param2._mc];
                _loc_4 = param2;
            }
            if (_loc_3.frame <= 10)
            {
                if (_loc_3.bmp.parent != null)
                {
                    _loc_3.bmp.parent.addChild(_loc_3.bmp);
                }
                _loc_3.bmp.rotation = (-_loc_3.frame) / 10 * 90;
            }
            else if (_loc_3.frame <= 15)
            {
                _loc_14 = (15 - _loc_3.frame) / 5;
                _loc_3.bmp.alpha = _loc_14;
                _loc_3.shape.alpha = _loc_14;
            }
            else
            {
                killDrillOut(_loc_4);
                return;
            }
            var _loc_15:* = _loc_3;
            var _loc_16:* = _loc_3.frame + 1;
            _loc_15.frame = _loc_16;
            return;
        }// end function

        public static function inDark(param1:Unit)
        {
            if (param1 != null && param1._img != null)
            {
                _inDarkDict[param1._mc] = {frame:0, unit:param1};
                inDarkLoop(null, param1);
                param1._mc.removeEventListener(Event.ENTER_FRAME, inDarkLoop);
                param1._mc.addEventListener(Event.ENTER_FRAME, inDarkLoop);
                param1.removeEventListener("destroy", handleInDarkDestroy);
                param1.addEventListener("destroy", handleInDarkDestroy);
            }
            return;
        }// end function

        private static function handleInDarkDestroy(param1)
        {
            killInDark(param1.target);
            return;
        }// end function

        private static function killInDark(param1)
        {
            if (_inDarkDict[param1._mc] != null)
            {
                param1._img.transform.colorTransform = new ColorTransform();
                param1._img.alpha = 1;
                delete _inDarkDict[param1._mc];
                param1.removeEventListener("destroy", handleInDarkDestroy);
                param1._mc.removeEventListener(Event.ENTER_FRAME, inDarkLoop);
            }
            return;
        }// end function

        private static function inDarkLoop(param1 = null, param2 = null)
        {
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
            if (param1 != null)
            {
                _loc_3 = _inDarkDict[param1.target];
                _loc_4 = _loc_3.unit;
            }
            else
            {
                _loc_3 = _inDarkDict[param2._mc];
                _loc_4 = param2;
            }
            var _loc_14:* = 15;
            var _loc_15:* = _loc_3.frame / _loc_14;
            if (_loc_3.frame / _loc_14 < 1)
            {
                _loc_4._img.transform.colorTransform = new ColorTransform(_loc_15, _loc_15, _loc_15, 1, 0, 0, 0, 0);
                _loc_4._img.alpha = _loc_15 + 0.5;
            }
            else
            {
                killInDark(_loc_4);
                return;
            }
            var _loc_16:* = _loc_3;
            var _loc_17:* = _loc_3.frame + 1;
            _loc_16.frame = _loc_17;
            return;
        }// end function

        public static function stare(param1, param2, param3)
        {
            return;
        }// end function

        public static function wave(param1:Unit, param2:Map, param3 = 100, param4 = 10, param5 = 8, param6 = 4, param7 = 10, param8 = -4)
        {
            var _loc_9:* = null;
            var _loc_10:* = undefined;
            var _loc_11:* = undefined;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = undefined;
            if (param1 != null && param1._img != null && param1._img._bitmap != null && param2 != null && param2._state == "ready")
            {
                _loc_9 = new Shape();
                _loc_9.graphics.beginFill(0, 1);
                _loc_9.graphics.drawEllipse(0, 0, param3 * 2, param3);
                _loc_9.graphics.endFill();
                _loc_10 = param1._mc.x + param2._rootMap.x - param2._tileLayer.x - param3;
                _loc_11 = param1._mc.y + param2._rootMap.y - param2._tileLayer.y - param3 / 2;
                _loc_12 = param2.getSketch(_loc_9, _loc_10, _loc_11);
                _loc_13 = new Sprite();
                _loc_14 = new Shape();
                _loc_14.cacheAsBitmap = true;
                _loc_15 = new Bitmap(_loc_12);
                _loc_15.cacheAsBitmap = true;
                _loc_13.blendMode = BlendMode.LAYER;
                _loc_16 = 0;
                _loc_13.addChild(_loc_14);
                _loc_13.addChild(_loc_15);
                _loc_15.mask = _loc_14;
                _loc_13.x = param1._mc.x - param3;
                _loc_13.y = param1._mc.y - param3 / 2 + param8;
                param2._footMap.addChild(_loc_13);
                _waveDict[param1._mc] = {unit:param1, circleArr:[], frame:0, bmp:_loc_15, bmpd:_loc_12, mask:_loc_14, output:_loc_13, rCount:_loc_16, r:param3, time:param4, interval:param5, broad:param7, speed:param6};
                waveLoop(null, param1);
                param1._mc.removeEventListener(Event.ENTER_FRAME, waveLoop);
                param1._mc.addEventListener(Event.ENTER_FRAME, waveLoop);
            }
            return;
        }// end function

        private static function handleWaveDestroy(param1)
        {
            return;
        }// end function

        private static function killWave(param1, param2 = false)
        {
            return;
        }// end function

        private static function waveLoop(param1 = null, param2 = null)
        {
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
            if (param1 != null)
            {
                _loc_3 = _waveDict[param1.target];
                _loc_4 = _loc_3.unit;
            }
            else
            {
                _loc_3 = _waveDict[param2._mc];
                _loc_4 = param2;
            }
            var _loc_16:* = _loc_3.circleArr;
            var _loc_17:* = _loc_3.mask;
            _loc_3.mask.graphics.clear();
            _loc_5 = 0;
            while (_loc_5 < _loc_16.length)
            {
                
                _loc_16[_loc_5] = _loc_16[_loc_5] + _loc_3.speed;
                _loc_14 = _loc_16[_loc_5];
                _loc_15 = _loc_3.broad;
                _loc_17.graphics.beginFill(0, 1);
                _loc_17.graphics.drawEllipse(_loc_3.r - _loc_14, (_loc_3.r - _loc_14) / 2, _loc_14 * 2, _loc_14);
                _loc_17.graphics.drawEllipse(_loc_3.r - _loc_14 + _loc_15, (_loc_3.r - _loc_14) / 2 + _loc_15 / 2, _loc_14 * 2 - _loc_15 * 2, _loc_14 - _loc_15);
                _loc_17.graphics.endFill();
                _loc_5 = _loc_5 + 1;
            }
            if (_loc_3.frame % _loc_3.interval == 0)
            {
                _loc_3.circleArr.push(0);
            }
            if (_loc_16[0] > _loc_3.r)
            {
                _loc_16.shift();
            }
            var _loc_18:* = _loc_3;
            var _loc_19:* = _loc_3.frame + 1;
            _loc_18.frame = _loc_19;
            return;
        }// end function

        public static function bleed(param1:Unit)
        {
            if (param1 != null && param1._img != null && param1._img._ready)
            {
                param1._img.filters = [_bleedCMF];
                param1.removeEventListener("destroy", handleBleedDestroy);
                param1.addEventListener("destroy", handleBleedDestroy);
                param1.removeEventListener("die", handleBleedDestroy);
                param1.addEventListener("die", handleBleedDestroy);
            }
            return;
        }// end function

        private static function handleBleedDestroy(param1)
        {
            param1.target.removeEventListener("die", handleBleedDestroy);
            param1.target.removeEventListener("destroy", handleBleedDestroy);
            killBleed(param1.target, true);
            return;
        }// end function

        public static function killBleed(param1:Unit, param2 = false)
        {
            param1.removeEventListener("die", handleBleedDestroy);
            param1.removeEventListener("destroy", handleBleedDestroy);
            if (!param2)
            {
                smash(param1, 4, 0.2);
            }
            if (param1 != null && param1._img != null)
            {
                param1._img.filters = [];
            }
            return;
        }// end function

        public static function stone(param1:Unit)
        {
            if (param1 != null && param1._img != null && param1._img._ready)
            {
                param1._img.filters = [_stoneCMF];
                param1._img.locked = true;
                param1.removeEventListener("destroy", handleStoneDestroy);
                param1.addEventListener("destroy", handleStoneDestroy);
                param1.removeEventListener("die", handleStoneDestroy);
                param1.addEventListener("die", handleStoneDestroy);
            }
            return;
        }// end function

        private static function handleStoneDestroy(param1)
        {
            param1.target.removeEventListener("die", handleStoneDestroy);
            param1.target.removeEventListener("destroy", handleStoneDestroy);
            killStone(param1.target, true);
            return;
        }// end function

        public static function killStone(param1:Unit, param2 = false)
        {
            param1.removeEventListener("die", handleStoneDestroy);
            param1.removeEventListener("destroy", handleStoneDestroy);
            if (!param2)
            {
                smash(param1, 5);
            }
            if (param1 != null && param1._img != null)
            {
                param1._img.filters = [];
                param1._img.locked = false;
            }
            return;
        }// end function

        public static function curse(param1:Unit)
        {
            if (param1 != null && param1._img != null && param1._img._ready)
            {
                param1._img.filters = [_curseCMF];
                param1.removeEventListener("destroy", handleCurseDestroy);
                param1.addEventListener("destroy", handleCurseDestroy);
                param1.removeEventListener("die", handleCurseDestroy);
                param1.addEventListener("die", handleCurseDestroy);
            }
            return;
        }// end function

        private static function handleCurseDestroy(param1)
        {
            param1.target.removeEventListener("die", handleCurseDestroy);
            param1.target.removeEventListener("destroy", handleCurseDestroy);
            killCurse(param1.target, true);
            return;
        }// end function

        public static function killCurse(param1:Unit, param2 = false)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = null;
            var _loc_5:* = null;
            param1.removeEventListener("die", handleCurseDestroy);
            param1.removeEventListener("destroy", handleCurseDestroy);
            if (!param2)
            {
                _loc_3 = 3;
                if (_curseBmpd == null)
                {
                    _loc_4 = new Shape();
                    _loc_5 = new Matrix();
                    _loc_5.createGradientBox(_loc_3 * 2, _loc_3 * 2, 0, _loc_3 / 3, (-_loc_3) / 2);
                    _loc_4.graphics.beginGradientFill(GradientType.RADIAL, [16777215, 16777215, 65280, 65280, 26112], [0.1, 0.2, 0.8, 0.8, 0.8], [0, 50, 100, 230, 255], _loc_5);
                    _loc_4.graphics.drawCircle(_loc_3, _loc_3, _loc_3);
                    _loc_4.graphics.endFill();
                    _curseBmpd = new BitmapData(_loc_3 * 2, _loc_3 * 2, true, 0);
                    _curseBmpd.draw(_loc_4);
                }
                smash(param1, _loc_3 * 2, 0.4, -0.5, 10, -60, false, 5, _curseBmpd.clone());
            }
            if (param1 != null && param1._img != null)
            {
                param1._img.filters = [];
            }
            return;
        }// end function

        public static function poison(param1:Unit)
        {
            if (param1 != null && param1._img != null && param1._img._ready)
            {
                param1._img.filters = [_poisonCMF];
                param1.removeEventListener("destroy", handlePoisonDestroy);
                param1.addEventListener("destroy", handlePoisonDestroy);
                param1.removeEventListener("die", handlePoisonDestroy);
                param1.addEventListener("die", handlePoisonDestroy);
            }
            return;
        }// end function

        private static function handlePoisonDestroy(param1)
        {
            param1.target.removeEventListener("die", handlePoisonDestroy);
            param1.target.removeEventListener("destroy", handlePoisonDestroy);
            killPoison(param1.target, true);
            return;
        }// end function

        public static function killPoison(param1:Unit, param2 = false)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = null;
            var _loc_5:* = null;
            param1.removeEventListener("die", handlePoisonDestroy);
            param1.removeEventListener("destroy", handlePoisonDestroy);
            if (!param2)
            {
                _loc_3 = 3;
                if (_poisonBmpd == null)
                {
                    _loc_4 = new Shape();
                    _loc_5 = new Matrix();
                    _loc_5.createGradientBox(_loc_3 * 2, _loc_3 * 2, 0, _loc_3 / 3, (-_loc_3) / 2);
                    _loc_4.graphics.beginGradientFill(GradientType.RADIAL, [16777215, 16777215, 65280, 65280, 26112], [0.1, 0.2, 0.8, 0.8, 0.8], [0, 50, 100, 230, 255], _loc_5);
                    _loc_4.graphics.drawCircle(_loc_3, _loc_3, _loc_3);
                    _loc_4.graphics.endFill();
                    _poisonBmpd = new BitmapData(_loc_3 * 2, _loc_3 * 2, true, 0);
                    _poisonBmpd.draw(_loc_4);
                }
                smash(param1, _loc_3 * 2, 0.4, -0.5, 10, -60, false, 5, _poisonBmpd.clone());
            }
            if (param1 != null && param1._img != null)
            {
                param1._img.filters = [];
            }
            return;
        }// end function

        public static function cold(param1:Unit)
        {
            if (param1 != null && param1._img != null && param1._img._ready)
            {
                param1._img.filters = [_freezeCMF, _freezeGlowFilter1, _freezeGlowFilter2];
                param1.removeEventListener("destroy", handleColdDestroy);
                param1.addEventListener("destroy", handleColdDestroy);
                param1.removeEventListener("die", handleColdDestroy);
                param1.addEventListener("die", handleColdDestroy);
            }
            return;
        }// end function

        private static function handleColdDestroy(param1)
        {
            param1.target.removeEventListener("die", handleColdDestroy);
            param1.target.removeEventListener("destroy", handleColdDestroy);
            killCold(param1.target, true);
            return;
        }// end function

        public static function killCold(param1:Unit, param2 = false)
        {
            param1.removeEventListener("die", handleColdDestroy);
            param1.removeEventListener("destroy", handleColdDestroy);
            if (!param2)
            {
                smash(param1, 4, 0.05);
            }
            if (param1 != null && param1._img != null)
            {
                param1._img.filters = [];
            }
            return;
        }// end function

        public static function freeze(param1:Unit)
        {
            if (param1 != null && param1._img != null && param1._img._ready)
            {
                param1._img.filters = [_freezeCMF, _freezeGlowFilter1, _freezeGlowFilter2];
                param1._img.locked = true;
                param1.removeEventListener("destroy", handleFreezeDestroy);
                param1.addEventListener("destroy", handleFreezeDestroy);
                param1.removeEventListener("die", handleFreezeDestroy);
                param1.addEventListener("die", handleFreezeDestroy);
            }
            return;
        }// end function

        private static function handleFreezeDestroy(param1)
        {
            param1.target.removeEventListener("die", handleFreezeDestroy);
            param1.target.removeEventListener("destroy", handleFreezeDestroy);
            killFreeze(param1.target, true);
            return;
        }// end function

        public static function killFreeze(param1:Unit, param2 = false)
        {
            param1.removeEventListener("die", handleFreezeDestroy);
            param1.removeEventListener("destroy", handleFreezeDestroy);
            if (!param2)
            {
                smash(param1, 4, 0.05);
            }
            if (param1 != null && param1._img != null)
            {
                param1._img.filters = [];
                param1._img.locked = false;
            }
            return;
        }// end function

        public static function turn(param1:Unit)
        {
            if (param1 != null && param1._img != null && param1._img._ready)
            {
                killTurn(param1);
                _turnDict[param1._mc] = {unit:param1, count:0, direction:param1._img._direction, initDirection:param1._img._direction};
                param1._img.locked = true;
                param1._mc.addEventListener(Event.ENTER_FRAME, turnLoop);
                turnLoop(null, param1._mc);
            }
            return;
        }// end function

        public static function killTurn(param1)
        {
            var _loc_2:* = undefined;
            if (_turnDict[param1._mc] != null)
            {
                param1._img.locked = false;
                delete _turnDict[param1._mc];
                param1._mc.removeEventListener(Event.ENTER_FRAME, turnLoop);
                param1.changeStateTo("idle");
            }
            return;
        }// end function

        private static function turnLoop(param1 = null, param2 = null)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            if (Config.paused)
            {
                return;
            }
            if (param1 != null)
            {
                _loc_3 = _turnDict[param1.target];
                _loc_4 = param1.target;
            }
            else
            {
                _loc_3 = _turnDict[param2];
                _loc_4 = param2;
            }
            _loc_5 = _loc_3.unit;
            var _loc_6:* = _loc_3;
            var _loc_7:* = _loc_3.count + 1;
            _loc_6.count = _loc_7;
            var _loc_6:* = _loc_3;
            var _loc_7:* = _loc_3.direction + 1;
            _loc_6.direction = _loc_7;
            if (_loc_3.direction > 7)
            {
                _loc_3.direction = 0;
            }
            _loc_5._img.forceTo("idle", _loc_3.direction, 0);
            if (_loc_3.count > 4)
            {
                _loc_5._img.forceTo("idle", _loc_3.initDirection, 0);
                killTurn(_loc_5);
            }
            return;
        }// end function

        public static function jitter(param1:Unit, param2 = 32)
        {
            if (param1 != null && param1._img != null && param1._img._ready)
            {
                killJitter(param1);
                _jitterDict[param1._mc] = {unit:param1, count:0, direction:param1._img._direction, initDirection:param1._img._direction};
                param1._img.locked = true;
                param1._mc.addEventListener(Event.ENTER_FRAME, jitterLoop);
                jitterLoop(null, param1._mc);
            }
            return;
        }// end function

        public static function killJitter(param1)
        {
            var _loc_2:* = undefined;
            if (_jitterDict[param1._mc] != null)
            {
                param1._img.locked = false;
                delete _jitterDict[param1._mc];
                param1._mc.removeEventListener(Event.ENTER_FRAME, jitterLoop);
                param1.changeStateTo("idle");
            }
            return;
        }// end function

        private static function jitterLoop(param1 = null, param2 = null)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            if (Config.paused)
            {
                return;
            }
            if (param1 != null)
            {
                _loc_3 = _jitterDict[param1.target];
                _loc_4 = param1.target;
            }
            else
            {
                _loc_3 = _jitterDict[param2];
                _loc_4 = param2;
            }
            _loc_5 = _loc_3.unit;
            var _loc_6:* = _loc_3;
            var _loc_7:* = _loc_3.count + 1;
            _loc_6.count = _loc_7;
            var _loc_6:* = _loc_3;
            var _loc_7:* = _loc_3.direction + 1;
            _loc_6.direction = _loc_7;
            if (_loc_3.direction > 7)
            {
                _loc_3.direction = 0;
            }
            _loc_5._img.forceTo("idle", _loc_3.direction, 0);
            if (_loc_3.count > 4)
            {
                _loc_5._img.forceTo("idle", _loc_3.initDirection, 0);
                killJitter(_loc_5);
            }
            return;
        }// end function

        public static function stiff(param1:Unit, param2:int = 32, param3 = "attack", param4 = 5, param5 = 0, param6:int = 0, param7:int = 0)
        {
            if (param1 != null && param1._img != null && param1._img._bitmap != null)
            {
                killStiff(param1);
                _stiffDict[param1._mc] = {unit:param1, frame:param2, count:0, crazyMin:param6, crazyMax:param7, crazyCount:param6, imgArr:[], decay:0.1, initAlpha:0.6, interval:0, crazyFrame:0, freeze:param5, endFreeze:param4, action:param3, angle:param1._img._direction, frameCount:0, frameSkip:param1._img._frameSkip};
                param1._img.locked = true;
                param1.actionLock = true;
                param1._mc.addEventListener(Event.ENTER_FRAME, stiffLoop);
                param1.removeEventListener("destroy", handleStiffDestroy);
                param1.addEventListener("destroy", handleStiffDestroy);
                stiffLoop(null, param1._mc);
            }
            return;
        }// end function

        private static function handleStiffDestroy(param1)
        {
            killStiff(param1.target);
            return;
        }// end function

        public static function killStiff(param1:Unit, param2 = "idle", param3 = null)
        {
            var i:*;
            var unit:* = param1;
            var action:* = param2;
            var frame:* = param3;
            unit.removeEventListener("destroy", handleAfterimageDestroy);
            if (_stiffDict[unit._mc] != null)
            {
                var after:* = function ()
            {
                unit.changeStateTo("idle");
                unit.actionLock = false;
                return;
            }// end function
            ;
                i;
                while (i < _stiffDict[unit._mc].imgArr.length)
                {
                    
                    _stiffDict[unit._mc].imgArr[i].parent.removeChild(_stiffDict[unit._mc].imgArr[i]);
                    delete _stiffDict[unit._mc].imgArr[i];
                    i = (i + 1);
                }
                unit._img.locked = false;
                delete _stiffDict[unit._mc];
                unit._mc.removeEventListener(Event.ENTER_FRAME, stiffLoop);
                unit.changeStateTo(action, after);
                unit._img.forceAnimation(frame);
            }
            return;
        }// end function

        private static function stiffLoop(param1 = null, param2 = null)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            var _loc_9:* = null;
            if (Config.paused)
            {
                return;
            }
            if (param1 != null)
            {
                _loc_3 = _stiffDict[param1.target];
                _loc_4 = param1.target;
            }
            else
            {
                _loc_3 = _stiffDict[param2];
                _loc_4 = param2;
            }
            _loc_5 = _loc_3.unit;
            if (_loc_3.freeze < _loc_3.endFreeze)
            {
                if (_loc_3.frameCount >= _loc_3.frameSkip)
                {
                    var _loc_10:* = _loc_3;
                    var _loc_11:* = _loc_3.freeze + 1;
                    _loc_10.freeze = _loc_11;
                    _loc_3.frameCount = 0;
                }
                else
                {
                    var _loc_10:* = _loc_3;
                    var _loc_11:* = _loc_3.frameCount + 1;
                    _loc_10.frameCount = _loc_11;
                }
            }
            if (_loc_3.crazyMin != 0)
            {
                if (_loc_3.freeze < _loc_3.crazyMin)
                {
                    if (_loc_3.frameCount >= _loc_3.frameSkip)
                    {
                        var _loc_10:* = _loc_3;
                        var _loc_11:* = _loc_3.freeze + 1;
                        _loc_10.freeze = _loc_11;
                        _loc_3.frameCount = 0;
                    }
                    else
                    {
                        var _loc_10:* = _loc_3;
                        var _loc_11:* = _loc_3.frameCount + 1;
                        _loc_10.frameCount = _loc_11;
                    }
                }
                else
                {
                    var _loc_10:* = _loc_3;
                    var _loc_11:* = _loc_3.freeze + 1;
                    _loc_10.freeze = _loc_11;
                    if (_loc_3.freeze > _loc_3.crazyMax)
                    {
                        _loc_3.freeze = _loc_3.crazyMin;
                    }
                }
                _loc_5._img.forceTo(_loc_3.action, _loc_5._img._direction, _loc_3.freeze);
                if ((_loc_3.interval == 0 || _loc_3.count % _loc_3.interval == 0) && (_loc_3.count < _loc_3.frame || _loc_3.frame == 0))
                {
                    _loc_8 = _loc_5._img._bitmap.bitmapData;
                    if (_loc_8 != null)
                    {
                        _loc_9 = new Sprite();
                        _loc_9.alpha = _loc_3.initAlpha;
                        _loc_9.addChild(new Bitmap(_loc_8));
                        _loc_9.x = _loc_5._mc.x + _loc_5._img.x + _loc_5._img._bitmap.x;
                        _loc_9.scaleX = _loc_5._img._bitmap.scaleX;
                        _loc_9.y = _loc_5._mc.y + _loc_5._img.y + _loc_5._img._bitmap.y;
                        _loc_5._map._rootMap.addChild(_loc_9);
                        _loc_3.imgArr.push(_loc_9);
                    }
                }
                _loc_6 = 0;
                while (_loc_6 < _loc_3.imgArr.length)
                {
                    
                    _loc_3.imgArr[_loc_6].alpha = _loc_3.imgArr[_loc_6].alpha - _loc_3.decay;
                    if (_loc_3.imgArr[_loc_6].alpha <= 0)
                    {
                        _loc_3.imgArr[_loc_6].parent.removeChild(_loc_3.imgArr[_loc_6]);
                        _loc_3.imgArr.splice(_loc_6, 1);
                        _loc_6 = _loc_6 - 1;
                    }
                    _loc_6 = _loc_6 + 1;
                }
            }
            else
            {
                if (_loc_3.freeze < _loc_3.endFreeze)
                {
                    if (_loc_3.frameCount >= _loc_3.frameSkip)
                    {
                        var _loc_10:* = _loc_3;
                        var _loc_11:* = _loc_3.freeze + 1;
                        _loc_10.freeze = _loc_11;
                        _loc_3.frameCount = 0;
                    }
                    else
                    {
                        var _loc_10:* = _loc_3;
                        var _loc_11:* = _loc_3.frameCount + 1;
                        _loc_10.frameCount = _loc_11;
                    }
                }
                _loc_5._img.forceTo(_loc_3.action, _loc_5._img._direction, _loc_3.freeze);
            }
            var _loc_10:* = _loc_3;
            var _loc_11:* = _loc_3.count + 1;
            _loc_10.count = _loc_11;
            if (_loc_3.count == _loc_3.frame)
            {
                killStiff(_loc_5, _loc_3.action, _loc_3.freeze);
            }
            return;
        }// end function

        public static function twitch(param1:Unit, param2 = "attack", param3 = 0, param4 = 0, param5 = 5, param6 = 1, param7 = 0)
        {
            if (param1 != null && param1._img != null && param1._img._bitmap != null)
            {
                killTwitch(param1);
                _twitchDict[param1._mc] = {unit:param1, count:1, round:param6, freeze:param3, startFreeze:param4, endFreeze:param5, action:param2, angle:param1._img._direction, frameCount:0, frameSkip:param7};
                param1._img.locked = true;
                param1.actionLock = true;
                param1._mc.addEventListener(Event.ENTER_FRAME, twitchLoop);
                param1.removeEventListener("destroy", handleTwitchDestroy);
                param1.addEventListener("destroy", handleTwitchDestroy);
                twitchLoop(null, param1._mc);
            }
            return;
        }// end function

        private static function handleTwitchDestroy(param1)
        {
            killTwitch(param1.target);
            return;
        }// end function

        public static function killTwitch(param1:Unit, param2 = "idle", param3 = null)
        {
            var i:*;
            var unit:* = param1;
            var action:* = param2;
            var frame:* = param3;
            unit.removeEventListener("destroy", handleAfterimageDestroy);
            if (_twitchDict[unit._mc] != null)
            {
                var after:* = function ()
            {
                unit.changeStateTo("idle");
                unit.actionLock = false;
                return;
            }// end function
            ;
                unit._img.locked = false;
                delete _twitchDict[unit._mc];
                unit._mc.removeEventListener(Event.ENTER_FRAME, twitchLoop);
                unit.changeStateTo(action, after);
                unit._img.forceAnimation(frame);
            }
            return;
        }// end function

        private static function twitchLoop(param1 = null, param2 = null)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            if (Config.paused)
            {
                return;
            }
            if (param1 != null)
            {
                _loc_3 = _twitchDict[param1.target];
                _loc_4 = param1.target;
            }
            else
            {
                _loc_3 = _twitchDict[param2];
                _loc_4 = param2;
            }
            _loc_5 = _loc_3.unit;
            if (_loc_3.frameCount >= _loc_3.frameSkip)
            {
                if (_loc_3.freeze < _loc_3.endFreeze)
                {
                    var _loc_6:* = _loc_3;
                    var _loc_7:* = _loc_3.freeze + 1;
                    _loc_6.freeze = _loc_7;
                }
                else
                {
                    _loc_3.freeze = _loc_3.startFreeze;
                    var _loc_6:* = _loc_3;
                    var _loc_7:* = _loc_3.count + 1;
                    _loc_6.count = _loc_7;
                }
                _loc_5._img.forceTo(_loc_3.action, _loc_5._img._direction, _loc_3.freeze);
                _loc_3.frameCount = 0;
            }
            else
            {
                var _loc_6:* = _loc_3;
                var _loc_7:* = _loc_3.frameCount + 1;
                _loc_6.frameCount = _loc_7;
            }
            if (_loc_3.count == _loc_3.round)
            {
                killTwitch(_loc_5, _loc_3.action, _loc_3.freeze);
            }
            return;
        }// end function

        public static function whirl(param1:Unit, param2:int = 32, param3 = 4, param4 = 1)
        {
            if (param1 != null && param1._img != null && param1._img._bitmap)
            {
                killWhirl(param1);
                _whirlDict[param1._mc] = {unit:param1, frame:param2, count:0, freeze:param3, direction:0, imgArr:[], bmpArr:[], decay:0.1, initAlpha:0.6, interval:0, accCount:0, initAcc:param4, acc:param4};
                param1._img.locked = true;
                param1._mc.addEventListener(Event.ENTER_FRAME, whirlLoop);
                param1.removeEventListener("destroy", handleWhirlDestroy);
                param1.addEventListener("destroy", handleWhirlDestroy);
                whirlLoop(null, param1._mc);
            }
            return;
        }// end function

        private static function handleWhirlDestroy(param1)
        {
            killWhirl(param1.target);
            return;
        }// end function

        public static function killWhirl(param1)
        {
            var _loc_2:* = undefined;
            param1.removeEventListener("destroy", handleWhirlDestroy);
            if (_whirlDict[param1._mc] != null)
            {
                _loc_2 = 0;
                while (_loc_2 < _whirlDict[param1._mc].imgArr.length)
                {
                    
                    _whirlDict[param1._mc].bmpArr[_loc_2].bitmapData.dispose();
                    _whirlDict[param1._mc].imgArr[_loc_2].parent.removeChild(_whirlDict[param1._mc].imgArr[_loc_2]);
                    _loc_2 = _loc_2 + 1;
                }
                param1._img.locked = false;
                delete _whirlDict[param1._mc];
                param1._mc.removeEventListener(Event.ENTER_FRAME, whirlLoop);
                if (param1._moveFlag)
                {
                    param1.changeStateTo("walk", null, true);
                }
                else
                {
                    param1.changeStateTo("idle", null, true);
                }
            }
            return;
        }// end function

        private static function whirlLoop(param1 = null, param2 = null)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = null;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            if (Config.paused)
            {
                return;
            }
            if (param1 != null)
            {
                _loc_3 = _whirlDict[param1.target];
                _loc_4 = param1.target;
            }
            else
            {
                _loc_3 = _whirlDict[param2];
                _loc_4 = param2;
            }
            _loc_5 = _loc_3.unit;
            if (_loc_3.accCount > 0)
            {
                var _loc_12:* = _loc_3;
                var _loc_13:* = _loc_3.accCount - 1;
                _loc_12.accCount = _loc_13;
                return;
            }
            _loc_3.accCount = _loc_3.acc;
            var _loc_12:* = _loc_3;
            var _loc_13:* = _loc_3.count + 1;
            _loc_12.count = _loc_13;
            var _loc_12:* = _loc_3;
            var _loc_13:* = _loc_3.direction + 1;
            _loc_12.direction = _loc_13;
            if (_loc_3.direction > 7)
            {
                if (_loc_3.acc > 0)
                {
                    var _loc_12:* = _loc_3;
                    var _loc_13:* = _loc_3.acc - 1;
                    _loc_12.acc = _loc_13;
                }
                _loc_3.direction = 0;
            }
            if (_loc_5.visible && (_loc_3.interval == 0 || _loc_3.count % _loc_3.interval == 0) && (_loc_3.count < _loc_3.frame || _loc_3.frame == 0))
            {
                _loc_8 = _loc_5._img.bitmap;
                if (_loc_8 != null)
                {
                    _loc_9 = _loc_8.bmpd;
                    _loc_10 = new Sprite();
                    _loc_11 = new Bitmap(_loc_9);
                    if (_loc_5._img._hue != 0 && _loc_5._img._hue % 360 != 0)
                    {
                        _loc_9.applyFilter(_loc_9, _loc_9.rect, new Point(), HueColorMatrixFilter.getHue(_loc_5._img._hue));
                    }
                    _loc_10.alpha = _loc_3.initAlpha;
                    _loc_10.addChild(_loc_11);
                    _loc_10.x = _loc_5._mc.x + _loc_5._img.x + _loc_8.x;
                    _loc_10.y = _loc_5._mc.y + _loc_5._img.y + _loc_8.y;
                    _loc_10.scaleX = _loc_8.scale;
                    _loc_5._map._rootMap.addChild(_loc_10);
                    _loc_3.bmpArr.push(_loc_11);
                    _loc_3.imgArr.push(_loc_10);
                }
            }
            _loc_6 = 0;
            while (_loc_6 < _loc_3.imgArr.length)
            {
                
                _loc_3.imgArr[_loc_6].alpha = _loc_3.imgArr[_loc_6].alpha - _loc_3.decay;
                if (_loc_3.imgArr[_loc_6].alpha <= 0)
                {
                    _loc_3.bmpArr[_loc_6].bitmapData.dispose();
                    _loc_3.imgArr[_loc_6].parent.removeChild(_loc_3.imgArr[_loc_6]);
                    _loc_3.imgArr.splice(_loc_6, 1);
                    _loc_6 = _loc_6 - 1;
                }
                _loc_6 = _loc_6 + 1;
            }
            switch(_loc_3.direction)
            {
                case 0:
                {
                    break;
                }
                case 1:
                {
                    break;
                }
                case 2:
                {
                    break;
                }
                case 3:
                {
                    break;
                }
                case 4:
                {
                    break;
                }
                case 5:
                {
                    break;
                }
                case 6:
                {
                    break;
                }
                case 7:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            switch(_loc_3.direction)
            {
                case 0:
                {
                    break;
                }
                case 1:
                {
                    break;
                }
                case 2:
                {
                    break;
                }
                case 3:
                {
                    break;
                }
                case 4:
                {
                    break;
                }
                case 5:
                {
                    break;
                }
                case 6:
                {
                    break;
                }
                case 7:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            switch(_loc_3.direction)
            {
                case 0:
                {
                    break;
                }
                case 1:
                {
                    break;
                }
                case 2:
                {
                    break;
                }
                case 3:
                {
                    break;
                }
                case 4:
                {
                    break;
                }
                case 5:
                {
                    break;
                }
                case 6:
                {
                    break;
                }
                case 7:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (_loc_5.type == UNIT_TYPE_ENUM.TYPEID_UNIT && _loc_5._img._id == 1335)
            {
            }
            else
            {
            }
            if (_loc_3.count == _loc_3.frame)
            {
                killWhirl(_loc_5);
            }
            return;
        }// end function

        public static function jump(param1:Unit, param2:uint = 32, param3 = 3) : int
        {
            var _loc_4:* = undefined;
            if (param1 != null && param1._img != null && param1._img._bitmap != null)
            {
                killJump(param1);
                _loc_4 = -Math.sqrt(param2 * 2 * param3);
                _jumpDict[param1._mc] = {unit:param1, addY:0, ySpeed:_loc_4, gravity:param3};
                param1._mc.addEventListener(Event.ENTER_FRAME, jumpLoop);
                jumpLoop(null, param1._mc);
                param1.removeEventListener("destroy", subJumpDestroy);
                param1.addEventListener("destroy", subJumpDestroy);
                return Math.floor((-_loc_4) / param3 * 1000 / Config.fps * 2);
            }
            return 0;
        }// end function

        private static function subJumpDestroy(param1 = null)
        {
            killJump(param1.target);
            return;
        }// end function

        public static function killJump(param1)
        {
            param1.removeEventListener("destroy", subJumpDestroy);
            if (_jumpDict[param1._mc] != null)
            {
                param1._img.zoff = 0;
                param1._stateBar.setPos(param1._mc.x, param1._mc.y - param1._img._bitmapRectY + param1._imgY, param1._img._bitmapRectY - param1._imgY);
                delete _jumpDict[param1._mc];
                param1._mc.removeEventListener(Event.ENTER_FRAME, jumpLoop);
            }
            return;
        }// end function

        private static function jumpLoop(param1 = null, param2 = null)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            if (Config.paused)
            {
                return;
            }
            if (param1 != null)
            {
                _loc_3 = _jumpDict[param1.target];
                _loc_4 = param1.target;
            }
            else
            {
                _loc_3 = _jumpDict[param2];
                _loc_4 = param2;
            }
            _loc_5 = _loc_3.unit;
            _loc_3.addY = _loc_3.addY + _loc_3.ySpeed;
            _loc_3.ySpeed = _loc_3.ySpeed + _loc_3.gravity;
            if (_loc_3.addY > 0)
            {
                killJump(_loc_5);
            }
            else
            {
                _loc_5._img.zoff = -_loc_3.addY;
                _loc_5._stateBar.setPos(_loc_5._mc.x, _loc_5._mc.y - _loc_5._img._bitmapRectY + _loc_3.addY + _loc_5._imgY, _loc_5._img._bitmapRectY - _loc_3.addY - _loc_5._imgY);
            }
            return;
        }// end function

        public static function burst(param1:Unit, param2:Number = 1)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = null;
            var _loc_6:* = null;
            killBurst(param1);
            if (param1 != null && param1._img != null && param1._img._bitmap)
            {
                _loc_3 = param1._img.bitmap;
                if (_loc_3 != null)
                {
                    _loc_4 = _loc_3.bmpd;
                    _loc_5 = new Sprite();
                    _loc_6 = new Bitmap(_loc_4);
                    _loc_5.mouseChildren = false;
                    _loc_5.mouseEnabled = false;
                    _loc_5.addChild(_loc_6);
                    _loc_5.x = param1._mc.x + param1._img.x + _loc_3.x;
                    _loc_5.y = param1._mc.y + param1._img.y + _loc_3.y;
                    _loc_5.scaleX = _loc_3.scale;
                    param1._map._textMap.addChild(_loc_5);
                    _loc_5.filters = [_burstCMF, _burstFilter];
                    _loc_5.alpha = 0.6;
                    _loc_5.scaleY = param2 * 0.2 + 2;
                    if (_loc_5.scaleX > 0)
                    {
                        _loc_5.scaleX = _loc_5.scaleY;
                    }
                    else
                    {
                        _loc_5.scaleX = -_loc_5.scaleY;
                    }
                    _burstDict[param1._mc] = {unit:param1, power:param2, mc:_loc_5, bmp:_loc_6, bX:_loc_3.x, centerX:param1._mc.x, centerY:param1._mc.y, imgY:_loc_3.h};
                    param1._mc.removeEventListener(Event.ENTER_FRAME, burstLoop);
                    param1._mc.addEventListener(Event.ENTER_FRAME, burstLoop);
                    param1.removeEventListener("destroy", subBurstDestroy);
                    param1.addEventListener("destroy", subBurstDestroy);
                    burstLoop(null, param1._mc);
                }
            }
            return;
        }// end function

        private static function subBurstDestroy(param1)
        {
            killBurst(param1.target);
            return;
        }// end function

        public static function killBurst(param1:Unit)
        {
            param1.removeEventListener("destroy", subBurstDestroy);
            if (_burstDict[param1._mc] != null)
            {
                _burstDict[param1._mc].bmp.bitmapData.dispose();
                _burstDict[param1._mc].mc.parent.removeChild(_burstDict[param1._mc].mc);
                delete _burstDict[param1._mc];
                param1._mc.removeEventListener(Event.ENTER_FRAME, burstLoop);
            }
            return;
        }// end function

        private static function burstLoop(param1 = null, param2 = null)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            if (Config.paused)
            {
                return;
            }
            if (param1 != null)
            {
                _loc_3 = _burstDict[param1.target];
                _loc_4 = param1.target;
            }
            else
            {
                _loc_3 = _burstDict[param2];
                _loc_4 = param2;
            }
            _loc_5 = _loc_3.unit;
            var _loc_6:* = (_loc_3.mc.scaleY - 1) / 3;
            if (_loc_3.mc.scaleX > 0)
            {
                _loc_3.mc.scaleX = _loc_3.mc.scaleX - _loc_6;
                _loc_3.mc.scaleY = _loc_3.mc.scaleY - _loc_6;
                _loc_3.mc.x = _loc_3.centerX + _loc_3.mc.scaleY * _loc_3.bX;
            }
            else
            {
                _loc_3.mc.scaleX = _loc_3.mc.scaleX + _loc_6;
                _loc_3.mc.scaleY = _loc_3.mc.scaleY - _loc_6;
                _loc_3.mc.x = _loc_3.centerX + _loc_3.mc.scaleY * _loc_3.bX;
            }
            _loc_3.mc.y = _loc_3.centerY - _loc_3.mc.scaleY * _loc_3.imgY;
            _loc_3.mc.alpha = _loc_6 * 5;
            if (_loc_3.mc.scaleY < 1.1 || _loc_3.mc == null)
            {
                killBurst(_loc_5);
            }
            return;
        }// end function

        public static function charge(param1:Unit, param2:Number)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            if (param1 != null && param1._img != null && param1._img._bitmap)
            {
                if (_chargeDict[param1._mc] != null)
                {
                    _loc_3 = _chargeDict[param1._mc].imgArr;
                }
                else
                {
                    _loc_3 = [];
                }
                _loc_4 = 10;
                _chargeDict[param1._mc] = {killed:false, unit:param1, power:param2, imgArr:_loc_3, interval:2, count:0};
                param1._mc.removeEventListener(Event.ENTER_FRAME, chargeLoop);
                param1._mc.addEventListener(Event.ENTER_FRAME, chargeLoop);
                chargeLoop(null, param1._mc);
            }
            return;
        }// end function

        public static function killCharge(param1, param2 = false)
        {
            var _loc_3:* = undefined;
            if (param2)
            {
                if (_chargeDict[param1._mc] != null)
                {
                    _loc_3 = 0;
                    while (_loc_3 < _chargeDict[param1._mc].imgArr.length)
                    {
                        
                        _chargeDict[param1._mc].imgArr[_loc_3].parent.removeChild(_chargeDict[param1._mc].imgArr[_loc_3]);
                        delete _chargeDict[param1._mc].imgArr[_loc_3];
                        _loc_3 = _loc_3 + 1;
                    }
                    delete _chargeDict[param1._mc];
                    param1._mc.removeEventListener(Event.ENTER_FRAME, chargeLoop);
                }
            }
            else if (_chargeDict[param1._mc] != null)
            {
                _chargeDict[param1._mc].killed = true;
            }
            return;
        }// end function

        private static function chargeLoop(param1 = null, param2 = null)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            var _loc_9:* = undefined;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = undefined;
            var _loc_13:* = undefined;
            if (Config.paused)
            {
                return;
            }
            if (param1 != null)
            {
                _loc_3 = _chargeDict[param1.target];
                _loc_4 = param1.target;
            }
            else
            {
                _loc_3 = _chargeDict[param2];
                _loc_4 = param2;
            }
            _loc_5 = _loc_3.unit;
            _loc_8 = _loc_3.power * 1 + 5;
            _chargeFilter.blurX = _loc_8 / 2 + 2.5;
            _chargeFilter.blurY = _loc_8 / 2 + 2.5;
            if (!_loc_3.killed)
            {
                _loc_13 = Math.floor(Math.random() * 3 + 6);
                _loc_6 = 0;
                while (_loc_6 < _loc_13)
                {
                    
                    if (_loc_3.interval == 0 || _loc_3.count % _loc_3.interval == 0)
                    {
                        _loc_10 = new Shape();
                        _loc_11 = new Sprite();
                        _loc_10.graphics.beginFill(16777215, 1);
                        _loc_9 = _loc_8 * (Math.random() * 1.2 + 0.4);
                        _loc_10.graphics.drawEllipse(-2, (-_loc_9) * 5, 4, _loc_9 * 3);
                        _loc_10.graphics.endFill();
                        _loc_10.y = (-Math.floor(Math.random() * 3 + 2)) * _loc_8;
                        _loc_10.filters = [_chargeFilter];
                        _loc_11.rotation = 360 * Math.random();
                        _loc_11.x = _loc_5._mc.x;
                        _loc_11.y = _loc_5._mc.y - _loc_5._img._bitmapRect.height / 2;
                        _loc_11.addChild(_loc_10);
                        _loc_5._map._textMap.addChild(_loc_11);
                        _loc_3.imgArr.push(_loc_10);
                    }
                    _loc_6 = _loc_6 + 1;
                }
            }
            _loc_6 = 0;
            while (_loc_6 < _loc_3.imgArr.length)
            {
                
                _loc_12 = (-_loc_3.imgArr[_loc_6].y) / 5 + 1;
                _loc_3.imgArr[_loc_6].y = _loc_3.imgArr[_loc_6].y + _loc_12;
                var _loc_14:* = _loc_12 / 5;
                _loc_3.imgArr[_loc_6].scaleY = _loc_12 / 5;
                _loc_3.imgArr[_loc_6].alpha = _loc_14;
                if (_loc_3.imgArr[_loc_6].y >= -1)
                {
                    _loc_3.imgArr[_loc_6].parent.parent.removeChild(_loc_3.imgArr[_loc_6].parent);
                    _loc_3.imgArr[_loc_6].parent.removeChild(_loc_3.imgArr[_loc_6]);
                    _loc_3.imgArr[_loc_6].filters = [];
                    delete _loc_3.imgArr[_loc_6];
                    _loc_3.imgArr.splice(_loc_6, 1);
                    _loc_6 = _loc_6 - 1;
                }
                _loc_6 = _loc_6 + 1;
            }
            var _loc_14:* = _loc_3;
            var _loc_15:* = _loc_3.count + 1;
            _loc_14.count = _loc_15;
            if (_loc_3.imgArr.length == 0)
            {
                delete _chargeDict[_loc_4];
                _loc_4.removeEventListener(Event.ENTER_FRAME, chargeLoop);
            }
            return;
        }// end function

        public static function afterimage(param1:Unit, param2:int = 32, param3 = 4, param4 = 0.03, param5 = 0.6)
        {
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            if (param1 != null && param1._img != null && param1._img._bitmap)
            {
                if (_afterimageDict[param1._mc] != null)
                {
                    _loc_7 = _afterimageDict[param1._mc].bmpArr;
                    _loc_6 = _afterimageDict[param1._mc].imgArr;
                }
                else
                {
                    _loc_6 = [];
                    _loc_7 = [];
                }
                _afterimageDict[param1._mc] = {killed:false, unit:param1, bmpArr:_loc_7, imgArr:_loc_6, frame:param2, decay:param4, initAlpha:param5, count:0, interval:param3};
                param1._mc.removeEventListener(Event.ENTER_FRAME, afterimageLoop);
                param1._mc.addEventListener(Event.ENTER_FRAME, afterimageLoop);
                param1.removeEventListener("destroy", handleAfterimageDestroy);
                param1.addEventListener("destroy", handleAfterimageDestroy);
                afterimageLoop(null, param1._mc);
            }
            return;
        }// end function

        private static function handleAfterimageDestroy(param1)
        {
            killAfterimageLoop(param1.target, true);
            return;
        }// end function

        public static function killAfterimageLoop(param1, param2 = false)
        {
            var _loc_3:* = undefined;
            param1.removeEventListener("destroy", handleAfterimageDestroy);
            if (param2)
            {
                if (_afterimageDict[param1._mc] != null)
                {
                    _loc_3 = 0;
                    while (_loc_3 < _afterimageDict[param1._mc].imgArr.length)
                    {
                        
                        _afterimageDict[param1._mc].bmpArr[_loc_3].bitmapData.dispose();
                        _afterimageDict[param1._mc].imgArr[_loc_3].parent.removeChild(_afterimageDict[param1._mc].imgArr[_loc_3]);
                        _loc_3 = _loc_3 + 1;
                    }
                    delete _afterimageDict[param1._mc];
                    param1._mc.removeEventListener(Event.ENTER_FRAME, afterimageLoop);
                }
            }
            else if (_afterimageDict[param1._mc] != null)
            {
                _afterimageDict[param1._mc].killed = true;
            }
            return;
        }// end function

        private static function afterimageLoop(param1 = null, param2 = null)
        {
            var obj:*;
            var unitMc:*;
            var unit:*;
            var i:*;
            var x:*;
            var bmpObj:*;
            var bmpd:*;
            var rect:*;
            var sprt:Sprite;
            var bmp:Bitmap;
            var event:* = param1;
            var mc:* = param2;
            if (Config.paused)
            {
                return;
            }
            try
            {
                if (event != null)
                {
                    obj = _afterimageDict[event.target];
                    unitMc = event.target;
                }
                else
                {
                    obj = _afterimageDict[mc];
                    unitMc = mc;
                }
                unit = obj.unit;
                if (!obj.killed && unit.visible)
                {
                    if ((obj.interval == 0 || obj.count % obj.interval == 0) && (obj.count < obj.frame || obj.frame == 0))
                    {
                        bmpObj = unit._img.bitmap;
                        if (bmpObj != null)
                        {
                            bmpd = bmpObj.bmpd;
                            rect = bmpObj.rect;
                            sprt = new Sprite();
                            sprt.alpha = obj.initAlpha;
                            bmp = new Bitmap(bmpd);
                            sprt.addChild(bmp);
                            sprt.x = unit._mc.x + unit._img.x + bmpObj.x + unit._img.xoff;
                            sprt.y = unit._mc.y + unit._img.y + bmpObj.y - unit._img.zoff;
                            sprt.scaleX = bmpObj.scale;
                            unit._map._footMap.addChild(sprt);
                            obj.bmpd = bmpd;
                            obj.imgArr.push(sprt);
                            obj.bmpArr.push(bmp);
                        }
                    }
                }
                i;
                while (i < obj.imgArr.length)
                {
                    
                    obj.imgArr[i].alpha = obj.imgArr[i].alpha - obj.decay;
                    if (obj.imgArr[i].alpha <= 0)
                    {
                        if (obj.imgArr[i].parent != null)
                        {
                            obj.imgArr[i].parent.removeChild(obj.imgArr[i]);
                            obj.bmpArr[i].bitmapData.dispose();
                        }
                        obj.imgArr.splice(i, 1);
                        i = (i - 1);
                    }
                    i = (i + 1);
                }
                var _loc_4:* = obj;
                var _loc_5:* = obj.count + 1;
                _loc_4.count = _loc_5;
                if ((obj.frame != 0 && obj.count >= obj.frame || obj.frame == 0 && obj.killed) && obj.imgArr.length == 0)
                {
                    delete _afterimageDict[unitMc];
                    unitMc.removeEventListener(Event.ENTER_FRAME, afterimageLoop);
                }
            }
            catch (e)
            {
                if (event != null)
                {
                    obj = _afterimageDict[event.target];
                    unitMc = event.target;
                }
                else
                {
                    obj = _afterimageDict[mc];
                    unitMc = mc;
                }
                if (unitMc != null)
                {
                    delete _afterimageDict[unitMc];
                    unitMc.removeEventListener(Event.ENTER_FRAME, afterimageLoop);
                }
            }
            return;
        }// end function

        public static function extract(param1, param2 = null)
        {
            var _loc_8:* = undefined;
            var _loc_9:* = undefined;
            var _loc_3:* = Config.map.mapToScreen(param1);
            var _loc_4:* = Config.ui._playerHead._menegyPos;
            var _loc_5:* = Math.random() * 300 + 300;
            var _loc_6:* = Math.random() * 50 + 50;
            if (param2 == null)
            {
                param2 = Math.PI * 2 * Math.random();
            }
            var _loc_7:* = new GClip("me1");
            new GClip("me1").x = _loc_3._x;
            _loc_7.y = _loc_3._y - 40;
            Config.stage.addChild(_loc_7);
            var _loc_10:* = [];
            _loc_8 = 0;
            while (_loc_8 < 3)
            {
                
                _loc_9 = new GClip("me2");
                _loc_9.x = _loc_3._x;
                _loc_9.y = _loc_3._y - 40;
                Config.stage.addChild(_loc_9);
                _loc_10.push(_loc_9);
                _loc_8 = _loc_8 + 1;
            }
            _loc_8 = 0;
            while (_loc_8 < 9)
            {
                
                _loc_9 = new GClip("me3");
                _loc_9.x = _loc_3._x;
                _loc_9.y = _loc_3._y - 40;
                Config.stage.addChild(_loc_9);
                _loc_10.push(_loc_9);
                _loc_8 = _loc_8 + 1;
            }
            _extractDict[_loc_7] = {arr:_loc_10, target:_loc_4, speed:_loc_5, angle:param2, acc:_loc_6, decay:0.9};
            extractLoop(null, _loc_7);
            _loc_7.addEventListener(Event.ENTER_FRAME, extractLoop);
            return;
        }// end function

        public static function extractLoop(param1 = null, param2 = null)
        {
            var obj:*;
            var sprt:*;
            var unit:*;
            var i:*;
            var targetAngle:*;
            var angleOff:*;
            var xSpeed:*;
            var ySpeed:*;
            var distance:*;
            var event:* = param1;
            var mc:* = param2;
            if (Config.paused)
            {
                return;
            }
            try
            {
                if (event != null)
                {
                    sprt = event.target;
                }
                else
                {
                    sprt = mc;
                }
                obj = _extractDict[sprt];
                unit = obj.unit;
                targetAngle = Math.atan2(obj.target.y - sprt.y, obj.target.x - sprt.x);
                angleOff = targetAngle - obj.angle;
                if (angleOff > Math.PI)
                {
                    angleOff = angleOff - Math.PI * 2;
                }
                else if (angleOff < -Math.PI)
                {
                    angleOff = angleOff + Math.PI * 2;
                }
                angleOff = Math.abs(angleOff) / Math.PI;
                xSpeed = Math.cos(obj.angle) * obj.speed + Math.cos(targetAngle) * obj.acc * (1 - angleOff);
                ySpeed = Math.sin(obj.angle) * obj.speed + Math.sin(targetAngle) * obj.acc * (1 - angleOff);
                obj.angle = Math.atan2(ySpeed, xSpeed);
                obj.speed = Math.sqrt(Math.pow(xSpeed, 2) + Math.pow(ySpeed, 2));
                obj.speed = obj.speed * obj.decay;
                distance = Math.sqrt(Math.pow(obj.target.y - sprt.y, 2) + Math.pow(obj.target.x - sprt.x, 2));
                if (distance > obj.speed / Config.fps)
                {
                    obj.arr[0].x = sprt.x;
                    obj.arr[0].y = sprt.y;
                    sprt.x = sprt.x + Math.cos(obj.angle) * obj.speed / Config.fps;
                    sprt.y = sprt.y + Math.sin(obj.angle) * obj.speed / Config.fps;
                    i;
                    while (i < obj.arr.length)
                    {
                        
                        obj.arr[i].x = obj.arr[(i - 1)].x;
                        obj.arr[i].y = obj.arr[(i - 1)].y;
                        i = (i + 1);
                    }
                }
                else
                {
                    sprt.destroy();
                    if (sprt.parent != null)
                    {
                        sprt.parent.removeChild(sprt);
                    }
                    i;
                    while (i < obj.arr.length)
                    {
                        
                        obj.arr[i].destroy();
                        if (obj.arr[i].parent != null)
                        {
                            obj.arr[i].parent.removeChild(obj.arr[i]);
                        }
                        i = (i + 1);
                    }
                    sprt.removeEventListener(Event.ENTER_FRAME, extractLoop);
                    Config.ui._playerHead.menegyChange();
                    delete _extractDict[sprt];
                }
            }
            catch (e)
            {
                event.target.removeEventListener(Event.ENTER_FRAME, extractLoop);
            }
            return;
        }// end function

        public static function smash(param1:Unit, param2 = 5, param3 = 1, param4 = 1.5, param5 = 10, param6 = 0, param7 = true, param8 = -1, param9:BitmapData = null)
        {
            var _loc_10:* = undefined;
            var _loc_11:* = undefined;
            var _loc_12:* = undefined;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = undefined;
            var _loc_16:* = null;
            var _loc_17:* = null;
            var _loc_18:* = undefined;
            var _loc_19:* = undefined;
            var _loc_20:* = undefined;
            var _loc_21:* = undefined;
            var _loc_22:* = undefined;
            var _loc_23:* = undefined;
            var _loc_24:* = undefined;
            var _loc_25:* = null;
            var _loc_26:* = undefined;
            var _loc_27:* = undefined;
            var _loc_28:* = undefined;
            var _loc_29:* = undefined;
            var _loc_30:* = undefined;
            var _loc_31:* = undefined;
            var _loc_32:* = undefined;
            var _loc_33:* = undefined;
            if (param1.visible && param1._img != null && param1._img._bitmap != null && param1._img._bitmap.bitmapData != null)
            {
                if (_smashDict[param1._mc] != null)
                {
                    _loc_10 = 0;
                    while (_loc_10 < _smashDict[param1._mc].ptArr.length)
                    {
                        
                        if (_smashDict[param1._mc].ptArr[_loc_10].bmp != null)
                        {
                            if (_smashDict[param1._mc].ptArr[_loc_10].bmp.parent != null)
                            {
                                _smashDict[param1._mc].ptArr[_loc_10].bmp.parent.removeChild(_smashDict[param1._mc].ptArr[_loc_10].bmp);
                            }
                            if (_smashDict[param1._mc].ptArr[_loc_10].bmp.bitmapData != null)
                            {
                                _smashDict[param1._mc].ptArr[_loc_10].bmp.bitmapData.dispose();
                            }
                        }
                        _loc_10 = _loc_10 + 1;
                    }
                    delete _smashDict[param1._mc];
                }
                _loc_12 = new Point();
                _loc_15 = param1._img.bitmap;
                if (param1._img._bitmap.scaleX == 1)
                {
                    _loc_13 = _loc_15.bmpd;
                }
                else
                {
                    _loc_14 = new Matrix();
                    _loc_14.scale(-1, 1);
                    _loc_14.translate(_loc_15.w, 0);
                    _loc_13 = new BitmapData(_loc_15.bmpd.width, _loc_15.bmpd.height, true, 0);
                    _loc_13.draw(_loc_15.bmpd, _loc_14);
                    _loc_15.bmpd.dispose();
                }
                _loc_10 = 0;
                while (_loc_10 < param1._img._bitmap.filters.length)
                {
                    
                    _loc_13.applyFilter(_loc_13, _loc_13.rect, _loc_12, param1._img._bitmap.filters[_loc_10]);
                    _loc_10 = _loc_10 + 1;
                }
                _loc_10 = 0;
                while (_loc_10 < param1._img.filters.length)
                {
                    
                    _loc_13.applyFilter(_loc_13, _loc_13.rect, _loc_12, param1._img.filters[_loc_10]);
                    _loc_10 = _loc_10 + 1;
                }
                _loc_16 = _loc_13.getColorBoundsRect(4278190080, 0, false);
                _loc_23 = param2;
                _loc_24 = param2;
                _loc_25 = [];
                _loc_33 = 0;
                _loc_10 = _loc_16.x;
                while (_loc_10 < _loc_16.x + _loc_16.width)
                {
                    
                    _loc_11 = _loc_16.y;
                    while (_loc_11 < _loc_16.y + _loc_16.height)
                    {
                        
                        if (param3 == 1 || Math.random() < param3)
                        {
                            _loc_17 = new BitmapData(_loc_23, _loc_24, true, 0);
                            _loc_17.copyPixels(_loc_13, new Rectangle(_loc_10, _loc_11, _loc_23, _loc_24), _loc_12);
                            _loc_18 = _loc_17.getColorBoundsRect(4278190080, 0, false);
                            if (_loc_18.width == 0 || _loc_18.height == 0)
                            {
                                _loc_17.dispose();
                            }
                            else
                            {
                                if (param9 != null)
                                {
                                    _loc_17.dispose();
                                    _loc_17 = param9;
                                }
                                if (_loc_15.scale == 1)
                                {
                                    _loc_19 = param1._mc.x + param1._img.x + _loc_15.x + _loc_10;
                                }
                                else
                                {
                                    _loc_19 = param1._mc.x + param1._img.x + _loc_15.x - _loc_15.w + _loc_10;
                                }
                                _loc_20 = param1._mc.y + param1._img.y + _loc_15.y + _loc_11;
                                if (param7)
                                {
                                    _loc_21 = _loc_16.height + _loc_16.y - _loc_11 + param6;
                                }
                                else
                                {
                                    _loc_21 = param6;
                                }
                                _loc_22 = new Bitmap(_loc_17);
                                _loc_22.x = _loc_19;
                                _loc_22.y = _loc_20;
                                _loc_29 = Math.random() * Math.PI * 2;
                                _loc_30 = Math.random() * 32;
                                _loc_31 = Math.floor(Math.random() * param5) + param5;
                                _loc_33 = Math.max(_loc_31, _loc_33);
                                param1._map._textMap.addChild(_loc_22);
                                _loc_26 = Math.cos(_loc_29) * _loc_30 / _loc_31;
                                _loc_27 = Math.sin(_loc_29) * _loc_30 / _loc_31;
                                _loc_32 = param4;
                                _loc_28 = (-(_loc_21 - _loc_32 * _loc_31 * _loc_31 / 2)) / _loc_31;
                                _loc_25.push({bmp:_loc_22, count:_loc_31, initX:_loc_19, initY:_loc_20, initZ:_loc_21, x:0, y:0, z:_loc_21, xSpeed:_loc_26, ySpeed:_loc_27, zSpeed:_loc_28, gravity:_loc_32});
                            }
                        }
                        _loc_11 = _loc_11 + _loc_24;
                    }
                    _loc_10 = _loc_10 + _loc_23;
                }
                _loc_13.dispose();
                _smashDict[param1._mc] = {unit:param1, unitMc:param1._mc, ptArr:_loc_25, count:_loc_33 + 10, disappearCount:param8};
                param1._mc.addEventListener(Event.ENTER_FRAME, smashLoop);
                smashLoop(null, param1._mc);
            }
            return;
        }// end function

        public static function smashLoop(param1 = null, param2 = null)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            if (Config.paused)
            {
                return;
            }
            if (param1 != null)
            {
                _loc_3 = _smashDict[param1.target];
                _loc_4 = param1.target;
            }
            else
            {
                _loc_3 = _smashDict[param2];
                _loc_4 = param2;
            }
            _loc_5 = 0;
            while (_loc_5 < _loc_3.ptArr.length)
            {
                
                if (_loc_3.ptArr[_loc_5].count >= 0)
                {
                    _loc_3.ptArr[_loc_5].x = _loc_3.ptArr[_loc_5].x + _loc_3.ptArr[_loc_5].xSpeed;
                    _loc_3.ptArr[_loc_5].y = _loc_3.ptArr[_loc_5].y + _loc_3.ptArr[_loc_5].ySpeed;
                    _loc_3.ptArr[_loc_5].z = _loc_3.ptArr[_loc_5].z - _loc_3.ptArr[_loc_5].zSpeed;
                    _loc_3.ptArr[_loc_5].bmp.x = _loc_3.ptArr[_loc_5].initX + _loc_3.ptArr[_loc_5].x - _loc_3.ptArr[_loc_5].y;
                    _loc_3.ptArr[_loc_5].bmp.y = _loc_3.ptArr[_loc_5].initY + (_loc_3.ptArr[_loc_5].x + _loc_3.ptArr[_loc_5].y) / 2 + _loc_3.ptArr[_loc_5].z - _loc_3.ptArr[_loc_5].initZ;
                    _loc_3.ptArr[_loc_5].zSpeed = _loc_3.ptArr[_loc_5].zSpeed - _loc_3.ptArr[_loc_5].gravity;
                    var _loc_6:* = _loc_3.ptArr[_loc_5];
                    var _loc_7:* = _loc_3.ptArr[_loc_5].count - 1;
                    _loc_6.count = _loc_7;
                    if (_loc_3.disappearCount > 0)
                    {
                        if (_loc_3.ptArr[_loc_5].count <= _loc_3.disappearCount)
                        {
                            _loc_3.ptArr[_loc_5].bmp.alpha = _loc_3.ptArr[_loc_5].bmp.alpha - Math.ceil(1 / _loc_3.disappearCount * 10) / 10;
                        }
                    }
                }
                _loc_5 = _loc_5 + 1;
            }
            var _loc_6:* = _loc_3;
            var _loc_7:* = _loc_3.count - 1;
            _loc_6.count = _loc_7;
            if (_loc_3.count <= 0)
            {
                _loc_5 = 0;
                while (_loc_5 < _loc_3.ptArr.length)
                {
                    
                    if (_loc_3.ptArr[_loc_5].bmp.parent != null)
                    {
                        _loc_3.ptArr[_loc_5].bmp.parent.removeChild(_loc_3.ptArr[_loc_5].bmp);
                    }
                    _loc_3.ptArr[_loc_5].bmp.bitmapData.dispose();
                    _loc_5 = _loc_5 + 1;
                }
                delete _smashDict[_loc_4];
                _loc_4.removeEventListener(Event.ENTER_FRAME, smashLoop);
            }
            else if (_loc_3.count < 5)
            {
                _loc_5 = 0;
                while (_loc_5 < _loc_3.ptArr.length)
                {
                    
                    _loc_3.ptArr[_loc_5].bmp.alpha = _loc_3.ptArr[_loc_5].bmp.alpha - 0.2;
                    _loc_5 = _loc_5 + 1;
                }
            }
            return;
        }// end function

        public static function shock(param1:Unit, param2, param3 = 10)
        {
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            if (param1.visible && _jumpDict[param1] == null && param1._img != null && param1._img._ready)
            {
                _loc_4 = false;
                if (_shockDict[param1._mc] != null)
                {
                    _loc_4 = true;
                    delete _shockDict[param1._mc];
                }
                _shockDict[param1._mc] = {unit:param1, angle:param2, count:param3};
                param1.removeEventListener("destroy", subShockDestroy);
                param1.addEventListener("destroy", subShockDestroy);
                param1._mc.removeEventListener(Event.ENTER_FRAME, shockLoop);
                param1._mc.addEventListener(Event.ENTER_FRAME, shockLoop);
                if (!_loc_4)
                {
                    shockLoop(null, param1);
                }
                else
                {
                    param1._img._bitmap.x = param1._img.bitmapX;
                    param1._img._bitmap.y = param1._img.bitmapY;
                    for (_loc_5 in param1._img._exLayerArray)
                    {
                        
                        if (param1._img._exLayerArray[_loc_5]._bitmap != null && param1._img._exLayerArray[_loc_5]._bitmap.bitmapData != null && param1._img._exLayerArray[_loc_5]._bitmapRect != null)
                        {
                            param1._img._exLayerArray[_loc_5]._bitmap.x = param1._img.getLayerX(_loc_5);
                            param1._img._exLayerArray[_loc_5]._bitmap.y = param1._img.getLayerY(_loc_5);
                        }
                    }
                    param1._img.zoff = 0;
                }
            }
            return;
        }// end function

        public static function subShockDestroy(param1 = null)
        {
            var _loc_3:* = undefined;
            var _loc_2:* = param1.target;
            if (_loc_2._img != null && _loc_2._img._bitmap != null)
            {
                _loc_2._img._bitmap.x = _loc_2._img.bitmapX;
                _loc_2._img._bitmap.y = _loc_2._img.bitmapY;
                for (_loc_3 in _loc_2._img._exLayerArray)
                {
                    
                    if (_loc_2._img._exLayerArray[_loc_3]._bitmap != null && _loc_2._img._exLayerArray[_loc_3]._bitmap.bitmapData != null && _loc_2._img._exLayerArray[_loc_3]._bitmapRect != null)
                    {
                        _loc_2._img._exLayerArray[_loc_3]._bitmap.x = _loc_2._img.getLayerX(_loc_3);
                        _loc_2._img._exLayerArray[_loc_3]._bitmap.y = _loc_2._img.getLayerY(_loc_3);
                    }
                }
                _loc_2._img.zoff = 0;
                delete _shockDict[_loc_2._mc];
                _loc_2.removeEventListener("destroy", subShockDestroy);
                _loc_2._mc.removeEventListener(Event.ENTER_FRAME, shockLoop);
            }
            return;
        }// end function

        private static function shockLoop(param1 = null, param2 = null)
        {
            var obj:*;
            var unit:*;
            var i:*;
            var dis:*;
            var xoffset:*;
            var yoffset:*;
            var event:* = param1;
            var unitx:* = param2;
            if (Config.paused)
            {
                return;
            }
            if (event != null)
            {
                obj = _shockDict[event.target];
                unit = obj.unit;
            }
            else
            {
                obj = _shockDict[unitx._mc];
                unit = unitx;
            }
            try
            {
                dis = obj.count;
                xoffset = Math.cos(obj.angle) * dis;
                yoffset = Math.sin(obj.angle) * dis;
                unit._img._bitmap.x = unit._img.bitmapX + xoffset;
                unit._img._bitmap.y = unit._img.bitmapY + yoffset;
                var _loc_4:* = 0;
                var _loc_5:* = unit._img._exLayerArray;
                while (_loc_5 in _loc_4)
                {
                    
                    i = _loc_5[_loc_4];
                    if (unit._img._exLayerArray[i]._bitmap != null && unit._img._exLayerArray[i]._bitmap.bitmapData != null && unit._img._exLayerArray[i]._bitmapRect != null)
                    {
                        unit._img._exLayerArray[i]._bitmap.x = unit._img.getLayerX(i) + xoffset;
                        unit._img._exLayerArray[i]._bitmap.y = unit._img.getLayerY(i) + yoffset;
                    }
                }
                obj.count = obj.count - 2;
                if (obj.count <= 0)
                {
                    unit._img._bitmap.x = unit._img.bitmapX;
                    unit._img._bitmap.y = unit._img.bitmapY;
                    var _loc_4:* = 0;
                    var _loc_5:* = unit._img._exLayerArray;
                    while (_loc_5 in _loc_4)
                    {
                        
                        i = _loc_5[_loc_4];
                        if (unit._img._exLayerArray[i]._bitmap != null && unit._img._exLayerArray[i]._bitmap.bitmapData != null && unit._img._exLayerArray[i]._bitmapRect != null)
                        {
                            unit._img._exLayerArray[i]._bitmap.x = unit._img.getLayerX(i);
                            unit._img._exLayerArray[i]._bitmap.y = unit._img.getLayerY(i);
                        }
                    }
                    unit.removeEventListener("destroy", subShockDestroy);
                    unit._mc.removeEventListener(Event.ENTER_FRAME, shockLoop);
                    delete _shockDict[unit._mc];
                }
            }
            catch (e)
            {
                unit.removeEventListener("destroy", subShockDestroy);
                unit._mc.removeEventListener(Event.ENTER_FRAME, shockLoop);
            }
            return;
        }// end function

        public static function flash(param1:Unit)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = null;
            if (param1 != null && param1._img != null && param1._img._bitmap)
            {
                _loc_2 = param1._img.bitmap;
                if (_loc_2 != null)
                {
                    _loc_3 = _loc_2.bmpd;
                    _loc_4 = new Bitmap(_loc_3);
                    _loc_4.x = param1._mc.x + param1._img.x + _loc_2.x;
                    _loc_4.y = param1._mc.y + param1._img.y + _loc_2.y;
                    _loc_4.scaleX = _loc_2.scale;
                    param1._map._rootMap.addChild(_loc_4);
                    _loc_4.addEventListener(Event.ENTER_FRAME, handleFlashEnterFrame);
                }
            }
            return;
        }// end function

        private static function handleFlashEnterFrame(param1)
        {
            if (Config.paused)
            {
                return;
            }
            var _loc_2:* = param1.target;
            _loc_2.alpha = _loc_2.alpha / 1.05;
            if (_loc_2.alpha < 0.05)
            {
                _loc_2.removeEventListener(Event.ENTER_FRAME, handleFlashEnterFrame);
                _loc_2.bitmapData.dispose();
                if (_loc_2.parent != null)
                {
                    _loc_2.parent.removeChild(_loc_2);
                }
            }
            return;
        }// end function

        public static function colorTransform(param1, param2 = 561384, param3 = 1, param4 = 6)
        {
            var _loc_5:* = undefined;
            if (param1.visible && param1._img != null)
            {
                _loc_5 = false;
                if (_colorTransformDict[param1._mc] != null)
                {
                    _loc_5 = true;
                    delete _colorTransformDict[param1._mc];
                }
                _colorTransformDict[param1._mc] = {unit:param1, color:param2, starting:param3, ending:param4, frame:0};
                param1.removeEventListener("destroy", subColorTransformDestroy);
                param1.addEventListener("destroy", subColorTransformDestroy);
                param1._mc.removeEventListener(Event.ENTER_FRAME, subColorTransform);
                param1._mc.addEventListener(Event.ENTER_FRAME, subColorTransform);
                if (!_loc_5)
                {
                    subColorTransform(null, param1);
                }
                else
                {
                    param1._img.transform.colorTransform = new ColorTransform();
                }
            }
            return;
        }// end function

        public static function killTransform(param1)
        {
            if (_colorTransformDict[param1._mc] != null)
            {
                delete _colorTransformDict[param1._mc];
            }
            param1._img.transform.colorTransform = new ColorTransform();
            param1.removeEventListener("destroy", subColorTransformDestroy);
            param1._mc.removeEventListener(Event.ENTER_FRAME, subColorTransform);
            return;
        }// end function

        public static function subColorTransformDestroy(param1 = null)
        {
            var _loc_2:* = param1.target;
            killTransform(_loc_2);
            return;
        }// end function

        public static function subColorTransform(param1 = null, param2 = null)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            if (Config.paused)
            {
                return;
            }
            if (param1 != null)
            {
                _loc_3 = _colorTransformDict[param1.target];
                if (_loc_3 == null)
                {
                    param1.target.removeEventListener(Event.ENTER_FRAME, subColorTransform);
                }
                _loc_4 = _loc_3.unit;
            }
            else
            {
                _loc_3 = _colorTransformDict[param2._mc];
                _loc_4 = param2;
            }
            if (_loc_3.frame == _loc_3.starting)
            {
                _loc_5 = _loc_3.color >> 16 & 255;
                _loc_6 = _loc_3.color >> 8 & 255;
                _loc_7 = _loc_3.color & 255;
                _loc_4._img.transform.colorTransform = new ColorTransform(_loc_5 / 255, _loc_6 / 255, _loc_7 / 255, 1, 0, 0, 0, 0);
            }
            else if (_loc_3.frame == _loc_3.ending)
            {
                _loc_4._img.transform.colorTransform = new ColorTransform();
                delete _colorTransformDict[_loc_4._mc];
                _loc_4.removeEventListener("destroy", subColorTransformDestroy);
                _loc_4._mc.removeEventListener(Event.ENTER_FRAME, subColorTransform);
                return;
            }
            var _loc_8:* = _loc_3;
            var _loc_9:* = _loc_3.frame + 1;
            _loc_8.frame = _loc_9;
            return;
        }// end function

        public static function motionEffectParam(param1, param2, param3, param4)
        {
            var _loc_5:* = param4.split("_");
            while (_loc_5.length < 28)
            {
                
                _loc_5.push(0);
            }
            motionEffect(param1, param2, param3, Number(_loc_5[0]), Number(_loc_5[1]), Number(_loc_5[2]), Number(_loc_5[3]), Number(_loc_5[4]), Number(_loc_5[5]), Number(_loc_5[6]), Number(_loc_5[7]), Number(_loc_5[8]), Number(_loc_5[9]), Number(_loc_5[10]), Number(_loc_5[11]), Number(_loc_5[12]), Number(_loc_5[13]), Number(_loc_5[14]), Number(_loc_5[15]), Number(_loc_5[16]), Number(_loc_5[17]), Number(_loc_5[18]), Number(_loc_5[19]), Number(_loc_5[20]), Number(_loc_5[21]), Number(_loc_5[22]), Number(_loc_5[23]), Number(_loc_5[24]), Number(_loc_5[25]), Number(_loc_5[26]), Number(_loc_5[27]));
            return;
        }// end function

        public static function motionEffect(param1, param2, param3, param4, param5, param6 = 0, param7 = 0, param8 = 1, param9 = 0, param10 = 0, param11 = -1, param12 = 0, param13 = 0, param14 = 0, param15 = 0, param16 = 0, param17 = 0, param18 = 0, param19 = 0, param20 = 0, param21 = 0, param22 = 0, param23 = 0, param24 = 0, param25 = 0, param26 = 0, param27 = 0, param28 = 0, param29 = 0, param30 = 0, param31 = 0)
        {
            var _loc_32:* = undefined;
            var _loc_33:* = undefined;
            var _loc_34:* = undefined;
            var _loc_35:* = undefined;
            var _loc_36:* = undefined;
            var _loc_37:* = undefined;
            var _loc_38:* = undefined;
            var _loc_39:* = undefined;
            var _loc_40:* = null;
            if (param2._angle == null)
            {
                if (param3 != null)
                {
                    _loc_39 = Math.atan2(param3._y - param2._y, param3._x - param2._x);
                }
                else
                {
                    _loc_39 = 0;
                }
            }
            else
            {
                _loc_39 = param2._angle;
            }
            if (param19 > 0)
            {
                _loc_37 = 0;
                _loc_38 = _loc_39;
            }
            else if (param11 == -1)
            {
                _loc_37 = Math.PI * 2 / param5;
                _loc_38 = _loc_37 * Math.random();
            }
            else if (param5 == 1)
            {
                _loc_37 = 0;
                _loc_38 = _loc_39;
            }
            else
            {
                _loc_37 = param11 / (param5 - 1);
                _loc_38 = _loc_39 - param11 / 2;
            }
            _loc_32 = 0;
            while (_loc_32 < param5)
            {
                
                if (param15 == 0)
                {
                    _loc_35 = _loc_38 + _loc_37 * _loc_32;
                    _loc_36 = param9;
                    _loc_33 = param2._x + Math.cos(_loc_35) * _loc_36;
                    _loc_34 = param2._y + Math.sin(_loc_35) * _loc_36;
                }
                else if (param15 == 1)
                {
                    if (param19 > 0)
                    {
                        _loc_35 = _loc_39;
                    }
                    else if (param11 == -1)
                    {
                        _loc_35 = Math.PI * 2 * Math.random();
                    }
                    else
                    {
                        _loc_35 = _loc_39 - Math.random() * param11 + param11 / 2;
                    }
                    _loc_36 = param9 + (param10 - param9) * Math.random();
                    _loc_33 = param2._x + Math.cos(_loc_35) * _loc_36;
                    _loc_34 = param2._y + Math.sin(_loc_35) * _loc_36;
                }
                _loc_40 = Effect.newEffect(Config._model[param4], _loc_33, _loc_34, param6, param18, param21);
                _loc_40.display(param1);
                _loc_40._img.data.interval = param28 * _loc_32;
                if (_loc_40._img.data.interval > 0)
                {
                    _loc_40.visible = false;
                    _loc_40._img.locked = true;
                }
                _loc_40._img.zoff = param22;
                _loc_40._img.xoff = param25;
                if (param20 == -1)
                {
                    _loc_40._img.setHue(int(Math.random() * 360));
                }
                else
                {
                    _loc_40._img.setHue(param20);
                }
                _loc_40._img.data.centerObj = param2;
                _loc_40._img.data.center = {_x:param2._x, _y:param2._y};
                _loc_40._img.data.target = param3;
                _loc_40._img.data.centerAngle = _loc_39;
                _loc_40._img.data.lockTarget = param19;
                _loc_40._img.data.lockStart = param30;
                _loc_40._img.data.map = param1;
                _loc_40._img.data.count = 0;
                _loc_40._img.data.layer = param6;
                _loc_40._img.data.halo = param18;
                _loc_40._img.data.quake = param31;
                _loc_40._img.data.chaos = param29;
                _loc_40._img.data.chaosSpeed = 0;
                _loc_40._img.data.chaosPos = 0;
                _loc_40._img.data.shadow = param21;
                _loc_40._img.data.initZ = param22;
                _loc_40._img.data.z = param22;
                _loc_40._img.data.zSpeed = param23;
                _loc_40._img.data.zAcc = param24;
                _loc_40._img.data.xoff = param25;
                _loc_40._img.data.xoffSpeed = param26;
                _loc_40._img.data.xoffAcc = param27;
                _loc_40._img.data.effectId = param4;
                _loc_40._img.data.hue = param20;
                _loc_40._img.data.frame = param7;
                _loc_40._img.data.currentRound = 0;
                _loc_40._img.data.currentR = _loc_36;
                _loc_40._img.data.round = param8;
                _loc_40._img.data.startRange = param9;
                _loc_40._img.data.endRange = param10;
                _loc_40._img.data.verticalSpeed = param12;
                _loc_40._img.data.angleSpeed = param13;
                _loc_40._img.data.curvature = param14;
                _loc_40._img.data.startX = _loc_33;
                _loc_40._img.data.startY = _loc_34;
                _loc_40._img.data.startAngle = _loc_35;
                _loc_40._img.data.returnMode = param16;
                _loc_40._img.data.sector = param11;
                _loc_40._img.data.moveMode = param17;
                _loc_40._img.data.gen = 0;
                _loc_40._img.removeEventListener(Event.ENTER_FRAME, motionEffectLoop);
                _loc_40._img.addEventListener(Event.ENTER_FRAME, motionEffectLoop);
                if (param17 != 0)
                {
                    _loc_40.removeEventListener("over", handleEffectOver);
                    _loc_40.addEventListener("over", handleEffectOver);
                    _loc_40.removeEventListener("destroy", handleEffectDestroy);
                    _loc_40.addEventListener("destroy", handleEffectDestroy);
                }
                _loc_32 = _loc_32 + 1;
            }
            return;
        }// end function

        private static function handleEffectDestroy(param1)
        {
            if (param1.target._img != null)
            {
                param1.target._img.removeEventListener(Event.ENTER_FRAME, motionEffectLoop);
            }
            param1.target.removeEventListener("destroy", handleEffectDestroy);
            param1.target.removeEventListener("over", handleEffectOver);
            return;
        }// end function

        private static function handleEffectOver(param1)
        {
            var effectImg:*;
            var data:*;
            var event:* = param1;
            try
            {
                effectImg = event.target._img;
                event.target._img.removeEventListener(Event.ENTER_FRAME, motionEffectLoop);
                event.target.removeEventListener("destroy", handleEffectDestroy);
                event.target.removeEventListener("over", handleEffectOver);
                if (effectImg != null)
                {
                    data = effectImg.data;
                    if (data.quake > 0)
                    {
                        MapEffect.quake(data.map, data.quake);
                    }
                    event.target._img.removeEventListener(Event.ENTER_FRAME, motionEffectLoop);
                }
                else
                {
                    event.target.destroy();
                }
                event.target.over();
            }
            catch (e)
            {
                trace("handleEffectOver", e);
            }
            return;
        }// end function

        private static function motionEffectLoop(param1 = null, param2 = null)
        {
            var effectImg:*;
            var effect:*;
            var data:*;
            var preAngle:*;
            var r:*;
            var x:*;
            var y:*;
            var a:*;
            var temp:*;
            var chaos:*;
            var faceAngle:*;
            var newEffect:Effect;
            var event:* = param1;
            var mc:* = param2;
            if (Config.paused)
            {
                return;
            }
            try
            {
                effectImg = event.target;
                effect = effectImg.data.parentEffect;
                data = effectImg.data;
                if (!(effectImg.data.parentEffect is Effect) || effectImg._destroyed)
                {
                    effectImg.removeEventListener(Event.ENTER_FRAME, motionEffectLoop);
                    event.target.removeEventListener("destroy", handleEffectDestroy);
                    event.target.removeEventListener("over", handleEffectOver);
                    data.parentEffect.removeEventListener("destroy", handleEffectDestroy);
                    data.parentEffect.removeEventListener("over", handleEffectOver);
                    return;
                }
                if (data.interval > 1)
                {
                    var _loc_4:* = data;
                    var _loc_5:* = data.interval - 1;
                    _loc_4.interval = _loc_5;
                    return;
                }
                else if (data.interval == 1)
                {
                    if (effectImg._ready)
                    {
                        var _loc_4:* = data;
                        var _loc_5:* = data.interval - 1;
                        _loc_4.interval = _loc_5;
                        effectImg.locked = false;
                        effect.replay();
                        if (data.lockStart == 1)
                        {
                            data.center = {_x:data.centerObj._x, _y:data.centerObj._y};
                            effect.move(data.center._x + Math.cos(data.startAngle) * data.currentR, data.center._y + Math.sin(data.startAngle) * data.currentR);
                        }
                        effect.visible = true;
                    }
                    else
                    {
                        return;
                    }
                }
                else if (effectImg._ready)
                {
                    if (effectImg.locked)
                    {
                        effectImg.locked = false;
                        if (effect != null)
                        {
                            effect.replay();
                        }
                    }
                }
                else
                {
                    effectImg.locked = true;
                    return;
                }
                if (!effectImg._ready)
                {
                    effectImg.removeEventListener(Event.ENTER_FRAME, motionEffectLoop);
                    return;
                }
                var _loc_4:* = data;
                var _loc_5:* = data.count + 1;
                _loc_4.count = _loc_5;
                temp = data.curvature * data.angleSpeed + data.verticalSpeed;
                if (temp != 0 && data.lockTarget == 0)
                {
                    if (data.returnMode == 1 && data.currentRound % 2 == 1)
                    {
                        data.currentR = data.currentR - temp;
                        if (data.currentR < Math.min(data.startRange, data.endRange) || data.currentR > Math.max(data.startRange, data.endRange))
                        {
                            var _loc_4:* = data;
                            var _loc_5:* = data.currentRound + 1;
                            _loc_4.currentRound = _loc_5;
                            data.currentR = data.startRange;
                        }
                    }
                    else
                    {
                        data.currentR = data.currentR + temp;
                        if (data.currentR < Math.min(data.startRange, data.endRange) || data.currentR > Math.max(data.startRange, data.endRange))
                        {
                            var _loc_4:* = data;
                            var _loc_5:* = data.currentRound + 1;
                            _loc_4.currentRound = _loc_5;
                            if (data.returnMode == 0)
                            {
                                data.currentR = data.startRange;
                            }
                            else
                            {
                                data.currentR = data.endRange;
                            }
                        }
                    }
                }
                if (data.moveMode == 0 && data.lockTarget == 0 && (data.frame != 0 && data.count >= data.frame || data.frame == 0 && data.round != 0 && data.currentRound >= data.round || data.z < 0 || data.z > 500))
                {
                    effectImg.removeEventListener(Event.ENTER_FRAME, motionEffectLoop);
                    data.parentEffect.removeEventListener("destroy", handleEffectDestroy);
                    data.parentEffect.removeEventListener("over", handleEffectOver);
                    if (data.z < 0)
                    {
                        if (data.quake > 0)
                        {
                            MapEffect.quake(data.map, data.quake);
                        }
                    }
                    data.parentEffect.over();
                }
                else
                {
                    preAngle = data.centerAngle;
                    if (data.zSpeed != 0 || data.zAcc != 0)
                    {
                        data.z = data.z + data.zSpeed;
                        data.zSpeed = data.zSpeed + data.zAcc;
                    }
                    if (data.lockTarget == 1)
                    {
                        a = Math.atan2(data.target._y - effect._y, data.target._x - effect._x);
                        data.currentR = data.currentR + temp;
                        if (data.target == null || data.target is Unit && data.target._die || temp == 0 || Math.sqrt(Math.pow(data.target._y - data.center._y, 2) + Math.pow(data.target._x - data.center._x, 2)) - data.currentR < temp)
                        {
                            effectImg.removeEventListener(Event.ENTER_FRAME, motionEffectLoop);
                            data.parentEffect.removeEventListener("destroy", handleEffectDestroy);
                            data.parentEffect.removeEventListener("over", handleEffectOver);
                            data.parentEffect.over();
                            return;
                        }
                        if (data.chaos == 0)
                        {
                            x = data.currentR * Math.cos(a);
                            y = data.currentR * Math.sin(a);
                        }
                        else if (data.chaos > 0)
                        {
                            chaos = (-Math.random()) * data.chaos * 2 - data.chaos;
                            x = data.currentR * Math.cos(a + chaos);
                            y = data.currentR * Math.sin(a + chaos);
                        }
                        else if (data.chaos < 0)
                        {
                            chaos = Math.random() * data.chaos * 2 + data.chaos;
                            data.chaosSpeed = data.chaosSpeed + (chaos - data.chaosPos) * 0.1;
                            data.chaosPos = data.chaosPos + data.chaosSpeed;
                            x = data.currentR * Math.cos(a + data.chaosPos);
                            y = data.currentR * Math.sin(a + data.chaosPos);
                        }
                        data.z = data.initZ * Math.min(1, 1 - data.currentR / Math.sqrt(Math.pow(data.target._y - data.center._y, 2) + Math.pow(data.target._x - data.center._x, 2)));
                    }
                    else if (data.lockTarget == 2)
                    {
                        if (data.z < 0 || data.z > 500)
                        {
                            effectImg.removeEventListener(Event.ENTER_FRAME, motionEffectLoop);
                            data.parentEffect.removeEventListener("destroy", handleEffectDestroy);
                            data.parentEffect.removeEventListener("over", handleEffectOver);
                            if (data.z < 0)
                            {
                                if (data.quake > 0)
                                {
                                    MapEffect.quake(data.map, data.quake);
                                }
                            }
                            data.parentEffect.over();
                            return;
                        }
                        a = Math.atan2(data.target._y - effect._y, data.target._x - effect._x);
                        data.currentR = Math.sqrt(Math.pow(data.target._y - data.center._y, 2) + Math.pow(data.target._x - data.center._x, 2)) * (1 - data.z / data.initZ);
                        if (data.chaos == 0)
                        {
                            x = data.currentR * Math.cos(a);
                            y = data.currentR * Math.sin(a);
                        }
                        else if (data.chaos > 0)
                        {
                            chaos = Math.random() * data.chaos * 2 - data.chaos;
                            x = data.currentR * Math.cos(a + chaos);
                            y = data.currentR * Math.sin(a + chaos);
                        }
                        else if (data.chaos < 0)
                        {
                            chaos = (-Math.random()) * data.chaos * 2 + data.chaos;
                            data.chaosSpeed = data.chaosSpeed + (chaos - data.chaosPos) * 0.1;
                            data.chaosPos = data.chaosPos + data.chaosSpeed;
                            x = data.currentR * Math.cos(a + data.chaosPos);
                            y = data.currentR * Math.sin(a + data.chaosPos);
                        }
                    }
                    else
                    {
                        a = data.startAngle + data.angleSpeed * data.count;
                        if (data.chaos == 0)
                        {
                            x = data.currentR * Math.cos(a);
                            y = data.currentR * Math.sin(a);
                        }
                        else if (data.chaos > 0)
                        {
                            chaos = Math.random() * data.chaos * 2 - data.chaos;
                            x = data.currentR * Math.cos(a + chaos);
                            y = data.currentR * Math.sin(a + chaos);
                        }
                        else if (data.chaos < 0)
                        {
                            chaos = (-Math.random()) * data.chaos * 2 + data.chaos;
                            data.chaosSpeed = data.chaosSpeed + (chaos - data.chaosPos) * 0.1;
                            data.chaosPos = data.chaosPos + data.chaosSpeed;
                            x = data.currentR * Math.cos(a + data.chaosPos);
                            y = data.currentR * Math.sin(a + data.chaosPos);
                        }
                    }
                    faceAngle = Math.atan2(data.center._y + y - effect._y, data.center._x + x - effect._x);
                    effect.directTo(faceAngle);
                    if (data.xoffSpeed != 0 || data.xoffAcc != 0)
                    {
                        data.xoff = data.xoff + data.xoffSpeed;
                        data.xoffSpeed = data.xoffSpeed + data.xoffAcc;
                    }
                    if (data.moveMode == 0)
                    {
                        effect.move(data.center._x + x, data.center._y + y);
                        effect._img.zoff = Math.max(-1, data.z);
                        if (data.xoffSpeed != 0 || data.zAcc != 0)
                        {
                            effect._img.xoff = data.xoff;
                        }
                    }
                    else if (data.count % data.moveMode == 0)
                    {
                        if (data.frame != 0 && data.count > data.frame || data.frame == 0 && data.round != 0 && data.currentRound >= data.round)
                        {
                        }
                        else
                        {
                            newEffect = Effect.newEffect(Config._model[data.effectId], data.center._x + x, data.center._y + y, data.layer, data.halo, data.shadow);
                            newEffect.display(data.map);
                            if (data.z > 0)
                            {
                                newEffect._img.zoff = data.z;
                            }
                            newEffect._img.xoff = data.xoff;
                            newEffect.directTo(faceAngle);
                            if (data.hue == -1)
                            {
                                newEffect._img.setHue(int(Math.random() * 360));
                            }
                            else
                            {
                                newEffect._img.setHue(data.hue);
                            }
                            newEffect._img.data.center = {_x:data.center._x, _y:data.center._y};
                            newEffect._img.data.target = data.target;
                            newEffect._img.data.centerAngle = data.centerAngle;
                            newEffect._img.data.lockTarget = data.lockTarget;
                            newEffect._img.data.lockStart = data.lockStart;
                            newEffect._img.data.map = data.map;
                            newEffect._img.data.count = data.count;
                            newEffect._img.data.layer = data.layer;
                            newEffect._img.data.halo = data.halo;
                            newEffect._img.data.shock = data.shock;
                            newEffect._img.data.chaos = data.chaos;
                            newEffect._img.data.chaosSpeed = data.chaosSpeed;
                            newEffect._img.data.chaosPos = data.chaosPos;
                            newEffect._img.data.shadow = data.shadow;
                            newEffect._img.data.initZ = data.initZ;
                            newEffect._img.data.z = data.z;
                            newEffect._img.data.zSpeed = data.zSpeed;
                            newEffect._img.data.zAcc = data.zAcc;
                            newEffect._img.data.xoff = data.xoff;
                            newEffect._img.data.xoffSpeed = data.xoffSpeed;
                            newEffect._img.data.xoffAcc = data.xoffAcc;
                            newEffect._img.data.effectId = data.effectId;
                            newEffect._img.data.hue = data.hue;
                            newEffect._img.data.frame = data.frame;
                            newEffect._img.data.currentRound = data.currentRound;
                            newEffect._img.data.currentR = data.currentR;
                            newEffect._img.data.round = data.round;
                            newEffect._img.data.startRange = data.startRange;
                            newEffect._img.data.endRange = data.endRange;
                            newEffect._img.data.verticalSpeed = data.verticalSpeed;
                            newEffect._img.data.angleSpeed = data.angleSpeed;
                            newEffect._img.data.curvature = data.curvature;
                            newEffect._img.data.startAngle = data.startAngle;
                            newEffect._img.data.returnMode = data.returnMode;
                            newEffect._img.data.sector = data.sector;
                            newEffect._img.data.moveMode = data.moveMode;
                            newEffect._img.data.gen = data.gen + 1;
                            if (data.z >= 0 && data.z < 500)
                            {
                                newEffect._img.removeEventListener(Event.ENTER_FRAME, motionEffectLoop);
                                newEffect._img.addEventListener(Event.ENTER_FRAME, motionEffectLoop);
                            }
                            newEffect.removeEventListener("over", handleEffectOver);
                            newEffect.addEventListener("over", handleEffectOver);
                            newEffect.removeEventListener("destroy", handleEffectDestroy);
                            newEffect.addEventListener("destroy", handleEffectDestroy);
                        }
                        effectImg.removeEventListener(Event.ENTER_FRAME, motionEffectLoop);
                    }
                }
            }
            catch (e)
            {
                effectImg = event.target;
                if (effectImg != null)
                {
                    effectImg.removeEventListener(Event.ENTER_FRAME, motionEffectLoop);
                    data = effectImg.data;
                    if (data != null && data.parentEffect != null)
                    {
                        data.parentEffect.removeEventListener("destroy", handleEffectDestroy);
                        data.parentEffect.removeEventListener("over", handleEffectOver);
                        data.parentEffect.over();
                    }
                    else
                    {
                        effectImg.destroy();
                        if (effectImg.parent != null)
                        {
                            if (effectImg.parent.parent != null && effectImg.parent is Effect)
                            {
                                effectImg.parent.parent.removeChild(effectImg.parent);
                            }
                            effectImg.parent.removeChild(effectImg);
                        }
                    }
                }
            }
            return;
        }// end function

        public static function tileEffect(param1:Map, param2, param3, param4, param5)
        {
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = undefined;
            var _loc_13:* = undefined;
            var _loc_14:* = undefined;
            _loc_10 = param1.mapToTile(param2);
            _loc_12 = param1.tileToMap(_loc_10);
            _loc_13 = param2._x - _loc_12._x;
            _loc_14 = param2._y - _loc_12._y;
            var _loc_15:* = [];
            var _loc_16:* = Math.ceil(param4 / Map._ptPerTile * 2);
            if (_loc_10 == null)
            {
                return;
            }
            _loc_6 = _loc_10._x - _loc_16;
            while (_loc_6 < _loc_10._x + _loc_16 + 1)
            {
                
                _loc_7 = _loc_10._y - _loc_16;
                while (_loc_7 < _loc_10._y + _loc_16 + 1)
                {
                    
                    if (_loc_6 >= 0 && _loc_6 < param1._logicalWidth && _loc_7 >= 0 && _loc_7 < param1._logicalHeight)
                    {
                        _loc_9 = param1._logicalTile[_loc_6][_loc_7];
                        _loc_8 = param1.tileToMap(_loc_9);
                        if (Math.sqrt(Math.pow(_loc_8._y - _loc_12._y, 2) + Math.pow(_loc_8._x - _loc_12._x, 2)) <= param4)
                        {
                            _loc_11 = Effect.newEffect(Config._model[param3], _loc_8._x + _loc_13, _loc_8._y + _loc_14, 3);
                            _loc_11.display(param1);
                            _loc_15.push(_loc_11);
                        }
                    }
                    _loc_7 = _loc_7 + 1;
                }
                _loc_6 = _loc_6 + 1;
            }
            setTimeout(killTileEffect, Math.round(param5 / 30 * 1000), _loc_15);
            return;
        }// end function

        public static function killTileEffect(param1)
        {
            var _loc_2:* = undefined;
            _loc_2 = 0;
            while (_loc_2 < param1.length)
            {
                
                param1[_loc_2].destroy();
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public static function runEffect(param1:Map, param2, param3, param4, param5, param6, param7, param8, param9 = 0)
        {
            var _loc_10:* = param2._angle;
            var _loc_11:* = param2._x + Math.cos(_loc_10 + Math.PI) * param4 / 2;
            var _loc_12:* = param2._y + Math.sin(_loc_10 + Math.PI) * param4 / 2;
            var _loc_13:* = _loc_10 + Math.PI / 2;
            var _loc_14:* = Math.random() * param5;
            var _loc_15:* = _loc_11 + Math.cos(_loc_13) * (_loc_14 - param5 / 2);
            var _loc_16:* = _loc_12 + Math.sin(_loc_13) * (_loc_14 - param5 / 2);
            var _loc_17:* = param6 / Config.fps;
            var _loc_18:* = Math.floor(param4 / _loc_17);
            createRunEffect(param3, _loc_11, _loc_12, param1, _loc_10, _loc_18, param5, _loc_17, param7, param8, param9, false);
            if (param8 > 0)
            {
                setTimeout(createRunEffect, param7, param3, _loc_11, _loc_12, param1, _loc_10, _loc_18, param5, _loc_17, param7, (param8 - 1), param9);
            }
            return;
        }// end function

        private static function createRunEffect(param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12 = true)
        {
            var _loc_13:* = Math.random() * param7;
            var _loc_14:* = param5 + Math.PI / 2;
            var _loc_15:* = param2 + Math.cos(_loc_14) * (_loc_13 - param7 / 2);
            var _loc_16:* = param3 + Math.sin(_loc_14) * (_loc_13 - param7 / 2);
            var _loc_17:* = Effect.newEffect(Config._model[param1], _loc_15, _loc_16, 3, 0, -1);
            Effect.newEffect(Config._model[param1], _loc_15, _loc_16, 3, 0, -1).display(param4);
            if (_loc_17._img.testAction("walk"))
            {
                _loc_17.changeStateTo("walk");
            }
            else
            {
                _loc_17.changeStateTo("idle");
                _loc_17._img.shadow = false;
            }
            _loc_17.directTo(param5);
            if (param11 == -1)
            {
                _loc_17._img.setHue(int(Math.random() * 360));
            }
            else if (param11 > 0)
            {
                _loc_17._img.setHue(param11);
            }
            setTimeout(killRunEffect, 30, _loc_17, param5, param8, param6, param9);
            if (param12 && param10 > 1)
            {
                setTimeout(createRunEffect, param9, param1, param2, param3, param4, param5, param6, param7, param8, param9, (param10 - 1), param11);
            }
            return;
        }// end function

        private static function killRunEffect(param1:Effect, param2, param3, param4, param5)
        {
            if (param4 <= 0)
            {
                param1.destroy();
            }
            else
            {
                param1.move(param1._x + Math.cos(param2) * param3, param1._y + Math.sin(param2) * param3);
                setTimeout(killRunEffect, 30, param1, param2, param3, (param4 - 1), param5);
            }
            return;
        }// end function

        public static function chain(param1:Unit, param2:Unit, param3:Number = 0)
        {
            var _loc_4:* = undefined;
            var _loc_5:* = null;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            if (param1 == null || param2 == null)
            {
                return;
            }
            killChain(param1);
            var _loc_8:* = [];
            var _loc_9:* = param1.testDistance(param2);
            var _loc_10:* = Math.atan2(param2._y - param1._y, param2._x - param1._x);
            var _loc_11:* = Math.ceil(_loc_9 / 8) - 1;
            _loc_4 = 0;
            while (_loc_4 < _loc_11)
            {
                
                _loc_6 = param1._x + 8 * (_loc_4 + 1) * Math.cos(_loc_10);
                _loc_7 = param1._y + 8 * (_loc_4 + 1) * Math.sin(_loc_10);
                _loc_5 = Effect.newEffect(Config._model[1184], _loc_6, _loc_7, 2, 0, 16);
                _loc_5.display(param1._map);
                _loc_8[_loc_4] = _loc_5;
                _loc_4 = _loc_4 + 1;
            }
            _chainDict[param1._mc] = {unit:param1, target:param2, chainArr:_loc_8};
            param1._mc.removeEventListener(Event.ENTER_FRAME, chainLoop);
            param1._mc.addEventListener(Event.ENTER_FRAME, chainLoop);
            if (param3 > 0)
            {
                setTimeout(killChain, param3 / Config.fps * 1000, param1);
            }
            return;
        }// end function

        private static function chainLoop(param1 = null, param2 = null)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = null;
            var _loc_8:* = undefined;
            var _loc_9:* = undefined;
            var _loc_10:* = undefined;
            var _loc_11:* = undefined;
            var _loc_12:* = undefined;
            var _loc_13:* = undefined;
            var _loc_14:* = undefined;
            var _loc_15:* = undefined;
            var _loc_16:* = undefined;
            var _loc_17:* = undefined;
            if (Config.paused)
            {
                return;
            }
            if (param1 != null)
            {
                _loc_3 = _chainDict[param1.target];
                _loc_4 = _loc_3.unit;
            }
            else
            {
                _loc_3 = _chainDict[param2._mc];
                _loc_4 = param2;
            }
            _loc_7 = _loc_3.chainArr;
            if (_loc_7.length > 0)
            {
                _loc_10 = PointLine.leash(_loc_7[0], _loc_4, 8);
                _loc_8 = _loc_10._x;
                _loc_9 = _loc_10._y;
                _loc_7[0].move(_loc_8, _loc_9);
                _loc_11 = _loc_3.target.testDistance(_loc_10);
                _loc_14 = _loc_11;
                _loc_16 = 0;
                _loc_5 = 1;
                while (_loc_5 < _loc_7.length)
                {
                    
                    _loc_10 = PointLine.leash(_loc_7[_loc_5], _loc_7[(_loc_5 - 1)], 8);
                    _loc_8 = _loc_10._x;
                    _loc_9 = _loc_10._y;
                    _loc_7[_loc_5].move(_loc_8, _loc_9);
                    _loc_11 = _loc_3.target.testDistance(_loc_10);
                    if (_loc_11 <= 8 || _loc_14 < _loc_11)
                    {
                        while (_loc_7.length > (_loc_5 + 1))
                        {
                            
                            _loc_7.pop().destroy();
                        }
                        break;
                    }
                    _loc_14 = _loc_11;
                    _loc_5 = _loc_5 + 1;
                }
            }
            if (_loc_11 > 8)
            {
                _loc_12 = Math.ceil(_loc_11 / 8) - 1;
                _loc_17 = Math.atan2(_loc_3.target._y - _loc_10._y, _loc_3.target._x - _loc_10._x);
                _loc_5 = 0;
                while (_loc_5 < _loc_12)
                {
                    
                    _loc_8 = _loc_10._x + 8 * (_loc_5 + 1) * Math.cos(_loc_17);
                    _loc_9 = _loc_10._y + 8 * (_loc_5 + 1) * Math.sin(_loc_17);
                    _loc_13 = Effect.newEffect(Config._model[1184], _loc_8, _loc_9, 2, 0, 16);
                    _loc_13.display(_loc_4._map);
                    _loc_7.push(_loc_13);
                    _loc_5 = _loc_5 + 1;
                }
            }
            _loc_5 = 0;
            while (_loc_5 < _loc_7.length)
            {
                
                _loc_15 = 32 * Math.pow((_loc_7.length - _loc_5) / _loc_7.length, 8);
                _loc_7[_loc_5]._img.zoff = _loc_15;
                _loc_5 = _loc_5 + 1;
            }
            return;
        }// end function

        public static function killChain(param1)
        {
            var _loc_2:* = undefined;
            if (_chainDict[param1._mc] != null)
            {
                param1._mc.removeEventListener(Event.ENTER_FRAME, chainLoop);
                while (_chainDict[param1._mc].chainArr.length > 0)
                {
                    
                    _chainDict[param1._mc].chainArr.shift().destroy();
                }
                delete _chainDict[param1._mc];
            }
            return;
        }// end function

    }
}
