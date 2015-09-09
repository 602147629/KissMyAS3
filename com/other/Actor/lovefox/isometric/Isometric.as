package lovefox.isometric
{
    import flash.display.*;
    import flash.geom.*;
    import flash.utils.*;

    public class Isometric extends Object
    {
        public var _map:Map;
        private var _mapW:Object;
        private var _mapH:Object;
        public var _curr_focusX:Number = 0;
        public var _curr_focusY:Number = 0;
        private var _buffFlag:Number = 0;
        private var _buffSize:Number = 2;
        private var _focusX:Number;
        private var _focusY:Number;
        public var _preX:Number = 0;
        public var _preY:Number = 0;
        public var _xRect:Number;
        public var _yRect:Number;
        private var _xBorder:Number;
        private var _yBorder:Number;
        public var _xExtend:Object = 4;
        public var _yExtend:Object = 2;
        private var _haloDict:Dictionary;
        private var _haloArray:Array;
        private var _haloDetectIndex:uint = 0;
        public var _haloBorder:Object = 256;
        private var _halo:Object;
        private var _freshObstacle:Object;
        private var _mode:int = 0;
        private var _areaX:int = 0;
        private var _areaY:int = 0;

        public function Isometric(param1:Map)
        {
            this._haloArray = [];
            this._haloDict = new Dictionary(true);
            this._map = param1;
            if (this._map._tileBmpd != null)
            {
                this._map._tileBmpd.dispose();
                this._map._tileBmpd = null;
            }
            if (this._map._obstacleBmpd != null)
            {
                this._map._obstacleBmpd.dispose();
                this._map._obstacleBmpd = null;
            }
            this._map._footMap = new Sprite();
            this._map._rootMap = new Sprite();
            this._map._haloShade = new Sprite();
            this._map._haloShade.blendMode = BlendMode.LAYER;
            this._map._shadeLayer = new Shape();
            this._map._haloShade.addChild(this._map._shadeLayer);
            this._map._haloLayer = new Sprite();
            this._map._haloLayer.blendMode = BlendMode.ERASE;
            this._map._haloShade.addChild(this._map._haloLayer);
            this._map._textMap = new Sprite();
            this.setMode(this._mode);
            this.setSize(this._map._mapWidth, this._map._mapHeight);
            this.halo = this._map._halo;
            return;
        }// end function

        public function clear()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = this._haloArray.concat();
            _loc_1 = 0;
            while (_loc_1 < _loc_2.length)
            {
                
                this.removeHalo(_loc_2[_loc_1].owner);
                delete _loc_2[_loc_1];
                _loc_1 = _loc_1 + 1;
            }
            this._haloDetectIndex = 0;
            Config.clearDisplayList(this._map._rootMap);
            Config.clearDisplayList(this._map._footMap);
            Config.clearDisplayList(this._map._textMap);
            return;
        }// end function

        public function destroy()
        {
            this.clear();
            this._haloDetectIndex = 0;
            return;
        }// end function

        public function set halo(param1)
        {
            this._halo = param1;
            this._map._shadeLayer.graphics.clear();
            this._map._shadeLayer.graphics.beginFill(0, this._halo / 255);
            this._map._shadeLayer.graphics.drawRect(0, 0, this._xRect * Map._ptPerTile, this._yRect * Map._ptPerTile);
            return;
        }// end function

        public function setMode(param1)
        {
            this._mode = param1;
            if (this._mode == 0)
            {
                if (this._map._tileLayerContainer != null && this._map._tileLayerContainer.parent != null)
                {
                    this._map._tileLayerContainer.parent.removeChild(this._map._tileLayerContainer);
                }
                if (this._map._obstacleLayerContainer != null && this._map._obstacleLayerContainer.parent != null)
                {
                    this._map._obstacleLayerContainer.parent.removeChild(this._map._obstacleLayerContainer);
                }
                if (this._map._tileLayer == null)
                {
                    this._map._tileLayer = new Bitmap();
                }
                if (this._map._obstacleLayer == null)
                {
                    this._map._obstacleLayer = new Bitmap();
                }
                this._map._mc.addChild(this._map._tileLayer);
                this._map._mc.addChild(this._map._footMap);
                this._map._mc.addChild(this._map._rootMap);
                this._map._mc.addChild(this._map._obstacleLayer);
                this._map._mc.addChild(this._map._haloShade);
                this._map._mc.addChild(this._map._textMap);
            }
            else
            {
                if (this._map._tileLayer != null && this._map._tileLayer.parent != null)
                {
                    this._map._tileLayer.parent.removeChild(this._map._tileLayer);
                }
                if (this._map._obstacleLayer != null && this._map._obstacleLayer.parent != null)
                {
                    this._map._obstacleLayer.parent.removeChild(this._map._obstacleLayer);
                }
                if (this._map._tileLayerContainer == null)
                {
                    this._map._tileLayerContainer = new Sprite();
                }
                if (this._map._obstacleLayerContainer == null)
                {
                    this._map._obstacleLayerContainer = new Sprite();
                }
                this._map._mc.addChild(this._map._tileLayerContainer);
                this._map._mc.addChild(this._map._footMap);
                this._map._mc.addChild(this._map._rootMap);
                this._map._mc.addChild(this._map._obstacleLayerContainer);
                this._map._mc.addChild(this._map._haloShade);
                this._map._mc.addChild(this._map._textMap);
            }
            return;
        }// end function

        public function setSize(param1, param2)
        {
            this._mapW = param1;
            this._mapH = param2;
            this._xRect = Math.ceil(this._mapW / Map._ptPerTile);
            this._yRect = Math.ceil(this._mapH / Map._ptPerTile);
            this._xBorder = this._xRect + this._xExtend;
            this._yBorder = this._yRect + this._yExtend;
            this._map._mc.x = (-(this._xRect * Map._ptPerTile - this._mapW)) / 2 * this._map._mc.scaleX;
            this._map._mc.y = (-(this._yRect * Map._ptPerTile - this._mapH)) / 2 * this._map._mc.scaleX;
            this.halo = this._halo;
            return;
        }// end function

        public function scrollTo(param1:Number, param2:Number, param3 = false)
        {
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_12:* = undefined;
            var _loc_13:* = undefined;
            var _loc_14:* = undefined;
            var _loc_15:* = undefined;
            var _loc_16:* = 0;
            var _loc_17:* = 0;
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
            var _loc_28:* = NaN;
            var _loc_29:* = NaN;
            var _loc_4:* = param1 % Map._ptPerTile;
            var _loc_5:* = param2 % Map._ptPerTile;
            var _loc_6:* = _loc_4 - _loc_5;
            var _loc_7:* = _loc_4 / 2 + _loc_5 / 2;
            this._focusX = -Math.round((-param1) / Map._ptPerTile + (this._xBorder / 2 + this._yBorder) / 2);
            this._focusY = Math.round(param2 / Map._ptPerTile + (this._xBorder / 2 - this._yBorder) / 2);
            _loc_8 = this._focusX - this._focusY - (this._preX - this._preY);
            _loc_9 = this._focusX / 2 + this._focusY / 2 - (this._preX / 2 + this._preY / 2);
            var _loc_10:* = this._map._rootMap.x;
            var _loc_11:* = this._map._rootMap.y;
            if (this._map.halo)
            {
                var _loc_30:* = Math.floor(-Math.floor(param1 - param2 - this._xRect / 2 * Map._ptPerTile));
                this._map._rootMap.x = Math.floor(-Math.floor(param1 - param2 - this._xRect / 2 * Map._ptPerTile));
                this._map._textMap.x = _loc_30;
                this._map._haloLayer.x = _loc_30;
                this._map._footMap.x = _loc_30;
                var _loc_30:* = Math.floor(-Math.floor(param1 / 2 + param2 / 2 - this._yRect / 2 * Map._ptPerTile));
                this._map._rootMap.y = Math.floor(-Math.floor(param1 / 2 + param2 / 2 - this._yRect / 2 * Map._ptPerTile));
                this._map._textMap.y = _loc_30;
                this._map._haloLayer.y = _loc_30;
                this._map._footMap.y = _loc_30;
            }
            else
            {
                var _loc_30:* = Math.floor(-Math.floor(param1 - param2 - this._xRect / 2 * Map._ptPerTile));
                this._map._rootMap.x = Math.floor(-Math.floor(param1 - param2 - this._xRect / 2 * Map._ptPerTile));
                this._map._textMap.x = _loc_30;
                this._map._footMap.x = _loc_30;
                var _loc_30:* = Math.floor(-Math.floor(param1 / 2 + param2 / 2 - this._yRect / 2 * Map._ptPerTile));
                this._map._rootMap.y = Math.floor(-Math.floor(param1 / 2 + param2 / 2 - this._yRect / 2 * Map._ptPerTile));
                this._map._textMap.y = _loc_30;
                this._map._footMap.y = _loc_30;
            }
            if (this._mode == 0)
            {
                var _loc_30:* = this._map._rootMap.x - this._map._bmpdW * this._map._bmpdRatio;
                this._map._obstacleLayer.x = this._map._rootMap.x - this._map._bmpdW * this._map._bmpdRatio;
                this._map._tileLayer.x = _loc_30;
                var _loc_30:* = this._map._rootMap.y;
                this._map._obstacleLayer.y = this._map._rootMap.y;
                this._map._tileLayer.y = _loc_30;
            }
            else
            {
                var _loc_30:* = this._map._rootMap.x - this._map._bmpdW * this._map._bmpdRatio;
                this._map._obstacleLayerContainer.x = this._map._rootMap.x - this._map._bmpdW * this._map._bmpdRatio;
                _loc_12 = _loc_30;
                var _loc_30:* = this._map._rootMap.y;
                this._map._obstacleLayerContainer.y = this._map._rootMap.y;
                _loc_13 = _loc_30;
                _loc_14 = -int(_loc_12 / this._map._mode1Size);
                _loc_15 = -int(_loc_13 / this._map._mode1Size);
                _loc_23 = Math.ceil(this._map.width / this._map._mode1Size);
                _loc_24 = Math.ceil(this._map.height / this._map._mode1Size);
                _loc_8 = this._areaX - _loc_14;
                _loc_9 = this._areaY - _loc_15;
                _loc_19 = this._areaX - 0;
                _loc_20 = this._areaX + _loc_23;
                _loc_21 = this._areaY - 0;
                _loc_22 = this._areaY + _loc_24;
                if (param3 || _loc_8 > 0)
                {
                    if (param3)
                    {
                        _loc_18 = _loc_19;
                    }
                    else
                    {
                        _loc_18 = Math.max(_loc_19, _loc_20 - _loc_8 + 1);
                    }
                    _loc_16 = _loc_20;
                    while (_loc_16 >= _loc_18)
                    {
                        
                        _loc_17 = _loc_21;
                        while (_loc_17 <= _loc_22)
                        {
                            
                            this.removeArea(_loc_16, _loc_17);
                            _loc_17++;
                        }
                        _loc_16 = _loc_16 - 1;
                    }
                    _loc_20 = _loc_18 - 1;
                }
                else if (_loc_8 < 0)
                {
                    if (param3)
                    {
                        _loc_18 = _loc_20;
                    }
                    else
                    {
                        _loc_18 = Math.min(_loc_20, _loc_19 - _loc_8 - 1);
                    }
                    _loc_16 = _loc_19;
                    while (_loc_16 <= _loc_18)
                    {
                        
                        _loc_17 = _loc_21;
                        while (_loc_17 <= _loc_22)
                        {
                            
                            this.removeArea(_loc_16, _loc_17);
                            _loc_17++;
                        }
                        _loc_16++;
                    }
                    _loc_19 = _loc_18 + 1;
                }
                if (param3 || _loc_9 > 0)
                {
                    if (param3)
                    {
                        _loc_18 = _loc_21;
                    }
                    else
                    {
                        _loc_18 = Math.max(_loc_21, _loc_22 - _loc_9 + 1);
                    }
                    _loc_17 = _loc_22;
                    while (_loc_17 >= _loc_18)
                    {
                        
                        _loc_16 = _loc_19;
                        while (_loc_16 <= _loc_20)
                        {
                            
                            this.removeArea(_loc_16, _loc_17);
                            _loc_16++;
                        }
                        _loc_17 = _loc_17 - 1;
                    }
                }
                else if (_loc_9 < 0)
                {
                    if (param3)
                    {
                        _loc_18 = _loc_22;
                    }
                    else
                    {
                        _loc_18 = Math.min(_loc_22, _loc_21 - _loc_9 - 1);
                    }
                    _loc_17 = _loc_21;
                    while (_loc_17 <= _loc_18)
                    {
                        
                        _loc_16 = _loc_19;
                        while (_loc_16 <= _loc_20)
                        {
                            
                            this.removeArea(_loc_16, _loc_17);
                            _loc_16++;
                        }
                        _loc_17++;
                    }
                }
                _loc_8 = _loc_14 - this._areaX;
                _loc_9 = _loc_15 - this._areaY;
                _loc_19 = _loc_14 - 0;
                _loc_20 = _loc_14 + _loc_23;
                _loc_21 = _loc_15 - 0;
                _loc_22 = _loc_15 + _loc_24;
                _loc_25 = [];
                if (param3 || _loc_8 > 0)
                {
                    if (param3)
                    {
                        _loc_18 = _loc_19;
                    }
                    else
                    {
                        _loc_18 = Math.max(_loc_19, _loc_20 - _loc_8 + 1);
                    }
                    _loc_16 = _loc_20;
                    while (_loc_16 >= _loc_18)
                    {
                        
                        _loc_17 = _loc_21;
                        while (_loc_17 <= _loc_22)
                        {
                            
                            this.createArea(_loc_16, _loc_17);
                            _loc_17++;
                        }
                        _loc_16 = _loc_16 - 1;
                    }
                    _loc_20 = _loc_18 - 1;
                }
                else if (_loc_8 < 0)
                {
                    if (param3)
                    {
                        _loc_18 = _loc_20;
                    }
                    else
                    {
                        _loc_18 = Math.min(_loc_20, _loc_19 - _loc_8 - 1);
                    }
                    _loc_16 = _loc_19;
                    while (_loc_16 <= _loc_18)
                    {
                        
                        _loc_17 = _loc_21;
                        while (_loc_17 <= _loc_22)
                        {
                            
                            this.createArea(_loc_16, _loc_17);
                            _loc_17++;
                        }
                        _loc_16++;
                    }
                    _loc_19 = _loc_18 + 1;
                }
                if (param3 || _loc_9 > 0)
                {
                    if (param3)
                    {
                        _loc_18 = _loc_21;
                    }
                    else
                    {
                        _loc_18 = Math.max(_loc_21, _loc_22 - _loc_9 + 1);
                    }
                    _loc_17 = _loc_22;
                    while (_loc_17 >= _loc_18)
                    {
                        
                        _loc_16 = _loc_19;
                        while (_loc_16 <= _loc_20)
                        {
                            
                            this.createArea(_loc_16, _loc_17);
                            _loc_16++;
                        }
                        _loc_17 = _loc_17 - 1;
                    }
                }
                else if (_loc_9 < 0)
                {
                    if (param3)
                    {
                        _loc_18 = _loc_22;
                    }
                    else
                    {
                        _loc_18 = Math.min(_loc_22, _loc_21 - _loc_9 - 1);
                    }
                    _loc_17 = _loc_21;
                    while (_loc_17 <= _loc_18)
                    {
                        
                        _loc_16 = _loc_19;
                        while (_loc_16 <= _loc_20)
                        {
                            
                            this.createArea(_loc_16, _loc_17);
                            _loc_16++;
                        }
                        _loc_17++;
                    }
                }
                this._map._tileLayerContainer.x = _loc_12;
                this._map._tileLayerContainer.y = _loc_13;
                this._areaX = _loc_14;
                this._areaY = _loc_15;
            }
            if (this._map.halo)
            {
                _loc_26 = this._map._rootMap.x - _loc_10;
                _loc_27 = this._map._rootMap.y - _loc_11;
                _loc_19 = 0;
                _loc_20 = this._xBorder;
                if (_loc_8 > 0)
                {
                    _loc_18 = Math.max(this._xBorder - _loc_8 - 1, -1);
                    _loc_20 = _loc_18 + 1;
                    _loc_16 = this._xBorder - 1;
                    while (_loc_16 > _loc_18)
                    {
                        
                        _loc_17 = 0;
                        while (_loc_17 < this._yBorder)
                        {
                            
                            this.copyTile(_loc_16, _loc_17);
                            _loc_17++;
                        }
                        _loc_16 = _loc_16 - 1;
                    }
                }
                else if (_loc_8 < 0)
                {
                    _loc_18 = Math.min(-_loc_8, this._xBorder);
                    _loc_19 = _loc_18;
                    _loc_16 = 0;
                    while (_loc_16 < _loc_18)
                    {
                        
                        _loc_17 = 0;
                        while (_loc_17 < this._yBorder)
                        {
                            
                            this.copyTile(_loc_16, _loc_17);
                            _loc_17++;
                        }
                        _loc_16++;
                    }
                }
                if (_loc_9 > 0)
                {
                    _loc_18 = Math.max(this._yBorder - _loc_9 - 1, 0);
                    _loc_17 = _loc_18;
                    while (_loc_17 < this._yBorder)
                    {
                        
                        _loc_16 = _loc_19;
                        while (_loc_16 < _loc_20)
                        {
                            
                            this.copyTile(_loc_16, _loc_17);
                            _loc_16++;
                        }
                        _loc_17++;
                    }
                }
                else if (_loc_9 < 0)
                {
                    _loc_18 = Math.min(-_loc_9, (this._yBorder - 1));
                    _loc_17 = 0;
                    while (_loc_17 <= _loc_18)
                    {
                        
                        _loc_16 = _loc_19;
                        while (_loc_16 < _loc_20)
                        {
                            
                            this.copyTile(_loc_16, _loc_17);
                            _loc_16++;
                        }
                        _loc_17++;
                    }
                }
                this._preX = this._focusX;
                this._preY = this._focusY;
                this.testHalo();
            }
            return;
        }// end function

        private function removeArea(param1, param2)
        {
            if (this._map._tileLayerMatrix[param1] != null && this._map._tileLayerMatrix[param1][param2] != null)
            {
                if (this._map._tileLayerMatrix[param1][param2].parent != null)
                {
                    this._map._tileLayerMatrix[param1][param2].parent.removeChild(this._map._tileLayerMatrix[param1][param2]);
                }
            }
            if (this._map._obstacleLayerMatrix[param1] != null && this._map._obstacleLayerMatrix[param1][param2] != null)
            {
                if (this._map._obstacleLayerMatrix[param1][param2].parent != null)
                {
                    this._map._obstacleLayerMatrix[param1][param2].parent.removeChild(this._map._obstacleLayerMatrix[param1][param2]);
                }
            }
            return;
        }// end function

        private function createArea(param1, param2)
        {
            if (this._map._tileLayerMatrix[param1] != null && this._map._tileLayerMatrix[param1][param2] != null)
            {
                if (this._map._tileLayerMatrix[param1][param2].parent == null)
                {
                    this._map._tileLayerContainer.addChild(this._map._tileLayerMatrix[param1][param2]);
                }
            }
            if (this._map._obstacleLayerMatrix[param1] != null && this._map._obstacleLayerMatrix[param1][param2] != null)
            {
                if (this._map._obstacleLayerMatrix[param1][param2].parent == null)
                {
                    this._map._obstacleLayerContainer.addChild(this._map._obstacleLayerMatrix[param1][param2]);
                }
            }
            return;
        }// end function

        private function copyTile(param1:Number, param2:Number)
        {
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            var _loc_5:* = undefined;
            _loc_3 = this._focusX + param2 + param1 / 2 - param1 % 2 / 2;
            _loc_4 = this._focusY + param2 - param1 / 2 - param1 % 2 / 2;
            if (_loc_3 >= 0 && _loc_3 < this._map._width && (_loc_4 >= 0 && _loc_4 < this._map._height))
            {
                _loc_5 = this._map._tile[_loc_3][_loc_4];
                this.drawTile(_loc_5);
            }
            return;
        }// end function

        public function removeHalo(param1)
        {
            var _loc_2:* = undefined;
            if (this._haloDict[param1] != null)
            {
                if (this._haloDict[param1].halo.parent == this._map._haloLayer)
                {
                    this._map._haloLayer.removeChild(this._haloDict[param1].halo);
                }
                if (this._haloDict[param1].type != 3)
                {
                    this._haloDict[param1].halo.bitmapData.dispose();
                }
                for (_loc_2 in this._haloArray)
                {
                    
                    if (this._haloArray[_loc_2] == this._haloDict[param1])
                    {
                        this._haloArray.splice(_loc_2, 1);
                        break;
                    }
                }
                delete this._haloDict[param1];
            }
            return;
        }// end function

        public function getHaleArray()
        {
            return this._haloArray.concat();
        }// end function

        public function set freshObstacle(param1:Boolean) : void
        {
            this._freshObstacle = param1;
            return;
        }// end function

        public function get freshObstacle() : Boolean
        {
            return this._freshObstacle;
        }// end function

        public function refreshHalo(param1)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            for (_loc_2 in param1)
            {
                
                this.setHalo(param1[_loc_2].owner, param1[_loc_2].r, param1[_loc_2].x, param1[_loc_2].y, param1[_loc_2].type, param1[_loc_2].bmpd);
            }
            return;
        }// end function

        public function setHalo(param1, param2, param3, param4, param5 = 1, param6 = null, param7 = 0)
        {
            var _loc_8:* = undefined;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = undefined;
            var _loc_15:* = undefined;
            if (this._map.halo && this._map._halo > 0 && param2 > 0)
            {
                if (this._haloDict[param1] == null)
                {
                    if (param3 + this._map._rootMap.x >= -this._haloBorder || param4 + this._map._rootMap.y >= -this._haloBorder || param3 + this._map._rootMap.x <= this._map._mapWidth + this._haloBorder || param4 + this._map._rootMap.y <= this._map._mapHeight + this._haloBorder)
                    {
                        _loc_8 = new Shape();
                        _loc_9 = GradientType.RADIAL;
                        _loc_10 = [3683, 3683];
                        _loc_11 = [0.52, 0];
                        _loc_12 = [param7 / param2 * 255, 255];
                        _loc_13 = new Matrix();
                        if (param5 == 1)
                        {
                            _loc_13.createGradientBox(param2 * 2, param2, 0, 0, 0);
                            _loc_8.graphics.beginGradientFill(_loc_9, _loc_10, _loc_11, _loc_12, _loc_13, SpreadMethod.PAD);
                            _loc_8.graphics.drawRect(0, 0, param2 * 2, param2);
                            _loc_8.graphics.endFill();
                            _loc_14 = new BitmapData(param2 * 2, param2, true, 0);
                            _loc_14.draw(_loc_8);
                            _loc_15 = new Bitmap(_loc_14);
                            this._haloDict[param1] = {owner:param1, halo:_loc_15, x:param3, y:param4, r:param2, type:param5, bmpd:param6};
                            this._haloArray.push(this._haloDict[param1]);
                            _loc_15.x = param3 - _loc_8.width / 2;
                            _loc_15.y = param4 - _loc_8.height / 2;
                            this._map._haloLayer.addChild(_loc_15);
                        }
                        else if (param5 == 2)
                        {
                            _loc_13.createGradientBox(param2, param2, 0, 0, 0);
                            _loc_8.graphics.beginGradientFill(_loc_9, _loc_10, _loc_11, _loc_12, _loc_13, SpreadMethod.PAD);
                            _loc_8.graphics.drawRect(0, 0, param2, param2);
                            _loc_8.graphics.endFill();
                            _loc_14 = new BitmapData(param2, param2, true, 0);
                            _loc_14.draw(_loc_8);
                            _loc_15 = new Bitmap(_loc_14);
                            this._haloDict[param1] = {owner:param1, halo:_loc_15, x:param3, y:param4, r:param2, type:param5, bmpd:param6};
                            this._haloArray.push(this._haloDict[param1]);
                            _loc_15.x = param3 - _loc_8.width / 2;
                            _loc_15.y = param4 - _loc_8.height / 2;
                            this._map._haloLayer.addChild(_loc_15);
                        }
                        else if (param5 == 3 && param6 != null)
                        {
                            _loc_15 = new Bitmap(param6);
                            this._haloDict[param1] = {owner:param1, halo:_loc_15, x:param3, y:param4, r:param2, type:param5, bmpd:param6};
                            this._haloArray.push(this._haloDict[param1]);
                            _loc_15.x = param3;
                            _loc_15.y = param4;
                            this._map._haloLayer.addChild(_loc_15);
                        }
                    }
                }
                else
                {
                    this._haloDict[param1].x = param3;
                    this._haloDict[param1].y = param4;
                    if (this._haloDict[param1].type == 3)
                    {
                        this._haloDict[param1].halo.x = param3;
                        this._haloDict[param1].halo.y = param4;
                    }
                    else
                    {
                        this._haloDict[param1].halo.x = param3 - this._haloDict[param1].halo.width / 2;
                        this._haloDict[param1].halo.y = param4 - this._haloDict[param1].halo.height / 2;
                    }
                }
            }
            return;
        }// end function

        public function testHalo()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            if (this._haloDetectIndex >= this._haloArray.length)
            {
                this._haloDetectIndex = 0;
            }
            _loc_2 = this._haloArray[this._haloDetectIndex];
            if (_loc_2 != null)
            {
                if (_loc_2.x + this._map._rootMap.x < -this._haloBorder || _loc_2.y + this._map._rootMap.y < -this._haloBorder || _loc_2.x + this._map._rootMap.x > this._map._mapWidth + this._haloBorder || _loc_2.y + this._map._rootMap.y > this._map._mapHeight + this._haloBorder)
                {
                    this.removeHalo(_loc_2.owner);
                }
                else
                {
                    var _loc_3:* = this;
                    var _loc_4:* = this._haloDetectIndex + 1;
                    _loc_3._haloDetectIndex = _loc_4;
                }
            }
            return;
        }// end function

        public function drawTile(param1)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            if (param1._haloType == 1)
            {
                _loc_7 = (param1._obstacleWidth - param1._obstacleHeight) * Map._ptPerTile;
                _loc_8 = (param1._obstacleWidth + param1._obstacleHeight) * Map._ptPerTile / 2;
                this.setHalo(param1, param1._haloRadius, param1._xDraw + Map._ptPerTile - _loc_7 / 2, param1._yDraw + Map._ptPerTile / 2 * 3 - _loc_8 / 2, 1);
            }
            else if (param1._haloType == 2)
            {
                this.setHalo(param1, param1._haloRadius, param1._xDraw + Map._ptPerTile + param1._haloX, param1._yDraw + Map._ptPerTile / 2 * 3 - param1._haloY, 2);
            }
            else if (param1._haloType == 3)
            {
                this.setHalo(param1, param1._haloRadius, param1._xDraw + Map._ptPerTile - param1._haloBmpd.width / 2, param1._yDraw + Map._ptPerTile / 2 * 3 - param1._haloBmpd.height + param1._haloRadius, 3, param1._haloBmpd);
            }
            return;
        }// end function

        function drawEmptyTile(param1, param2)
        {
            var _loc_3:* = (param1 - param2) * Map._ptPerTile - Map._ptPerTile;
            var _loc_4:* = (param1 / 2 + param2 / 2) * Map._ptPerTile - Map._ptPerTile / 2;
            var _loc_5:* = new Sprite();
            new Sprite().graphics.beginFill(16777215);
            _loc_5.graphics.lineStyle(0, 0);
            _loc_5.graphics.moveTo(Map._ptPerTile, 0);
            _loc_5.graphics.lineTo(0, Map._ptPerTile / 2);
            _loc_5.graphics.lineTo(Map._ptPerTile, Map._ptPerTile);
            _loc_5.graphics.lineTo(Map._ptPerTile * 2, Map._ptPerTile / 2);
            _loc_5.graphics.lineTo(Map._ptPerTile, 0);
            _loc_5.graphics.endFill();
            var _loc_6:* = new BitmapData(Map._ptPerTile * 2, Map._ptPerTile, true, 16777215);
            new BitmapData(Map._ptPerTile * 2, Map._ptPerTile, true, 16777215).draw(_loc_5);
            this._map._tileLayer.bitmapData.copyPixels(_loc_6, _loc_6.rect, new Point(_loc_3 + this._map._rootMap.x + Map._ptPerTile * this._xExtend, _loc_4 + this._map._rootMap.y + Map._ptPerTile * this._yExtend), null, null, true);
            return;
        }// end function

    }
}
