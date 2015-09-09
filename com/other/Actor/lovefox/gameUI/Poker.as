package lovefox.gameUI
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import lovefox.unit.*;

    public class Poker extends Sprite
    {
        private var bmd:BitmapData;
        private var bmd1:BitmapData;
        private var m:Matrix3D;
        private var tm:Matrix3D;
        private var verts:Vector.<Number>;
        private var uvts:Vector.<Number>;
        private var projectedVerts:Vector.<Number>;
        private var tempVerts:Vector.<Number>;
        private var cp:Point;
        private var np:Point;
        private var v3d:Vector3D;
        private var axis:Vector3D;
        private var _ta:Number = 0;
        private var _moveLock:Boolean = false;
        private var _moveObj:Object;
        private var _moveBuff:Array;
        public var _xpos:Object;
        public var _ypos:Object;
        private var _changed:Object = false;
        public var _data:Object;
        public var _info:String = "";
        public var _slot:ButtonSlot;
        public var _txt1:TextField;
        public var _txt2:TextField;
        private var _aBmp:BitmapData;
        private var _aPtArray:Array;
        private var _aCanvas:Sprite;
        private var _count:Object = 20;
        private static var _filters:Object = {};
        private static var _step:uint = 10;
        private static var ct:ColorTransform = new ColorTransform(1, 1, 1, 0.8, 0, 0, 0, 0);

        public function Poker(param1, param2, param3, param4)
        {
            this.m = new Matrix3D();
            this.tm = new Matrix3D();
            this.tempVerts = new Vector.<Number>;
            this.np = new Point();
            this.v3d = new Vector3D();
            this._moveBuff = [];
            this._aPtArray = [];
            this.bmd = param1;
            this.bmd1 = param2;
            this._xpos = param3;
            this._ypos = param4;
            this.mouseChildren = false;
            this.init();
            return;
        }// end function

        public function set baseFiler(param1)
        {
            if (param1 == null)
            {
                if (this.filters.length == 2)
                {
                    this.filters = [this.filters[1]];
                }
            }
            else if (this.filters.length == 2)
            {
                this.filters = [param1, this.filters[1]];
            }
            else if (this.filters.length == 1)
            {
                this.filters = [param1, this.filters[0]];
            }
            return;
        }// end function

        private function getFilter(param1)
        {
            if (_filters[param1] == null)
            {
                _filters[param1] = [new DropShadowFilter(5 * (1 + param1 * 5), 45, 0, 0.5, 5 * (1 + param1 * 5), 5 * (1 + param1 * 5), 1, 3)];
            }
            return _filters[param1];
        }// end function

        public function move(param1, param2 = 0)
        {
            if (this._moveLock)
            {
                this._moveBuff.push({x:param1, initX:x, type:param2});
            }
            else
            {
                this._moveLock = true;
                if (param2 == 1)
                {
                    this.parent.addChild(this);
                }
                this._moveObj = {x:param1, initX:x, type:param2, count:_step};
                removeEventListener(Event.ENTER_FRAME, this.update);
                removeEventListener(Event.ENTER_FRAME, this.delayOver);
                addEventListener(Event.ENTER_FRAME, this.update);
                this.update();
            }
            return;
        }// end function

        private function init()
        {
            this.verts = new Vector.<Number>;
            this.uvts = new Vector.<Number>;
            this.projectedVerts = new Vector.<Number>;
            this.createCube(100, this.verts, this.uvts);
            this.cp = new Point();
            var _loc_1:* = new PerspectiveProjection();
            _loc_1.fieldOfView = 160;
            _loc_1.focalLength = 300;
            this.tm.prepend(_loc_1.toMatrix3D());
            this.tm.prependTranslation(0, 0, 300);
            this.m.appendRotation(90, new Vector3D(1, 0, 0));
            this.m.appendRotation(-90, new Vector3D(0, 1, 0));
            this.m.transformVectors(this.verts, this.tempVerts);
            Utils3D.projectVectors(this.tm, this.tempVerts, this.projectedVerts, this.uvts);
            this.graphics.clear();
            this.graphics.lineStyle(0, 0, 0);
            this.graphics.beginBitmapFill(this.bmd);
            this.graphics.drawTriangles(this.projectedVerts, null, this.uvts, TriangleCulling.POSITIVE);
            this.graphics.beginBitmapFill(this.bmd1);
            this.graphics.drawTriangles(this.projectedVerts, null, this.uvts, TriangleCulling.NEGATIVE);
            this.filters = this.getFilter(0);
            return;
        }// end function

        public function reset()
        {
            if (!this._changed)
            {
                return;
            }
            this._info = "";
            this._changed = false;
            removeEventListener(Event.ENTER_FRAME, this.update);
            removeEventListener(Event.ENTER_FRAME, this.delayOver);
            this._ta = 0;
            this.m = new Matrix3D();
            this.m.appendRotation(90, new Vector3D(1, 0, 0));
            this.m.appendRotation(-90, new Vector3D(0, 1, 0));
            if (this._slot != null && this._slot.parent != null)
            {
                this._slot.parent.removeChild(this._slot);
            }
            if (this._txt1 != null && this._txt1.parent != null)
            {
                this._txt1.parent.removeChild(this._txt1);
            }
            if (this._txt2 != null && this._txt2.parent != null)
            {
                this._txt2.parent.removeChild(this._txt2);
            }
            this.m.transformVectors(this.verts, this.tempVerts);
            Utils3D.projectVectors(this.tm, this.tempVerts, this.projectedVerts, this.uvts);
            this.graphics.clear();
            this.graphics.lineStyle(0, 0, 0);
            this.graphics.beginBitmapFill(this.bmd);
            this.graphics.drawTriangles(this.projectedVerts, null, this.uvts, TriangleCulling.POSITIVE);
            this.graphics.beginBitmapFill(this.bmd1);
            this.graphics.drawTriangles(this.projectedVerts, null, this.uvts, TriangleCulling.NEGATIVE);
            return;
        }// end function

        private function createCube(param1:Number, param2:Vector.<Number>, param3:Vector.<Number>) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = -77 / 2;
            var _loc_6:* = 0;
            var _loc_7:* = 77 / 2;
            var _loc_8:* = 105 / 2;
            var _loc_9:* = -105 / 2;
            var _loc_10:* = 0;
            var _loc_11:* = 1;
            var _loc_12:* = 0;
            var _loc_13:* = 1;
            param2.push(_loc_4, _loc_5, _loc_8, _loc_6, _loc_7, _loc_8, _loc_6, _loc_7, _loc_9, _loc_6, _loc_7, _loc_9, _loc_4, _loc_5, _loc_9, _loc_4, _loc_5, _loc_8);
            param3.push(_loc_10, _loc_12, 0, _loc_11, _loc_12, 0, _loc_11, _loc_13, 0, _loc_11, _loc_13, 0, _loc_10, _loc_13, 0, _loc_10, _loc_12, 0);
            return;
        }// end function

        private function update(event:Event = null) : void
        {
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            var _loc_4:* = undefined;
            this._changed = true;
            if (x != this._moveObj.x)
            {
                x = this._moveObj.initX + (this._moveObj.x - this._moveObj.initX) / _step * ((_step + 1) - this._moveObj.count);
            }
            if (this._moveObj.type == 1)
            {
                this.np.x = mouseX;
                this.np.y = mouseY;
                _loc_2 = Point.distance(this.cp, this.np);
                _loc_3 = -180 / _step;
                this.v3d.x = 1;
                this.v3d.y = 0;
                this.v3d.z = 0;
                this.axis = Vector3D.Z_AXIS.crossProduct(this.v3d);
                this.axis.normalize();
                this.m.appendRotation(_loc_3, this.axis);
                this.m.transformVectors(this.verts, this.tempVerts);
                Utils3D.projectVectors(this.tm, this.tempVerts, this.projectedVerts, this.uvts);
                this._ta = this._ta + _loc_3;
                _loc_4 = int(Math.abs(Math.sin(this._ta / 180 * Math.PI)) * 1000) / 1000;
                this.filters = this.getFilter(_loc_4);
                var _loc_5:* = _loc_4 / 5 + 1;
                this.scaleY = _loc_4 / 5 + 1;
                this.scaleX = _loc_5;
                this.graphics.clear();
                this.graphics.lineStyle(0, 0, 0);
                this.graphics.beginBitmapFill(this.bmd);
                this.graphics.drawTriangles(this.projectedVerts, null, this.uvts, TriangleCulling.POSITIVE);
                this.graphics.beginBitmapFill(this.bmd1);
                this.graphics.drawTriangles(this.projectedVerts, null, this.uvts, TriangleCulling.NEGATIVE);
            }
            var _loc_5:* = this._moveObj;
            var _loc_6:* = this._moveObj.count - 1;
            _loc_5.count = _loc_6;
            if (this._moveObj.count == 0)
            {
                if (this._moveObj.type == 1)
                {
                    if (this._ypos == 2)
                    {
                        Config.ui._fbDetailUI.afterEffect(new Rectangle(x, y, this.bmd.width, this.bmd.height), 16542677);
                    }
                    else
                    {
                        Config.ui._fbDetailUI.afterEffect(new Rectangle(x, y, this.bmd.width, this.bmd.height), 57087);
                    }
                    this.setItemName();
                }
                x = this._moveObj.x;
                removeEventListener(Event.ENTER_FRAME, this.update);
                removeEventListener(Event.ENTER_FRAME, this.delayOver);
                addEventListener(Event.ENTER_FRAME, this.delayOver);
            }
            return;
        }// end function

        private function delayOver(param1)
        {
            var _loc_2:* = undefined;
            removeEventListener(Event.ENTER_FRAME, this.delayOver);
            this._moveLock = false;
            if (this._moveBuff.length > 0)
            {
                _loc_2 = this._moveBuff.shift();
                this.move(_loc_2.x, _loc_2.type);
            }
            return;
        }// end function

        public function setItemName()
        {
            var _loc_4:* = undefined;
            var _loc_5:* = null;
            var _loc_6:* = undefined;
            var _loc_1:* = this._data.itemId;
            var _loc_2:* = this._data.name;
            var _loc_3:* = this._data.count;
            if (_loc_1 != null && _loc_1 != 0)
            {
                _loc_4 = Config._itemMap[_loc_1];
                _loc_5 = Item.newItem(_loc_4, 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 10000);
                this._info = _loc_5.outputInfo();
                _loc_5.destroy();
                _loc_6 = String(_loc_4.icon);
                if (_loc_6.indexOf("|") != -1)
                {
                    _loc_6 = _loc_6.split("|")[0];
                }
                if (this._slot == null)
                {
                    this._slot = new ButtonSlot(32);
                    this._slot.filters = [new GlowFilter(0, 1, 5, 5, 1, 3)];
                }
                addChild(this._slot);
                this._slot.setIcon(_loc_6, true);
                this._slot.x = (-this._slot.width) / 2;
                this._slot.y = -this._slot.height;
                if (this._txt1 == null)
                {
                    this._txt1 = Config.getSimpleTextField();
                    this._txt1.textColor = 16501086;
                }
                addChild(this._txt1);
                this._txt1.wordWrap = false;
                this._txt1.text = "× " + _loc_3;
                this._txt1.x = (-this._txt1.width) / 2;
                this._txt1.y = 2;
            }
            else
            {
                if (this._slot == null)
                {
                    this._slot = new ButtonSlot(32);
                    this._slot.filters = [new GlowFilter(0, 1, 5, 5, 1, 3)];
                }
                addChild(this._slot);
                this._slot.setIcon(null, true);
            }
            if (this._txt2 == null)
            {
                this._txt2 = Config.getSimpleTextField();
                this._txt2.textColor = 16501086;
            }
            addChild(this._txt2);
            this._txt2.htmlText = "<b>" + _loc_2 + "</b>";
            this._txt2.x = (-this._txt2.width) / 2;
            this._txt2.y = 24;
            return;
        }// end function

    }
}
