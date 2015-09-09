package lovefox.unit
{
    import flash.display.*;
    import flash.geom.*;
    import lovefox.buffer.*;

    public class UnitClip extends Sprite
    {
        private var _poolPushed:Boolean = false;
        private var _pushPoolTimer:Object;
        private var _enterframeListenerArray:Array;
        public var _state:Object;
        public var _direction:uint = 0;
        public var _bitmap:Bitmap;
        private var _shadow:Boolean = true;
        private var _shadowSize:Number;
        private var _shadowAlpha:Number = 0.8;
        private var _shadowScale:Number = 1;
        public var _unitObj:Object;
        public var _unitRectObj:Object;
        private var _soundObj:Object;
        private var _soundDelayObj:Object;
        private var _oneDirecionObj:Object;
        public var _bitmapArray:Array;
        public var _bitmapRectArray:Array;
        public var _bitmapRect:Object;
        public var _bitmapRectY:uint = 0;
        public var _bitmapRectW:uint = 0;
        public var _currFrame:int = 0;
        private var _currTotalFrame:uint;
        public var _frameSkip:uint;
        public var _frameLeft:uint;
        private var _loopFrame:uint;
        public var _layerStack:Object;
        public var _exLayerArray:Object;
        public var _directions:uint;
        public var _a4:uint = 0;
        public var _width:uint;
        public var _height:uint;
        public var _colorReplaceArr:Object;
        public var _hue:Object;
        public var _alpha:Object;
        public var _yOff:int;
        private var _action:Object;
        public var _data:Object;
        public var _id:uint;
        var _overDo:Function;
        public var _ready:Object = false;
        public var _destroyed:Object = false;
        private var _concated:Boolean = false;
        private var _progressTxt:Object;
        private var _locked:Boolean = false;
        private var _dynamicData:Object;
        private var _z:Number = 0;
        private var _xoff:Number = 0;
        private var _loader:FileLoader;
        private var _pLoader:BitmapLoader;
        private var _multiLayer:Boolean = false;
        private var _freeze:Boolean = false;
        private var _cloneOri:Object;
        private var _clone:Boolean = false;
        private static var _initCount:uint = 0;
        private static var _initStack:Array = [];
        private static var _initStackMax:uint = 6;
        public static var _layerStackBuff:Object = {};
        public static var _modelURL:Object = "stuff/model/";
        private static var _freezeCMF:Object = new ColorMatrixFilter([0.3, 0.3, 0.3, 0, -40, 0.4, 0.4, 0.4, 0, -30, 0.6, 0.6, 0.6, 0, 30, 0, 0, 0, 1, 0]);
        private static var _stoneCMF:Object = new ColorMatrixFilter([0.3, 0.59, 0.11, 0, 0, 0.3, 0.59, 0.11, 0, 0, 0.3, 0.59, 0.11, 0, 0, 0, 0, 0, 1, 0]);
        private static var _poisonCMF:Object = new ColorMatrixFilter([0, 0, 0, 0, 0, 0.4, 0.4, 0.4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0]);
        private static var _goldCMF:Object = new ColorMatrixFilter([0.4, 0.4, 0.4, 0, 0, 0.3, 0.3, 0.3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0]);
        private static var _bleedCMF:Object = new ColorMatrixFilter([0.4, 0.4, 0.4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0]);
        public static var _shadowOn:Boolean = true;
        private static var _objectPool:Array = [];
        private static var _buff:Object = {};
        private static var _bitmapRecord:Array = [];

        public function UnitClip(param1 = null, param2:Boolean = false, param3 = 0, param4 = 1, param5 = null)
        {
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            var _loc_9:* = undefined;
            this._enterframeListenerArray = [];
            this._layerStack = {};
            this._exLayerArray = {};
            this._dynamicData = {};
            this.mouseEnabled = false;
            this.mouseChildren = false;
            if (param1 == null)
            {
                return;
            }
            this._multiLayer = param2;
            this.layerStack = param5;
            this._data = param1;
            this._id = Number(param1.id);
            this._ready = false;
            this._destroyed = false;
            this._hue = param3;
            if (this._data.hue != null)
            {
                this._hue = this._data.hue;
            }
            this._alpha = param4;
            this._yOff = parseInt(this._data.yOffset);
            this._frameSkip = this._data.frameSkip;
            this._action = this._data.action;
            this._directions = parseInt(this._data.direction);
            this._width = parseInt(this._data.width);
            this._height = parseInt(this._data.height);
            this._loopFrame = parseInt(this._data.loopFrame);
            this._a4 = Number(this._data.a4);
            this._bitmapRect = new Rectangle(0, 0, this._width, this._height);
            if (_buff[this._id] == null)
            {
                this._progressTxt = Config.getSimpleTextField();
                addChild(this._progressTxt);
                if (this._loader != null)
                {
                    this._loader.removeEventListener(ProgressEvent.PROGRESS, this.handleLoadProgress);
                    this._loader.removeEventListener(Event.COMPLETE, this.handleLoadComplete);
                }
                this._loader = new FileLoader();
                this._loader.addEventListener(ProgressEvent.PROGRESS, this.handleLoadProgress);
                this._loader.addEventListener(Event.COMPLETE, this.handleLoadComplete);
                this._loader.load([_modelURL + this._id + ".mod"]);
            }
            else
            {
                _loc_6 = _buff[this._id];
                this._yOff = _loc_6._yOff;
                this._frameSkip = _loc_6._frameSkip;
                this._directions = _loc_6._directions;
                this._loopFrame = _loc_6._loopFrame;
                this._a4 = _loc_6._a4;
                this._soundObj = _loc_6._soundObj;
                this._soundDelayObj = _loc_6._soundDelayObj;
                this._oneDirecionObj = _loc_6._oneDirecionObj;
                this._bitmapRectY = _loc_6._bitmapRectY;
                this._bitmapRectW = _loc_6._bitmapRectW;
                this._unitObj = {};
                this._unitRectObj = {};
                for (_loc_7 in _loc_6._unitObj)
                {
                    
                    this._unitObj[_loc_7] = [];
                    this._unitRectObj[_loc_7] = [];
                    for (_loc_8 in _loc_6._unitObj[_loc_7])
                    {
                        
                        this._unitObj[_loc_7][_loc_8] = [];
                        this._unitRectObj[_loc_7][_loc_8] = [];
                        for (_loc_9 in _loc_6._unitObj[_loc_7][_loc_8])
                        {
                            
                            this._unitObj[_loc_7][_loc_8][_loc_9] = _loc_6._unitObj[_loc_7][_loc_8][_loc_9];
                            this._unitRectObj[_loc_7][_loc_8][_loc_9] = _loc_6._unitRectObj[_loc_7][_loc_8][_loc_9];
                        }
                    }
                }
                this.init();
            }
            return;
        }// end function

        public function get bitmap()
        {
            var _loc_1:* = undefined;
            var _loc_8:* = null;
            var _loc_2:* = Number.MAX_VALUE;
            var _loc_3:* = Number.MAX_VALUE;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = false;
            var _loc_7:* = null;
            if (this._bitmap != null && this._bitmap.bitmapData != null && this._bitmapRect != null)
            {
                _loc_6 = true;
                _loc_2 = Math.min(_loc_2, this._bitmapRect.x);
                _loc_3 = Math.min(_loc_3, this._bitmapRect.y);
                _loc_4 = Math.max(_loc_4, this._bitmapRect.x + this._bitmapRect.width);
                _loc_5 = Math.max(_loc_5, this._bitmapRect.y + this._bitmapRect.height);
                _loc_7 = this._bitmap.scaleX;
            }
            for (_loc_1 in this._exLayerArray)
            {
                
                if (this._exLayerArray[_loc_1]._bitmap != null && this._exLayerArray[_loc_1]._bitmap.bitmapData != null && this._exLayerArray[_loc_1]._bitmapRect != null)
                {
                    _loc_6 = true;
                    _loc_2 = Math.min(_loc_2, this._exLayerArray[_loc_1]._bitmapRect.x);
                    _loc_3 = Math.min(_loc_3, this._exLayerArray[_loc_1]._bitmapRect.y);
                    _loc_4 = Math.max(_loc_4, this._exLayerArray[_loc_1]._bitmapRect.x + this._exLayerArray[_loc_1]._bitmapRect.width);
                    _loc_5 = Math.max(_loc_5, this._exLayerArray[_loc_1]._bitmapRect.y + this._exLayerArray[_loc_1]._bitmapRect.height);
                    if (_loc_7 == null)
                    {
                        _loc_7 = this._exLayerArray[_loc_1]._bitmap.scaleX;
                    }
                }
            }
            if (_loc_6)
            {
                _loc_8 = new BitmapData(_loc_4 - _loc_2, _loc_5 - _loc_3, true, 0);
                if (this._bitmap != null && this._bitmap.bitmapData != null && this._bitmapRect != null)
                {
                    _loc_8.copyPixels(this._bitmap.bitmapData, this._bitmap.bitmapData.rect, new Point(this._bitmapRect.x - _loc_2, this._bitmapRect.y - _loc_3), null, null, true);
                }
                for (_loc_1 in this._exLayerArray)
                {
                    
                    if (this._exLayerArray[_loc_1]._bitmap != null && this._exLayerArray[_loc_1]._bitmap.bitmapData != null && this._exLayerArray[_loc_1]._bitmapRect != null)
                    {
                        _loc_8.copyPixels(this._exLayerArray[_loc_1]._bitmap.bitmapData, this._exLayerArray[_loc_1]._bitmap.bitmapData.rect, new Point(this._exLayerArray[_loc_1]._bitmapRect.x - _loc_2, this._exLayerArray[_loc_1]._bitmapRect.y - _loc_3), null, null, true);
                    }
                }
                if (_loc_7 == null)
                {
                    _loc_7 = 1;
                }
                if (_loc_7 == 1)
                {
                    return {bmpd:_loc_8, x:(-this._width) / 2 + _loc_2 + this._xoff, y:this._yOff + _loc_3, w:_loc_4 - _loc_2, h:_loc_5 - _loc_3, scale:_loc_7};
                }
                return {bmpd:_loc_8, x:this._width / 2 - _loc_2 + this._xoff, y:this._yOff + _loc_3, w:_loc_4 - _loc_2, h:_loc_5 - _loc_3, scale:_loc_7};
            }
            else
            {
                return null;
            }
        }// end function

        public function set multiLayer(param1)
        {
            this._multiLayer = param1;
            return;
        }// end function

        public function get multiLayer()
        {
            return this._multiLayer;
        }// end function

        public function set layerStack(param1)
        {
            if (param1 == null)
            {
                this._layerStack = null;
            }
            else
            {
                this._layerStack = _layerStackBuff[param1];
            }
            return;
        }// end function

        public function testAction(param1)
        {
            var _loc_2:* = undefined;
            if (this._action == null)
            {
                return false;
            }
            if (this._unitObj == null)
            {
                if (this._action is Array)
                {
                    _loc_2 = 0;
                    while (_loc_2 < this._action.length)
                    {
                        
                        if (this._action[_loc_2].state == param1)
                        {
                            return true;
                        }
                        _loc_2 = _loc_2 + 1;
                    }
                    return false;
                }
                else
                {
                    if (this._action.state == param1)
                    {
                        return true;
                    }
                    return false;
                }
            }
            else
            {
                if (this._unitObj[param1] == null)
                {
                    return false;
                }
                return true;
            }
        }// end function

        public function addExLayer(param1, param2)
        {
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            if (!this._multiLayer)
            {
                return;
            }
            this.clearLayer(param2);
            var _loc_3:* = {};
            _loc_3._data = param1;
            _loc_3._id = Number(param1.id);
            _loc_3._action = param1.action;
            _loc_3._ready = false;
            this._exLayerArray[param2] = _loc_3;
            if (_buff[_loc_3._id] == null)
            {
                _loc_3._loader = new FileLoader();
                _loc_3._loader.data = param2;
                _loc_3._loader.removeEventListener(Event.COMPLETE, this.handleWeaponLoadComplete);
                _loc_3._loader.addEventListener(Event.COMPLETE, this.handleWeaponLoadComplete);
                _loc_3._loader.load([_modelURL + _loc_3._id + ".mod"]);
            }
            else
            {
                _loc_3._yOff = _buff[_loc_3._id]._yOff;
                _loc_3._frameSkip = _buff[_loc_3._id]._frameSkip;
                _loc_3._directions = _buff[_loc_3._id]._directions;
                _loc_3._loopFrame = _buff[_loc_3._id]._loopFrame;
                _loc_3._a4 = _buff[_loc_3._id]._a4;
                _loc_3._soundObj = _buff[_loc_3._id]._soundObj;
                _loc_3._soundDelayObj = _buff[_loc_3._id]._soundDelayObj;
                _loc_3._oneDirecionObj = _buff[_loc_3._id]._oneDirecionObj;
                _loc_3._bitmapRectY = _buff[_loc_3._id]._bitmapRectY;
                _loc_3._bitmapRectW = _buff[_loc_3._id]._bitmapRectW;
                _loc_3._unitObj = {};
                _loc_3._unitRectObj = {};
                for (_loc_4 in _buff[_loc_3._id]._unitObj)
                {
                    
                    _loc_3._unitObj[_loc_4] = [];
                    _loc_3._unitRectObj[_loc_4] = [];
                    for (_loc_5 in _buff[_loc_3._id]._unitObj[_loc_4])
                    {
                        
                        _loc_3._unitObj[_loc_4][_loc_5] = [];
                        _loc_3._unitRectObj[_loc_4][_loc_5] = [];
                        for (_loc_6 in _buff[_loc_3._id]._unitObj[_loc_4][_loc_5])
                        {
                            
                            _loc_3._unitObj[_loc_4][_loc_5][_loc_6] = _buff[_loc_3._id]._unitObj[_loc_4][_loc_5][_loc_6];
                            _loc_3._unitRectObj[_loc_4][_loc_5][_loc_6] = _buff[_loc_3._id]._unitRectObj[_loc_4][_loc_5][_loc_6];
                        }
                    }
                }
                this.initWeapon(param2);
            }
            return;
        }// end function

        public function clearLayer(param1, param2 = false)
        {
            var _loc_3:* = this._exLayerArray[param1];
            if (_loc_3 == null)
            {
                return;
            }
            if (_loc_3._loader != null)
            {
                _loc_3._loader.removeEventListener(Event.COMPLETE, this.handleWeaponLoadComplete);
                delete _loc_3._loader;
            }
            if (_loc_3._pLoader != null)
            {
                _loc_3._pLoader.removeEventListener(Event.COMPLETE, this.handleWeaponPicLoadComplete);
                delete _loc_3._pLoader;
            }
            if (_loc_3._bitmap != null)
            {
                _loc_3._bitmap.bitmapData = null;
                if (_loc_3._bitmap.parent != null)
                {
                    _loc_3._bitmap.parent.removeChild(_loc_3._bitmap);
                }
                _loc_3._bitmap.scaleX = 1;
                _loc_3._bitmap.rotation = 0;
            }
            _loc_3._bitmap = null;
            _loc_3._id = 0;
            _loc_3._data = null;
            delete this._exLayerArray[param1];
            if (!param2)
            {
                if (this.ready)
                {
                    this.sortMultiLayer();
                }
                if (this._state != null)
                {
                    this.firstChangeState();
                }
            }
            return;
        }// end function

        public function set lWing(param1)
        {
            if (param1 != null)
            {
                this.addExLayer(param1, 3);
            }
            else
            {
                this.clearLayer(3);
                dispatchEvent(new Event("weaponComplete"));
            }
            return;
        }// end function

        public function set rWing(param1)
        {
            if (param1 != null)
            {
                this.addExLayer(param1, 4);
            }
            else
            {
                this.clearLayer(4);
                dispatchEvent(new Event("weaponComplete"));
            }
            return;
        }// end function

        public function set weapon(param1)
        {
            if (param1 != null)
            {
                this.addExLayer(param1, 2);
            }
            else
            {
                this.clearLayer(2);
                dispatchEvent(new Event("weaponComplete"));
            }
            return;
        }// end function

        public function set cloth(param1)
        {
            if (param1 != null)
            {
                this.addExLayer(param1, 1);
            }
            else
            {
                this.clearLayer(1);
                dispatchEvent(new Event("weaponComplete"));
            }
            return;
        }// end function

        public function set hair(param1)
        {
            if (param1 != null)
            {
                this.addExLayer(param1, 0);
            }
            else
            {
                this.clearLayer(0);
                dispatchEvent(new Event("weaponComplete"));
            }
            return;
        }// end function

        private function handleWeaponLoadComplete(param1)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            var _loc_9:* = undefined;
            param1.target.removeEventListener(Event.COMPLETE, this.handleWeaponLoadComplete);
            var _loc_2:* = param1.target.data;
            if (!this._destroyed && this._exLayerArray[_loc_2] != null)
            {
                _loc_3 = this._exLayerArray[_loc_2]._id;
                if (_buff[_loc_3] == null)
                {
                    _loc_4 = FileLoader.pick(_modelURL + this._exLayerArray[_loc_2]._id + ".mod");
                    this._exLayerArray[_loc_2]._yOff = _loc_4._yOff;
                    this._exLayerArray[_loc_2]._frameSkip = _loc_4._frameSkip;
                    this._exLayerArray[_loc_2]._directions = _loc_4._directions;
                    this._exLayerArray[_loc_2]._loopFrame = _loc_4._loopFrame;
                    this._exLayerArray[_loc_2]._a4 = _loc_4._a4;
                    this._exLayerArray[_loc_2]._soundObj = _loc_4._soundObj;
                    this._exLayerArray[_loc_2]._soundDelayObj = _loc_4._soundDelayObj;
                    this._exLayerArray[_loc_2]._oneDirecionObj = _loc_4._oneDirecionObj;
                    this._exLayerArray[_loc_2]._bitmapRectY = _loc_4._bitmapRectY;
                    this._exLayerArray[_loc_2]._bitmapRectW = _loc_4._bitmapRectW;
                    this._exLayerArray[_loc_2]._unitObj = {};
                    this._exLayerArray[_loc_2]._unitRectObj = {};
                    _loc_8 = {};
                    _loc_9 = [];
                    for (_loc_5 in _loc_4._unitObj)
                    {
                        
                        this._exLayerArray[_loc_2]._unitObj[_loc_5] = [];
                        this._exLayerArray[_loc_2]._unitRectObj[_loc_5] = [];
                        for (_loc_6 in _loc_4._unitObj[_loc_5])
                        {
                            
                            this._exLayerArray[_loc_2]._unitObj[_loc_5][_loc_6] = [];
                            this._exLayerArray[_loc_2]._unitRectObj[_loc_5][_loc_6] = [];
                            for (_loc_7 in _loc_4._unitObj[_loc_5][_loc_6])
                            {
                                
                                this._exLayerArray[_loc_2]._unitRectObj[_loc_5][_loc_6][_loc_7] = _loc_4._unitRectObj[_loc_5][_loc_6][_loc_7];
                                this._exLayerArray[_loc_2]._unitObj[_loc_5][_loc_6][_loc_7] = true;
                                _loc_8[this._exLayerArray[_loc_2]._id + "_" + _loc_5 + "_" + _loc_6 + "_" + _loc_7] = _loc_4._unitObj[_loc_5][_loc_6][_loc_7];
                                _loc_9.push(this._exLayerArray[_loc_2]._id + "_" + _loc_5 + "_" + _loc_6 + "_" + _loc_7);
                            }
                        }
                    }
                    BitmapLoader.setByteArray(_loc_8);
                    this._exLayerArray[_loc_2]._pLoader = BitmapLoader.newBitmapLoader();
                    this._exLayerArray[_loc_2]._pLoader.data = _loc_2;
                    this._exLayerArray[_loc_2]._pLoader.removeEventListener(Event.COMPLETE, this.handleWeaponPicLoadComplete);
                    this._exLayerArray[_loc_2]._pLoader.addEventListener(Event.COMPLETE, this.handleWeaponPicLoadComplete);
                    this._exLayerArray[_loc_2]._pLoader.load(_loc_9);
                }
                else
                {
                    _loc_4 = _buff[_loc_3];
                    this._exLayerArray[_loc_2]._yOff = _loc_4.yOff;
                    this._exLayerArray[_loc_2]._frameSkip = _loc_4._frameSkip;
                    this._exLayerArray[_loc_2]._directions = _loc_4._directions;
                    this._exLayerArray[_loc_2]._loopFrame = _loc_4._loopFrame;
                    this._exLayerArray[_loc_2]._a4 = _loc_4._a4;
                    this._exLayerArray[_loc_2]._soundObj = _loc_4._soundObj;
                    this._exLayerArray[_loc_2]._soundDelayObj = _loc_4._soundDelayObj;
                    this._exLayerArray[_loc_2]._oneDirecionObj = _loc_4._oneDirecionObj;
                    this._exLayerArray[_loc_2]._bitmapRectY = _loc_4._bitmapRectY;
                    this._exLayerArray[_loc_2]._bitmapRectW = _loc_4._bitmapRectW;
                    this._exLayerArray[_loc_2]._unitObj = {};
                    this._exLayerArray[_loc_2]._unitRectObj = {};
                    for (_loc_5 in _loc_4._unitObj)
                    {
                        
                        this._exLayerArray[_loc_2]._unitObj[_loc_5] = [];
                        this._exLayerArray[_loc_2]._unitRectObj[_loc_5] = [];
                        for (_loc_6 in _loc_4._unitObj[_loc_5])
                        {
                            
                            this._exLayerArray[_loc_2]._unitObj[_loc_5][_loc_6] = [];
                            this._exLayerArray[_loc_2]._unitRectObj[_loc_5][_loc_6] = [];
                            for (_loc_7 in _loc_4._unitObj[_loc_5][_loc_6])
                            {
                                
                                this._exLayerArray[_loc_2]._unitObj[_loc_5][_loc_6][_loc_7] = _loc_4._unitObj[_loc_5][_loc_6][_loc_7];
                                this._exLayerArray[_loc_2]._unitRectObj[_loc_5][_loc_6][_loc_7] = _loc_4._unitRectObj[_loc_5][_loc_6][_loc_7];
                            }
                        }
                    }
                    this.initWeapon(_loc_2);
                }
            }
            else
            {
                trace("_destroyed build");
            }
            return;
        }// end function

        public function initWeapon(param1, param2 = false)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            var _loc_9:* = undefined;
            if (this._destroyed)
            {
                return;
            }
            if (!param2)
            {
                if (_initCount >= _initStackMax)
                {
                    _loc_7 = false;
                    _loc_3 = 0;
                    while (_loc_3 < _initStack.length)
                    {
                        
                        if (_initStack[_loc_3].obj == this && _initStack[_loc_3].layer == param1)
                        {
                            _loc_7 = true;
                            break;
                        }
                        _loc_3 = _loc_3 + 1;
                    }
                    if (!_loc_7)
                    {
                        _initStack.push({obj:this, layer:param1});
                        Config.startLoop(initStackLoop);
                    }
                    return;
                }
            }
            var _loc_11:* = _initCount + 1;
            _initCount = _loc_11;
            var _loc_6:* = this._exLayerArray[param1];
            if (this._exLayerArray[param1]._bitmap == null)
            {
                _loc_6._bitmap = new Bitmap();
            }
            _loc_6._bitmap.x = (-this._width) / 2;
            _loc_6._bitmap.y = this._yOff - this._z;
            addChild(_loc_6._bitmap);
            if (this._multiLayer)
            {
                _loc_8 = {};
                _loc_9 = {};
                for (_loc_4 in _loc_6._unitObj)
                {
                    
                    _loc_8[_loc_4] = [];
                    _loc_9[_loc_4] = [];
                    for (_loc_5 in _loc_6._unitObj[_loc_4])
                    {
                        
                        _loc_8[_loc_4][_loc_5] = [];
                        _loc_9[_loc_4][_loc_5] = [];
                    }
                }
                _loc_6._unitObj = _loc_8;
                _loc_6._unitRectObj = _loc_9;
            }
            _loc_6._ready = true;
            if (this.ready)
            {
                this.sortMultiLayer();
            }
            if (this._state != null)
            {
                this.firstChangeState();
            }
            dispatchEvent(new Event("weaponComplete"));
            return;
        }// end function

        public function get ready()
        {
            var _loc_1:* = undefined;
            if (!this._ready)
            {
                return false;
            }
            for (_loc_1 in this._exLayerArray)
            {
                
                if (!this._exLayerArray[_loc_1]._ready)
                {
                    return false;
                }
            }
            return true;
        }// end function

        private function firstChangeState()
        {
            if (!this._multiLayer || Config.paused)
            {
                this.subFirstChangeState();
            }
            else
            {
                this.startLoop(this.subFirstChangeState);
            }
            return;
        }// end function

        private function subFirstChangeState(param1 = null)
        {
            if (this._clone)
            {
            }
            this.stopLoop(this.subFirstChangeState);
            this.changeStateTo(this._state, this._overDo, true);
            this.forceAnimation(0);
            return;
        }// end function

        private function sortMultiLayer()
        {
            if (this._multiLayer)
            {
                if (Config.paused)
                {
                    this.subSortMultiLayer();
                }
                else
                {
                    this.startLoop(this.subSortMultiLayer);
                }
            }
            return;
        }// end function

        private function subSortMultiLayer(param1 = null)
        {
            var i:*;
            var j:*;
            var k:*;
            var l:*;
            var m:*;
            var n:*;
            var arr:*;
            var arr1:*;
            var arr2:*;
            var map1:*;
            var id:*;
            var count:*;
            var obj:*;
            var obj1:*;
            var event:* = param1;
            this.stopLoop(this.subSortMultiLayer);
            try
            {
                if (this._bitmap != null)
                {
                    addChild(this._bitmap);
                }
                var _loc_3:* = 0;
                var _loc_4:* = this._exLayerArray;
                while (_loc_4 in _loc_3)
                {
                    
                    i = _loc_4[_loc_3];
                    if (this._exLayerArray[i]._bitmap != null)
                    {
                        addChild(this._exLayerArray[i]._bitmap);
                    }
                }
                var _loc_3:* = 0;
                var _loc_4:* = this._layerStack;
                while (_loc_4 in _loc_3)
                {
                    
                    i = _loc_4[_loc_3];
                    var _loc_5:* = 0;
                    var _loc_6:* = this._layerStack[i];
                    while (_loc_6 in _loc_5)
                    {
                        
                        j = _loc_6[_loc_5];
                        var _loc_7:* = 0;
                        var _loc_8:* = this._layerStack[i][j];
                        while (_loc_8 in _loc_7)
                        {
                            
                            k = _loc_8[_loc_7];
                            map1;
                            arr1;
                            arr2;
                            if (this._bitmap != null)
                            {
                                map1[0] = this;
                                arr2.push(this);
                            }
                            var _loc_9:* = 0;
                            var _loc_10:* = this._exLayerArray;
                            while (_loc_10 in _loc_9)
                            {
                                
                                m = _loc_10[_loc_9];
                                if (this._exLayerArray[m]._bitmap != null)
                                {
                                    map1[(m + 1)] = this._exLayerArray[m];
                                    arr2.push(this._exLayerArray[m]);
                                }
                            }
                            arr = this._layerStack[i][j][k];
                            m;
                            while (m < arr.length)
                            {
                                
                                if (map1[arr[m]] != null)
                                {
                                    id = map1[arr[m]]._id;
                                    arr1.push(map1[arr[m]]._id);
                                }
                                m = (m + 1);
                            }
                            m;
                            while (m < arr1.length)
                            {
                                
                                id = arr1[m];
                                if (arr2[(arr1.length - 1) - m]._unitRectObj[i] == null)
                                {
                                    arr2[(arr1.length - 1) - m]._unitRectObj[i] = [];
                                }
                                if (arr2[(arr1.length - 1) - m]._unitRectObj[i][j] == null)
                                {
                                    arr2[(arr1.length - 1) - m]._unitRectObj[i][j] = [];
                                }
                                if (arr2[(arr1.length - 1) - m]._unitObj[i] == null)
                                {
                                    arr2[(arr1.length - 1) - m]._unitObj[i] = [];
                                }
                                if (arr2[(arr1.length - 1) - m]._unitObj[i][j] == null)
                                {
                                    arr2[(arr1.length - 1) - m]._unitObj[i][j] = [];
                                }
                                arr2[(arr1.length - 1) - m]._unitRectObj[i][j][k] = _buff[id]._unitRectObj[i][j][k];
                                arr2[(arr1.length - 1) - m]._unitObj[i][j][k] = _buff[id]._unitObj[i][j][k];
                                m = (m + 1);
                            }
                        }
                    }
                }
            }
            catch (e)
            {
                trace("error subSortMultiLayer", e);
            }
            return;
        }// end function

        public function set locked(param1)
        {
            this._locked = param1;
            return;
        }// end function

        public function get locked()
        {
            return this._locked;
        }// end function

        private function handleLoadProgress(param1)
        {
            var _loc_2:* = undefined;
            if (!this._destroyed)
            {
                _loc_2 = Math.floor(param1.bytesLoaded / param1.bytesTotal * 100);
                if (this._progressTxt != null)
                {
                    this._progressTxt.text = _loc_2 + "%";
                }
            }
            return;
        }// end function

        private function handleLoadComplete(param1)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            if (this._progressTxt != null && this._progressTxt.parent != null)
            {
                this._progressTxt.parent.removeChild(this._progressTxt);
                this._progressTxt = null;
            }
            param1.target.removeEventListener("progress", this.handleLoadProgress);
            param1.target.removeEventListener(Event.COMPLETE, this.handleLoadComplete);
            if (!this._destroyed)
            {
                if (_buff[this._id] == null)
                {
                    _loc_2 = FileLoader.pick(_modelURL + this._id + ".mod");
                    this._yOff = _loc_2._yOff;
                    this._frameSkip = _loc_2._frameSkip;
                    this._directions = _loc_2._directions;
                    this._loopFrame = _loc_2._loopFrame;
                    this._a4 = _loc_2._a4;
                    this._soundObj = _loc_2._soundObj;
                    this._soundDelayObj = _loc_2._soundDelayObj;
                    this._oneDirecionObj = _loc_2._oneDirecionObj;
                    this._bitmapRectY = _loc_2._bitmapRectY;
                    this._bitmapRectW = _loc_2._bitmapRectW;
                    this._unitObj = {};
                    this._unitRectObj = {};
                    _loc_6 = {};
                    _loc_7 = [];
                    for (_loc_3 in _loc_2._unitObj)
                    {
                        
                        this._unitObj[_loc_3] = [];
                        this._unitRectObj[_loc_3] = [];
                        for (_loc_4 in _loc_2._unitObj[_loc_3])
                        {
                            
                            this._unitObj[_loc_3][_loc_4] = [];
                            this._unitRectObj[_loc_3][_loc_4] = [];
                            for (_loc_5 in _loc_2._unitObj[_loc_3][_loc_4])
                            {
                                
                                this._unitObj[_loc_3][_loc_4][_loc_5] = true;
                                this._unitRectObj[_loc_3][_loc_4][_loc_5] = _loc_2._unitRectObj[_loc_3][_loc_4][_loc_5];
                                _loc_6[this._id + "_" + _loc_3 + "_" + _loc_4 + "_" + _loc_5] = _loc_2._unitObj[_loc_3][_loc_4][_loc_5];
                                _loc_7.push(this._id + "_" + _loc_3 + "_" + _loc_4 + "_" + _loc_5);
                            }
                        }
                    }
                    BitmapLoader.setByteArray(_loc_6);
                    this._pLoader = BitmapLoader.newBitmapLoader();
                    this._pLoader.removeEventListener(Event.COMPLETE, this.handlePicLoadComplete);
                    this._pLoader.addEventListener(Event.COMPLETE, this.handlePicLoadComplete);
                    this._pLoader.load(_loc_7);
                }
                else
                {
                    _loc_2 = _buff[this._id];
                    this._yOff = _loc_2._yOff;
                    this._frameSkip = _loc_2._frameSkip;
                    this._directions = _loc_2._directions;
                    this._loopFrame = _loc_2._loopFrame;
                    this._a4 = _loc_2._a4;
                    this._soundObj = _loc_2._soundObj;
                    this._soundDelayObj = _loc_2._soundDelayObj;
                    this._oneDirecionObj = _loc_2._oneDirecionObj;
                    this._bitmapRectY = _loc_2._bitmapRectY;
                    this._bitmapRectW = _loc_2._bitmapRectW;
                    this._unitObj = {};
                    this._unitRectObj = {};
                    for (_loc_3 in _loc_2._unitObj)
                    {
                        
                        this._unitObj[_loc_3] = [];
                        this._unitRectObj[_loc_3] = [];
                        for (_loc_4 in _loc_2._unitObj[_loc_3])
                        {
                            
                            this._unitObj[_loc_3][_loc_4] = [];
                            this._unitRectObj[_loc_3][_loc_4] = [];
                            for (_loc_5 in _loc_2._unitObj[_loc_3][_loc_4])
                            {
                                
                                this._unitObj[_loc_3][_loc_4][_loc_5] = _loc_2._unitObj[_loc_3][_loc_4][_loc_5];
                                this._unitRectObj[_loc_3][_loc_4][_loc_5] = _loc_2._unitRectObj[_loc_3][_loc_4][_loc_5];
                            }
                        }
                    }
                    this.init();
                }
            }
            else
            {
                trace("_destroyed build");
            }
            return;
        }// end function

        private function handleWeaponPicLoadComplete(param1)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            param1.target.removeEventListener(Event.COMPLETE, this.handleWeaponPicLoadComplete);
            var _loc_2:* = param1.target.data;
            if (!this._destroyed && this._exLayerArray[_loc_2] != null)
            {
                if (_buff[this._exLayerArray[_loc_2]._id] == null)
                {
                    for (_loc_3 in this._exLayerArray[_loc_2]._unitObj)
                    {
                        
                        for (_loc_4 in this._exLayerArray[_loc_2]._unitObj[_loc_3])
                        {
                            
                            for (_loc_5 in this._exLayerArray[_loc_2]._unitObj[_loc_3][_loc_4])
                            {
                                
                                this._exLayerArray[_loc_2]._unitObj[_loc_3][_loc_4][_loc_5] = BitmapLoader.pick(this._exLayerArray[_loc_2]._id + "_" + _loc_3 + "_" + _loc_4 + "_" + _loc_5);
                            }
                        }
                    }
                    _buff[this._exLayerArray[_loc_2]._id] = {};
                    _buff[this._exLayerArray[_loc_2]._id]._yOff = this._exLayerArray[_loc_2]._yOff;
                    _buff[this._exLayerArray[_loc_2]._id]._frameSkip = this._exLayerArray[_loc_2]._frameSkip;
                    _buff[this._exLayerArray[_loc_2]._id]._directions = this._exLayerArray[_loc_2]._directions;
                    _buff[this._exLayerArray[_loc_2]._id]._loopFrame = this._exLayerArray[_loc_2]._loopFrame;
                    _buff[this._exLayerArray[_loc_2]._id]._a4 = this._exLayerArray[_loc_2]._a4;
                    _buff[this._exLayerArray[_loc_2]._id]._unitRectObj = this._exLayerArray[_loc_2]._unitRectObj;
                    _buff[this._exLayerArray[_loc_2]._id]._soundObj = this._exLayerArray[_loc_2]._soundObj;
                    _buff[this._exLayerArray[_loc_2]._id]._soundDelayObj = this._exLayerArray[_loc_2]._soundDelayObj;
                    _buff[this._exLayerArray[_loc_2]._id]._oneDirecionObj = this._exLayerArray[_loc_2]._oneDirecionObj;
                    _buff[this._exLayerArray[_loc_2]._id]._bitmapRectY = this._exLayerArray[_loc_2]._bitmapRectY;
                    _buff[this._exLayerArray[_loc_2]._id]._bitmapRectW = this._exLayerArray[_loc_2]._bitmapRectW;
                    _buff[this._exLayerArray[_loc_2]._id]._unitObj = this._exLayerArray[_loc_2]._unitObj;
                }
                else
                {
                    _loc_6 = _buff[this._exLayerArray[_loc_2]._id];
                    this._exLayerArray[_loc_2]._yOff = _loc_6._yOff;
                    this._exLayerArray[_loc_2]._frameSkip = _loc_6._frameSkip;
                    this._exLayerArray[_loc_2]._directions = _loc_6._directions;
                    this._exLayerArray[_loc_2]._loopFrame = _loc_6._loopFrame;
                    this._exLayerArray[_loc_2]._a4 = _loc_6._a4;
                    this._exLayerArray[_loc_2]._unitRectObj = _loc_6._unitRectObj;
                    this._exLayerArray[_loc_2]._soundObj = _loc_6._soundObj;
                    this._exLayerArray[_loc_2]._soundDelayObj = _loc_6._soundDelayObj;
                    this._exLayerArray[_loc_2]._oneDirecionObj = _loc_6._oneDirecionObj;
                    this._exLayerArray[_loc_2]._bitmapRectY = _loc_6._bitmapRectY;
                    this._exLayerArray[_loc_2]._bitmapRectW = _loc_6._bitmapRectW;
                    this._exLayerArray[_loc_2]._unitObj = _loc_6._unitObj;
                }
                this.initWeapon(_loc_2);
            }
            return;
        }// end function

        private function handlePicLoadComplete(param1)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            param1.target.removeEventListener(Event.COMPLETE, this.handlePicLoadComplete);
            if (!this._destroyed)
            {
                if (_buff[this._id] == null)
                {
                    for (_loc_2 in this._unitObj)
                    {
                        
                        for (_loc_3 in this._unitObj[_loc_2])
                        {
                            
                            for (_loc_4 in this._unitObj[_loc_2][_loc_3])
                            {
                                
                                this._unitObj[_loc_2][_loc_3][_loc_4] = BitmapLoader.pick(this._id + "_" + _loc_2 + "_" + _loc_3 + "_" + _loc_4);
                            }
                        }
                    }
                    _buff[this._id] = {};
                    _buff[this._id]._yOff = this._yOff;
                    _buff[this._id]._frameSkip = this._frameSkip;
                    _buff[this._id]._directions = this._directions;
                    _buff[this._id]._loopFrame = this._loopFrame;
                    _buff[this._id]._a4 = this._a4;
                    _buff[this._id]._unitRectObj = this._unitRectObj;
                    _buff[this._id]._soundObj = this._soundObj;
                    _buff[this._id]._soundDelayObj = this._soundDelayObj;
                    _buff[this._id]._oneDirecionObj = this._oneDirecionObj;
                    _buff[this._id]._bitmapRectY = this._bitmapRectY;
                    _buff[this._id]._bitmapRectW = this._bitmapRectW;
                    _buff[this._id]._unitObj = this._unitObj;
                }
                else
                {
                    _loc_5 = _buff[this._id];
                    this._yOff = _loc_5._yOff;
                    this._frameSkip = _loc_5._frameSkip;
                    this._directions = _loc_5._directions;
                    this._loopFrame = _loc_5._loopFrame;
                    this._a4 = _loc_5._a4;
                    this._unitRectObj = _loc_5._unitRectObj;
                    this._soundObj = _loc_5._soundObj;
                    this._soundDelayObj = _loc_5._soundDelayObj;
                    this._oneDirecionObj = _loc_5._oneDirecionObj;
                    this._bitmapRectY = _loc_5._bitmapRectY;
                    this._bitmapRectW = _loc_5._bitmapRectW;
                    this._unitObj = _loc_5._unitObj;
                }
                this.init();
            }
            return;
        }// end function

        public function startLoop(param1:Function)
        {
            if (!this._destroyed)
            {
                this.stopLoop(param1);
                this._enterframeListenerArray.push(param1);
                if (this._enterframeListenerArray.length == 1)
                {
                    addEventListener(Event.ENTER_FRAME, this.enterframeLoop);
                }
            }
            return;
        }// end function

        public function stopLoop(param1:Function)
        {
            var _loc_2:* = undefined;
            _loc_2 = 0;
            while (_loc_2 < this._enterframeListenerArray.length)
            {
                
                if (this._enterframeListenerArray[_loc_2] == param1)
                {
                    this._enterframeListenerArray.splice(_loc_2, 1);
                    break;
                }
                _loc_2 = _loc_2 + 1;
            }
            if (this._enterframeListenerArray.length == 0)
            {
                removeEventListener(Event.ENTER_FRAME, this.enterframeLoop);
            }
            return;
        }// end function

        private function enterframeLoop(param1)
        {
            var _loc_2:* = undefined;
            if (!Config.paused)
            {
                for (_loc_2 in this._enterframeListenerArray)
                {
                    
                    var _loc_5:* = this._enterframeListenerArray;
                    _loc_5.this._enterframeListenerArray[_loc_2](param1);
                }
            }
            if (this._enterframeListenerArray.length == 0)
            {
                removeEventListener(Event.ENTER_FRAME, this.enterframeLoop);
            }
            return;
        }// end function

        private function clearEnterframeLoop()
        {
            this._enterframeListenerArray = [];
            removeEventListener(Event.ENTER_FRAME, this.enterframeLoop);
            return;
        }// end function

        public function clone(param1:UnitClip)
        {
            this._cloneOri = param1;
            this.startLoop(this.subClone);
            return;
        }// end function

        public function subClone(param1)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            this.stopLoop(this.subClone);
            var _loc_2:* = this._cloneOri;
            this._clone = true;
            this._data = _loc_2._data;
            this._alpha = _loc_2._alpha;
            this._yOff = _loc_2._yOff;
            this._frameSkip = _loc_2._frameSkip;
            this._action = _loc_2._action;
            this._directions = _loc_2._directions;
            this._width = _loc_2._width;
            this._height = _loc_2._height;
            this._bitmapRectW = 0;
            this._bitmapRectY = 0;
            if (this._bitmap == null)
            {
                this._bitmap = new Bitmap();
                this._bitmap.x = (-this._width) / 2;
                this._bitmap.y = this._yOff;
            }
            addChild(this._bitmap);
            this._yOff = _loc_2._yOff;
            this._frameSkip = _loc_2._frameSkip;
            this._directions = _loc_2._directions;
            this._loopFrame = _loc_2._loopFrame;
            this._a4 = _loc_2._a4;
            this._unitRectObj = _loc_2._unitRectObj;
            this._soundObj = _loc_2._soundObj;
            this._soundDelayObj = _loc_2._soundDelayObj;
            this._oneDirecionObj = _loc_2._oneDirecionObj;
            this._bitmapRectY = _loc_2._bitmapRectY;
            this._bitmapRectW = _loc_2._bitmapRectW;
            this._unitObj = _loc_2._unitObj;
            for (_loc_3 in this._exLayerArray)
            {
                
                this.clearLayer(_loc_3, true);
            }
            for (_loc_3 in _loc_2._exLayerArray)
            {
                
                _loc_4 = {};
                _loc_5 = _loc_2._exLayerArray[_loc_3];
                _loc_4._data = _loc_5._data;
                _loc_4._id = Number(_loc_4._data.id);
                _loc_4._action = Number(_loc_4._data.action);
                _loc_4._ready = true;
                this._exLayerArray[_loc_3] = _loc_4;
                if (_loc_4._bitmap == null)
                {
                    _loc_4._bitmap = new Bitmap();
                    _loc_4._bitmap.x = (-this._width) / 2;
                    _loc_4._bitmap.y = this._yOff;
                }
                addChild(_loc_4._bitmap);
                _loc_4._yOff = _loc_5._yOff;
                _loc_4._frameSkip = _loc_5._frameSkip;
                _loc_4._directions = _loc_5._directions;
                _loc_4._loopFrame = _loc_5._loopFrame;
                _loc_4._a4 = _loc_5._a4;
                _loc_4._unitRectObj = _loc_5._unitRectObj;
                _loc_4._soundObj = _loc_5._soundObj;
                _loc_4._soundDelayObj = _loc_5._soundDelayObj;
                _loc_4._oneDirecionObj = _loc_5._oneDirecionObj;
                _loc_4._bitmapRectY = _loc_5._bitmapRectY;
                _loc_4._bitmapRectW = _loc_5._bitmapRectW;
                _loc_4._unitObj = _loc_5._unitObj;
            }
            this._currFrame = 0;
            this.setHue(this._hue);
            this._ready = true;
            if (this.ready)
            {
                this.sortMultiLayer();
            }
            if (this._state != null)
            {
                this.firstChangeState();
            }
            return;
        }// end function

        private function completeHandler(param1)
        {
            trace("savefileComplete");
            return;
        }// end function

        private function errorHandler(param1)
        {
            trace("savefileError");
            return;
        }// end function

        public function setHue(param1)
        {
            this._hue = param1;
            if (this._bitmap != null)
            {
                if (this._hue == null || this._hue % 360 == 0)
                {
                    this._bitmap.filters = [];
                }
                else
                {
                    this._bitmap.filters = [HueColorMatrixFilter.getHue(this._hue)];
                }
            }
            return;
        }// end function

        public function setAlpha(param1)
        {
            if (this._alpha != param1)
            {
                this._alpha = param1;
                if (this._alpha == null)
                {
                    this._bitmap.alpha = 1;
                }
                else
                {
                    this._bitmap.alpha = this._alpha;
                }
            }
            return;
        }// end function

        public function destroy()
        {
            var _loc_1:* = undefined;
            this.transform.colorTransform = new ColorTransform();
            this.filters = [];
            _loc_1 = 0;
            while (_loc_1 < _initStack.length)
            {
                
                if (_initStack[_loc_1].obj == this)
                {
                    _initStack.splice(_loc_1, 1);
                    _loc_1 = _loc_1 - 1;
                }
                _loc_1 = _loc_1 + 1;
            }
            for (_loc_1 in this._exLayerArray)
            {
                
                this.clearLayer(_loc_1, true);
            }
            this._clone = false;
            this.layerStack = null;
            this._multiLayer = false;
            if (this._loader != null)
            {
                this._loader.removeEventListener("progress", this.handleLoadProgress);
                this._loader.removeEventListener(Event.COMPLETE, this.handleLoadComplete);
                this._loader = null;
            }
            if (this._pLoader != null)
            {
                this._pLoader.removeEventListener(Event.COMPLETE, this.handlePicLoadComplete);
                this._pLoader = null;
            }
            this.removeShadow();
            this.clearEnterframeLoop();
            this._ready = false;
            this._freeze = false;
            if (this._bitmap != null)
            {
                this._bitmap.bitmapData = null;
                if (this._bitmap.parent != null)
                {
                    this._bitmap.parent.removeChild(this._bitmap);
                }
                this._bitmap.scaleX = 1;
                this._bitmap.rotation = 0;
                this._bitmap = null;
            }
            this._dynamicData = {};
            x = 0;
            y = 0;
            this._direction = 0;
            this._z = 0;
            this._xoff = 0;
            this._ready = false;
            this._concated = false;
            this._locked = false;
            this._bitmapArray = null;
            this._overDo = null;
            this._direction = 0;
            this._currFrame = 0;
            this._currTotalFrame = 0;
            this._oneDirecionObj = 0;
            this._frameSkip = 0;
            this._frameLeft = 0;
            this._loopFrame = 0;
            this._state = null;
            this._direction = 0;
            this._shadowSize = 0;
            this._shadowAlpha = 0;
            this._unitObj = null;
            this._soundObj = null;
            this._soundDelayObj = null;
            this._currFrame = 0;
            this._currTotalFrame = 0;
            this._oneDirecionObj = null;
            this._frameSkip = 0;
            this._frameLeft = 0;
            this._loopFrame = 0;
            this._directions = 0;
            this._width = 0;
            this._height = 0;
            this._colorReplaceArr = null;
            this._hue = null;
            this._alpha = null;
            this._yOff = 0;
            this._action = null;
            this._data = null;
            this._overDo = null;
            this._concated = false;
            this._locked = false;
            this._z = 0;
            this._xoff = 0;
            Config.clearDisplayList(this);
            clearTimeout(this._pushPoolTimer);
            if (!this._poolPushed)
            {
                this._poolPushed = true;
                this._pushPoolTimer = setTimeout(this.pushPool, 2000);
            }
            this._destroyed = true;
            return;
        }// end function

        private function pushPool()
        {
            clearTimeout(this._pushPoolTimer);
            _objectPool.push(this);
            return;
        }// end function

        public function removeShadow()
        {
            this.graphics.clear();
            return;
        }// end function

        public function addShadow(param1 = null, param2 = null, param3 = null)
        {
            var _loc_4:* = null;
            var _loc_5:* = undefined;
            if (param1 != null)
            {
                this._shadowSize = param1;
            }
            if (param2 != null)
            {
                this._shadowAlpha = param2;
            }
            if (param3 != null)
            {
                this._shadowScale = param3;
            }
            if (_shadowOn && this._shadow && this._shadowSize > 0 && this._shadowAlpha > 0)
            {
                this.graphics.clear();
                this.graphics.lineStyle(0, 0, 0);
                _loc_4 = new Matrix();
                _loc_5 = this._shadowSize * this._shadowScale;
                _loc_4.createGradientBox(_loc_5, _loc_5 / 2, 0, (-_loc_5) / 2, (-_loc_5) / 4);
                this.graphics.beginGradientFill(GradientType.RADIAL, [0, 0], [this._shadowAlpha, 0], [0, 255], _loc_4);
                this.graphics.drawEllipse((-_loc_5) / 2, (-_loc_5) / 4, _loc_5, _loc_5 / 2);
                this.graphics.endFill();
            }
            else
            {
                this.removeShadow();
            }
            return;
        }// end function

        public function set shadow(param1)
        {
            this._shadow = param1;
            if (this._shadow)
            {
                this.addShadow();
            }
            else
            {
                this.removeShadow();
            }
            return;
        }// end function

        public function get shadow()
        {
            return this._shadow;
        }// end function

        public function set zoff(param1:Number)
        {
            var _loc_2:* = undefined;
            this._z = param1;
            if (this._bitmap != null)
            {
                this._bitmap.y = this.bitmapY - this._z;
            }
            for (_loc_2 in this._exLayerArray)
            {
                
                if (this._exLayerArray[_loc_2]._bitmap != null)
                {
                    if (this._exLayerArray[_loc_2]._bitmapArray != null)
                    {
                        this._exLayerArray[_loc_2]._bitmap.y = this.getLayerY(_loc_2) - this._z;
                    }
                }
            }
            this.addShadow(null, null, (200 - this._z) / 200);
            return;
        }// end function

        public function get zoff() : Number
        {
            return this._z;
        }// end function

        public function set xoff(param1:Number)
        {
            var _loc_2:* = undefined;
            this._xoff = param1;
            if (this._bitmap != null)
            {
                this._bitmap.x = this.bitmapX + this._xoff;
            }
            for (_loc_2 in this._exLayerArray)
            {
                
                if (this._exLayerArray[_loc_2]._bitmap != null)
                {
                    if (this._exLayerArray[_loc_2]._bitmapArray != null)
                    {
                        this._exLayerArray[_loc_2]._bitmap.x = this.getLayerX(_loc_2) + this._xoff;
                    }
                }
            }
            return;
        }// end function

        public function get xoff() : Number
        {
            return this._xoff;
        }// end function

        public function init(param1 = false)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            if (this._destroyed)
            {
                return;
            }
            if (!param1)
            {
                if (_initCount >= _initStackMax)
                {
                    _loc_3 = false;
                    _loc_2 = 0;
                    while (_loc_2 < _initStack.length)
                    {
                        
                        if (_initStack[_loc_2].obj == this && _initStack[_loc_2].layer == -1)
                        {
                            _loc_3 = true;
                            break;
                        }
                        _loc_2 = _loc_2 + 1;
                    }
                    if (!_loc_3)
                    {
                        _initStack.push({obj:this, layer:-1});
                        Config.startLoop(initStackLoop);
                    }
                    return;
                }
            }
            var _loc_8:* = _initCount + 1;
            _initCount = _loc_8;
            if (this._bitmap == null)
            {
                this._bitmap = new Bitmap();
            }
            this._bitmap.x = (-this._width) / 2;
            this._bitmap.y = this._yOff - this._z;
            addChild(this._bitmap);
            if (this._multiLayer)
            {
                _loc_4 = {};
                _loc_5 = {};
                for (_loc_2 in this._unitObj)
                {
                    
                    _loc_4[_loc_2] = [];
                    _loc_5[_loc_2] = [];
                    for (_loc_6 in this._unitObj[_loc_2])
                    {
                        
                        _loc_4[_loc_2][_loc_6] = [];
                        _loc_5[_loc_2][_loc_6] = [];
                    }
                }
                this._unitObj = _loc_4;
                this._unitRectObj = _loc_5;
            }
            this.setHue(this._hue);
            this._currFrame = 0;
            this.addShadow(this._bitmapRectW, 0.8);
            this._ready = true;
            if (this.ready)
            {
                this.sortMultiLayer();
            }
            if (this._state != null)
            {
                this.firstChangeState();
            }
            dispatchEvent(new Event(Event.COMPLETE));
            return;
        }// end function

        private function onEnterFrame(param1)
        {
            var event:* = param1;
            if (!this._locked && !this._destroyed)
            {
                try
                {
                    this.playAnimation();
                }
                catch (e)
                {
                    trace("error onEnterFrame", e);
                }
            }
            return;
        }// end function

        public function get frame()
        {
            return this._currFrame * this._frameSkip + (this._frameSkip - this._frameLeft);
        }// end function

        public function get totalFrame()
        {
            return this._currTotalFrame * this._frameSkip;
        }// end function

        private function playAnimation()
        {
            var i:*;
            var temp:*;
            var sndURL:*;
            try
            {
                if (this._frameLeft <= 0)
                {
                    this._frameLeft = this._frameSkip;
                    var _loc_2:* = this;
                    var _loc_3:* = this._currFrame + 1;
                    _loc_2._currFrame = _loc_3;
                    if (this._currFrame >= this._currTotalFrame)
                    {
                        if (this._currTotalFrame > 1)
                        {
                            if (this._overDo != null)
                            {
                                this._overDo(this);
                            }
                        }
                        this._currFrame = this._loopFrame;
                        dispatchEvent(new Event("frameLoop"));
                    }
                    if (!this._destroyed)
                    {
                        this._bitmapRect = this._bitmapRectArray[this._currFrame];
                        this._bitmap.x = this.bitmapX + this._xoff;
                        this._bitmap.y = this.bitmapY - this._z;
                        this._bitmap.bitmapData = this._bitmapArray[this._currFrame];
                        var _loc_2:* = 0;
                        var _loc_3:* = this._exLayerArray;
                        while (_loc_3 in _loc_2)
                        {
                            
                            i = _loc_3[_loc_2];
                            if (this._exLayerArray[i]._bitmap != null)
                            {
                                if (this._exLayerArray[i]._bitmapArray != null)
                                {
                                    this._exLayerArray[i]._bitmapRect = this._exLayerArray[i]._bitmapRectArray[this._currFrame];
                                    this._exLayerArray[i]._bitmap.x = this.getLayerX(i) + this._xoff;
                                    this._exLayerArray[i]._bitmap.y = this.getLayerY(i) - this._z;
                                    this._exLayerArray[i]._bitmap.bitmapData = this._exLayerArray[i]._bitmapArray[this._currFrame];
                                    continue;
                                }
                                this._exLayerArray[i]._bitmap.bitmapData = null;
                            }
                        }
                    }
                    if (this._currFrame == 1)
                    {
                        if (this._soundObj[this._state] != null)
                        {
                            temp = Math.floor(Math.random() * this._soundObj[this._state].length);
                            sndURL = this._soundObj[this._state][temp];
                            if (sndURL != "undefined")
                            {
                                if (this._soundDelayObj[this._state] == 0)
                                {
                                    SoundManager.play(sndURL);
                                }
                                else
                                {
                                    setTimeout(SoundManager.play, this._soundDelayObj[this._state], sndURL);
                                }
                            }
                        }
                    }
                }
                else
                {
                    var _loc_2:* = this;
                    var _loc_3:* = this._frameLeft - 1;
                    _loc_2._frameLeft = _loc_3;
                }
            }
            catch (e)
            {
                trace("error playAnimation", e);
            }
            return;
        }// end function

        public function forceAnimation(param1 = null)
        {
            var i:*;
            var frame:* = param1;
            try
            {
                if (this._ready)
                {
                    if (frame != null)
                    {
                        this._currFrame = frame;
                    }
                    this._bitmapRect = this._bitmapRectArray[this._currFrame];
                    this._bitmap.x = this.bitmapX + this._xoff;
                    this._bitmap.y = this.bitmapY - this._z;
                    this._bitmap.bitmapData = this._bitmapArray[this._currFrame];
                    var _loc_3:* = 0;
                    var _loc_4:* = this._exLayerArray;
                    while (_loc_4 in _loc_3)
                    {
                        
                        i = _loc_4[_loc_3];
                        if (this._exLayerArray[i]._bitmap != null)
                        {
                            if (this._exLayerArray[i]._bitmapArray != null)
                            {
                                this._exLayerArray[i]._bitmapRect = this._exLayerArray[i]._bitmapRectArray[this._currFrame];
                                this._exLayerArray[i]._bitmap.x = this.getLayerX(i) + this._xoff;
                                this._exLayerArray[i]._bitmap.y = this.getLayerY(i) - this._z;
                                this._exLayerArray[i]._bitmap.bitmapData = this._exLayerArray[i]._bitmapArray[this._currFrame];
                                continue;
                            }
                            this._exLayerArray[i]._bitmap.bitmapData = null;
                        }
                    }
                }
            }
            catch (e)
            {
                trace("error forceAnimation", e);
            }
            return;
        }// end function

        public function killAnimation()
        {
            this.stopLoop(this.onEnterFrame);
            return;
        }// end function

        public function wakeAnimation()
        {
            this._freeze = false;
            if (this._currTotalFrame > 1)
            {
                this.startLoop(this.onEnterFrame);
            }
            else
            {
                this.stopLoop(this.onEnterFrame);
            }
            return;
        }// end function

        public function sleepAnimation()
        {
            this._freeze = true;
            this.stopLoop(this.onEnterFrame);
            return;
        }// end function

        public function changeStateTo(param1:String, param2:Function = null, param3 = false) : void
        {
            var _loc_4:* = undefined;
            if (this._ready && !this._locked && !this._destroyed && this._unitObj != null)
            {
                this._overDo = param2;
                if (this._state != param1 || param3)
                {
                    this._state = param1;
                    if (this._unitObj[this._state] != null)
                    {
                        if (this._oneDirecionObj[this._state])
                        {
                            this._bitmapArray = this._unitObj[this._state][0];
                            this._bitmapRectArray = this._unitRectObj[this._state][0];
                            for (_loc_4 in this._exLayerArray)
                            {
                                
                                if (this._exLayerArray[_loc_4]._bitmap != null && this._exLayerArray[_loc_4]._unitObj[this._state] != null)
                                {
                                    this._exLayerArray[_loc_4]._bitmapArray = this._exLayerArray[_loc_4]._unitObj[this._state][0];
                                    this._exLayerArray[_loc_4]._bitmapRectArray = this._exLayerArray[_loc_4]._unitRectObj[this._state][0];
                                    continue;
                                }
                                this._exLayerArray[_loc_4]._bitmapArray = null;
                                this._exLayerArray[_loc_4]._bitmapRectArray = null;
                            }
                            this._currTotalFrame = this._unitObj[this._state][0].length;
                        }
                        else
                        {
                            if (this._directions == 4)
                            {
                                if (this._a4 == 0)
                                {
                                    if (this._direction < 2)
                                    {
                                        this._bitmap.scaleX = 1;
                                        this._bitmapArray = this._unitObj[this._state][this._direction];
                                        this._bitmapRectArray = this._unitRectObj[this._state][this._direction];
                                        for (_loc_4 in this._exLayerArray)
                                        {
                                            
                                            if (this._exLayerArray[_loc_4]._bitmap != null && this._exLayerArray[_loc_4]._unitObj[this._state] != null)
                                            {
                                                this._exLayerArray[_loc_4]._bitmap.scaleX = 1;
                                                this._exLayerArray[_loc_4]._bitmapArray = this._exLayerArray[_loc_4]._unitObj[this._state][this._direction];
                                                this._exLayerArray[_loc_4]._bitmapRectArray = this._exLayerArray[_loc_4]._unitRectObj[this._state][this._direction];
                                                continue;
                                            }
                                            this._exLayerArray[_loc_4]._bitmapArray = null;
                                            this._exLayerArray[_loc_4]._bitmapRectArray = null;
                                        }
                                    }
                                    else
                                    {
                                        this._bitmap.scaleX = -1;
                                        this._bitmapArray = this._unitObj[this._state][3 - this._direction];
                                        this._bitmapRectArray = this._unitRectObj[this._state][3 - this._direction];
                                        for (_loc_4 in this._exLayerArray)
                                        {
                                            
                                            if (this._exLayerArray[_loc_4]._bitmap != null && this._exLayerArray[_loc_4]._unitObj[this._state] != null)
                                            {
                                                this._exLayerArray[_loc_4]._bitmap.scaleX = -1;
                                                this._exLayerArray[_loc_4]._bitmapArray = this._exLayerArray[_loc_4]._unitObj[this._state][3 - this._direction];
                                                this._exLayerArray[_loc_4]._bitmapRectArray = this._exLayerArray[_loc_4]._unitRectObj[this._state][3 - this._direction];
                                                continue;
                                            }
                                            this._exLayerArray[_loc_4]._bitmapArray = null;
                                            this._exLayerArray[_loc_4]._bitmapRectArray = null;
                                        }
                                    }
                                }
                                else if (this._direction < 3)
                                {
                                    this._bitmap.scaleX = 1;
                                    this._bitmapArray = this._unitObj[this._state][this._direction];
                                    this._bitmapRectArray = this._unitRectObj[this._state][this._direction];
                                    for (_loc_4 in this._exLayerArray)
                                    {
                                        
                                        if (this._exLayerArray[_loc_4]._bitmap != null && this._exLayerArray[_loc_4]._unitObj[this._state] != null)
                                        {
                                            this._exLayerArray[_loc_4]._bitmap.scaleX = 1;
                                            this._exLayerArray[_loc_4]._bitmapArray = this._exLayerArray[_loc_4]._unitObj[this._state][this._direction];
                                            this._exLayerArray[_loc_4]._bitmapRectArray = this._exLayerArray[_loc_4]._unitRectObj[this._state][this._direction];
                                            continue;
                                        }
                                        this._exLayerArray[_loc_4]._bitmapArray = null;
                                        this._exLayerArray[_loc_4]._bitmapRectArray = null;
                                    }
                                }
                                else
                                {
                                    this._bitmap.scaleX = -1;
                                    this._bitmapArray = this._unitObj[this._state][1];
                                    this._bitmapRectArray = this._unitRectObj[this._state][1];
                                    for (_loc_4 in this._exLayerArray)
                                    {
                                        
                                        if (this._exLayerArray[_loc_4]._bitmap != null && this._exLayerArray[_loc_4]._unitObj[this._state] != null)
                                        {
                                            this._exLayerArray[_loc_4]._bitmap.scaleX = -1;
                                            this._exLayerArray[_loc_4]._bitmapArray = this._exLayerArray[_loc_4]._unitObj[this._state][1];
                                            this._exLayerArray[_loc_4]._bitmapRectArray = this._exLayerArray[_loc_4]._unitRectObj[this._state][1];
                                            continue;
                                        }
                                        this._exLayerArray[_loc_4]._bitmapArray = null;
                                        this._exLayerArray[_loc_4]._bitmapRectArray = null;
                                    }
                                }
                            }
                            else if (this._directions == 8)
                            {
                                if (this._direction < 5)
                                {
                                    this._bitmap.scaleX = 1;
                                    this._bitmapArray = this._unitObj[this._state][this._direction];
                                    this._bitmapRectArray = this._unitRectObj[this._state][this._direction];
                                    for (_loc_4 in this._exLayerArray)
                                    {
                                        
                                        if (this._exLayerArray[_loc_4]._bitmap != null && this._exLayerArray[_loc_4]._unitObj != null && this._exLayerArray[_loc_4]._unitObj[this._state] != null)
                                        {
                                            this._exLayerArray[_loc_4]._bitmap.scaleX = 1;
                                            this._exLayerArray[_loc_4]._bitmapArray = this._exLayerArray[_loc_4]._unitObj[this._state][this._direction];
                                            this._exLayerArray[_loc_4]._bitmapRectArray = this._exLayerArray[_loc_4]._unitRectObj[this._state][this._direction];
                                            continue;
                                        }
                                        this._exLayerArray[_loc_4]._bitmapArray = null;
                                        this._exLayerArray[_loc_4]._bitmapRectArray = null;
                                    }
                                }
                                else
                                {
                                    this._bitmap.scaleX = -1;
                                    this._bitmapArray = this._unitObj[this._state][8 - this._direction];
                                    this._bitmapRectArray = this._unitRectObj[this._state][8 - this._direction];
                                    for (_loc_4 in this._exLayerArray)
                                    {
                                        
                                        if (this._exLayerArray[_loc_4]._bitmap != null && this._exLayerArray[_loc_4]._unitObj[this._state] != null)
                                        {
                                            this._exLayerArray[_loc_4]._bitmap.scaleX = -1;
                                            this._exLayerArray[_loc_4]._bitmapArray = this._exLayerArray[_loc_4]._unitObj[this._state][8 - this._direction];
                                            this._exLayerArray[_loc_4]._bitmapRectArray = this._exLayerArray[_loc_4]._unitRectObj[this._state][8 - this._direction];
                                            continue;
                                        }
                                        this._exLayerArray[_loc_4]._bitmapArray = null;
                                        this._exLayerArray[_loc_4]._bitmapRectArray = null;
                                    }
                                }
                            }
                            else if (this._directions == 16)
                            {
                                if (this._direction < 9)
                                {
                                    this._bitmap.scaleX = 1;
                                    this._bitmapArray = this._unitObj[this._state][this._direction];
                                    this._bitmapRectArray = this._unitRectObj[this._state][this._direction];
                                    for (_loc_4 in this._exLayerArray)
                                    {
                                        
                                        if (this._exLayerArray[_loc_4]._bitmap != null && this._exLayerArray[_loc_4]._unitObj[this._state] != null)
                                        {
                                            this._exLayerArray[_loc_4]._bitmap.scaleX = 1;
                                            this._exLayerArray[_loc_4]._bitmapArray = this._exLayerArray[_loc_4]._unitObj[this._state][this._direction];
                                            this._exLayerArray[_loc_4]._bitmapRectArray = this._exLayerArray[_loc_4]._unitRectObj[this._state][this._direction];
                                            continue;
                                        }
                                        this._exLayerArray[_loc_4]._bitmapArray = null;
                                        this._exLayerArray[_loc_4]._bitmapRectArray = null;
                                    }
                                }
                                else
                                {
                                    this._bitmap.scaleX = -1;
                                    this._bitmapArray = this._unitObj[this._state][16 - this._direction];
                                    this._bitmapRectArray = this._unitRectObj[this._state][16 - this._direction];
                                    for (_loc_4 in this._exLayerArray)
                                    {
                                        
                                        if (this._exLayerArray[_loc_4]._bitmap != null && this._exLayerArray[_loc_4]._unitObj[this._state] != null)
                                        {
                                            this._exLayerArray[_loc_4]._bitmap.scaleX = -1;
                                            this._exLayerArray[_loc_4]._bitmapArray = this._exLayerArray[_loc_4]._unitObj[this._state][16 - this._direction];
                                            this._exLayerArray[_loc_4]._bitmapRectArray = this._exLayerArray[_loc_4]._unitRectObj[this._state][16 - this._direction];
                                            continue;
                                        }
                                        this._exLayerArray[_loc_4]._bitmapArray = null;
                                        this._exLayerArray[_loc_4]._bitmapRectArray = null;
                                    }
                                }
                            }
                            this._currTotalFrame = this._bitmapArray.length;
                        }
                        this._currFrame = -1;
                        this._frameLeft = 0;
                        this.playAnimation();
                        if (this._currTotalFrame > 1)
                        {
                            if (!this._freeze)
                            {
                                this.startLoop(this.onEnterFrame);
                            }
                        }
                        else
                        {
                            this.stopLoop(this.onEnterFrame);
                        }
                        dispatchEvent(new Event("changeState"));
                    }
                }
            }
            else
            {
                this._state = param1;
                this._overDo = param2;
            }
            return;
        }// end function

        public function get bitmapX()
        {
            if (this._bitmap == null || this._bitmapRect == null)
            {
                return 0;
            }
            if (this._bitmap.scaleX == 1)
            {
                return (-this._width) / 2 + this._bitmapRect.x;
            }
            return this._width / 2 - this._bitmapRect.x;
        }// end function

        public function get bitmapY()
        {
            if (this._bitmapRect == null)
            {
                return this._yOff;
            }
            return this._yOff + this._bitmapRect.y;
        }// end function

        public function getLayerX(param1)
        {
            if (this._exLayerArray[param1]._bitmap == null || this._exLayerArray[param1]._bitmapRect == null)
            {
                return 0;
            }
            if (this._exLayerArray[param1]._bitmap.scaleX == 1)
            {
                return (-this._width) / 2 + this._exLayerArray[param1]._bitmapRect.x;
            }
            return this._width / 2 - this._exLayerArray[param1]._bitmapRect.x;
        }// end function

        public function getLayerY(param1)
        {
            if (this._exLayerArray[param1]._bitmapRect == null)
            {
                return this._yOff;
            }
            return this._yOff + this._exLayerArray[param1]._bitmapRect.y;
        }// end function

        public function changeDirectionTo(param1:Number) : void
        {
            var _loc_2:* = undefined;
            if (this._ready && this._state != null && !this._destroyed)
            {
                if (this._direction != param1)
                {
                    this._direction = param1;
                    if (this._unitObj[this._state] != null && !this._locked)
                    {
                        if (this._oneDirecionObj[this._state])
                        {
                        }
                        else
                        {
                            if (this._directions == 4)
                            {
                                if (this._a4 == 0)
                                {
                                    if (this._direction < 2)
                                    {
                                        this._bitmap.scaleX = 1;
                                        this._bitmapArray = this._unitObj[this._state][this._direction];
                                        this._bitmapRectArray = this._unitRectObj[this._state][this._direction];
                                        for (_loc_2 in this._exLayerArray)
                                        {
                                            
                                            if (this._exLayerArray[_loc_2]._bitmap != null && this._exLayerArray[_loc_2]._unitObj[this._state] != null)
                                            {
                                                this._exLayerArray[_loc_2]._bitmap.scaleX = 1;
                                                this._exLayerArray[_loc_2]._bitmapArray = this._exLayerArray[_loc_2]._unitObj[this._state][this._direction];
                                                this._exLayerArray[_loc_2]._bitmapRectArray = this._exLayerArray[_loc_2]._unitRectObj[this._state][this._direction];
                                                continue;
                                            }
                                            this._exLayerArray[_loc_2]._bitmapArray = null;
                                            this._exLayerArray[_loc_2]._bitmapRectArray = null;
                                        }
                                    }
                                    else
                                    {
                                        this._bitmap.scaleX = -1;
                                        this._bitmapArray = this._unitObj[this._state][3 - this._direction];
                                        this._bitmapRectArray = this._unitRectObj[this._state][3 - this._direction];
                                        for (_loc_2 in this._exLayerArray)
                                        {
                                            
                                            if (this._exLayerArray[_loc_2]._bitmap != null && this._exLayerArray[_loc_2]._unitObj[this._state] != null)
                                            {
                                                this._exLayerArray[_loc_2]._bitmap.scaleX = -1;
                                                this._exLayerArray[_loc_2]._bitmapArray = this._exLayerArray[_loc_2]._unitObj[this._state][3 - this._direction];
                                                this._exLayerArray[_loc_2]._bitmapRectArray = this._exLayerArray[_loc_2]._unitRectObj[this._state][3 - this._direction];
                                                continue;
                                            }
                                            this._exLayerArray[_loc_2]._bitmapArray = null;
                                            this._exLayerArray[_loc_2]._bitmapRectArray = null;
                                        }
                                    }
                                }
                                else if (this._direction < 3)
                                {
                                    this._bitmap.scaleX = 1;
                                    this._bitmapArray = this._unitObj[this._state][this._direction];
                                    this._bitmapRectArray = this._unitRectObj[this._state][this._direction];
                                    for (_loc_2 in this._exLayerArray)
                                    {
                                        
                                        if (this._exLayerArray[_loc_2]._bitmap != null && this._exLayerArray[_loc_2]._unitObj[this._state] != null)
                                        {
                                            this._exLayerArray[_loc_2]._bitmap.scaleX = 1;
                                            this._exLayerArray[_loc_2]._bitmapArray = this._exLayerArray[_loc_2]._unitObj[this._state][this._direction];
                                            this._exLayerArray[_loc_2]._bitmapRectArray = this._exLayerArray[_loc_2]._unitRectObj[this._state][this._direction];
                                            continue;
                                        }
                                        this._exLayerArray[_loc_2]._bitmapArray = null;
                                        this._exLayerArray[_loc_2]._bitmapRectArray = null;
                                    }
                                }
                                else
                                {
                                    this._bitmap.scaleX = -1;
                                    this._bitmapArray = this._unitObj[this._state][1];
                                    this._bitmapRectArray = this._unitRectObj[this._state][1];
                                    for (_loc_2 in this._exLayerArray)
                                    {
                                        
                                        if (this._exLayerArray[_loc_2]._bitmap != null && this._exLayerArray[_loc_2]._unitObj[this._state] != null)
                                        {
                                            this._exLayerArray[_loc_2]._bitmap.scaleX = -1;
                                            this._exLayerArray[_loc_2]._bitmapArray = this._exLayerArray[_loc_2]._unitObj[this._state][1];
                                            this._exLayerArray[_loc_2]._bitmapRectArray = this._exLayerArray[_loc_2]._unitRectObj[this._state][1];
                                            continue;
                                        }
                                        this._exLayerArray[_loc_2]._bitmapArray = null;
                                        this._exLayerArray[_loc_2]._bitmapRectArray = null;
                                    }
                                }
                            }
                            else if (this._directions == 8)
                            {
                                if (this._direction < 5)
                                {
                                    this._bitmap.scaleX = 1;
                                    this._bitmapArray = this._unitObj[this._state][this._direction];
                                    this._bitmapRectArray = this._unitRectObj[this._state][this._direction];
                                    for (_loc_2 in this._exLayerArray)
                                    {
                                        
                                        if (this._exLayerArray[_loc_2]._bitmap != null && this._exLayerArray[_loc_2]._unitObj[this._state] != null)
                                        {
                                            this._exLayerArray[_loc_2]._bitmap.scaleX = 1;
                                            this._exLayerArray[_loc_2]._bitmapArray = this._exLayerArray[_loc_2]._unitObj[this._state][this._direction];
                                            this._exLayerArray[_loc_2]._bitmapRectArray = this._exLayerArray[_loc_2]._unitRectObj[this._state][this._direction];
                                            continue;
                                        }
                                        this._exLayerArray[_loc_2]._bitmapArray = null;
                                        this._exLayerArray[_loc_2]._bitmapRectArray = null;
                                    }
                                }
                                else
                                {
                                    this._bitmap.scaleX = -1;
                                    this._bitmapArray = this._unitObj[this._state][8 - this._direction];
                                    this._bitmapRectArray = this._unitRectObj[this._state][8 - this._direction];
                                    for (_loc_2 in this._exLayerArray)
                                    {
                                        
                                        if (this._exLayerArray[_loc_2]._bitmap != null && this._exLayerArray[_loc_2]._unitObj[this._state] != null)
                                        {
                                            this._exLayerArray[_loc_2]._bitmap.scaleX = -1;
                                            this._exLayerArray[_loc_2]._bitmapArray = this._exLayerArray[_loc_2]._unitObj[this._state][8 - this._direction];
                                            this._exLayerArray[_loc_2]._bitmapRectArray = this._exLayerArray[_loc_2]._unitRectObj[this._state][8 - this._direction];
                                            continue;
                                        }
                                        this._exLayerArray[_loc_2]._bitmapArray = null;
                                        this._exLayerArray[_loc_2]._bitmapRectArray = null;
                                    }
                                }
                            }
                            else if (this._directions == 16)
                            {
                                if (this._direction < 9)
                                {
                                    this._bitmap.scaleX = 1;
                                    this._bitmapArray = this._unitObj[this._state][this._direction];
                                    this._bitmapRectArray = this._unitRectObj[this._state][this._direction];
                                    for (_loc_2 in this._exLayerArray)
                                    {
                                        
                                        if (this._exLayerArray[_loc_2]._bitmap != null && this._exLayerArray[_loc_2]._unitObj[this._state] != null)
                                        {
                                            this._exLayerArray[_loc_2]._bitmap.scaleX = 1;
                                            this._exLayerArray[_loc_2]._bitmapArray = this._exLayerArray[_loc_2]._unitObj[this._state][this._direction];
                                            this._exLayerArray[_loc_2]._bitmapRectArray = this._exLayerArray[_loc_2]._unitRectObj[this._state][this._direction];
                                            continue;
                                        }
                                        this._exLayerArray[_loc_2]._bitmapArray = null;
                                        this._exLayerArray[_loc_2]._bitmapRectArray = null;
                                    }
                                }
                                else
                                {
                                    this._bitmap.scaleX = -1;
                                    this._bitmapArray = this._unitObj[this._state][16 - this._direction];
                                    this._bitmapRectArray = this._unitRectObj[this._state][16 - this._direction];
                                    for (_loc_2 in this._exLayerArray)
                                    {
                                        
                                        if (this._exLayerArray[_loc_2]._bitmap != null && this._exLayerArray[_loc_2]._unitObj[this._state] != null)
                                        {
                                            this._exLayerArray[_loc_2]._bitmap.scaleX = -1;
                                            this._exLayerArray[_loc_2]._bitmapArray = this._exLayerArray[_loc_2]._unitObj[this._state][16 - this._direction];
                                            this._exLayerArray[_loc_2]._bitmapRectArray = this._exLayerArray[_loc_2]._unitRectObj[this._state][16 - this._direction];
                                            continue;
                                        }
                                        this._exLayerArray[_loc_2]._bitmapArray = null;
                                        this._exLayerArray[_loc_2]._bitmapRectArray = null;
                                    }
                                }
                            }
                            this._currTotalFrame = this._bitmapArray.length;
                            this.playAnimation();
                            this.forceAnimation();
                            if (this._currTotalFrame > 1)
                            {
                                if (!this._freeze)
                                {
                                    this.startLoop(this.onEnterFrame);
                                }
                            }
                            else
                            {
                                this.stopLoop(this.onEnterFrame);
                            }
                        }
                        dispatchEvent(new Event("changeDirection"));
                    }
                }
            }
            else
            {
                this._direction = param1;
            }
            return;
        }// end function

        public function forceTo(param1, param2, param3)
        {
            var i:*;
            var action:* = param1;
            var direction:* = param2;
            var frame:* = param3;
            if (this._ready)
            {
                try
                {
                    if (this._oneDirecionObj[action])
                    {
                        return;
                    }
                    if (this._directions == 4)
                    {
                        if (this._a4 == 0)
                        {
                            if (direction < 2)
                            {
                                this._bitmap.scaleX = 1;
                                this._bitmapRect = this._unitRectObj[action][direction][frame];
                                this._bitmap.x = this.bitmapX + this._xoff;
                                this._bitmap.y = this.bitmapY - this._z;
                                this._bitmap.bitmapData = this._unitObj[action][direction][frame];
                                var _loc_5:* = 0;
                                var _loc_6:* = this._exLayerArray;
                                while (_loc_6 in _loc_5)
                                {
                                    
                                    i = _loc_6[_loc_5];
                                    if (this._exLayerArray[i]._bitmap != null)
                                    {
                                        if (this._exLayerArray[i]._unitObj[action] != null)
                                        {
                                            this._exLayerArray[i]._bitmap.scaleX = 1;
                                            this._exLayerArray[i]._bitmapRect = this._exLayerArray[i]._unitRectObj[action][direction][frame];
                                            this._exLayerArray[i]._bitmap.x = this.getLayerX(i) + this._xoff;
                                            this._exLayerArray[i]._bitmap.y = this.getLayerY(i) - this._z;
                                            this._exLayerArray[i]._bitmap.bitmapData = this._exLayerArray[i]._unitObj[action][direction][frame];
                                            continue;
                                        }
                                        this._exLayerArray[i]._bitmap.bitmapData = null;
                                    }
                                }
                            }
                            else
                            {
                                this._bitmap.scaleX = -1;
                                this._bitmapRect = this._unitRectObj[action][3 - direction][frame];
                                this._bitmap.x = this.bitmapX + this._xoff;
                                this._bitmap.y = this.bitmapY - this._z;
                                this._bitmap.bitmapData = this._unitObj[action][3 - direction][frame];
                                var _loc_5:* = 0;
                                var _loc_6:* = this._exLayerArray;
                                while (_loc_6 in _loc_5)
                                {
                                    
                                    i = _loc_6[_loc_5];
                                    if (this._exLayerArray[i]._bitmap != null)
                                    {
                                        if (this._exLayerArray[i]._unitObj[action] != null)
                                        {
                                            this._exLayerArray[i]._bitmap.scaleX = -1;
                                            this._exLayerArray[i]._bitmapRect = this._exLayerArray[i]._unitRectObj[action][3 - direction][frame];
                                            this._exLayerArray[i]._bitmap.x = this.getLayerX(i) + this._xoff;
                                            this._exLayerArray[i]._bitmap.y = this.getLayerY(i) - this._z;
                                            this._exLayerArray[i]._bitmap.bitmapData = this._exLayerArray[i]._unitObj[action][3 - direction][frame];
                                            continue;
                                        }
                                        this._exLayerArray[i]._bitmap.bitmapData = null;
                                    }
                                }
                            }
                        }
                        else if (direction < 3)
                        {
                            this._bitmap.scaleX = 1;
                            this._bitmapRect = this._unitRectObj[action][direction][frame];
                            this._bitmap.x = this.bitmapX + this._xoff;
                            this._bitmap.y = this.bitmapY - this._z;
                            this._bitmap.bitmapData = this._unitObj[action][direction][frame];
                            var _loc_5:* = 0;
                            var _loc_6:* = this._exLayerArray;
                            while (_loc_6 in _loc_5)
                            {
                                
                                i = _loc_6[_loc_5];
                                if (this._exLayerArray[i]._bitmap != null)
                                {
                                    if (this._exLayerArray[i]._unitObj[action] != null)
                                    {
                                        this._exLayerArray[i]._bitmap.scaleX = 1;
                                        this._exLayerArray[i]._bitmapRect = this._exLayerArray[i]._unitRectObj[action][direction][frame];
                                        this._exLayerArray[i]._bitmap.x = this.getLayerX(i) + this._xoff;
                                        this._exLayerArray[i]._bitmap.y = this.getLayerY(i) - this._z;
                                        this._exLayerArray[i]._bitmap.bitmapData = this._exLayerArray[i]._unitObj[action][direction][frame];
                                        continue;
                                    }
                                    this._exLayerArray[i]._bitmap.bitmapData = null;
                                }
                            }
                        }
                        else
                        {
                            this._bitmap.scaleX = -1;
                            this._bitmapRect = this._unitRectObj[action][1][frame];
                            this._bitmap.x = this.bitmapX + this._xoff;
                            this._bitmap.y = this.bitmapY - this._z;
                            this._bitmap.bitmapData = this._unitObj[action][1][frame];
                            var _loc_5:* = 0;
                            var _loc_6:* = this._exLayerArray;
                            while (_loc_6 in _loc_5)
                            {
                                
                                i = _loc_6[_loc_5];
                                if (this._exLayerArray[i]._bitmap != null)
                                {
                                    if (this._exLayerArray[i]._unitObj[action] != null)
                                    {
                                        this._exLayerArray[i]._bitmap.scaleX = -1;
                                        this._exLayerArray[i]._bitmapRect = this._exLayerArray[i]._unitRectObj[action][1][frame];
                                        this._exLayerArray[i]._bitmap.x = this.getLayerX(i) + this._xoff;
                                        this._exLayerArray[i]._bitmap.y = this.getLayerY(i) - this._z;
                                        this._exLayerArray[i]._bitmap.bitmapData = this._exLayerArray[i]._unitObj[action][1][frame];
                                        continue;
                                    }
                                    this._exLayerArray[i]._bitmap.bitmapData = null;
                                }
                            }
                        }
                    }
                    else if (this._directions == 8)
                    {
                        if (direction < 5)
                        {
                            this._bitmap.scaleX = 1;
                            this._bitmapRect = this._unitRectObj[action][direction][frame];
                            this._bitmap.x = this.bitmapX + this._xoff;
                            this._bitmap.y = this.bitmapY - this._z;
                            this._bitmap.bitmapData = this._unitObj[action][direction][frame];
                            var _loc_5:* = 0;
                            var _loc_6:* = this._exLayerArray;
                            while (_loc_6 in _loc_5)
                            {
                                
                                i = _loc_6[_loc_5];
                                if (this._exLayerArray[i]._bitmap != null)
                                {
                                    if (this._exLayerArray[i]._unitObj[action] != null)
                                    {
                                        this._exLayerArray[i]._bitmap.scaleX = 1;
                                        this._exLayerArray[i]._bitmapRect = this._exLayerArray[i]._unitRectObj[action][direction][frame];
                                        this._exLayerArray[i]._bitmap.x = this.getLayerX(i) + this._xoff;
                                        this._exLayerArray[i]._bitmap.y = this.getLayerY(i) - this._z;
                                        this._exLayerArray[i]._bitmap.bitmapData = this._exLayerArray[i]._unitObj[action][direction][frame];
                                        continue;
                                    }
                                    this._exLayerArray[i]._bitmap.bitmapData = null;
                                }
                            }
                        }
                        else
                        {
                            this._bitmap.scaleX = -1;
                            this._bitmapRect = this._unitRectObj[action][8 - direction][frame];
                            this._bitmap.x = this.bitmapX + this._xoff;
                            this._bitmap.y = this.bitmapY - this._z;
                            this._bitmap.bitmapData = this._unitObj[action][8 - direction][frame];
                            var _loc_5:* = 0;
                            var _loc_6:* = this._exLayerArray;
                            while (_loc_6 in _loc_5)
                            {
                                
                                i = _loc_6[_loc_5];
                                if (this._exLayerArray[i]._bitmap != null)
                                {
                                    if (this._exLayerArray[i]._unitObj[action] != null)
                                    {
                                        this._exLayerArray[i]._bitmap.scaleX = -1;
                                        this._exLayerArray[i]._bitmapRect = this._exLayerArray[i]._unitRectObj[action][8 - direction][frame];
                                        this._exLayerArray[i]._bitmap.x = this.getLayerX(i) + this._xoff;
                                        this._exLayerArray[i]._bitmap.y = this.getLayerY(i) - this._z;
                                        this._exLayerArray[i]._bitmap.bitmapData = this._exLayerArray[i]._unitObj[action][8 - direction][frame];
                                        continue;
                                    }
                                    this._exLayerArray[i]._bitmap.bitmapData = null;
                                }
                            }
                        }
                    }
                    else if (this._directions == 16)
                    {
                        if (direction < 9)
                        {
                            this._bitmap.scaleX = 1;
                            this._bitmapRect = this._unitRectObj[action][direction][frame];
                            this._bitmap.x = this.bitmapX + this._xoff;
                            this._bitmap.y = this.bitmapY - this._z;
                            this._bitmap.bitmapData = this._unitObj[action][direction][frame];
                            var _loc_5:* = 0;
                            var _loc_6:* = this._exLayerArray;
                            while (_loc_6 in _loc_5)
                            {
                                
                                i = _loc_6[_loc_5];
                                if (this._exLayerArray[i]._bitmap != null)
                                {
                                    if (this._exLayerArray[i]._unitObj[action] != null)
                                    {
                                        this._exLayerArray[i]._bitmap.scaleX = 1;
                                        this._exLayerArray[i]._bitmapRect = this._exLayerArray[i]._unitRectObj[action][direction][frame];
                                        this._exLayerArray[i]._bitmap.x = this.getLayerX(i) + this._xoff;
                                        this._exLayerArray[i]._bitmap.y = this.getLayerY(i) - this._z;
                                        this._exLayerArray[i]._bitmap.bitmapData = this._exLayerArray[i]._unitObj[action][direction][frame];
                                        continue;
                                    }
                                    this._exLayerArray[i]._bitmap.bitmapData = null;
                                }
                            }
                        }
                        else
                        {
                            this._bitmap.scaleX = -1;
                            this._bitmapRect = this._unitRectObj[action][16 - direction][frame];
                            this._bitmap.x = this.bitmapX + this._xoff;
                            this._bitmap.y = this.bitmapY - this._z;
                            this._bitmap.bitmapData = this._unitObj[action][16 - direction][frame];
                            var _loc_5:* = 0;
                            var _loc_6:* = this._exLayerArray;
                            while (_loc_6 in _loc_5)
                            {
                                
                                i = _loc_6[_loc_5];
                                if (this._exLayerArray[i]._bitmap != null)
                                {
                                    if (this._exLayerArray[i]._unitObj[action] != null)
                                    {
                                        this._exLayerArray[i]._bitmap.scaleX = -1;
                                        this._exLayerArray[i]._bitmapRect = this._exLayerArray[i]._unitRectObj[action][16 - direction][frame];
                                        this._exLayerArray[i]._bitmap.x = this.getLayerX(i) + this._xoff;
                                        this._exLayerArray[i]._bitmap.y = this.getLayerY(i) - this._z;
                                        this._exLayerArray[i]._bitmap.bitmapData = this._exLayerArray[i]._unitObj[action][16 - direction][frame];
                                        continue;
                                    }
                                    this._exLayerArray[i]._bitmap.bitmapData = null;
                                }
                            }
                        }
                    }
                }
                catch (e)
                {
                }
            }
            return;
        }// end function

        public function set data(param1:Object) : void
        {
            this._dynamicData = param1;
            return;
        }// end function

        public function get data() : Object
        {
            return this._dynamicData;
        }// end function

        public function directTo(param1)
        {
            this.changeDirectionTo(angleToDirection(param1, this._directions, this._a4));
            return;
        }// end function

        public static function set shadow(param1:Boolean)
        {
            var _loc_2:* = undefined;
            _shadowOn = param1;
            var _loc_3:* = Unit.unitArray;
            if (_shadowOn)
            {
                for (_loc_2 in _loc_3)
                {
                    
                    if (_loc_3[_loc_2]._img != null)
                    {
                        _loc_3[_loc_2]._img.addShadow();
                    }
                }
            }
            else
            {
                for (_loc_2 in _loc_3)
                {
                    
                    if (_loc_3[_loc_2]._img != null)
                    {
                        _loc_3[_loc_2]._img.removeShadow();
                    }
                }
            }
            return;
        }// end function

        public static function get shadow()
        {
            return _shadowOn;
        }// end function

        public static function initLayerStack(param1, param2)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            var _loc_9:* = undefined;
            var _loc_10:* = undefined;
            _layerStackBuff[param1] = {};
            for (_loc_3 in param2)
            {
                
                _loc_9 = param2[_loc_3];
                _loc_6 = _loc_9.split("|");
                _loc_10 = [];
                _loc_4 = 0;
                while (_loc_4 < _loc_6.length)
                {
                    
                    _loc_10[_loc_4] = [];
                    _loc_7 = _loc_6[_loc_4].split(";");
                    _loc_5 = 0;
                    while (_loc_5 < _loc_7.length)
                    {
                        
                        _loc_10[_loc_4][_loc_5] = _loc_7[_loc_5].split(",");
                        _loc_5 = _loc_5 + 1;
                    }
                    _loc_4 = _loc_4 + 1;
                }
                _layerStackBuff[param1][_loc_3] = _loc_10;
            }
            return;
        }// end function

        public static function newUnitClip(param1 = null, param2:Boolean = false, param3 = 0, param4 = 1, param5 = null)
        {
            var _loc_6:* = null;
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            var _loc_9:* = undefined;
            var _loc_10:* = undefined;
            var _loc_11:* = undefined;
            if (_objectPool.length == 0)
            {
                return new UnitClip(param1, param2, param3, param4, param5);
            }
            _loc_6 = _objectPool.shift();
            _loc_6._poolPushed = false;
            if (param1 == null)
            {
                return _loc_6;
            }
            _loc_6._freeze = false;
            _loc_6.layerStack = param5;
            _loc_6._multiLayer = param2;
            _loc_6.visible = true;
            _loc_6._shadow = true;
            _loc_6._shadowSize = 0;
            _loc_6._shadowAlpha = 0.8;
            _loc_6._shadowScale = 1;
            _loc_6._bitmapRectW = 0;
            _loc_6._data = param1;
            _loc_6._id = Number(param1.id);
            _loc_6._ready = false;
            _loc_6._destroyed = false;
            _loc_6._overDo = null;
            _loc_6._state = null;
            _loc_6._hue = param3;
            if (_loc_6._data.hue != null)
            {
                _loc_6._hue = _loc_6._data.hue;
            }
            _loc_6._alpha = param4;
            _loc_6._yOff = parseInt(_loc_6._data.yOffset);
            _loc_6._frameSkip = _loc_6._data.frameSkip;
            _loc_6._action = _loc_6._data.action;
            _loc_6._directions = parseInt(_loc_6._data.direction);
            _loc_6._width = parseInt(_loc_6._data.width);
            _loc_6._height = parseInt(_loc_6._data.height);
            _loc_6._loopFrame = parseInt(_loc_6._data.loopFrame);
            _loc_6._a4 = Number(_loc_6._data.a4);
            if (_buff[_loc_6._id] == null)
            {
                if (_loc_6._progressTxt == null)
                {
                    _loc_6._progressTxt = Config.getSimpleTextField();
                }
                _loc_6.addChild(_loc_6._progressTxt);
                _loc_7 = Buffer.findPicInXML(_loc_6._data);
                if (_loc_6._loader != null)
                {
                    _loc_6._loader.removeEventListener(ProgressEvent.PROGRESS, _loc_6.handleLoadProgress);
                    _loc_6._loader.removeEventListener(Event.COMPLETE, _loc_6.handleLoadComplete);
                }
                _loc_6._loader = new FileLoader();
                _loc_6._loader.addEventListener(ProgressEvent.PROGRESS, _loc_6.handleLoadProgress);
                _loc_6._loader.addEventListener(Event.COMPLETE, _loc_6.handleLoadComplete);
                _loc_6._loader.load([_modelURL + _loc_6._id + ".mod"]);
            }
            else
            {
                _loc_8 = _buff[_loc_6._id];
                _loc_6._yOff = _loc_8._yOff;
                _loc_6._frameSkip = _loc_8._frameSkip;
                _loc_6._directions = _loc_8._directions;
                _loc_6._loopFrame = _loc_8._loopFrame;
                _loc_6._a4 = _loc_8._a4;
                _loc_6._soundObj = _loc_8._soundObj;
                _loc_6._soundDelayObj = _loc_8._soundDelayObj;
                _loc_6._oneDirecionObj = _loc_8._oneDirecionObj;
                _loc_6._bitmapRectY = _loc_8._bitmapRectY;
                _loc_6._bitmapRectW = _loc_8._bitmapRectW;
                _loc_6._unitObj = {};
                _loc_6._unitRectObj = {};
                for (_loc_9 in _loc_8._unitObj)
                {
                    
                    _loc_6._unitObj[_loc_9] = [];
                    _loc_6._unitRectObj[_loc_9] = [];
                    for (_loc_10 in _loc_8._unitObj[_loc_9])
                    {
                        
                        _loc_6._unitObj[_loc_9][_loc_10] = [];
                        _loc_6._unitRectObj[_loc_9][_loc_10] = [];
                        for (_loc_11 in _loc_8._unitObj[_loc_9][_loc_10])
                        {
                            
                            _loc_6._unitObj[_loc_9][_loc_10][_loc_11] = _loc_8._unitObj[_loc_9][_loc_10][_loc_11];
                            _loc_6._unitRectObj[_loc_9][_loc_10][_loc_11] = _loc_8._unitRectObj[_loc_9][_loc_10][_loc_11];
                        }
                    }
                }
                _loc_6.init();
            }
            return _loc_6;
        }// end function

        public static function clearBuff()
        {
            var _loc_1:* = undefined;
            trace("unitclip.clearBuff");
            subDispose(_buff);
            _buff = {};
            Config.stopLoop(initStackLoop);
            _initStack = [];
            return;
        }// end function

        public static function subDispose(param1)
        {
            var _loc_2:* = undefined;
            if (param1 is BitmapData)
            {
                param1.dispose();
            }
            else if (param1 is Array)
            {
                _loc_2 = 0;
                while (_loc_2 < param1.length)
                {
                    
                    subDispose(param1[_loc_2]);
                    _loc_2 = _loc_2 + 1;
                }
            }
            else if (param1 is Object)
            {
                for (_loc_2 in param1)
                {
                    
                    subDispose(param1[_loc_2]);
                }
            }
            return;
        }// end function

        private static function initStackLoop(param1)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = _initStackMax;
            _initCount = 0;
            while (_initStack.length > 0 && _loc_3 > 0)
            {
                
                _loc_2 = _initStack.shift();
                if (_loc_2.layer == -1)
                {
                    _loc_2.obj.init(true);
                }
                else
                {
                    _loc_2.obj.initWeapon(_loc_2.layer, true);
                }
                _loc_3 = _loc_3 - 1;
            }
            if (_initStack.length <= 0)
            {
                Config.stopLoop(initStackLoop);
            }
            return;
        }// end function

        public static function angleToDirection(param1, param2, param3)
        {
            var _loc_4:* = param1;
            if (param1 > Math.PI || _loc_4 <= -Math.PI)
            {
                _loc_4 = (_loc_4 + Math.PI) % (Math.PI * 2) - Math.PI;
            }
            if (param2 == 16)
            {
                if (_loc_4 > (-Math.PI) / 16 && _loc_4 <= Math.PI / 16)
                {
                    return 14;
                }
                if (_loc_4 > Math.PI / 16 && _loc_4 <= Math.PI * 3 / 16)
                {
                    return 15;
                }
                if (_loc_4 > Math.PI * 3 / 16 && _loc_4 <= Math.PI * 5 / 16)
                {
                    return 0;
                }
                if (_loc_4 > Math.PI * 5 / 16 && _loc_4 <= Math.PI * 7 / 16)
                {
                    return 1;
                }
                if (_loc_4 > Math.PI * 7 / 16 && _loc_4 <= Math.PI * 9 / 16)
                {
                    return 2;
                }
                if (_loc_4 > Math.PI * 9 / 16 && _loc_4 <= Math.PI * 11 / 16)
                {
                    return 3;
                }
                if (_loc_4 > Math.PI * 11 / 16 && _loc_4 <= Math.PI * 13 / 16)
                {
                    return 4;
                }
                if (_loc_4 > Math.PI * 13 / 16 && _loc_4 <= Math.PI * 15 / 16)
                {
                    return 5;
                }
                if (_loc_4 > Math.PI * 15 / 16 && _loc_4 <= Math.PI * 16 / 16)
                {
                    return 6;
                }
                if (_loc_4 > (-Math.PI) * 16 / 16 && _loc_4 <= (-Math.PI) * 15 / 16)
                {
                    return 6;
                }
                if (_loc_4 > (-Math.PI) * 15 / 16 && _loc_4 <= (-Math.PI) * 13 / 16)
                {
                    return 7;
                }
                if (_loc_4 > (-Math.PI) * 13 / 16 && _loc_4 <= (-Math.PI) * 11 / 16)
                {
                    return 8;
                }
                if (_loc_4 > (-Math.PI) * 11 / 16 && _loc_4 <= (-Math.PI) * 9 / 16)
                {
                    return 9;
                }
                if (_loc_4 > (-Math.PI) * 9 / 16 && _loc_4 <= (-Math.PI) * 7 / 16)
                {
                    return 10;
                }
                if (_loc_4 > (-Math.PI) * 7 / 16 && _loc_4 <= (-Math.PI) * 5 / 16)
                {
                    return 11;
                }
                if (_loc_4 > (-Math.PI) * 5 / 16 && _loc_4 <= (-Math.PI) * 3 / 16)
                {
                    return 12;
                }
                if (_loc_4 > (-Math.PI) * 3 / 16 && _loc_4 <= (-Math.PI) * 1 / 16)
                {
                    return 13;
                }
            }
            else if (param2 == 8)
            {
                if (_loc_4 > (-Math.PI) / 8 && _loc_4 <= Math.PI / 8)
                {
                    return 7;
                }
                if (_loc_4 > Math.PI / 8 && _loc_4 <= Math.PI * 3 / 8)
                {
                    return 0;
                }
                if (_loc_4 > Math.PI * 3 / 8 && _loc_4 <= Math.PI * 5 / 8)
                {
                    return 1;
                }
                if (_loc_4 > Math.PI * 5 / 8 && _loc_4 <= Math.PI * 7 / 8)
                {
                    return 2;
                }
                if (_loc_4 > Math.PI * 7 / 8 && _loc_4 <= Math.PI * 8 / 8)
                {
                    return 3;
                }
                if (_loc_4 > (-Math.PI) * 8 / 8 && _loc_4 <= (-Math.PI) * 7 / 8)
                {
                    return 3;
                }
                if (_loc_4 > (-Math.PI) * 7 / 8 && _loc_4 <= (-Math.PI) * 5 / 8)
                {
                    return 4;
                }
                if (_loc_4 > (-Math.PI) * 5 / 8 && _loc_4 <= (-Math.PI) * 3 / 8)
                {
                    return 5;
                }
                if (_loc_4 > (-Math.PI) * 3 / 8 && _loc_4 <= (-Math.PI) / 8)
                {
                    return 6;
                }
            }
            else if (param2 == 4)
            {
                if (param3 == 0)
                {
                    if (_loc_4 > Math.PI / 4 && _loc_4 <= Math.PI / 4 * 3)
                    {
                        return 0;
                    }
                    if (_loc_4 > Math.PI / 4 * 3 && _loc_4 <= Math.PI)
                    {
                        return 1;
                    }
                    if (_loc_4 > -Math.PI && _loc_4 <= (-Math.PI) / 4 * 3)
                    {
                        return 1;
                    }
                    if (_loc_4 > (-Math.PI) / 4 * 3 && _loc_4 <= (-Math.PI) / 4)
                    {
                        return 2;
                    }
                    if (_loc_4 > (-Math.PI) / 4 && _loc_4 <= Math.PI / 4)
                    {
                        return 3;
                    }
                }
                else
                {
                    if (_loc_4 > -Math.PI && _loc_4 <= (-Math.PI) / 2)
                    {
                        return 2;
                    }
                    if (_loc_4 > (-Math.PI) / 2 && _loc_4 <= 0)
                    {
                        return 3;
                    }
                    if (_loc_4 > 0 && _loc_4 <= Math.PI / 2)
                    {
                        return 0;
                    }
                    if (_loc_4 > Math.PI / 2 && _loc_4 <= Math.PI)
                    {
                        return 1;
                    }
                }
            }
            return;
        }// end function

    }
}
