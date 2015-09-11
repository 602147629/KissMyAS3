package com.dango_itimi.physics
{
    import IMap.*;
    import flash.*;
    import flash.display.*;
    import haxe.ds.*;

    public class FlashToPhysicsObjectParser extends Object
    {
        public var registeredPolygonSet:Array;
        public var registeredCircleSet:Array;
        public var registeredBoxSet:Array;
        public var map:IMap;
        public var anonymousMap:IMap;
        public static var ANONYMOUS_INSTANCE:String;
        public static var ANONYMOUS_INSTANCE_FOR_OPENFL:String;

        public function FlashToPhysicsObjectParser() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            map = new ObjectMap();
            anonymousMap = new ObjectMap();
            registeredBoxSet = [];
            registeredCircleSet = [];
            registeredPolygonSet = [];
            return;
        }// end function

        public function registerInstance(param1:PhysicsObjectType, param2:DisplayObject) : void
        {
            getRegisteredSet(param1).push(param2);
            return;
        }// end function

        public function parse(param1:Class, param2:DisplayObject, param3:IMap, param4:Array) : void
        {
            var _loc_8:* = 0;
            var _loc_9:* = null as DisplayObject;
            var _loc_10:* = null as String;
            var _loc_11:* = null as PhysicsObject;
            var _loc_5:* = param2;
            var _loc_6:* = _loc_5.numChildren;
            var _loc_7:* = 0;
            while (_loc_7 < _loc_6)
            {
                
                _loc_7++;
                _loc_8 = _loc_7;
                _loc_9 = _loc_5.getChildAt(_loc_8);
                if (!(_loc_9 is MovieClip))
                {
                    continue;
                }
                _loc_10 = null;
                _loc_10 = _loc_9.name;
                _loc_11 = Type.createInstance(param1, [_loc_9]);
                if (_loc_10.indexOf("instance") != -1)
                {
                    param4.push(_loc_11);
                    continue;
                }
                param3[_loc_9] = _loc_11;
            }
            return;
        }// end function

        public function getRegisteredSet(param1:PhysicsObjectType) : Array
        {
            switch(param1.index) branch count is:<2>[18, 29, 40] default offset is:<14>;
            ;
            return registeredBoxSet;
            ;
            return registeredCircleSet;
            ;
            return registeredPolygonSet;
            return;
        }// end function

        public function getPhysicsObject(param1:DisplayObject, param2:DisplayObject) : PhysicsObject
        {
            var _loc_3:* = map[param1];
            return _loc_3.get(param2);
        }// end function

        public function getAnonymousPhysicsObjectSet(param1:DisplayObject) : Array
        {
            return anonymousMap[param1];
        }// end function

        public function execute() : void
        {
            createMap(PhysicsObject, registeredBoxSet);
            createMap(PhysicsObject, registeredCircleSet);
            createMap(PhysicsPolygon, registeredPolygonSet);
            return;
        }// end function

        public function createMap(param1:Class, param2:Array) : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = null as DisplayObject;
            var _loc_7:* = null as IMap;
            var _loc_8:* = null as Array;
            var _loc_3:* = 0;
            var _loc_4:* = param2.length;
            while (_loc_3 < _loc_4)
            {
                
                _loc_3++;
                _loc_5 = _loc_3;
                _loc_6 = param2[_loc_5];
                _loc_7 = new ObjectMap();
                map[_loc_6] = _loc_7;
                _loc_8 = [];
                anonymousMap[_loc_6] = _loc_8;
                parse(param1, _loc_6, _loc_7, _loc_8);
            }
            return;
        }// end function

    }
}
