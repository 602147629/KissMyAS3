package com.dango_itimi.physics
{
    import flash.*;
    import flash.display.*;
    import flash.geom.*;

    public class PhysicsPolygon extends PhysicsObject
    {
        public var vertices:Array;
        public static var VERTEX_MOVIE_CLIP_HEAD_NAME:String;

        public function PhysicsPolygon(param1:MovieClip = undefined) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = null as MovieClip;
            if (Boot.skip_constructor)
            {
                return;
            }
            super(param1);
            vertices = [];
            var _loc_2:* = param1.numChildren;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_3++;
                _loc_4 = _loc_3;
                _loc_5 = param1.getChildByName(PhysicsPolygon.VERTEX_MOVIE_CLIP_HEAD_NAME + _loc_4);
                if (_loc_5 != null)
                {
                    vertices.push(new Point(_loc_5.x, _loc_5.y));
                }
            }
            return;
        }// end function

        override public function toString() : String
        {
            var _loc_4:* = null as Point;
            var _loc_1:* = toString();
            _loc_1 = _loc_1 + "\n{";
            var _loc_2:* = 0;
            var _loc_3:* = vertices;
            while (_loc_2 < _loc_3.length)
            {
                
                _loc_4 = _loc_3[_loc_2];
                _loc_2++;
                _loc_1 = _loc_1 + ("{" + _loc_4.x + ", " + _loc_4.y + "} ");
            }
            _loc_1 = _loc_1 + "}";
            return _loc_1;
        }// end function

    }
}
