package lovefox.gameUI
{
    import com.bit101.components.*;
    import com.fileload.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import lovefox.socket.*;

    public class ZoomMap extends Window
    {
        private var mainpanel:Sprite;
        private var mapmask:Shape;
        private var _openmapid:int = 0;
        private var smapid:int = 0;
        private var zoomload:BulkLoader;
        private var worldmapbtn:PushButton;
        private var landmapbtn:PushButton;
        private var maptip:Sprite;
        private var mapname:Label;
        private var tiplevel:Label;
        private var mapmc:MovieClip;
        private var mapbounds:Rectangle;
        private var mapbox:ComboBox;
        private var mapobj:Object;
        private var loadmc:MovieClip;
        private var loadflag:Boolean = true;
        private var _alertId:uint;

        public function ZoomMap(param1:DisplayObjectContainer)
        {
            super(param1);
            this.setmaparr();
            this.initpanel();
            return;
        }// end function

        private function initpanel() : void
        {
            var _loc_1:* = null;
            this.draggable = false;
            this.mainpanel = new Sprite();
            this.addChild(this.mainpanel);
            this.mapmask = new Shape();
            this.addChild(this.mapmask);
            this.zoomload = new BulkLoader("zoommap");
            this.zoomload.logLevel = BulkLoader.LOG_INFO;
            this.zoomload.add(Config.sourceURL + "stuff/zoommap/load.swf", {id:"load"});
            this.zoomload.addEventListener(BulkLoader.COMPLETE, this.onfileLoaded);
            this.zoomload.addEventListener(BulkLoader.PROGRESS, this.onfileProgress);
            this.zoomload.start();
            _loc_1 = new Shape();
            _loc_1.graphics.beginFill(0, 0.5);
            _loc_1.graphics.drawRect(0, 0, 107, 82);
            _loc_1.graphics.endFill();
            _loc_1.x = 5;
            _loc_1.y = 23;
            this.addChild(_loc_1);
            this.worldmapbtn = new PushButton(this, 8, 26, Config.language("ZoomMap", 1), Config.create(this.changeshow, 1));
            this.worldmapbtn.width = 80;
            this.landmapbtn = new PushButton(this, 8, 53, Config.language("ZoomMap", 2), Config.create(this.changeshow, 0));
            this.landmapbtn.width = 80;
            this.mapbox = new ComboBox(null, 8, 80, this.handleMapCbSelect);
            this.mapbox.editable = false;
            this.maptip = new Sprite();
            this.mapname = new Label(this.maptip, 5, 5);
            this.mapname.textColor = 16777215;
            this.tiplevel = new Label(this.maptip, 5, 25);
            this.tiplevel.textColor = 16763904;
            return;
        }// end function

        private function handleMapCbSelect(param1) : void
        {
            this.moveFly(Number(this.mapbox.selectedItem.data));
            return;
        }// end function

        override public function open(event:MouseEvent = null)
        {
            this.loadzoommap(this.getlandid(Config.map.id));
            super.open();
            trace(Config.map.id);
            return;
        }// end function

        override public function close()
        {
            super.close();
            this.removeallchild(this.mainpanel);
            this.mapmc = null;
            return;
        }// end function

        override public function resize(param1, param2)
        {
            var _loc_3:* = param1;
            var _loc_4:* = param2;
            if (param1 > 950)
            {
                param1 = 950;
            }
            if (param2 > 468)
            {
                param2 = 468;
            }
            super.resize(param1, param2);
            this.x = (_loc_3 - param1) / 2;
            this.y = (_loc_4 - param2) / 2;
            this.mapmask.graphics.clear();
            this.mapmask.graphics.beginFill(16777215);
            this.mapmask.graphics.drawRect(0, 0, this.width - 10, this.height - 10);
            this.mapmask.x = 5;
            this.mapmask.y = 23;
            this.mainpanel.mask = this.mapmask;
            this.setrect();
            return;
        }// end function

        private function setrect() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            if (this.mapmc != null)
            {
                this.mapmc.x = (this.width - this.mapmc.width) / 2;
                this.mapmc.y = 23;
                _loc_1 = this.mapmc.x;
                _loc_2 = this.mapmc.y;
                _loc_3 = 0;
                _loc_4 = 0;
                if (_loc_1 < 0)
                {
                    _loc_1 = _loc_1 * 2;
                    _loc_3 = -_loc_1;
                }
                if (_loc_2 < 25)
                {
                    _loc_2 = 25 - (25 - _loc_2) * 2;
                    _loc_4 = 25 - _loc_2;
                }
                trace(_loc_1, _loc_2, _loc_3, _loc_4);
                this.mapbounds = new Rectangle(_loc_1, _loc_2, _loc_3, _loc_4);
            }
            return;
        }// end function

        private function loadzoommap(param1:int = 0) : void
        {
            switch(param1)
            {
                case 0:
                {
                    this.title = Config.language("ZoomMap", 3);
                    break;
                }
                case 1:
                {
                    this.title = Config.language("ZoomMap", 4);
                    break;
                }
                case 2:
                {
                    this.title = Config.language("ZoomMap", 5);
                    break;
                }
                case 3:
                {
                    this.title = Config.language("ZoomMap", 6);
                    break;
                }
                case 4:
                {
                    this.title = Config.language("ZoomMap", 7);
                    break;
                }
                case 5:
                {
                    this.title = Config.language("ZoomMap", 8);
                    break;
                }
                case 6:
                {
                    this.title = Config.language("ZoomMap", 9);
                    break;
                }
                case 7:
                {
                    this.title = Config.language("ZoomMap", 10);
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (param1 != 0)
            {
                this.smapid = param1;
            }
            this._openmapid = param1;
            this.zoomload.add(Config.sourceURL + "stuff/zoommap/" + param1 + ".swf", {id:String(param1)});
            this.zoomload.start();
            this.zoomload.removeEventListener(BulkLoader.COMPLETE, this.onfileLoaded);
            this.zoomload.removeEventListener(BulkLoader.PROGRESS, this.onfileProgress);
            this.zoomload.addEventListener(BulkLoader.COMPLETE, this.onfileLoaded);
            this.zoomload.addEventListener(BulkLoader.PROGRESS, this.onfileProgress);
            this.showcombobox(param1);
            this.removeallchild(this.mainpanel);
            this.mainpanel.addChild(this.loadmc);
            this.loadmc.x = (this.width - this.loadmc.width) / 2;
            this.loadmc.y = (this.height - this.loadmc.height) / 2;
            return;
        }// end function

        private function showcombobox(param1:int) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            if (param1 != 0)
            {
                this.addChild(this.mapbox);
                this.mapbox.selectedItem = {label:Config.map._data.name, data:Config.map.id};
                _loc_2 = [];
                _loc_3 = 0;
                while (_loc_3 < this.mapobj["arr" + param1].length)
                {
                    
                    if (Config._mapMap[this.mapobj["arr" + param1][_loc_3]] != null)
                    {
                        _loc_2.push({label:Config._mapMap[this.mapobj["arr" + param1][_loc_3]].mapData.name, data:this.mapobj["arr" + param1][_loc_3]});
                    }
                    _loc_3 = _loc_3 + 1;
                }
                this.mapbox.itemArray = _loc_2;
            }
            else if (this.mapbox.parent != null)
            {
                this.removeChild(this.mapbox);
            }
            return;
        }// end function

        private function onfileLoaded(event:BulkProgressEvent) : void
        {
            var tempid:int;
            var headsp:Sprite;
            var headBmp:Bitmap;
            var e:* = event;
            if (this.loadflag)
            {
                this.loadmc = this.zoomload.getMovieClip("load");
                this.loadflag = false;
                return;
            }
            this.zoomload.removeEventListener(BulkLoader.COMPLETE, this.onfileLoaded);
            this.zoomload.removeEventListener(BulkLoader.PROGRESS, this.onfileProgress);
            this.mapmc = this.zoomload.getMovieClip(String(this._openmapid), true);
            if (this.mapmc == null)
            {
                return;
            }
            this.removeallchild(this.mainpanel);
            this.mainpanel.addChild(this.mapmc);
            this.setrect();
            try
            {
                if (this._openmapid == 0)
                {
                    tempid = this.getlandid(Config.map.id);
                }
                else
                {
                    tempid = Config.map.id;
                }
                headsp = new Sprite();
                headBmp = new Bitmap();
                headBmp.smoothing = true;
                headBmp.bitmapData = Config.findHead("b" + ((Player.sex - 1) * 12 + Player.job), 72, 72);
                headBmp.width = 50;
                headBmp.height = 50;
                headsp.filters = [Style.HIGHLIGHT];
                headsp.addChild(headBmp);
                this.mapmc.setbackfuc(this.mcbackfuc, tempid, headsp);
            }
            catch (e:Error)
            {
                trace("调用失败");
            }
            return;
        }// end function

        private function dragfuc(event:MouseEvent, param2:int) : void
        {
            if (this.mapmc == null)
            {
                return;
            }
            if (param2 == 1)
            {
                if (this.width < this.mapmc.width || this.height - 55 - this.mapmc.height < 0)
                {
                    this.mapmc.startDrag(false, this.mapbounds);
                }
                Config.setMouseState("pick", true);
            }
            else
            {
                this.mapmc.stopDrag();
                Config.setMouseState("", true);
            }
            return;
        }// end function

        private function onfileProgress(event:BulkProgressEvent) : void
        {
            if (!this.loadflag)
            {
            }
            return;
        }// end function

        public function set openmapid(param1:int) : void
        {
            this.loadzoommap(param1);
            return;
        }// end function

        private function removeallchild(param1:Sprite) : void
        {
            while (param1.numChildren > 0)
            {
                
                param1.removeChildAt((param1.numChildren - 1));
            }
            param1.graphics.clear();
            return;
        }// end function

        private function mcbackfuc(param1:Object, param2:int) : void
        {
            var _loc_3:* = NaN;
            var _loc_4:* = null;
            if (param2 == 1)
            {
                this.mapname.text = param1.pname;
                if (param1.id < 8)
                {
                    this.tiplevel.text = param1.level;
                }
                else if (param1.level.length <= 1)
                {
                    this.tiplevel.text = Config.language("ZoomMap", 11);
                }
                else
                {
                    this.tiplevel.text = Config.language("ZoomMap", 12, param1.level);
                }
                _loc_3 = Math.max(this.mapname.width, this.tiplevel.width) + 10;
                this.maptip.graphics.clear();
                this.maptip.graphics.lineStyle(1, 0);
                this.maptip.graphics.beginFill(0, 0.8);
                this.maptip.graphics.drawRoundRect(0, 0, _loc_3, 50, 5);
                this.maptip.graphics.endFill();
                this.mapname.x = (this.maptip.width - this.mapname.width) / 2;
                this.tiplevel.x = (this.maptip.width - this.tiplevel.width) / 2;
                Config.ui._layer3.addChild(this.maptip);
                Config.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.resettip);
                Config.stage.addEventListener(MouseEvent.MOUSE_MOVE, this.resettip);
            }
            else if (param2 == 2)
            {
                if (this.maptip.parent != null)
                {
                    Config.ui._layer3.removeChild(this.maptip);
                }
                Config.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.resettip);
            }
            else
            {
                AlertUI.remove(this._alertId);
                if (param1.id < 8)
                {
                    this.loadzoommap(param1.id);
                }
                else
                {
                    if (Config.map._type == 0 || Config.map._type == 1 || Config.map._type == 2 || Config.map._type == 6 || Config.map._type == 10 || Config.map._type == 16 || Config.map._type == 17)
                    {
                    }
                    else
                    {
                        this._alertId = AlertUI.alert(Config.language("ZoomMap", 13), Config.language("ZoomMap", 16), [Config.language("ZoomMap", 15)]);
                        return;
                    }
                    _loc_4 = Config.language("ZoomMap", 22, param1.pname);
                    if (Config._lanVersion == LanVersion.QQ_ZH_CN)
                    {
                        _loc_4 = Config.language("ZoomMap", 24, param1.pname);
                    }
                    this._alertId = AlertUI.alert(Config.language("ZoomMap", 13), _loc_4, [Config.language("ZoomMap", 18), Config.language("ZoomMap", 19), Config.language("ZoomMap", 20)], [Config.create(this.hangmap, param1.id), Config.create(this.flyMap, param1.id)], null);
                }
            }
            return;
        }// end function

        public function moveFly(param1:int, param2:int = 0) : void
        {
            AlertUI.remove(this._alertId);
            if (Config.map._type == 0 || Config.map._type == 1 || Config.map._type == 2 || Config.map._type == 6 || Config.map._type == 10 || Config.map._type == 16 || Config.map._type == 17)
            {
            }
            else
            {
                this._alertId = AlertUI.alert(Config.language("ZoomMap", 13), Config.language("ZoomMap", 16), [Config.language("ZoomMap", 15)]);
                return;
            }
            if (param1 > 1000000000 || Config._giftMap[param1] != null)
            {
                this._alertId = AlertUI.alert(Config.language("ZoomMap", 13), Config.language("ZoomMap", 21), [Config.language("ZoomMap", 15)]);
                return;
            }
            var _loc_3:* = Config.language("ZoomMap", 17, Config._mapMap[DistrictMap.realToMap(param1)].mapData.name);
            if (Config._lanVersion == LanVersion.QQ_ZH_CN)
            {
                _loc_3 = Config.language("ZoomMap", 24, Config._mapMap[DistrictMap.realToMap(param1)].mapData.name);
            }
            if (param2 != 0)
            {
                this._alertId = AlertUI.alert(Config.language("ZoomMap", 13), _loc_3, [Config.language("ZoomMap", 18), Config.language("ZoomMap", 19), Config.language("ZoomMap", 20)], [Config.create(this.hangmapnpc, param2), Config.create(this.enterFlytransp, DistrictMap.realToMap(param1))], null);
            }
            else
            {
                this._alertId = AlertUI.alert(Config.language("ZoomMap", 13), _loc_3, [Config.language("ZoomMap", 18), Config.language("ZoomMap", 19), Config.language("ZoomMap", 20)], [Config.create(this.hangmap, DistrictMap.realToMap(param1)), Config.create(this.flyMap, DistrictMap.realToMap(param1))], null);
            }
            return;
        }// end function

        private function resettip(event:MouseEvent = null) : void
        {
            var _loc_2:* = Config.stage.mouseX + 10;
            var _loc_3:* = Config.stage.mouseY + 10;
            if (_loc_2 + this.maptip.width > Config.stage.stageWidth)
            {
                _loc_2 = Config.stage.mouseX - 10 - 136;
            }
            if (_loc_3 + 10 + 50 > Config.stage.stageHeight)
            {
                _loc_3 = Config.stage.mouseY - 10 - 50;
            }
            this.maptip.x = _loc_2;
            this.maptip.y = _loc_3;
            return;
        }// end function

        private function changeshow(event:MouseEvent, param2:int) : void
        {
            if (param2 == 1)
            {
                this.loadzoommap(0);
            }
            else
            {
                this.loadzoommap(this.getlandid(Config.map.id));
            }
            return;
        }// end function

        private function hangmap(event:MouseEvent, param2:int) : void
        {
            Hang.hangMap(param2);
            this.close();
            return;
        }// end function

        private function hangmapnpc(event:MouseEvent, param2:int) : void
        {
            Hang.hangNpc(param2);
            this.close();
            return;
        }// end function

        public function flyMapAlert(param1)
        {
            if (Config.map._type == 0 || Config.map._type == 1 || Config.map._type == 2 || Config.map._type == 6 || Config.map._type == 10 || Config.map._type == 16 || Config.map._type == 17)
            {
            }
            else
            {
                this._alertId = AlertUI.alert(Config.language("ZoomMap", 13), Config.language("ZoomMap", 16), [Config.language("ZoomMap", 15)]);
                return;
            }
            if (param1 > 1000000000 || Config._giftMap[param1] != null)
            {
                this._alertId = AlertUI.alert(Config.language("ZoomMap", 13), Config.language("ZoomMap", 21), [Config.language("ZoomMap", 15)]);
                return;
            }
            AlertUI.remove(this._alertId);
            var _loc_2:* = Config.language("ZoomMap", 22, Config._mapMap[DistrictMap.realToMap(param1)].mapData.name);
            if (Config._lanVersion == LanVersion.QQ_ZH_CN)
            {
                _loc_2 = Config.language("ZoomMap", 24, Config._mapMap[DistrictMap.realToMap(param1)].mapData.name);
            }
            this._alertId = AlertUI.alert(Config.language("ZoomMap", 13), _loc_2, [Config.language("ZoomMap", 15), Config.language("ZoomMap", 20)], [this.enterFly, null], DistrictMap.realToMap(param1));
            return;
        }// end function

        private function enterFly(param1) : void
        {
            if (param1 == Config.map._id)
            {
                Config.message(Config.language("TaskInforSp", 62));
            }
            else
            {
                this.flyMap(null, param1);
                Config.ui._taskpanel.MapNextFlag = true;
            }
            return;
        }// end function

        private function enterFlytransp(event:MouseEvent, param2)
        {
            if (param2 == Config.map._id)
            {
                Config.message(Config.language("TaskInforSp", 62));
            }
            else
            {
                this.flyMap(null, param2);
                Config.ui._taskpanel.MapNextFlag = true;
            }
            return;
        }// end function

        public function flyMap(event:MouseEvent = null, param2:int = 0) : void
        {
            var _loc_3:* = null;
            if (param2 == Config.map._id)
            {
                Config.message(Config.language("TaskInforSp", 62));
            }
            else
            {
                if (Config.player.boothing)
                {
                    Config.message(Config.language("ZoomMap", 23));
                    return;
                }
                _loc_3 = new DataSet();
                _loc_3.addHead(CONST_ENUM.C2G_USE_TRANSPORT_CRYSTAL);
                _loc_3.add32(param2);
                ClientSocket.send(_loc_3);
                if (this.parent != null)
                {
                    this.close();
                }
            }
            return;
        }// end function

        private function setmaparr() : void
        {
            this.mapobj = new Object();
            this.mapobj.arr1 = [319, 336, 343, 346, 328, 330, 331, 334, 327, 335, 326, 333, 332, 329, 337, 342, 338, 339, 340, 341, 361, 362, 363, 364, 365, 366, 367, 368, 498, 499, 503, 606, 607, 608, 611];
            this.mapobj.arr2 = [344, 351, 352, 345, 347, 349, 348, 350, 413, 414, 415, 416, 417, 418, 419, 420, 421, 422, 423, 625, 626, 609, 610, 623, 624, 627, 628, 629, 630, 631];
            this.mapobj.arr3 = [396, 397, 398, 399, 401, 404, 405, 402, 400, 403, 407, 408, 409, 410, 411, 406, 412, 451, 452, 453, 454, 455, 456, 457, 476, 504, 612, 614, 615, 527];
            this.mapobj.arr4 = [432, 431, 427, 324, 316, 315, 317, 314, 322, 320, 323, 380, 429, 430, 502, 617, 618];
            this.mapobj.arr5 = [464, 600, 602, 470, 466, 467, 468, 469, 471, 472, 656, 601, 604, 605, 603, 766, 767, 768, 770, 771, 772, 776, 777, 657, 914, 915, 916, 917, 918];
            this.mapobj.arr6 = [435, 436, 437, 433, 434, 441, 440, 439, 442, 438, 443, 444, 445, 446, 450, 447, 449, 501, 621, 769];
            this.mapobj.arr7 = [1040, 1041, 1042, 1043, 1044, 1045, 1046, 1037, 1025, 1036, 1029, 1030, 1031, 1032, 1033, 1034, 1035, 1026, 1024, 1023, 1022, 1021, 1027, 1028, 1139, 1038, 1039, 1047, 1130, 1131, 1132, 1133, 1134, 1135, 1136, 1137, 1138];
            return;
        }// end function

        public function getlandid(param1:int) : int
        {
            var _loc_3:* = 0;
            var _loc_2:* = 1;
            while (_loc_2 < 8)
            {
                
                _loc_3 = 0;
                while (_loc_3 < this.mapobj["arr" + _loc_2].length)
                {
                    
                    if (param1 == this.mapobj["arr" + _loc_2][_loc_3])
                    {
                        return _loc_2;
                    }
                    _loc_3 = _loc_3 + 1;
                }
                _loc_2 = _loc_2 + 1;
            }
            return 1;
        }// end function

        public function isDesert(param1)
        {
            if (this.mapobj.arr2.indexOf(param1) != -1)
            {
                return true;
            }
            return false;
        }// end function

        override public function testGuide()
        {
            GuideUI.testDoId(50);
            return;
        }// end function

    }
}
