package lovefox.isometric
{
    import flash.display.*;
    import flash.geom.*;
    import flash.ui.*;
    import lovefox.astar.*;
    import lovefox.buffer.*;

    public class Map extends Sprite
    {
        public var _fastStep1:Object = 300;
        public var _fastStep2:Object = 50;
        public var _slowStep:Object = 1;
        public var _fastStep:Object = 0;
        public var _initStep:Object = 0;
        public var _exBorder:Object = 7;
        public var _earthBorder:Object = 0;
        public var _mapWidth:uint = 800;
        public var _mapHeight:uint = 400;
        public var _stage:Stage;
        public var _zoom:uint = 100;
        public var _rootMap:Sprite;
        public var _textMap:Sprite;
        public var _footMap:Sprite;
        public var _mode:int = 0;
        public var _bmpdW:int = 0;
        public var _bmpdH:int = 0;
        public var _mode1Size:int = 96;
        public var _tileLayerContainer:Sprite;
        public var _obstacleLayerContainer:Sprite;
        public var _tileLayerMatrix:Array;
        public var _obstacleLayerMatrix:Array;
        public var _tileBmpdMatrix:Array;
        public var _obstacleBmpdMatrix:Array;
        public var _tileLayer:Bitmap;
        public var _obstacleLayer:Bitmap;
        public var _tileBmpd:BitmapData;
        public var _obstacleBmpd:BitmapData;
        public var _bmpdRatio:Object;
        public var _haloShade:Sprite;
        public var _shadeLayer:Shape;
        public var _haloLayer:Sprite;
        public var _visibility:int = -1;
        public var _iso:Isometric;
        private var _focusObj:Object;
        private var _lock:Boolean = false;
        private var _removeBuff:Array;
        public var _startPoint:Object;
        public var _roomMin:int;
        public var _roomMax:int;
        public var _xml:String = "";
        public var _type:uint;
        public var _maxPlayer:uint;
        public var _dieMap:uint;
        public var _dieX:uint;
        public var _dieY:uint;
        public var _halo:uint = 0;
        public var _under:uint;
        public var _music:String;
        private var _enterframeListenerArray:Array;
        public var _x:uint = 0;
        public var _y:uint = 0;
        public var _width:uint;
        public var _height:uint;
        public var _logicalWidth:Object;
        public var _logicalHeight:Object;
        public var _tile:Array;
        public var _logicalTile:Array;
        private var _tileArray:Array;
        public var _id:int = -1;
        public var _name:String;
        public var _state:String = "unready";
        public var _data:Object;
        public var _mc:Sprite;
        public var _mask:Shape;
        private var _preloadTotal:int;
        private var _preloadLoaded:int;
        public var _emptyTileBmp:BitmapData;
        public var _forceEmptyTileBmp:BitmapData;
        public var _noMusic:Boolean = false;
        private var _clockInterval:Number;
        private var _haloSwitch:Boolean = false;
        private var _loader:BitmapLoader;
        private var _loadArr:Array;
        public var _astar:Astar;
        public static var _ptPerTile:uint = 48;
        public static var _exBorder:Object = 7;

        public function Map(param1 = null)
        {
            this._enterframeListenerArray = [];
            this._data = param1;
            return;
        }// end function

        public function get mapName()
        {
            if (this._data != null)
            {
                return String(this._data.name);
            }
            return "";
        }// end function

        public function set noMusic(param1)
        {
            this._noMusic = param1;
            return;
        }// end function

        public function get noMusic()
        {
            return this._noMusic;
        }// end function

        public function set forceEmptyTileBmp(param1)
        {
            this._forceEmptyTileBmp = param1;
            return;
        }// end function

        public function get forceEmptyTileBmp()
        {
            return this._forceEmptyTileBmp;
        }// end function

        override public function set width(param1:Number) : void
        {
            this._mapWidth = param1;
            this.draw();
            dispatchEvent(new Event("resize"));
            return;
        }// end function

        override public function get width() : Number
        {
            return this._mapWidth;
        }// end function

        override public function set height(param1:Number) : void
        {
            this._mapHeight = param1;
            this.draw();
            dispatchEvent(new Event("resize"));
            return;
        }// end function

        override public function get height() : Number
        {
            return this._mapHeight;
        }// end function

        public function setSize(param1, param2)
        {
            this._mapWidth = param1;
            this._mapHeight = param2;
            this.draw();
            dispatchEvent(new Event("resize"));
            return;
        }// end function

        private function draw()
        {
            if (this._iso != null)
            {
                this._mask.y = 0;
                this._mask.graphics.clear();
                this._mask.graphics.beginFill(0);
                this._mask.graphics.lineStyle(0, 0);
                this._mask.graphics.drawRect(0, 0, this._mapWidth, this._mapHeight);
                this._mask.graphics.endFill();
                this._iso.setSize(this._mapWidth * 100 / this._zoom, this._mapHeight * 100 / this._zoom);
                this.refresh();
            }
            dispatchEvent(new Event("resize"));
            return;
        }// end function

        public function get halo()
        {
            return this._haloSwitch;
        }// end function

        public function set halo(param1)
        {
            if (param1 == true)
            {
                this._haloSwitch = true;
            }
            else
            {
                this._haloSwitch = false;
            }
            if (this._haloShade == null)
            {
                return;
            }
            if (param1 == true)
            {
                this._haloShade.addChild(this._shadeLayer);
                this._haloShade.addChild(this._haloLayer);
                this._mc.addChild(this._haloShade);
                this._mc.addChild(this._textMap);
            }
            else
            {
                if (this._shadeLayer.parent == this._haloShade)
                {
                    this._haloShade.removeChild(this._shadeLayer);
                }
                if (this._haloLayer.parent == this._haloShade)
                {
                    this._haloShade.removeChild(this._haloLayer);
                }
                if (this._haloShade.parent == this._mc)
                {
                    this._mc.removeChild(this._haloShade);
                }
            }
            return;
        }// end function

        public function set id(param1)
        {
            this._id = param1;
            return;
        }// end function

        public function get id()
        {
            return this._id;
        }// end function

        public function clear()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            var _loc_3:* = null;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            this.clearEnterframeLoop();
            clearInterval(this._clockInterval);
            this._iso.clear();
            this._state = "unready";
            if (this._data == null)
            {
                return;
            }
            if (this._emptyTileBmp != null)
            {
                this._emptyTileBmp.dispose();
            }
            this._tileArray = null;
            if (this._tile != null)
            {
                _loc_1 = 0;
                while (_loc_1 < this._width)
                {
                    
                    _loc_2 = 0;
                    while (_loc_2 < this._height)
                    {
                        
                        if (this._tile[_loc_1] != null && this._tile[_loc_1][_loc_2] != null)
                        {
                            this._tile[_loc_1][_loc_2].destroy();
                        }
                        _loc_2 = _loc_2 + 1;
                    }
                    _loc_1 = _loc_1 + 1;
                }
            }
            if (this._logicalTile != null)
            {
                _loc_1 = 0;
                while (_loc_1 < this._logicalTile.length)
                {
                    
                    _loc_2 = 0;
                    while (_loc_2 < this._logicalTile[_loc_1].length)
                    {
                        
                        if (this._logicalTile[_loc_1] != null && this._logicalTile[_loc_1][_loc_2] != null)
                        {
                            this._logicalTile[_loc_1][_loc_2].destroy();
                        }
                        _loc_2 = _loc_2 + 1;
                    }
                    _loc_1 = _loc_1 + 1;
                }
            }
            dispatchEvent(new Event("destroy"));
            this._type = Number(this._data.type);
            this._name = String(this._data.name);
            this._maxPlayer = Number(this._data.maxPlayer);
            this._dieMap = Number(this._data.dieMap);
            this._dieX = Number(this._data.dieX);
            this._dieY = Number(this._data.dieY);
            this._halo = Number(this._data.halo);
            this._under = Number(this._data.under);
            this._music = String(this._data.music);
            if (this._halo == 0)
            {
                this.checkClock();
                clearInterval(this._clockInterval);
                this._clockInterval = setInterval(this.checkClock, 6000);
            }
            this._iso.halo = this._halo;
            if (this._loader != null)
            {
                this._loader.removeEventListener("progress", this.handlePreLoadProgress);
                this._loader.removeEventListener("complete", this.handlePreLoadComplete);
                this._loader = null;
            }
            this._state = "unready";
            this._width = Number(this._data.width) + this._exBorder + this._earthBorder;
            this._height = Number(this._data.height) + this._exBorder + this._earthBorder;
            this._logicalWidth = Number(this._data.width) * 2;
            this._logicalHeight = Number(this._data.height) * 2;
            this.preload();
            return;
        }// end function

        public function destroy()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            var _loc_3:* = null;
            this.clearEnterframeLoop();
            clearInterval(this._clockInterval);
            if (this._data == null)
            {
                return;
            }
            if (this._iso != null)
            {
                this._iso.destroy();
                this._iso = null;
            }
            if (this._emptyTileBmp != null)
            {
                this._emptyTileBmp.dispose();
            }
            _loc_1 = 0;
            while (_loc_1 < this._width)
            {
                
                _loc_2 = 0;
                while (_loc_2 < this._height)
                {
                    
                    this._tile[_loc_1][_loc_2].destroy();
                    _loc_2 = _loc_2 + 1;
                }
                _loc_1 = _loc_1 + 1;
            }
            this._tileArray = null;
            _loc_1 = 0;
            while (_loc_1 < this._logicalTile.length)
            {
                
                _loc_2 = 0;
                while (_loc_2 < this._logicalTile[_loc_1].length)
                {
                    
                    this._logicalTile[_loc_1][_loc_2].destroy();
                    _loc_2 = _loc_2 + 1;
                }
                _loc_1 = _loc_1 + 1;
            }
            this._tileLayer.bitmapData.dispose();
            this._obstacleLayer.bitmapData.dispose();
            removeChild(this._mc);
            this._mc = null;
            removeChild(this._mask);
            this._mask = null;
            while (this.numChildren > 0)
            {
                
                this.removeChildAt((this.numChildren - 1));
            }
            if (this._loader != null)
            {
                this._loader.removeEventListener("progress", this.handlePreLoadProgress);
                this._loader.removeEventListener("complete", this.handlePreLoadComplete);
                this._loader = null;
            }
            this._state = "unready";
            Config.gc();
            dispatchEvent(new Event("destroy"));
            return;
        }// end function

        public function breakLoading()
        {
            if (this._loader != null)
            {
                this._loader.removeEventListener("progress", this.handlePreLoadProgress);
                this._loader.removeEventListener("complete", this.handlePreLoadComplete);
                this._loader = null;
            }
            return;
        }// end function

        private function checkClock()
        {
            var _loc_2:* = undefined;
            var _loc_1:* = Config.minute;
            if (_loc_1 < 60)
            {
                _loc_2 = Math.floor(Math.ceil(60 - _loc_1) / 6 * 20);
            }
            else if (_loc_1 > 180)
            {
                _loc_2 = Math.floor(Math.ceil(_loc_1 - 180) / 6 * 20);
            }
            else
            {
                _loc_2 = 0;
            }
            if (_loc_2 != this._halo)
            {
                this._halo = _loc_2;
                if (this._iso != null)
                {
                    this._iso.halo = this._halo;
                }
            }
            return;
        }// end function

        public function init()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            this._type = Number(this._data.type);
            this._name = String(this._data.name);
            this._maxPlayer = Number(this._data.maxPlayer);
            this._dieMap = Number(this._data.dieMap);
            this._dieX = Number(this._data.dieX);
            this._dieY = Number(this._data.dieY);
            this._halo = Number(this._data.halo);
            this._under = Number(this._data.under);
            this._music = String(this._data.music);
            if (this._halo == 0)
            {
                this.checkClock();
                clearInterval(this._clockInterval);
                this._clockInterval = setInterval(this.checkClock, 60000);
            }
            this._mask = new Shape();
            this._mask.graphics.beginFill(0);
            this._mask.graphics.lineStyle(0, 0);
            this._mask.graphics.drawRect(0, 0, this._mapWidth, this._mapHeight);
            this._mask.graphics.endFill();
            this._mc = new Sprite();
            addChild(this._mc);
            addChild(this._mask);
            this._mc.mask = this._mask;
            this._state = "unready";
            this._width = Number(this._data.width) + this._exBorder + this._earthBorder;
            this._height = Number(this._data.height) + this._exBorder + this._earthBorder;
            this._logicalWidth = Number(this._data.width) * 2;
            this._logicalHeight = Number(this._data.height) * 2;
            this._iso = new Isometric(this);
            this._astar = new Astar();
            this.preload();
            return;
        }// end function

        private function preload()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = [];
            if (this._data.tileTable != null)
            {
                _loc_2 = this._data.tileTable.split(",");
                _loc_1 = 0;
                while (_loc_1 < _loc_2.length)
                {
                    
                    if (Config._tileModel[Number(_loc_2[_loc_1])] != null)
                    {
                        _loc_4 = _loc_4.concat(findPic(Config._tileModel[Number(_loc_2[_loc_1])]));
                    }
                    _loc_1 = _loc_1 + 1;
                }
            }
            if (this._data.obstacleTable != null)
            {
                _loc_2 = this._data.obstacleTable.split(",");
                _loc_1 = 0;
                while (_loc_1 < _loc_2.length)
                {
                    
                    if (Config._obstacleModel[Number(_loc_2[_loc_1])] != null)
                    {
                        _loc_4 = _loc_4.concat(findPic(Config._obstacleModel[Number(_loc_2[_loc_1])]));
                    }
                    _loc_1 = _loc_1 + 1;
                }
            }
            this._preloadLoaded = 0;
            this._preloadTotal = _loc_4.length;
            this._loadArr = _loc_4;
            if (this._preloadTotal > 0)
            {
                if (this._loader == null)
                {
                    this._loader = BitmapLoader.newBitmapLoader();
                }
                this._loader.removeEventListener("progress", this.handlePreLoadProgress);
                this._loader.removeEventListener("complete", this.handlePreLoadComplete);
                this._loader.addEventListener("progress", this.handlePreLoadProgress);
                this._loader.addEventListener("complete", this.handlePreLoadComplete);
                this._loader.load(_loc_4);
            }
            else
            {
                this.handlePreLoadComplete();
            }
            this.halo = this.halo;
            return;
        }// end function

        private function handlePreLoadProgress(param1) : void
        {
            var _loc_2:* = this;
            var _loc_3:* = this._preloadLoaded + 1;
            _loc_2._preloadLoaded = _loc_3;
            dispatchEvent(new ProgressEvent("progress", false, false, this._preloadLoaded, this._preloadTotal));
            return;
        }// end function

        private function handlePreLoadComplete(param1 = null) : void
        {
            if (this._loader != null)
            {
                this._loader.removeEventListener("progress", this.handlePreLoadProgress);
                this._loader.removeEventListener("complete", this.handlePreLoadComplete);
                this._loader = null;
            }
            this.display();
            return;
        }// end function

        public function setMode(param1)
        {
            this._mode = param1;
            this._iso.setMode(this._mode);
            if (this._mode == 0)
            {
            }
            return;
        }// end function

        public function display()
        {
            var i:*;
            var j:*;
            var k:*;
            var l:*;
            var m:*;
            var n:*;
            var tempArr:*;
            var tempArr1:*;
            var cstr:*;
            var temp:*;
            var loop:*;
            var tile:*;
            var arr:*;
            var tempBmpd:BitmapData;
            var bmpd:BitmapData;
            var xDraw:*;
            var yDraw:*;
            var tempTileId:*;
            var tempTile:*;
            var blockWidth:*;
            var blockHeight:*;
            var blockArr:*;
            var lowerTile:*;
            var higherTile:*;
            var temp1:*;
            var temp2:*;
            var temp3:*;
            var temp4:*;
            var temp5:*;
            var temp6:*;
            var temp7:*;
            var temp8:*;
            var temp9:*;
            var temp10:*;
            var temp11:*;
            var temp12:*;
            var temp13:*;
            var temp14:*;
            var temp15:*;
            var temp16:*;
            var temp17:*;
            var temp18:*;
            var temp19:*;
            var temp20:*;
            var tempRemove:*;
            var tempPoint:*;
            var tempPoint1:*;
            var x:*;
            var y:*;
            var cutFlag:*;
            var tempBmp:*;
            var bmp:*;
            var bmp1:*;
            var tempTileDraw:*;
            if (this._tileBmpd != null)
            {
                this._tileBmpd.dispose();
                this._tileBmpd = null;
            }
            if (this._obstacleBmpd != null)
            {
                this._obstacleBmpd.dispose();
                this._obstacleBmpd = null;
            }
            if (this._emptyTileBmp != null)
            {
                this._emptyTileBmp.dispose();
                this._emptyTileBmp = null;
            }
            if (this._tileBmpdMatrix != null)
            {
                i;
                while (i < Math.ceil(this._bmpdW / this._mode1Size))
                {
                    
                    j;
                    while (j < Math.ceil(this._bmpdH / this._mode1Size))
                    {
                        
                        if (this._tileBmpdMatrix[i][j] != null)
                        {
                            this._tileBmpdMatrix[i][j].dispose();
                            if (this._tileLayerMatrix[i][j].parent != null)
                            {
                                this._tileLayerMatrix[i][j].parent.removeChild(this._tileLayerMatrix[i][j]);
                            }
                            delete this._tileBmpdMatrix[i][j];
                            delete this._tileLayerMatrix[i][j];
                        }
                        if (this._obstacleBmpdMatrix[i][j] != null)
                        {
                            this._obstacleBmpdMatrix[i][j].dispose();
                            if (this._obstacleLayerMatrix[i][j].parent != null)
                            {
                                this._obstacleLayerMatrix[i][j].parent.removeChild(this._obstacleLayerMatrix[i][j]);
                            }
                            delete this._obstacleBmpdMatrix[i][j];
                            delete this._obstacleLayerMatrix[i][j];
                        }
                        j = (j + 1);
                    }
                    i = (i + 1);
                }
                Config.clearDisplayList(this._tileLayerContainer);
                Config.clearDisplayList(this._obstacleLayerContainer);
                this._tileBmpdMatrix = null;
                this._obstacleBmpdMatrix = null;
            }
            var xml:* = this._data;
            this._bmpdW = _ptPerTile * (this._width + this._height);
            this._bmpdH = _ptPerTile * (this._width + this._height) / 2;
            if (this._mode == 0)
            {
                try
                {
                    this._tileBmpd = new BitmapData(_ptPerTile * (this._width + this._height), _ptPerTile / 2 * (this._width + this._height), true, 0);
                }
                catch (e)
                {
                    setMode(1);
                }
                if (this._mode == 0)
                {
                    try
                    {
                        this._obstacleBmpd = this._tileBmpd.clone();
                        this._tileLayer.bitmapData = this._tileBmpd;
                        this._obstacleLayer.bitmapData = this._obstacleBmpd;
                    }
                    catch (e)
                    {
                        setMode(1);
                    }
                }
            }
            if (this._mode == 1)
            {
                this._tileBmpdMatrix = [];
                this._obstacleBmpdMatrix = [];
                this._tileLayerMatrix = [];
                this._obstacleLayerMatrix = [];
                i;
                while (i < Math.ceil(this._bmpdW / this._mode1Size))
                {
                    
                    this._tileLayerMatrix[i] = [];
                    this._obstacleLayerMatrix[i] = [];
                    this._tileBmpdMatrix[i] = [];
                    this._obstacleBmpdMatrix[i] = [];
                    j;
                    while (j < Math.ceil(this._bmpdH / this._mode1Size))
                    {
                        
                        this._tileBmpdMatrix[i][j] = new BitmapData(this._mode1Size, this._mode1Size, true, 0);
                        this._obstacleBmpdMatrix[i][j] = new BitmapData(this._mode1Size, this._mode1Size, true, 0);
                        this._tileLayerMatrix[i][j] = new Bitmap(this._tileBmpdMatrix[i][j]);
                        this._obstacleLayerMatrix[i][j] = new Bitmap(this._obstacleBmpdMatrix[i][j]);
                        this._tileLayerMatrix[i][j].x = this._mode1Size * i;
                        this._tileLayerMatrix[i][j].y = this._mode1Size * j;
                        this._obstacleLayerMatrix[i][j].x = this._mode1Size * i;
                        this._obstacleLayerMatrix[i][j].y = this._mode1Size * j;
                        j = (j + 1);
                    }
                    i = (i + 1);
                }
            }
            if (this._logicalTile == null)
            {
                this._logicalTile = [];
            }
            i;
            while (i < this._logicalWidth)
            {
                
                if (this._logicalTile[i] == null)
                {
                    this._logicalTile[i] = [];
                }
                i = (i + 1);
            }
            if (this._tile == null)
            {
                this._tile = [];
            }
            i;
            while (i < this._width)
            {
                
                if (this._tile[i] == null)
                {
                    this._tile[i] = [];
                }
                i = (i + 1);
            }
            this._tileArray = [];
            i;
            while (i < this._width)
            {
                
                j;
                while (j < this._height)
                {
                    
                    if (this._tile[i][j] == null)
                    {
                        this._tile[i][j] = new Tile(i, j, this);
                    }
                    if (i < this._exBorder || j < this._exBorder)
                    {
                    }
                    else
                    {
                        this._tileArray.push(this._tile[i][j]);
                    }
                    j = (j + 1);
                }
                i = (i + 1);
            }
            arr;
            i;
            while (i < this._logicalWidth)
            {
                
                arr[i] = [];
                j;
                while (j < this._logicalHeight)
                {
                    
                    arr[i][j] = this._logicalTile[i][j];
                    j = (j + 1);
                }
                i = (i + 1);
            }
            this._astar.setMap(arr);
            var tileTable:*;
            var obstacleTable:*;
            arr;
            var preLoadArr:*;
            if (xml.tileTable != null)
            {
                tempArr = xml.tileTable.split(",");
                i;
                while (i < tempArr.length)
                {
                    
                    if (Config._tileModel[Number(tempArr[i])] != null)
                    {
                        tileTable[i] = Number(tempArr[i]);
                        preLoadArr = preLoadArr.concat(findPic(Config._tileModel[Number(tempArr[i])]));
                    }
                    else
                    {
                        trace("找不到tile", tempArr[i], Number(tempArr[i]));
                    }
                    i = (i + 1);
                }
            }
            if (xml.obstacleTable != null)
            {
                tempArr = xml.obstacleTable.split(",");
                i;
                while (i < tempArr.length)
                {
                    
                    if (Config._obstacleModel[Number(tempArr[i])] != null)
                    {
                        obstacleTable[i] = Number(tempArr[i]);
                        preLoadArr = preLoadArr.concat(findPic(Config._obstacleModel[Number(tempArr[i])]));
                    }
                    else
                    {
                        trace("找不到obj", tempArr[i], Number(tempArr[i]));
                    }
                    i = (i + 1);
                }
            }
            var totalW:* = _ptPerTile * (this._width + this._height);
            var totalH:* = _ptPerTile * (this._width + this._height) / 2;
            var ratio:* = 1 - this._width / (this._width + this._height);
            this._bmpdRatio = ratio;
            var serialTileArray:*;
            var serialObstacleArray:*;
            arr = xml.tileArray.split(",");
            i;
            while (i < arr.length)
            {
                
                cstr = arr[i];
                temp = cstr.split(":");
                if (temp.length == 1)
                {
                    serialTileArray.push(cstr);
                }
                else
                {
                    loop = parseInt(temp[1]);
                    j;
                    while (j < loop)
                    {
                        
                        serialTileArray.push(temp[0]);
                        j = (j + 1);
                    }
                }
                i = (i + 1);
            }
            arr = xml.obstacleArray.split(",");
            i;
            while (i < arr.length)
            {
                
                cstr = arr[i];
                temp = cstr.split(":");
                if (temp.length == 1)
                {
                    serialObstacleArray.push(cstr);
                }
                else
                {
                    loop = parseInt(temp[1]);
                    j;
                    while (j < loop)
                    {
                        
                        serialObstacleArray.push(temp[0]);
                        j = (j + 1);
                    }
                }
                i = (i + 1);
            }
            var total:* = this._tileArray.length;
            i;
            while (i < total)
            {
                
                if (serialTileArray[i] != null)
                {
                    tempTileId = parseInt("" + serialTileArray[i]);
                    tempTile = Config._tileModel[tileTable[tempTileId]];
                    this._tileArray[i]._tileTableID = tempTileId;
                    if (tempTileId == -1)
                    {
                        this._tileArray[i]._tileWalkable = 0;
                    }
                    else
                    {
                        this._tileArray[i]._tileWalkable = tempTile.walkable;
                    }
                }
                else
                {
                    this._tileArray[i]._tileTableID = -1;
                    this._tileArray[i]._tileWalkable = 0;
                }
                if (serialObstacleArray[i] != null)
                {
                    tempTileId = parseInt("" + serialObstacleArray[i]);
                    tempTile = Config._obstacleModel[obstacleTable[tempTileId]];
                    this._tileArray[i]._obstacleTableID = tempTileId;
                    if (tempTileId == -1)
                    {
                        this._tileArray[i]._obstacleWalkable = 2;
                    }
                    else
                    {
                        this._tileArray[i]._obstacleCutable = Number(tempTile.cutable);
                        blockWidth = Number(tempTile.width);
                        blockHeight = Number(tempTile.height);
                        blockArr = String(tempTile.walkable).split("");
                        k;
                        while (k < blockWidth)
                        {
                            
                            l;
                            while (l < blockHeight)
                            {
                                
                                if (this._tileArray[i]._x - k >= 0 && this._tileArray[i]._x - k < this._width)
                                {
                                    if (this._tileArray[i]._y - l >= 0 && this._tileArray[i]._y - l < this._height)
                                    {
                                        this._tile[this._tileArray[i]._x - k][this._tileArray[i]._y - l]._obstacleWalkable = Math.min(this._tile[this._tileArray[i]._x - k][this._tileArray[i]._y - l]._obstacleWalkable, blockArr[l * blockWidth + k]);
                                    }
                                }
                                l = (l + 1);
                            }
                            k = (k + 1);
                        }
                    }
                }
                else
                {
                    this._tileArray[i]._obstacleTableID = -1;
                    this._tileArray[i]._obstacleWalkable = 2;
                }
                i = (i + 1);
            }
            if (this._emptyTileBmp == null)
            {
                if (this._forceEmptyTileBmp != null)
                {
                    this._emptyTileBmp = this._forceEmptyTileBmp.clone();
                }
                else if (tileTable.length > 0)
                {
                    temp = Tileset.toBmp(Config._tileModel[tileTable[0]]);
                    temp1 = new BitmapData(temp.width, temp.height, true, 4278190080);
                    this._emptyTileBmp = new BitmapData(temp.width, temp.height, true, 0);
                    this._emptyTileBmp.copyPixels(temp1, temp1.rect, Config._point0, temp, Config._point0, true);
                }
                else
                {
                    tempTileDraw = new Sprite();
                    tempTileDraw.graphics.beginFill(16777215);
                    tempTileDraw.graphics.lineStyle(0, 0);
                    tempTileDraw.graphics.moveTo(_ptPerTile, 0);
                    tempTileDraw.graphics.lineTo(0, _ptPerTile / 2);
                    tempTileDraw.graphics.lineTo(_ptPerTile, _ptPerTile);
                    tempTileDraw.graphics.lineTo(_ptPerTile, _ptPerTile);
                    tempTileDraw.graphics.lineTo(_ptPerTile * 2, _ptPerTile / 2);
                    tempTileDraw.graphics.lineTo(_ptPerTile, 0);
                    tempTileDraw.graphics.endFill();
                    this._emptyTileBmp = new BitmapData(_ptPerTile * 2, _ptPerTile, true, 0);
                    this._emptyTileBmp.draw(tempTileDraw);
                }
            }
            var obstacleCutTable:*;
            if (this._data.obstacleTable != null && this._data.obstacleTable != "undefined")
            {
                tempArr = this._data.obstacleTable.split(",");
                i;
                while (i < tempArr.length)
                {
                    
                    if (Config._obstacleModel[Number(tempArr[i])]["cutable"] == 1)
                    {
                        tempBmpd = Picset.toBmp(Config._obstacleModel[Number(tempArr[i])]);
                        j;
                        while (j < 2)
                        {
                            
                            k;
                            while (k < 2)
                            {
                                
                                l;
                                while (l < 2)
                                {
                                    
                                    m;
                                    while (m < 2)
                                    {
                                        
                                        bmpd = new BitmapData(_ptPerTile / 3 * 4, tempBmpd.height + _ptPerTile / 2, true, 0);
                                        if (j == 1)
                                        {
                                            bmpd.copyPixels(tempBmpd, tempBmpd.rect, Config._point0, null, null, true);
                                        }
                                        if (k == 1)
                                        {
                                            bmpd.copyPixels(tempBmpd, tempBmpd.rect, new Point(_ptPerTile / 3 * 2, 0), null, null, true);
                                        }
                                        bmpd.copyPixels(tempBmpd, tempBmpd.rect, new Point(_ptPerTile / 3, _ptPerTile / 6), null, null, true);
                                        if (l == 1)
                                        {
                                            bmpd.copyPixels(tempBmpd, tempBmpd.rect, new Point(0, _ptPerTile / 3), null, null, true);
                                        }
                                        if (m == 1)
                                        {
                                            bmpd.copyPixels(tempBmpd, tempBmpd.rect, new Point(_ptPerTile / 3 * 2, _ptPerTile / 3), null, null, true);
                                        }
                                        obstacleCutTable["" + i + j + k + l + m] = bmpd;
                                        m = (m + 1);
                                    }
                                    l = (l + 1);
                                }
                                k = (k + 1);
                            }
                            j = (j + 1);
                        }
                        tempBmpd.dispose();
                    }
                    i = (i + 1);
                }
            }
            i;
            while (i < total)
            {
                
                tempTileId = parseInt("" + serialObstacleArray[i]);
                tempTile = Config._obstacleModel[obstacleTable[tempTileId]];
                if (tempTileId != -1)
                {
                    if (tempTile.halo != null)
                    {
                        if (tempTile.halo.type == 1)
                        {
                            this._tileArray[i]._haloType = 1;
                            this._tileArray[i]._haloRadius = Number(tempTile.halo.radius);
                        }
                        else if (tempTile.halo.type == 2)
                        {
                            this._tileArray[i]._haloType = 2;
                            this._tileArray[i]._haloRadius = Number(tempTile.halo.radius);
                            this._tileArray[i]._haloX = Number(tempTile.halo.x);
                            this._tileArray[i]._haloY = Number(tempTile.halo.y);
                        }
                        else if (tempTile.halo.type == 3)
                        {
                            this._tileArray[i]._haloType = 3;
                            this._tileArray[i]._haloRadius = Number(tempTile.halo.radius);
                            tempBmpd = Picset.toBmp(tempTile);
                            this._tileArray[i]._haloBmpd = new BitmapData(tempBmpd.width + this._tileArray[i]._haloRadius * 2, tempBmpd.height + this._tileArray[i]._haloRadius * 2, true, 0);
                            this._tileArray[i]._haloBmpd.copyPixels(tempBmpd, tempBmpd.rect, new Point(this._tileArray[i]._haloRadius, this._tileArray[i]._haloRadius));
                            temp18 = new GlowFilter(0, 1, this._tileArray[i]._haloRadius, this._tileArray[i]._haloRadius);
                            this._tileArray[i]._haloBmpd.applyFilter(this._tileArray[i]._haloBmpd, this._tileArray[i]._haloBmpd.rect, new Point(), temp18);
                        }
                    }
                }
                i = (i + 1);
            }
            var tileX:* = this._exBorder;
            var tileY:* = this._exBorder;
            var _loc_2:* = 0;
            var _loc_3:* = serialTileArray;
            while (_loc_3 in _loc_2)
            {
                
                i = _loc_3[_loc_2];
                temp = Number(serialTileArray[i]);
                if (temp != -1)
                {
                    xDraw = Math.round((tileX - tileY) * _ptPerTile - _ptPerTile + totalW * ratio);
                    yDraw = (tileX / 2 + tileY / 2) * _ptPerTile;
                    tempBmpd = Tileset.toBmp(Config._tileModel[tileTable[Number(temp)]]);
                    if (this._mode == 0)
                    {
                        this._tileBmpd.copyPixels(tempBmpd, tempBmpd.rect, new Point(xDraw, yDraw), null, null, true);
                    }
                    else
                    {
                        m = int(xDraw / this._mode1Size);
                        while (m < Math.ceil((xDraw + tempBmpd.rect.width) / this._mode1Size))
                        {
                            
                            n = int(yDraw / this._mode1Size);
                            while (n < Math.ceil((yDraw + tempBmpd.rect.height) / this._mode1Size))
                            {
                                
                                this._tileBmpdMatrix[m][n].copyPixels(tempBmpd, tempBmpd.rect, new Point(xDraw - m * this._mode1Size, yDraw - n * this._mode1Size), null, null, true);
                                n = (n + 1);
                            }
                            m = (m + 1);
                        }
                    }
                    tempBmpd.dispose();
                }
                tileY = (tileY + 1);
                if (tileY >= this._height)
                {
                    tileY = this._exBorder;
                    tileX = (tileX + 1);
                }
            }
            tileX = this._exBorder;
            tileY = this._exBorder;
            var _loc_2:* = 0;
            var _loc_3:* = serialObstacleArray;
            while (_loc_3 in _loc_2)
            {
                
                i = _loc_3[_loc_2];
                temp = Number(serialObstacleArray[i]);
                tile = this._tile[tileX][tileY];
                tile._walkable = Math.min(tile._tileWalkable, tile._obstacleWalkable);
                if (temp != -1)
                {
                    xDraw = Math.round((tileX - tileY) * _ptPerTile - _ptPerTile + totalW * ratio);
                    yDraw = (tileX / 2 + tileY / 2) * _ptPerTile;
                    temp1 = Config._obstacleModel[obstacleTable[Number(temp)]];
                    if (Number(temp1["cutable"]) == 1)
                    {
                        cutFlag;
                        if (tile._x > 0 && this._tile[(tile._x - 1)][tile._y]._obstacleCutable > 0)
                        {
                            cutFlag = (cutFlag + 1);
                        }
                        else
                        {
                            cutFlag = cutFlag + 0;
                        }
                        if (tile._y > 0 && this._tile[tile._x][(tile._y - 1)]._obstacleCutable > 0)
                        {
                            cutFlag = (cutFlag + 1);
                        }
                        else
                        {
                            cutFlag = cutFlag + 0;
                        }
                        if (tile._y < (this._height - 1) && this._tile[tile._x][(tile._y + 1)]._obstacleCutable > 0)
                        {
                            cutFlag = (cutFlag + 1);
                        }
                        else
                        {
                            cutFlag = cutFlag + 0;
                        }
                        if (tile._x < (this._width - 1) && this._tile[(tile._x + 1)][tile._y]._obstacleCutable > 0)
                        {
                            cutFlag = (cutFlag + 1);
                        }
                        else
                        {
                            cutFlag = cutFlag + 0;
                        }
                        tempBmpd = obstacleCutTable["" + temp + cutFlag].clone();
                    }
                    else
                    {
                        tempBmpd = Picset.toBmp(temp1);
                    }
                    if (Number(temp1.width) <= 1 && Number(temp1.height) <= 1 && this._under >= 1 && this._tileArray[i]._x >= this._exBorder && this._tileArray[i]._y >= this._exBorder)
                    {
                        temp18;
                        temp9 = _ptPerTile / 3;
                        temp10;
                        bmp1 = tempBmpd;
                        bmp = new BitmapData(96, bmp1.height, true, 0);
                        bmp.copyPixels(bmp1, bmp1.rect, new Point(Math.floor((96 - bmp1.width) / 2), 0), null, null, true);
                        tempBmp = new BitmapData(bmp.width, bmp.height, true, 4278190080);
                        x = this._tile[tileX][tileY]._x;
                        y = (this._tile[tileX][tileY]._y + 1);
                        if (x >= 0 && x < this._width && (y >= 0 && y < this._height))
                        {
                            lowerTile = this._tile[x][y];
                            if (lowerTile._tileTableID == -1)
                            {
                                temp10 = (temp10 + 1);
                                bmp.copyPixels(tempBmp, tempBmp.rect, new Point(), bmp1, new Point(0, (-temp9) / 2), true);
                                bmp.copyPixels(tempBmp, tempBmp.rect, new Point(0, temp18), bmp1, new Point(0, (-temp9) / 2), true);
                            }
                        }
                        else
                        {
                            temp10 = (temp10 + 1);
                            bmp.copyPixels(tempBmp, tempBmp.rect, new Point(), bmp1, new Point(0, (-temp9) / 2), true);
                            bmp.copyPixels(tempBmp, tempBmp.rect, new Point(0, temp18), bmp1, new Point(0, (-temp9) / 2), true);
                        }
                        x = (this._tile[tileX][tileY]._x + 1);
                        y = this._tile[tileX][tileY]._y;
                        if (x >= 0 && x < this._width && (y >= 0 && y < this._height))
                        {
                            lowerTile = this._tile[x][y];
                            if (lowerTile._tileTableID == -1)
                            {
                                temp10 = temp10 + 2;
                                bmp.copyPixels(tempBmp, tempBmp.rect, new Point(96 - bmp1.width, 0), bmp1, new Point(0, (-temp9) / 2), true);
                                bmp.copyPixels(tempBmp, tempBmp.rect, new Point(96 - bmp1.width, temp18), bmp1, new Point(0, (-temp9) / 2), true);
                            }
                        }
                        else
                        {
                            temp10 = temp10 + 2;
                            bmp.copyPixels(tempBmp, tempBmp.rect, new Point(96 - bmp1.width, 0), bmp1, new Point(0, (-temp9) / 2), true);
                            bmp.copyPixels(tempBmp, tempBmp.rect, new Point(96 - bmp1.width, temp18), bmp1, new Point(0, (-temp9) / 2), true);
                        }
                        x = (this._tile[tileX][tileY]._x + 1);
                        y = (this._tile[tileX][tileY]._y + 1);
                        if (temp10 == 3 || temp10 == 0)
                        {
                            if (x >= 0 && x < this._width && (y >= 0 && y < this._height))
                            {
                                lowerTile = this._tile[x][y];
                                if (lowerTile._tileTableID == -1)
                                {
                                    temp10 = temp10 + 4;
                                    bmp.copyPixels(tempBmp, tempBmp.rect, new Point(Math.floor((96 - bmp1.width) / 2), temp9 / 2), bmp1, new Point(0, -8), true);
                                    bmp.copyPixels(tempBmp, tempBmp.rect, new Point(Math.floor((96 - bmp1.width) / 2), temp9 / 2 + temp18), bmp1, new Point(0, -8), true);
                                }
                            }
                            else
                            {
                                temp10 = temp10 + 4;
                                bmp.copyPixels(tempBmp, tempBmp.rect, new Point(Math.floor((96 - bmp1.width) / 2), temp9 / 2), bmp1, new Point(0, -8), true);
                                bmp.copyPixels(tempBmp, tempBmp.rect, new Point(Math.floor((96 - bmp1.width) / 2), temp9 / 2 + temp18), bmp1, new Point(0, -8), true);
                            }
                        }
                        x = (this._tile[tileX][tileY]._x - 1);
                        y = (this._tile[tileX][tileY]._y + 1);
                        if (temp10 > 0)
                        {
                            if (x >= 0 && x < this._width && (y >= 0 && y < this._height))
                            {
                                lowerTile = this._tile[x][y];
                                if (lowerTile._tileTableID == -1)
                                {
                                    bmp.copyPixels(tempBmp, tempBmp.rect, new Point(-32, 0), bmp1, new Point(0, -8), true);
                                    bmp.copyPixels(tempBmp, tempBmp.rect, new Point(-32, temp18), bmp1, new Point(0, -8), true);
                                }
                            }
                            else
                            {
                                bmp.copyPixels(tempBmp, tempBmp.rect, new Point(-32, 0), bmp1, new Point(0, -8), true);
                                bmp.copyPixels(tempBmp, tempBmp.rect, new Point(-32, temp18), bmp1, new Point(0, -8), true);
                            }
                        }
                        x = (this._tile[tileX][tileY]._x + 1);
                        y = (this._tile[tileX][tileY]._y - 1);
                        if (temp10 > 0)
                        {
                            if (x >= 0 && x < this._width && (y >= 0 && y < this._height))
                            {
                                lowerTile = this._tile[x][y];
                                if (lowerTile._tileTableID == -1)
                                {
                                    bmp.copyPixels(tempBmp, tempBmp.rect, new Point(96 - bmp1.width + 32, 0), bmp1, new Point(0, -8), true);
                                    bmp.copyPixels(tempBmp, tempBmp.rect, new Point(96 - bmp1.width + 32, temp18), bmp1, new Point(0, -8), true);
                                }
                            }
                            else
                            {
                                bmp.copyPixels(tempBmp, tempBmp.rect, new Point(96 - bmp1.width + 32, 0), bmp1, new Point(0, -8), true);
                                bmp.copyPixels(tempBmp, tempBmp.rect, new Point(96 - bmp1.width + 32, temp18), bmp1, new Point(0, -8), true);
                            }
                        }
                        if (temp10 > 0)
                        {
                            tempBmpd = bmp;
                            bmp1.dispose();
                        }
                        else
                        {
                            bmp.dispose();
                        }
                        tempBmp.dispose();
                    }
                    tempPoint = new Point(xDraw - tempBmpd.width / (Number(temp1.width) + Number(temp1.height)) * Number(temp1.width) + _ptPerTile, yDraw - tempBmpd.height + _ptPerTile);
                    if (Number(temp1.ground) == 1)
                    {
                        if (this._mode == 0)
                        {
                            this._tileBmpd.copyPixels(tempBmpd, tempBmpd.rect, tempPoint, null, null, true);
                        }
                        else
                        {
                            m = int(tempPoint.x / this._mode1Size);
                            while (m < Math.ceil((tempPoint.x + tempBmpd.rect.width) / this._mode1Size))
                            {
                                
                                n = int(tempPoint.y / this._mode1Size);
                                while (n < Math.ceil((tempPoint.y + tempBmpd.rect.height) / this._mode1Size))
                                {
                                    
                                    this._tileBmpdMatrix[m][n].copyPixels(tempBmpd, tempBmpd.rect, new Point(tempPoint.x - m * this._mode1Size, tempPoint.y - n * this._mode1Size), null, null, true);
                                    n = (n + 1);
                                }
                                m = (m + 1);
                            }
                        }
                    }
                    else if (Number(temp1.ground) == 2)
                    {
                        if (this._mode == 0)
                        {
                            this._obstacleBmpd.copyPixels(tempBmpd, tempBmpd.rect, tempPoint, null, null, true);
                        }
                        else
                        {
                            m = int(tempPoint.x / this._mode1Size);
                            while (m < Math.ceil((tempPoint.x + tempBmpd.rect.width) / this._mode1Size))
                            {
                                
                                n = int(tempPoint.y / this._mode1Size);
                                while (n < Math.ceil((tempPoint.y + tempBmpd.rect.height) / this._mode1Size))
                                {
                                    
                                    this._obstacleBmpdMatrix[m][n].copyPixels(tempBmpd, tempBmpd.rect, new Point(tempPoint.x - m * this._mode1Size, tempPoint.y - n * this._mode1Size), null, null, true);
                                    n = (n + 1);
                                }
                                m = (m + 1);
                            }
                        }
                    }
                    else
                    {
                        temp9;
                        temp10;
                        while (temp10 || temp9 <= Math.max(temp1.width, temp1.height))
                        {
                            
                            temp10;
                            arr;
                            temp2;
                            while (temp2 < temp9)
                            {
                                
                                arr.push({k:(temp9 - 1), l:temp2});
                                temp2 = (temp2 + 1);
                            }
                            temp2;
                            while (temp2 < temp9)
                            {
                                
                                if (temp2 != (temp9 - 1))
                                {
                                    arr.push({k:temp2, l:(temp9 - 1)});
                                }
                                temp2 = (temp2 + 1);
                            }
                            temp2;
                            while (temp2 < arr.length)
                            {
                                
                                k = arr[temp2].k;
                                l = arr[temp2].l;
                                x = tile._x - k;
                                y = tile._y - l;
                                higherTile;
                                if ((x + 1) >= 0 && (x + 1) < this._width && (y + 1) >= 0 && (y + 1) < this._height)
                                {
                                    higherTile = this._tile[(x + 1)][(y + 1)];
                                }
                                if (x >= 0 && x < this._width && y >= 0 && y < this._height)
                                {
                                    lowerTile = this._tile[x][y];
                                    if ((k == 0 && l < Number(temp1.height) || l == 0 && k < Number(temp1.width)) && (x < (this._width - 1) && this._tile[(x + 1)][y]._obstacleWalkable == 2 || y < (this._height - 1) && this._tile[x][(y + 1)]._obstacleWalkable == 2 || x < (this._width - 1) && y < (this._height - 1) && this._tile[(x + 1)][(y + 1)]._obstacleWalkable == 2) || l < (Number(temp1.height) + 1) && k < (Number(temp1.width) + 1) && (lowerTile._obstacleWalkable == 2 != true && (higherTile != null && higherTile._obstacleWalkable == 2 || higherTile == null)))
                                    {
                                        tempPoint1 = new Point(-Math.floor(tempBmpd.width / (Number(temp1.width) + Number(temp1.height)) * Number(temp1.width)) + _ptPerTile + (tile._xDraw - lowerTile._xDraw), -tempBmpd.height + _ptPerTile + (tile._yDraw - lowerTile._yDraw));
                                        if (this._mode == 0)
                                        {
                                            this._tileBmpd.copyPixels(tempBmpd, tempBmpd.rect, tempPoint, this._emptyTileBmp, tempPoint1, true);
                                        }
                                        else
                                        {
                                            m = int(tempPoint.x / this._mode1Size);
                                            while (m < Math.ceil((tempPoint.x + tempBmpd.rect.width) / this._mode1Size))
                                            {
                                                
                                                n = int(tempPoint.y / this._mode1Size);
                                                while (n < Math.ceil((tempPoint.y + tempBmpd.rect.height) / this._mode1Size))
                                                {
                                                    
                                                    this._tileBmpdMatrix[m][n].copyPixels(tempBmpd, tempBmpd.rect, new Point(tempPoint.x - m * this._mode1Size, tempPoint.y - n * this._mode1Size), this._emptyTileBmp, tempPoint1, true);
                                                    n = (n + 1);
                                                }
                                                m = (m + 1);
                                            }
                                        }
                                        tempRemove = new BitmapData(tempBmpd.width, tempBmpd.height, true, 4294901760);
                                        tempBmpd.copyPixels(tempRemove, tempRemove.rect, new Point(), this._emptyTileBmp, new Point(-Math.floor(tempBmpd.width / (Number(temp1.width) + Number(temp1.height)) * Number(temp1.width)) + _ptPerTile + (tile._xDraw - lowerTile._xDraw), -tempBmpd.height + _ptPerTile + (tile._yDraw - lowerTile._yDraw)), true);
                                        if (tempBmpd.threshold(tempBmpd, tempBmpd.rect, new Point(), "==", 4294901760) > 0)
                                        {
                                            temp10;
                                        }
                                        tempRemove.dispose();
                                    }
                                }
                                temp2 = (temp2 + 1);
                            }
                            temp9 = (temp9 + 1);
                        }
                        if (this._mode == 0)
                        {
                            this._obstacleBmpd.copyPixels(tempBmpd, tempBmpd.rect, tempPoint, null, null, true);
                        }
                        else
                        {
                            m = int(tempPoint.x / this._mode1Size);
                            while (m < Math.ceil((tempPoint.x + tempBmpd.rect.width) / this._mode1Size))
                            {
                                
                                n = int(tempPoint.y / this._mode1Size);
                                while (n < Math.ceil((tempPoint.y + tempBmpd.rect.height) / this._mode1Size))
                                {
                                    
                                    this._obstacleBmpdMatrix[m][n].copyPixels(tempBmpd, tempBmpd.rect, new Point(tempPoint.x - m * this._mode1Size, tempPoint.y - n * this._mode1Size), null, null, true);
                                    n = (n + 1);
                                }
                                m = (m + 1);
                            }
                        }
                    }
                }
                if (tempBmpd != null)
                {
                    tempBmpd.dispose();
                }
                tileY = (tileY + 1);
                if (tileY >= this._height)
                {
                    tileY = this._exBorder;
                    tileX = (tileX + 1);
                }
            }
            if (this._mode == 1)
            {
                i;
                while (i < Math.ceil(this._bmpdW / this._mode1Size))
                {
                    
                    j;
                    while (j < Math.ceil(this._bmpdH / this._mode1Size))
                    {
                        
                        temp4 = this._tileBmpdMatrix[i][j].getColorBoundsRect(4278190080, 0, false);
                        if (temp4.width == 0 && temp4.height == 0)
                        {
                            this._tileBmpdMatrix[i][j].dispose();
                            delete this._tileBmpdMatrix[i][j];
                            delete this._tileLayerMatrix[i][j];
                        }
                        temp4 = this._obstacleBmpdMatrix[i][j].getColorBoundsRect(4278190080, 0, false);
                        if (temp4.width == 0 && temp4.height == 0)
                        {
                            this._obstacleBmpdMatrix[i][j].dispose();
                            delete this._obstacleBmpdMatrix[i][j];
                            delete this._obstacleLayerMatrix[i][j];
                        }
                        j = (j + 1);
                    }
                    i = (i + 1);
                }
            }
            Picset.clearBuff();
            Tileset.clearBuff();
            BitmapLoader.clearBuffArr(this._loadArr);
            this._loadArr = null;
            var _loc_2:* = 0;
            var _loc_3:* = obstacleCutTable;
            while (_loc_3 in _loc_2)
            {
                
                i = _loc_3[_loc_2];
                obstacleCutTable[i].dispose();
            }
            this._iso.freshObstacle = true;
            this._state = "ready";
            this.refresh();
            this.fillInnerArea();
            Config.gc();
            dispatchEvent(new Event("scroll"));
            dispatchEvent(new Event("complete"));
            return;
        }// end function

        public function playMusic()
        {
            if (!this._noMusic && this._data != null)
            {
                if (String(this._data.music) == "")
                {
                    Music.stop();
                }
                else
                {
                    Music.play(String(this._data.music));
                }
            }
            else
            {
                Music.stop();
            }
            return;
        }// end function

        public function set data(param1) : void
        {
            this._data = param1;
            this.playMusic();
            if (this._mc == null)
            {
                if (param1 == null)
                {
                    return;
                }
                this.init();
            }
            else
            {
                this.clear();
            }
            dispatchEvent(new Event("reload"));
            return;
        }// end function

        public function get data()
        {
            return this._data;
        }// end function

        public function defineContextMenu(param1)
        {
            var switchShade:*;
            var item:ContextMenuItem;
            var switchSound:*;
            var shade:* = param1;
            switchShade = function ()
            {
                halo = !halo;
                defineContextMenu(halo);
                return;
            }// end function
            ;
            switchSound = function ()
            {
                SoundManager.on = !SoundManager.on;
                defineContextMenu(halo);
                return;
            }// end function
            ;
            var myContextMenu:* = new ContextMenu();
            myContextMenu.hideBuiltInItems();
            if (this.halo)
            {
                item = new ContextMenuItem(Config.language("Map", 4));
            }
            else
            {
                item = new ContextMenuItem(Config.language("Map", 5));
            }
            item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, switchShade);
            myContextMenu.customItems.push(item);
            if (SoundManager.on)
            {
                item = new ContextMenuItem(Config.language("Map", 6));
            }
            else
            {
                item = new ContextMenuItem(Config.language("Map", 7));
            }
            item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, switchSound);
            myContextMenu.customItems.push(item);
            contextMenu = myContextMenu;
            return;
        }// end function

        private function startLoop(param1:Function)
        {
            this.stopLoop(param1);
            this._enterframeListenerArray.push(param1);
            if (this._enterframeListenerArray.length == 1)
            {
                addEventListener(Event.ENTER_FRAME, this.enterframeLoop);
            }
            return;
        }// end function

        private function stopLoop(param1:Function)
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
            for (_loc_2 in this._enterframeListenerArray)
            {
                
                var _loc_5:* = this._enterframeListenerArray;
                _loc_5.this._enterframeListenerArray[_loc_2](param1);
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

        public function findPath(param1, param2, param3 = false) : Array
        {
            var pt1:* = param1;
            var pt2:* = param2;
            var justTerrain:* = param3;
            try
            {
                if (pt1 == pt2)
                {
                    return [pt1, pt2];
                }
                LogicalTile._justTerrain = justTerrain;
                this._astar.setStartPoint(pt1._y, pt1._x);
                this._astar.setEndPoint(pt2._y, pt2._x);
                if (this._astar.testStraight({y:pt1._x, x:pt1._y}, {y:pt2._x, x:pt2._y}))
                {
                    return [pt1, pt2];
                }
                else
                {
                    return this._astar.findPath();
                }
                LogicalTile._justTerrain = false;
            }
            catch (e)
            {
            }
            return [];
        }// end function

        public function testFlyStraight(param1, param2)
        {
            var _loc_3:* = this.mapToTile(param1);
            var _loc_4:* = this.mapToTile(param2);
            return this._astar.testFlyStraight({y:_loc_3._x, x:_loc_3._y}, {y:_loc_4._x, x:_loc_4._y});
        }// end function

        public function testWalkable(param1, param2, param3 = 1)
        {
            var _loc_4:* = this.findNearWalkable(param1._currTile, param2);
            var _loc_5:* = this.findNearWalkable(param2._currTile, param1, param3);
            this._astar.setStartPoint(_loc_4._y, _loc_4._x);
            this._astar.setEndPoint(_loc_5._y, _loc_5._x);
            var _loc_6:* = this._astar.findPath(false);
            if (this._astar.findPath(false).length > 1)
            {
                return true;
            }
            return false;
        }// end function

        public function lock(param1:uint, param2:uint)
        {
            this._lock = true;
            this._iso.scrollTo(param1, param2);
            this._x = param1;
            this._y = param2;
            dispatchEvent(new Event("scroll"));
            return;
        }// end function

        public function unlock()
        {
            this._lock = false;
            return;
        }// end function

        public function scrollTo(param1:uint, param2:uint, param3 = false)
        {
            var _loc_4:* = param1 + this._exBorder * _ptPerTile;
            var _loc_5:* = param2 + this._exBorder * _ptPerTile;
            if (this._lock || this._state != "ready")
            {
            }
            else
            {
                if (this._iso != null)
                {
                    this._iso.scrollTo(_loc_4, _loc_5, param3);
                }
                this._x = param1;
                this._y = param2;
                dispatchEvent(new Event("scroll"));
            }
            return;
        }// end function

        public function removeHalo(param1)
        {
            if (this._iso != null)
            {
                this._iso.removeHalo(param1);
            }
            return;
        }// end function

        public function setHalo(param1, param2, param3, param4, param5 = 1, param6 = null, param7 = 0)
        {
            if (this._iso != null)
            {
                this._iso.setHalo(param1, param2, param3, param4, param5, param6, param7);
            }
            return;
        }// end function

        public function refresh()
        {
            var _loc_1:* = undefined;
            if (this._state == "ready")
            {
                _loc_1 = this._iso.getHaleArray();
                this.scrollTo(this._x, this._y, true);
                this._iso.refreshHalo(_loc_1);
            }
            return;
        }// end function

        public function positionToMap(param1:Object)
        {
            var _loc_2:* = {};
            var _loc_3:* = param1._y + param1._x / 2 + _ptPerTile / 2;
            var _loc_4:* = param1._y - param1._x / 2 + _ptPerTile / 2;
            _loc_2._x = _loc_3;
            _loc_2._y = _loc_4;
            if (_loc_2._x < 0)
            {
                _loc_2._x = 0;
            }
            else if (_loc_2._x > (this._width - this._exBorder - this._earthBorder) * _ptPerTile - 1)
            {
                _loc_2._x = (this._width - this._exBorder - this._earthBorder) * _ptPerTile - 1;
            }
            if (_loc_2._y < 0)
            {
                _loc_2._y = 0;
            }
            else if (_loc_2._y > (this._height - this._exBorder - this._earthBorder) * _ptPerTile - 1)
            {
                _loc_2._y = (this._height - this._exBorder - this._earthBorder) * _ptPerTile - 1;
            }
            return _loc_2;
        }// end function

        public function screenToMap(param1:Object)
        {
            var _loc_2:* = {};
            var _loc_3:* = param1._x;
            var _loc_4:* = param1._y;
            var _loc_5:* = param1._y + _loc_3 / 2 - (this._mapHeight + this._mapWidth / 2) / 2;
            var _loc_6:* = _loc_4 - _loc_3 / 2 - (this._mapHeight - this._mapWidth / 2) / 2;
            _loc_5 = _loc_5 / (this._zoom / 100);
            _loc_6 = _loc_6 / (this._zoom / 100);
            _loc_2._x = _loc_5 + this._x;
            _loc_2._y = _loc_6 + this._y;
            if (_loc_2._x < _ptPerTile / 4)
            {
                _loc_2._x = _ptPerTile / 4;
            }
            else if (_loc_2._x > this._logicalWidth * _ptPerTile / 2 - _ptPerTile / 4)
            {
                _loc_2._x = this._logicalWidth * _ptPerTile / 2 - _ptPerTile / 4;
            }
            if (_loc_2._y < _ptPerTile / 4)
            {
                _loc_2._y = _ptPerTile / 4;
            }
            else if (_loc_2._y > this._logicalHeight * _ptPerTile / 2 - _ptPerTile / 4)
            {
                _loc_2._y = this._logicalHeight * _ptPerTile / 2 - _ptPerTile / 4;
            }
            return _loc_2;
        }// end function

        public function mapToScreen(param1:Object)
        {
            var _loc_2:* = {};
            var _loc_3:* = (param1._x - this._x) * this._zoom / 100;
            var _loc_4:* = (param1._y - this._y) * this._zoom / 100;
            var _loc_5:* = _loc_3 - _loc_4 + this._mapWidth / 2;
            var _loc_6:* = (_loc_3 + _loc_4 + this._mapHeight) / 2;
            _loc_2._x = _loc_5;
            _loc_2._y = _loc_6;
            return _loc_2;
        }// end function

        public function mapToUnit(param1:Object)
        {
            var _loc_2:* = {};
            var _loc_3:* = param1._x - param1._y;
            var _loc_4:* = (param1._x + param1._y) / 2;
            _loc_2._x = _loc_3;
            _loc_2._y = _loc_4 + this._exBorder * _ptPerTile;
            return _loc_2;
        }// end function

        public function tileToMap(param1:Object)
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            if (param1 == null)
            {
                return {_x:0, _y:0};
            }
            _loc_2 = Math.ceil(param1._x) * _ptPerTile / 2 + _ptPerTile / 4;
            _loc_3 = Math.ceil(param1._y) * _ptPerTile / 2 + _ptPerTile / 4;
            return {_x:_loc_2, _y:_loc_3};
        }// end function

        public function mapToTile(param1:Object)
        {
            var x:*;
            var y:*;
            var pt:* = param1;
            try
            {
                x = Math.floor(Math.ceil(Math.floor(pt._x)) / _ptPerTile * 2);
                y = Math.floor(Math.ceil(Math.floor(pt._y)) / _ptPerTile * 2);
                if (x < 0)
                {
                    x;
                }
                else if (x > (this._logicalWidth - 1))
                {
                    x = (this._logicalWidth - 1);
                }
                if (y < 0)
                {
                    y;
                }
                else if (y > (this._logicalHeight - 1))
                {
                    y = (this._logicalHeight - 1);
                }
                return this._logicalTile[x][y];
            }
            catch (e)
            {
            }
            return;
        }// end function

        public function set zoom(param1:Number) : void
        {
            var _loc_2:* = this._zoom;
            this._zoom = param1 * 100;
            var _loc_3:* = this._zoom / 100;
            this._mc.scaleY = this._zoom / 100;
            this._mc.scaleX = _loc_3;
            this._iso.setSize(this._mapWidth * 100 / this._zoom, this._mapHeight * 100 / this._zoom);
            this.scrollTo(this._x, this._y);
            dispatchEvent(new Event("zoom"));
            return;
        }// end function

        public function get zoom() : Number
        {
            return this._zoom / 100;
        }// end function

        public function flag(param1)
        {
            param1._flaged = true;
            this._iso.drawTile(param1);
            return;
        }// end function

        public function unflag(param1)
        {
            param1._flaged = false;
            this._iso.drawTile(param1);
            return;
        }// end function

        public function paintEmptyTile(param1)
        {
            param1._bitmapData = this._emptyTileBmp;
            param1._tileID = -1;
            param1._tileTableID = -1;
            this._iso.drawTile(param1);
            return;
        }// end function

        public function paintTile(param1, param2)
        {
            return;
        }// end function

        public function paintEmptyObstacle(param1)
        {
            return;
        }// end function

        public function paintObstacle(param1, param2)
        {
            return;
        }// end function

        public function fixPtByTarget(param1, param2, param3)
        {
            return this.tileToMap(param2);
        }// end function

        public function findNearPt(param1, param2, param3, param4 = null)
        {
            var _loc_5:* = Math.floor(param3 / (_ptPerTile / 2));
            var _loc_6:* = param1._currTile;
            if (param1._currTile == null)
            {
                _loc_6 = this.mapToTile(param1);
            }
            var _loc_7:* = this.findNearWalkable(_loc_6, param2, _loc_5, param4);
            var _loc_8:* = this.tileToMap(_loc_7);
            var _loc_9:* = PointLine.leash(_loc_8, param1, param3);
            return PointLine.leash(_loc_8, param1, param3);
        }// end function

        public function findNearWalkable(param1, param2, param3 = 1, param4 = null)
        {
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            var _loc_9:* = undefined;
            var _loc_10:* = undefined;
            if (param1 == null)
            {
                return;
            }
            _loc_10 = param3;
            _loc_9 = [];
            while (_loc_9.length == 0)
            {
                
                _loc_9 = [];
                _loc_7 = param1._y - _loc_10;
                if (_loc_7 >= 0 && _loc_7 < this._logicalHeight)
                {
                    _loc_6 = -_loc_10 + param1._x;
                    while (_loc_6 < (_loc_10 + 1) + param1._x)
                    {
                        
                        if (_loc_6 >= 0 && _loc_6 < this._logicalWidth)
                        {
                            if ((this._logicalTile[_loc_6][_loc_7].walkable || param2._currTile == this._logicalTile[_loc_6][_loc_7]) && (param4 == null || this.param4(this._logicalTile[_loc_6][_loc_7])))
                            {
                                _loc_9.push({pt:this._logicalTile[_loc_6][_loc_7], r:Math.abs(param2._currTile._y - _loc_7) + Math.abs(param2._currTile._x - _loc_6)});
                            }
                        }
                        _loc_6 = _loc_6 + 1;
                    }
                }
                _loc_7 = param1._y + _loc_10;
                if (_loc_7 >= 0 && _loc_7 < this._logicalHeight)
                {
                    _loc_6 = -_loc_10 + param1._x;
                    while (_loc_6 < (_loc_10 + 1) + param1._x)
                    {
                        
                        if (_loc_6 >= 0 && _loc_6 < this._logicalWidth)
                        {
                            if ((this._logicalTile[_loc_6][_loc_7].walkable || param2._currTile == this._logicalTile[_loc_6][_loc_7]) && (param4 == null || this.param4(this._logicalTile[_loc_6][_loc_7])))
                            {
                                _loc_9.push({pt:this._logicalTile[_loc_6][_loc_7], r:Math.abs(param2._currTile._y - _loc_7) + Math.abs(param2._currTile._x - _loc_6)});
                            }
                        }
                        _loc_6 = _loc_6 + 1;
                    }
                }
                _loc_6 = param1._x - _loc_10;
                if (_loc_6 >= 0 && _loc_6 < this._logicalWidth)
                {
                    _loc_7 = -_loc_10 + param1._y;
                    while (_loc_7 < (_loc_10 + 1) + param1._y)
                    {
                        
                        if (_loc_7 >= 0 && _loc_7 < this._logicalHeight)
                        {
                            if ((this._logicalTile[_loc_6][_loc_7].walkable || param2._currTile == this._logicalTile[_loc_6][_loc_7]) && (param4 == null || this.param4(this._logicalTile[_loc_6][_loc_7])))
                            {
                                _loc_9.push({pt:this._logicalTile[_loc_6][_loc_7], r:Math.abs(param2._currTile._y - _loc_7) + Math.abs(param2._currTile._x - _loc_6)});
                            }
                        }
                        _loc_7 = _loc_7 + 1;
                    }
                }
                _loc_6 = param1._x + _loc_10;
                if (_loc_6 >= 0 && _loc_6 < this._logicalWidth)
                {
                    _loc_7 = -_loc_10 + param1._y;
                    while (_loc_7 < (_loc_10 + 1) + param1._y)
                    {
                        
                        if (_loc_7 >= 0 && _loc_7 < this._logicalHeight)
                        {
                            if ((this._logicalTile[_loc_6][_loc_7].walkable || param2._currTile == this._logicalTile[_loc_6][_loc_7]) && (param4 == null || this.param4(this._logicalTile[_loc_6][_loc_7])))
                            {
                                _loc_9.push({pt:this._logicalTile[_loc_6][_loc_7], r:Math.abs(param2._currTile._y - _loc_7) + Math.abs(param2._currTile._x - _loc_6)});
                            }
                        }
                        _loc_7 = _loc_7 + 1;
                    }
                }
                _loc_10 = _loc_10 + 1;
            }
            _loc_9.sortOn("r", Array.NUMERIC);
            return _loc_9[0].pt;
        }// end function

        public function getMiniMap(param1)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_11:* = undefined;
            var _loc_12:* = undefined;
            var _loc_13:* = undefined;
            var _loc_4:* = _ptPerTile * (this._width + this._height - this._exBorder * 2);
            var _loc_5:* = _ptPerTile * (this._width + this._height - this._exBorder * 2) / 2;
            var _loc_6:* = param1 / _loc_4;
            var _loc_7:* = new Matrix();
            new Matrix().scale(Math.max(0.02, _loc_6), Math.max(0.02, _loc_6));
            var _loc_8:* = 1 - this._width / (this._width + this._height);
            var _loc_9:* = new BitmapData(_ptPerTile * 2, _ptPerTile, true, 0);
            var _loc_10:* = new BitmapData(param1, param1 / 2, true, 0);
            new BitmapData(param1, param1 / 2, true, 0).lock();
            _loc_2 = this._exBorder;
            while (_loc_2 < this._width)
            {
                
                _loc_3 = this._exBorder;
                while (_loc_3 < this._height)
                {
                    
                    _loc_13 = this._tile[_loc_2][_loc_3];
                    _loc_9 = new BitmapData(_ptPerTile * 2, _ptPerTile, true, 0);
                    _loc_9.draw(_loc_13._bitmapData, _loc_7);
                    _loc_11 = (_loc_13._x - _loc_13._y) * _ptPerTile - _ptPerTile;
                    _loc_12 = (_loc_13._x / 2 + _loc_13._y / 2 - this._exBorder) * _ptPerTile - _ptPerTile / 2;
                    _loc_10.copyPixels(_loc_9, new Rectangle(0, 0, _loc_9.width, _loc_9.height), new Point((_loc_11 + _loc_4 * _loc_8) * _loc_6, (_loc_12 + _ptPerTile / 2) * _loc_6), null, null, true);
                    if (_loc_13._obstacleBitmapData != null)
                    {
                        _loc_9 = new BitmapData(_ptPerTile * 2, _ptPerTile, true, 0);
                        _loc_9.draw(_loc_13._obstacleBitmapData, _loc_7);
                        _loc_10.copyPixels(_loc_9, new Rectangle(0, 0, _loc_9.width, _loc_9.height), new Point((_loc_11 + _loc_4 * _loc_8 + _ptPerTile - Math.floor(_loc_13._obstacleBitmapData.width / (_loc_13._obstacleWidth + _loc_13._obstacleHeight) * _loc_13._obstacleWidth)) * _loc_6, (_loc_12 + _ptPerTile / 2 + _loc_13._obstacleY) * _loc_6), null, null, true);
                    }
                    _loc_3 = _loc_3 + 1;
                }
                _loc_2 = _loc_2 + 1;
            }
            _loc_10.unlock();
            return _loc_10;
        }// end function

        public function getBlockMap(param1, param2 = 16777215)
        {
            var _loc_9:* = undefined;
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
            var _loc_25:* = undefined;
            var _loc_3:* = _ptPerTile * (this._width + this._height - this._exBorder * 2);
            var _loc_4:* = _ptPerTile * (this._width + this._height - this._exBorder * 2) / 2;
            var _loc_5:* = param1 / _loc_3;
            var _loc_6:* = 0;
            var _loc_7:* = new Matrix();
            new Matrix().scale(_loc_5, _loc_5);
            var _loc_8:* = 1 - (this._width - this._exBorder) / (this._width + this._height - this._exBorder * 2);
            var _loc_10:* = new BitmapData(param1, param1 / 2, true, 0);
            new BitmapData(param1, param1 / 2, true, 0).lock();
            _loc_12 = new Shape();
            _loc_13 = this._exBorder;
            while (_loc_13 < this._width)
            {
                
                _loc_14 = this._exBorder;
                while (_loc_14 < this._height)
                {
                    
                    _loc_25 = this._tile[_loc_13][_loc_14];
                    _loc_21 = false;
                    _loc_22 = 0;
                    while (_loc_22 < 2)
                    {
                        
                        _loc_23 = 0;
                        while (_loc_23 < 2)
                        {
                            
                            _loc_24 = this._logicalTile[(_loc_13 - this._exBorder) * 2 + _loc_22][(_loc_14 - this._exBorder) * 2 + _loc_23];
                            _loc_11 = Config.eventStack[_loc_24._x + "_" + _loc_24._y];
                            if (_loc_11 != null && String(_loc_11.type) == "jump_map")
                            {
                                _loc_21 = true;
                                break;
                            }
                            if (_loc_11 != null && String(_loc_11.type) == "jump_battle_field")
                            {
                                _loc_21 = true;
                                break;
                            }
                            _loc_23 = _loc_23 + 1;
                        }
                        if (_loc_21)
                        {
                            break;
                        }
                        _loc_22 = _loc_22 + 1;
                    }
                    if (_loc_21)
                    {
                        _loc_12.graphics.clear();
                        _loc_12.graphics.beginFill(16750848);
                        _loc_12.graphics.lineStyle(0, 16750848);
                        _loc_12.graphics.moveTo(_ptPerTile, 0);
                        _loc_12.graphics.lineTo(_ptPerTile * 2, _ptPerTile / 2);
                        _loc_12.graphics.lineTo(_ptPerTile, _ptPerTile);
                        _loc_12.graphics.lineTo(0, _ptPerTile / 2);
                        _loc_12.graphics.lineTo(_ptPerTile, 0);
                        _loc_12.graphics.endFill();
                        _loc_9 = new BitmapData(_ptPerTile * 2, _ptPerTile, true, 0);
                        _loc_9.draw(_loc_12, _loc_7);
                        _loc_19 = (_loc_25._x - _loc_25._y) * _ptPerTile - _ptPerTile;
                        _loc_20 = (_loc_25._x / 2 + _loc_25._y / 2 - this._exBorder) * _ptPerTile - _ptPerTile / 2;
                        _loc_10.copyPixels(_loc_9, _loc_9.rect, new Point((_loc_19 + _loc_3 * _loc_8) * _loc_5, _loc_20 * _loc_5 + _ptPerTile * _loc_5 / 2), null, null, true);
                    }
                    else if (_loc_25.walkable != true)
                    {
                        _loc_17 = true;
                        _loc_18 = 0;
                        _loc_15 = _loc_13 - 1;
                        _loc_16 = _loc_14;
                        if (_loc_15 >= 0 && _loc_15 < this._width && _loc_16 >= 0 && _loc_16 < this._height && this._tile[_loc_15][_loc_16].walkable != true)
                        {
                            _loc_18 = _loc_18 + 1;
                        }
                        _loc_15 = _loc_13 + 1;
                        _loc_16 = _loc_14;
                        if (_loc_15 >= 0 && _loc_15 < this._width && _loc_16 >= 0 && _loc_16 < this._height && this._tile[_loc_15][_loc_16].walkable != true)
                        {
                            _loc_18 = _loc_18 + 2;
                        }
                        _loc_15 = _loc_13;
                        _loc_16 = _loc_14 - 1;
                        if (_loc_15 >= 0 && _loc_15 < this._width && _loc_16 >= 0 && _loc_16 < this._height && this._tile[_loc_15][_loc_16].walkable != true)
                        {
                            _loc_18 = _loc_18 + 4;
                        }
                        _loc_15 = _loc_13;
                        _loc_16 = _loc_14 + 1;
                        if (_loc_15 >= 0 && _loc_15 < this._width && _loc_16 >= 0 && _loc_16 < this._height && this._tile[_loc_15][_loc_16].walkable != true)
                        {
                            _loc_18 = _loc_18 + 8;
                        }
                        _loc_12.graphics.clear();
                        _loc_12.graphics.beginFill(param2);
                        _loc_12.graphics.lineStyle(0, param2);
                        _loc_12.graphics.moveTo(_ptPerTile, 0);
                        _loc_12.graphics.lineTo(_ptPerTile * 2, _ptPerTile / 2);
                        _loc_12.graphics.lineTo(_ptPerTile, _ptPerTile);
                        _loc_12.graphics.lineTo(0, _ptPerTile / 2);
                        _loc_12.graphics.lineTo(_ptPerTile, 0);
                        _loc_12.graphics.endFill();
                        _loc_9 = new BitmapData(_ptPerTile * 2, _ptPerTile, true, 0);
                        _loc_9.draw(_loc_12, _loc_7);
                        _loc_19 = (_loc_25._x - _loc_25._y) * _ptPerTile - _ptPerTile;
                        _loc_20 = (_loc_25._x / 2 + _loc_25._y / 2 - this._exBorder) * _ptPerTile - _ptPerTile / 2;
                        _loc_10.copyPixels(_loc_9, _loc_9.rect, new Point((_loc_19 + _loc_3 * _loc_8) * _loc_5, _loc_20 * _loc_5 + _ptPerTile * _loc_5 / 2), null, null, true);
                    }
                    if (_loc_9 != null)
                    {
                        _loc_9.dispose();
                        _loc_9 = null;
                    }
                    _loc_14 = _loc_14 + 1;
                }
                _loc_13 = _loc_13 + 1;
            }
            _loc_12.graphics.clear();
            _loc_12.graphics.lineStyle(0, param2);
            _loc_12.graphics.moveTo(0, param1 / 2 * _loc_8);
            _loc_12.graphics.lineTo(param1 * _loc_8, 0);
            _loc_12.graphics.lineTo(param1, param1 / 2 * (1 - _loc_8));
            _loc_12.graphics.lineTo(param1 * (1 - _loc_8), param1 / 2);
            _loc_12.graphics.lineTo(0, param1 / 2 * _loc_8);
            _loc_9 = new BitmapData(param1, param1 / 2, true, 0);
            _loc_9.draw(_loc_12);
            _loc_10.copyPixels(_loc_9, _loc_9.rect, Config._point0, null, null, true);
            _loc_9.dispose();
            _loc_10.unlock();
            _loc_12 = null;
            return _loc_10;
        }// end function

        public function getRectTile(param1, param2)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_15:* = NaN;
            var _loc_16:* = NaN;
            var _loc_17:* = undefined;
            var _loc_19:* = undefined;
            var _loc_6:* = Math.min(param1._x, param2._x);
            var _loc_7:* = Math.min(param1._y, param2._y);
            var _loc_8:* = Math.min(param1._y, param2._y) + _loc_6 / 2 - this._mapWidth / 4;
            var _loc_9:* = _loc_7 - _loc_6 / 2;
            var _loc_10:* = {_x:_loc_8 + this._x, _y:_loc_9 + this._y};
            _loc_10 = this.mapToTile(_loc_10);
            var _loc_11:* = Math.ceil(Math.abs(param2._x - param1._x) / (_ptPerTile / 2)) + 4;
            var _loc_12:* = Math.ceil(Math.abs(param2._y - param1._y) / (_ptPerTile / 2)) + 2;
            var _loc_13:* = _loc_10._x - 1;
            var _loc_14:* = _loc_10._y;
            var _loc_18:* = [];
            _loc_3 = 0;
            while (_loc_3 < _loc_11)
            {
                
                _loc_4 = 0;
                while (_loc_4 < _loc_12)
                {
                    
                    _loc_15 = _loc_13 + _loc_4 + _loc_3 / 2 - _loc_3 % 2 / 2;
                    _loc_16 = _loc_14 + _loc_4 - _loc_3 / 2 - _loc_3 % 2 / 2;
                    if (_loc_15 >= 0 && _loc_15 < this._logicalWidth && (_loc_16 >= 0 && _loc_16 < this._logicalHeight))
                    {
                        _loc_17 = this._logicalTile[_loc_15][_loc_16];
                        _loc_18.push(_loc_17);
                    }
                    _loc_4 = _loc_4 + 1;
                }
                _loc_3 = _loc_3 + 1;
            }
            return _loc_18;
        }// end function

        public function getRandomWalkableTile(param1 = null)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_2:* = [];
            _loc_3 = 0;
            while (_loc_3 < this._logicalTile.length)
            {
                
                _loc_4 = 0;
                while (_loc_4 < this._logicalTile[_loc_3].length)
                {
                    
                    if (this._logicalTile[_loc_3][_loc_4].walkable)
                    {
                        if (Config.eventStack[_loc_3 + "_" + _loc_4] == null && Config.npcStack[_loc_3 + "_" + _loc_4] == null)
                        {
                            _loc_2.push(this._logicalTile[_loc_3][_loc_4]);
                        }
                    }
                    _loc_4 = _loc_4 + 1;
                }
                _loc_3 = _loc_3 + 1;
            }
            var _loc_7:* = 0;
            while (true && _loc_7 < 10)
            {
                
                _loc_5 = Math.floor(Math.random() * _loc_2.length);
                _loc_6 = _loc_2[_loc_5];
                if (param1 == null || this.findPath(param1, _loc_6).length > 0)
                {
                    break;
                }
                else
                {
                    _loc_6 = null;
                    _loc_2.splice(_loc_5, 1);
                }
                _loc_7 = _loc_7 + 1;
            }
            return _loc_6;
        }// end function

        private function fillInnerArea() : void
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_9:* = undefined;
            _loc_1 = this._exBorder;
            while (_loc_1 < this._width)
            {
                
                _loc_2 = this._exBorder;
                while (_loc_2 < this._height)
                {
                    
                    this._tile[_loc_1][_loc_2].fillInnerOpen = false;
                    this._tile[_loc_1][_loc_2].fillInnerClose = false;
                    _loc_2 = _loc_2 + 1;
                }
                _loc_1 = _loc_1 + 1;
            }
            _loc_5 = [];
            _loc_6 = [];
            var _loc_8:* = Config._mapMap[this.id];
            if (Config._mapMap[this.id] == null)
            {
                return;
            }
            if (_loc_8.flagData != null && _loc_8.flagData.data != null)
            {
                if (_loc_8.flagData.data is Array)
                {
                    _loc_1 = 0;
                    while (_loc_1 < _loc_8.flagData.data.length)
                    {
                        
                        _loc_9 = _loc_8.flagData.data[_loc_1];
                        if (!this._logicalTile[Number(_loc_9.x)][Number(_loc_9.y)]._parentTile.fillInnerOpen)
                        {
                            _loc_6.push(this._logicalTile[Number(_loc_9.x)][Number(_loc_9.y)]._parentTile);
                            this._logicalTile[Number(_loc_9.x)][Number(_loc_9.y)]._parentTile.fillInnerOpen = true;
                        }
                        _loc_1 = _loc_1 + 1;
                    }
                }
                else
                {
                    _loc_9 = _loc_8.flagData.data;
                    if (!this._logicalTile[Number(_loc_9.x)][Number(_loc_9.y)]._parentTile.fillInnerOpen)
                    {
                        _loc_6.push(this._logicalTile[Number(_loc_9.x)][Number(_loc_9.y)]._parentTile);
                        this._logicalTile[Number(_loc_9.x)][Number(_loc_9.y)]._parentTile.fillInnerOpen = true;
                    }
                }
            }
            _loc_5 = _loc_6.concat();
            while (_loc_6.length > 0)
            {
                
                _loc_7 = [];
                _loc_1 = 0;
                while (_loc_1 < _loc_6.length)
                {
                    
                    _loc_7 = _loc_7.concat(this.getNear(_loc_6[_loc_1]));
                    _loc_6[_loc_1].fillInnerOpen = true;
                    _loc_1 = _loc_1 + 1;
                }
                _loc_5 = _loc_5.concat(_loc_6);
                _loc_6 = _loc_7;
            }
            _loc_1 = this._exBorder;
            while (_loc_1 < this._width)
            {
                
                _loc_2 = this._exBorder;
                while (_loc_2 < this._height)
                {
                    
                    if (this._tile[_loc_1][_loc_2].fillInnerOpen != true)
                    {
                        if (this._tile[_loc_1][_loc_2]._walkable == 2)
                        {
                            this._tile[_loc_1][_loc_2]._walkable = 0;
                        }
                    }
                    _loc_2 = _loc_2 + 1;
                }
                _loc_1 = _loc_1 + 1;
            }
            return;
        }// end function

        private function getNear(param1:Tile) : Array
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = [];
            _loc_2 = param1._x - 1;
            _loc_3 = param1._y;
            if (_loc_2 >= this._exBorder)
            {
                _loc_4 = this._tile[_loc_2][_loc_3];
                if (_loc_4.fillInnerOpen != true && _loc_4.fillInnerClose != true && _loc_4._walkable == 2)
                {
                    _loc_4.fillInnerClose = true;
                    _loc_5.push(_loc_4);
                }
            }
            _loc_2 = param1._x + 1;
            _loc_3 = param1._y;
            if (_loc_2 < this._width)
            {
                _loc_4 = this._tile[_loc_2][_loc_3];
                if (_loc_4.fillInnerOpen != true && _loc_4.fillInnerClose != true && _loc_4._walkable == 2)
                {
                    _loc_4.fillInnerClose = true;
                    _loc_5.push(_loc_4);
                }
            }
            _loc_2 = param1._x;
            _loc_3 = param1._y - 1;
            if (_loc_3 >= this._exBorder)
            {
                _loc_4 = this._tile[_loc_2][_loc_3];
                if (_loc_4.fillInnerOpen != true && _loc_4.fillInnerClose != true && _loc_4._walkable == 2)
                {
                    _loc_4.fillInnerClose = true;
                    _loc_5.push(_loc_4);
                }
            }
            _loc_2 = param1._x;
            _loc_3 = param1._y + 1;
            if (_loc_3 < this._height)
            {
                _loc_4 = this._tile[_loc_2][_loc_3];
                if (_loc_4.fillInnerOpen != true && _loc_4.fillInnerClose != true && _loc_4._walkable == 2)
                {
                    _loc_4.fillInnerClose = true;
                    _loc_5.push(_loc_4);
                }
            }
            return _loc_5;
        }// end function

        public function getSketch(param1:Shape, param2, param3, param4 = 0)
        {
            var _loc_5:* = new BitmapData(param1.width, param1.height, true, 0);
            new BitmapData(param1.width, param1.height, true, 0).draw(param1);
            var _loc_6:* = new BitmapData(param1.width, param1.height, true, 0);
            var _loc_7:* = new Rectangle(param2, param3, param1.width, param1.height);
            var _loc_8:* = new Point(param2, param3);
            if (param4 == 0 || param4 == 2)
            {
                _loc_6.copyPixels(this._tileBmpd, _loc_7, Config._point0, _loc_5, Config._point0, false);
            }
            if (param4 == 1 || param4 == 2)
            {
                _loc_6.copyPixels(this._tileBmpd, _loc_7, Config._point0, _loc_5, Config._point0, false);
            }
            _loc_5.dispose();
            return _loc_6;
        }// end function

        private static function findPic(param1)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = null;
            if (param1.dir != null)
            {
                return [param1.dir];
            }
            if (param1.pic is Array)
            {
                _loc_3 = [];
                _loc_2 = 0;
                while (_loc_2 < param1.pic.length)
                {
                    
                    _loc_3.push(param1.pic[_loc_2].dir);
                    _loc_2 = _loc_2 + 1;
                }
                return _loc_3;
            }
            else
            {
                return [param1.pic.dir];
            }
        }// end function

        public static function getPart(param1, param2)
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
            var _loc_16:* = undefined;
            var _loc_17:* = undefined;
            var _loc_18:* = undefined;
            var _loc_19:* = [];
            var _loc_20:* = [];
            var _loc_21:* = [];
            var _loc_22:* = [];
            var _loc_23:* = [];
            var _loc_24:* = [];
            _loc_13 = Number(param1.width);
            _loc_14 = Number(param1.height);
            _loc_7 = param1.tileTable.split(",");
            _loc_8 = param1.tileArray.split(",");
            _loc_16 = 0;
            _loc_17 = 0;
            _loc_3 = 0;
            while (_loc_3 < _loc_8.length)
            {
                
                _loc_10 = _loc_8[_loc_3];
                _loc_9 = _loc_10.split(":");
                if (_loc_9.length == 1)
                {
                    if (_loc_16 >= param2.x && _loc_16 < param2.x + param2.width)
                    {
                        if (_loc_17 >= param2.y && _loc_17 < param2.y + param2.height)
                        {
                            if (_loc_10 != "-1")
                            {
                                _loc_23.push(_loc_7[_loc_10]);
                                _loc_18 = true;
                                _loc_5 = 0;
                                while (_loc_5 < _loc_21.length)
                                {
                                    
                                    if (_loc_21[_loc_5] == _loc_7[_loc_10])
                                    {
                                        _loc_18 = false;
                                        break;
                                    }
                                    _loc_5 = _loc_5 + 1;
                                }
                                if (_loc_18)
                                {
                                    _loc_21.push(_loc_7[_loc_10]);
                                }
                                _loc_19.push(_loc_5);
                            }
                            else
                            {
                                _loc_23.push(_loc_10);
                                _loc_19.push(_loc_10);
                            }
                        }
                    }
                    if (++_loc_17 >= _loc_14)
                    {
                        ++_loc_17 = 0;
                        _loc_16 = _loc_16 + 1;
                    }
                }
                else
                {
                    _loc_15 = parseInt(_loc_9[1]);
                    _loc_4 = 0;
                    while (_loc_4 < _loc_15)
                    {
                        
                        if (_loc_16 >= param2.x && _loc_16 < param2.x + param2.width)
                        {
                            if (++_loc_17 >= param2.y && _loc_17 < param2.y + param2.height)
                            {
                                if (_loc_9[0] != "-1")
                                {
                                    _loc_23.push(_loc_7[_loc_9[0]]);
                                    _loc_18 = true;
                                    _loc_5 = 0;
                                    while (_loc_5 < _loc_21.length)
                                    {
                                        
                                        if (_loc_21[_loc_5] == _loc_7[_loc_9[0]])
                                        {
                                            _loc_18 = false;
                                            break;
                                        }
                                        _loc_5 = _loc_5 + 1;
                                    }
                                    if (_loc_18)
                                    {
                                        _loc_21.push(_loc_7[_loc_9[0]]);
                                    }
                                    _loc_19.push(_loc_5);
                                }
                                else
                                {
                                    _loc_23.push(_loc_9[0]);
                                    _loc_19.push(_loc_9[0]);
                                }
                            }
                        }
                        if (++_loc_17 >= _loc_14)
                        {
                            ++_loc_17 = 0;
                            _loc_16 = _loc_16 + 1;
                        }
                        _loc_4 = _loc_4 + 1;
                    }
                }
                _loc_3 = _loc_3 + 1;
            }
            _loc_7 = param1.obstacleTable.split(",");
            _loc_8 = param1.obstacleArray.split(",");
            _loc_16 = 0;
            ++_loc_17 = 0;
            _loc_3 = 0;
            while (_loc_3 < _loc_8.length)
            {
                
                _loc_10 = _loc_8[_loc_3];
                _loc_9 = _loc_10.split(":");
                if (_loc_9.length == 1)
                {
                    if (_loc_16 >= param2.x && _loc_16 < param2.x + param2.width)
                    {
                        if (++_loc_17 >= param2.y && _loc_17 < param2.y + param2.height)
                        {
                            if (_loc_10 != "-1")
                            {
                                _loc_24.push(_loc_7[_loc_10]);
                                _loc_18 = true;
                                _loc_5 = 0;
                                while (_loc_5 < _loc_22.length)
                                {
                                    
                                    if (_loc_22[_loc_5] == _loc_7[_loc_10])
                                    {
                                        _loc_18 = false;
                                        break;
                                    }
                                    _loc_5 = _loc_5 + 1;
                                }
                                if (_loc_18)
                                {
                                    _loc_22.push(_loc_7[_loc_10]);
                                }
                                _loc_20.push(_loc_5);
                            }
                            else
                            {
                                _loc_24.push(_loc_10);
                                _loc_20.push(_loc_10);
                            }
                        }
                    }
                    if (++_loc_17 >= _loc_14)
                    {
                        ++_loc_17 = 0;
                        _loc_16 = _loc_16 + 1;
                    }
                }
                else
                {
                    _loc_15 = parseInt(_loc_9[1]);
                    _loc_4 = 0;
                    while (_loc_4 < _loc_15)
                    {
                        
                        if (_loc_16 >= param2.x && _loc_16 < param2.x + param2.width)
                        {
                            if (++_loc_17 >= param2.y && _loc_17 < param2.y + param2.height)
                            {
                                if (_loc_9[0] != "-1")
                                {
                                    _loc_24.push(_loc_7[_loc_9[0]]);
                                    _loc_18 = true;
                                    _loc_5 = 0;
                                    while (_loc_5 < _loc_22.length)
                                    {
                                        
                                        if (_loc_22[_loc_5] == _loc_7[_loc_9[0]])
                                        {
                                            _loc_18 = false;
                                            break;
                                        }
                                        _loc_5 = _loc_5 + 1;
                                    }
                                    if (_loc_18)
                                    {
                                        _loc_22.push(_loc_7[_loc_9[0]]);
                                    }
                                    _loc_20.push(_loc_5);
                                }
                                else
                                {
                                    _loc_24.push(_loc_9[0]);
                                    _loc_20.push(_loc_9[0]);
                                }
                            }
                        }
                        if (++_loc_17 >= _loc_14)
                        {
                            ++_loc_17 = 0;
                            _loc_16 = _loc_16 + 1;
                        }
                        _loc_4 = _loc_4 + 1;
                    }
                }
                _loc_3 = _loc_3 + 1;
            }
            return {tile:_loc_23, obstacle:_loc_24};
        }// end function

        public static function getBlockMap(param1, param2)
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
            var _loc_16:* = Number(param1.width);
            var _loc_17:* = Number(param1.height);
            var _loc_18:* = [];
            var _loc_19:* = [];
            _loc_3 = 0;
            while (_loc_3 < _loc_16)
            {
                
                _loc_18[_loc_3] = new Array(_loc_17);
                _loc_4 = 0;
                while (_loc_4 < _loc_17)
                {
                    
                    _loc_18[_loc_3][_loc_4] = {x:_loc_3, y:_loc_4, fillInnerOpen:false, fillInnerClose:false};
                    _loc_19.push(_loc_18[_loc_3][_loc_4]);
                    _loc_4 = _loc_4 + 1;
                }
                _loc_3 = _loc_3 + 1;
            }
            _loc_9 = [];
            if (String(param1.tileTable) != "")
            {
                _loc_9 = param1.tileTable.split(",");
            }
            var _loc_20:* = [];
            _loc_3 = 0;
            while (_loc_3 < _loc_9.length)
            {
                
                _loc_20[_loc_3] = Config._tileModel[Number(_loc_9[_loc_3])];
                _loc_3 = _loc_3 + 1;
            }
            _loc_9 = [];
            if (String(param1.obstacleTable) != "")
            {
                _loc_9 = param1.obstacleTable.split(",");
            }
            var _loc_21:* = [];
            _loc_3 = 0;
            while (_loc_3 < _loc_9.length)
            {
                
                _loc_21[_loc_3] = Config._obstacleModel[Number(_loc_9[_loc_3])];
                _loc_3 = _loc_3 + 1;
            }
            var _loc_22:* = [];
            var _loc_23:* = [];
            _loc_9 = param1.tileArray.split(",");
            _loc_3 = 0;
            while (_loc_3 < _loc_9.length)
            {
                
                _loc_10 = _loc_9[_loc_3];
                _loc_7 = _loc_10.split(":");
                if (_loc_7.length == 1)
                {
                    _loc_22.push(_loc_10);
                }
                else
                {
                    _loc_11 = parseInt(_loc_7[1]);
                    _loc_4 = 0;
                    while (_loc_4 < _loc_11)
                    {
                        
                        _loc_22.push(_loc_7[0]);
                        _loc_4 = _loc_4 + 1;
                    }
                }
                _loc_3 = _loc_3 + 1;
            }
            _loc_9 = param1.obstacleArray.split(",");
            _loc_3 = 0;
            while (_loc_3 < _loc_9.length)
            {
                
                _loc_10 = _loc_9[_loc_3];
                _loc_7 = _loc_10.split(":");
                if (_loc_7.length == 1)
                {
                    _loc_23.push(_loc_10);
                }
                else
                {
                    _loc_11 = parseInt(_loc_7[1]);
                    _loc_4 = 0;
                    while (_loc_4 < _loc_11)
                    {
                        
                        _loc_23.push(_loc_7[0]);
                        _loc_4 = _loc_4 + 1;
                    }
                }
                _loc_3 = _loc_3 + 1;
            }
            _loc_3 = 0;
            while (_loc_3 < _loc_19.length)
            {
                
                if (_loc_22.length > 0)
                {
                    _loc_7 = parseInt("" + _loc_22.shift());
                    if (_loc_7 == -1)
                    {
                        _loc_19[_loc_3].w = 0;
                    }
                    else
                    {
                        _loc_19[_loc_3].w = _loc_20[_loc_7].walkable;
                    }
                }
                else
                {
                    _loc_19[_loc_3].w = 2;
                }
                _loc_3 = _loc_3 + 1;
            }
            _loc_3 = 0;
            while (_loc_3 < _loc_19.length)
            {
                
                if (_loc_23.length > 0)
                {
                    _loc_7 = parseInt("" + _loc_23.shift());
                    if (_loc_7 == -1)
                    {
                        _loc_19[_loc_3].w = Math.min(2, _loc_19[_loc_3].w);
                    }
                    else
                    {
                        _loc_12 = Number(_loc_21[_loc_7].width);
                        _loc_13 = Number(_loc_21[_loc_7].height);
                        _loc_14 = String(_loc_21[_loc_7].walkable).split("");
                        _loc_5 = 0;
                        while (_loc_5 < _loc_12)
                        {
                            
                            _loc_6 = 0;
                            while (_loc_6 < _loc_13)
                            {
                                
                                if (_loc_19[_loc_3].x - _loc_5 >= 0 && _loc_19[_loc_3].x - _loc_5 < _loc_16)
                                {
                                    if (_loc_19[_loc_3].y - _loc_6 >= 0 && _loc_19[_loc_3].y - _loc_6 < _loc_17)
                                    {
                                        _loc_18[_loc_19[_loc_3].x - _loc_5][_loc_19[_loc_3].y - _loc_6].w = Math.min(_loc_14[_loc_6 * _loc_12 + _loc_5], _loc_18[_loc_19[_loc_3].x - _loc_5][_loc_19[_loc_3].y - _loc_6].w);
                                    }
                                }
                                _loc_6 = _loc_6 + 1;
                            }
                            _loc_5 = _loc_5 + 1;
                        }
                    }
                }
                else
                {
                    _loc_19[_loc_3].w = Math.min(2, _loc_19[_loc_3].w);
                }
                _loc_3 = _loc_3 + 1;
            }
            severFillInnerArea(_loc_18, param2);
            _loc_3 = 0;
            while (_loc_3 < _loc_19.length)
            {
                
                _loc_19[_loc_3].fillInnerOpen = false;
                _loc_19[_loc_3].fillInnerClose = false;
                _loc_3 = _loc_3 + 1;
            }
            return _loc_18;
        }// end function

        public static function getUnblockArea(param1, param2, param3)
        {
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            _loc_8 = [];
            _loc_9 = [];
            _loc_9.push(param1[param2][param3]);
            param1[param2][param3].fillInnerOpen = true;
            _loc_8 = _loc_9.concat();
            while (_loc_9.length > 0)
            {
                
                _loc_10 = [];
                _loc_4 = 0;
                while (_loc_4 < _loc_9.length)
                {
                    
                    _loc_10 = _loc_10.concat(serverGetNear(_loc_9[_loc_4], param1));
                    _loc_9[_loc_4].fillInnerOpen = true;
                    _loc_4 = _loc_4 + 1;
                }
                _loc_8 = _loc_8.concat(_loc_9);
                _loc_9 = _loc_10;
            }
            return _loc_8;
        }// end function

        private static function severFillInnerArea(param1, param2 = null) : void
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = undefined;
            _loc_3 = 0;
            while (_loc_3 < param1.length)
            {
                
                _loc_4 = 0;
                while (_loc_4 < param1[0].length)
                {
                    
                    param1[_loc_3][_loc_4].fillInnerOpen = false;
                    param1[_loc_3][_loc_4].fillInnerClose = false;
                    _loc_4 = _loc_4 + 1;
                }
                _loc_3 = _loc_3 + 1;
            }
            _loc_7 = [];
            _loc_8 = [];
            if (param2 != null && param2.data != null)
            {
                if (param2.data is Array)
                {
                    _loc_3 = 0;
                    while (_loc_3 < param2.data.length)
                    {
                        
                        _loc_10 = param2.data[_loc_3];
                        if (!param1[Math.floor(Number(_loc_10.x) / 2)][Math.floor(Number(_loc_10.y) / 2)].fillInnerOpen)
                        {
                            _loc_8.push(param1[Math.floor(Number(_loc_10.x) / 2)][Math.floor(Number(_loc_10.y) / 2)]);
                            param1[Math.floor(Number(_loc_10.x) / 2)][Math.floor(Number(_loc_10.y) / 2)].fillInnerOpen = true;
                        }
                        _loc_3 = _loc_3 + 1;
                    }
                }
                else
                {
                    _loc_10 = param2.data;
                    if (!param1[Math.floor(Number(_loc_10.x) / 2)][Math.floor(Number(_loc_10.y) / 2)].fillInnerOpen)
                    {
                        _loc_8.push(param1[Math.floor(Number(_loc_10.x) / 2)][Math.floor(Number(_loc_10.y) / 2)]);
                        param1[Math.floor(Number(_loc_10.x) / 2)][Math.floor(Number(_loc_10.y) / 2)].fillInnerOpen = true;
                    }
                }
            }
            _loc_7 = _loc_8.concat();
            while (_loc_8.length > 0)
            {
                
                _loc_9 = [];
                _loc_3 = 0;
                while (_loc_3 < _loc_8.length)
                {
                    
                    _loc_9 = _loc_9.concat(serverGetNear(_loc_8[_loc_3], param1));
                    _loc_8[_loc_3].fillInnerOpen = true;
                    _loc_3 = _loc_3 + 1;
                }
                _loc_7 = _loc_7.concat(_loc_8);
                _loc_8 = _loc_9;
            }
            _loc_3 = 0;
            while (_loc_3 < param1.length)
            {
                
                _loc_4 = 0;
                while (_loc_4 < param1[0].length)
                {
                    
                    if (param1[_loc_3][_loc_4].fillInnerOpen != true)
                    {
                        if (param1[_loc_3][_loc_4].w == 2)
                        {
                            param1[_loc_3][_loc_4].w = 0;
                        }
                    }
                    _loc_4 = _loc_4 + 1;
                }
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        private static function serverGetNear(param1, param2) : Array
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = [];
            _loc_3 = param1.x - 1;
            _loc_4 = param1.y;
            if (_loc_3 >= 0)
            {
                _loc_5 = param2[_loc_3][_loc_4];
                if (_loc_5.fillInnerOpen != true && _loc_5.fillInnerClose != true && _loc_5.w == 2)
                {
                    _loc_5.fillInnerClose = true;
                    _loc_6.push(_loc_5);
                }
            }
            _loc_3 = param1.x + 1;
            _loc_4 = param1.y;
            if (_loc_3 < param2.length)
            {
                _loc_5 = param2[_loc_3][_loc_4];
                if (_loc_5.fillInnerOpen != true && _loc_5.fillInnerClose != true && _loc_5.w == 2)
                {
                    _loc_5.fillInnerClose = true;
                    _loc_6.push(_loc_5);
                }
            }
            _loc_3 = param1.x;
            if (--param1.y >= 0)
            {
                _loc_5 = param2[_loc_3][--param1.y];
                if (_loc_5.fillInnerOpen != true && _loc_5.fillInnerClose != true && _loc_5.w == 2)
                {
                    _loc_5.fillInnerClose = true;
                    _loc_6.push(_loc_5);
                }
            }
            _loc_3 = param1.x;
            if (++param1.y < param2[0].length)
            {
                _loc_5 = param2[_loc_3][++param1.y];
                if (_loc_5.fillInnerOpen != true && _loc_5.fillInnerClose != true && _loc_5.w == 2)
                {
                    _loc_5.fillInnerClose = true;
                    _loc_6.push(_loc_5);
                }
            }
            return _loc_6;
        }// end function

        public static function xmlToBitmap(param1)
        {
            var i:*;
            var j:*;
            var k:*;
            var l:*;
            var tempArr:*;
            var tempArr1:*;
            var cstr:*;
            var temp:*;
            var loop:*;
            var tileTable:*;
            var obstacleTable:*;
            var arr:*;
            var height:*;
            var totalW:uint;
            var ratio:Number;
            var tempBmpd:BitmapData;
            var rsArr:*;
            var bW:*;
            var bH:*;
            var handlePreLoadComplete:*;
            var loader:BitmapLoader;
            var xml:* = param1;
            handlePreLoadComplete = function (param1 = null) : void
            {
                var _loc_4:* = undefined;
                var _loc_5:* = undefined;
                var _loc_8:* = undefined;
                var _loc_2:* = [];
                var _loc_3:* = [];
                arr = xml.tileArray.split(",");
                i = 0;
                while (i < arr.length)
                {
                    
                    cstr = arr[i];
                    temp = cstr.split(":");
                    if (temp.length == 1)
                    {
                        _loc_2.push(cstr);
                    }
                    else
                    {
                        loop = parseInt(temp[1]);
                        j = 0;
                        while (j < loop)
                        {
                            
                            _loc_2.push(temp[0]);
                            var _loc_10:* = j + 1;
                            j = _loc_10;
                        }
                    }
                    var _loc_10:* = i + 1;
                    i = _loc_10;
                }
                arr = xml.obstacleArray.split(",");
                i = 0;
                while (i < arr.length)
                {
                    
                    cstr = arr[i];
                    temp = cstr.split(":");
                    if (temp.length == 1)
                    {
                        _loc_3.push(cstr);
                    }
                    else
                    {
                        loop = parseInt(temp[1]);
                        j = 0;
                        while (j < loop)
                        {
                            
                            _loc_3.push(temp[0]);
                            var _loc_10:* = j + 1;
                            j = _loc_10;
                        }
                    }
                    var _loc_10:* = i + 1;
                    i = _loc_10;
                }
                var _loc_6:* = 0;
                var _loc_7:* = 0;
                while (_loc_2.length > 0)
                {
                    
                    temp = Number(_loc_2.shift());
                    if (temp != -1)
                    {
                        _loc_4 = Math.round((_loc_6 - _loc_7) * _ptPerTile - _ptPerTile + totalW * ratio);
                        _loc_5 = (_loc_6 / 2 + _loc_7 / 2) * _ptPerTile;
                        tempBmpd = Tileset.toBmp(Config._tileModel[tileTable[Number(temp)]]);
                        i = 0;
                        while (i < rsArr.length)
                        {
                            
                            j = 0;
                            while (j < rsArr[i].length)
                            {
                                
                                rsArr[i][j].copyPixels(tempBmpd, tempBmpd.rect, new Point(_loc_4 - i * 2880, _loc_5 - j * 2880), null, null, true);
                                var _loc_10:* = j + 1;
                                j = _loc_10;
                            }
                            var _loc_10:* = i + 1;
                            i = _loc_10;
                        }
                        tempBmpd.dispose();
                    }
                    if (++_loc_7 >= height)
                    {
                        ++_loc_7 = 0;
                        _loc_6 = _loc_6 + 1;
                    }
                }
                _loc_6 = 0;
                ++_loc_7 = 0;
                while (_loc_3.length > 0)
                {
                    
                    temp = Number(_loc_3.shift());
                    if (temp != -1)
                    {
                        _loc_4 = Math.round((_loc_6 - ++_loc_7) * _ptPerTile - _ptPerTile + totalW * ratio);
                        _loc_5 = (_loc_6 / 2 + _loc_7 / 2) * _ptPerTile;
                        _loc_8 = Config._obstacleModel[obstacleTable[Number(temp)]];
                        tempBmpd = Picset.toBmp(_loc_8);
                        i = 0;
                        while (i < rsArr.length)
                        {
                            
                            j = 0;
                            while (j < rsArr[i].length)
                            {
                                
                                rsArr[i][j].copyPixels(tempBmpd, tempBmpd.rect, new Point(_loc_4 - tempBmpd.width / (Number(_loc_8.width) + Number(_loc_8.height)) * Number(_loc_8.width) + _ptPerTile - i * 2880, _loc_5 - tempBmpd.height + _ptPerTile - j * 2880), null, null, true);
                                var _loc_10:* = j + 1;
                                j = _loc_10;
                            }
                            var _loc_10:* = i + 1;
                            i = _loc_10;
                        }
                        tempBmpd.dispose();
                    }
                    if (++_loc_7 >= height)
                    {
                        ++_loc_7 = 0;
                        _loc_6 = _loc_6 + 1;
                    }
                }
                return;
            }// end function
            ;
            tileTable;
            obstacleTable;
            arr;
            var preLoadArr:*;
            if (String(xml.tileTable).length > 0)
            {
                tempArr = xml.tileTable.split(",");
                i;
                while (i < tempArr.length)
                {
                    
                    if (Config._tileModel[Number(tempArr[i])] != null)
                    {
                        tileTable[i] = Number(tempArr[i]);
                        preLoadArr = preLoadArr.concat(findPic(Config._tileModel[Number(tempArr[i])]));
                    }
                    i = (i + 1);
                }
            }
            if (String(xml.obstacleTable).length > 0)
            {
                tempArr = xml.obstacleTable.split(",");
                i;
                while (i < tempArr.length)
                {
                    
                    if (Config._obstacleModel[Number(tempArr[i])] != null)
                    {
                        obstacleTable[i] = Number(tempArr[i]);
                        preLoadArr = preLoadArr.concat(findPic(Config._obstacleModel[Number(tempArr[i])]));
                    }
                    i = (i + 1);
                }
            }
            var width:* = Number(xml.width);
            height = Number(xml.height);
            totalW = _ptPerTile * (width + height);
            var totalH:* = _ptPerTile * (width + height) / 2;
            ratio = 1 - width / (width + height);
            rsArr;
            i;
            while (i < Math.ceil(totalW / 2880))
            {
                
                rsArr[i] = [];
                j;
                while (j < Math.ceil(totalH / 2880))
                {
                    
                    bW = Math.min(totalW - i * 2880, 2880);
                    bH = Math.min(totalH - j * 2880, 2880);
                    rsArr[i][j] = new BitmapData(bW, bH, true, 0);
                    j = (j + 1);
                }
                i = (i + 1);
            }
            if (arr.length > 0)
            {
                loader = BitmapLoader.newBitmapLoader();
                loader.removeEventListener("complete", handlePreLoadComplete);
                loader.addEventListener("complete", handlePreLoadComplete);
                loader.load(preLoadArr);
            }
            else
            {
                Map.handlePreLoadComplete();
            }
            return rsArr;
        }// end function

    }
}
