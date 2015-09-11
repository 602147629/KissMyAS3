package zpp_nape.geom
{
    import zpp_nape.util.*;

    public class ZPP_Convex extends Object
    {

        public function ZPP_Convex() : void
        {
            return;
        }// end function

        public static function isinner(param1:ZPP_PartitionVertex, param2:ZPP_PartitionVertex, param3:ZPP_PartitionVertex) : Boolean
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            _loc_4 = param1.x - param2.x;
            _loc_5 = param1.y - param2.y;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            _loc_6 = param3.x - param2.x;
            _loc_7 = param3.y - param2.y;
            return _loc_7 * _loc_4 - _loc_6 * _loc_5 >= 0;
        }// end function

        public static function optimise(param1:ZPP_PartitionedPoly) : void
        {
            var _loc_4:* = null as ZPP_PartitionVertex;
            var _loc_5:* = null as ZPP_PartitionVertex;
            var _loc_6:* = null as ZPP_PartitionVertex;
            var _loc_7:* = null as ZNPNode_ZPP_PartitionVertex;
            var _loc_8:* = null as ZNPNode_ZPP_PartitionVertex;
            var _loc_9:* = null as ZPP_PartitionVertex;
            var _loc_10:* = null as ZPP_PartitionVertex;
            var _loc_11:* = false;
            var _loc_12:* = null as ZPP_PartitionVertex;
            var _loc_13:* = null as ZPP_PartitionVertex;
            var _loc_14:* = null as ZNPNode_ZPP_PartitionVertex;
            var _loc_15:* = null as ZNPNode_ZPP_PartitionVertex;
            var _loc_16:* = null as ZPP_PartitionVertex;
            var _loc_17:* = null as ZPP_PartitionVertex;
            var _loc_2:* = param1.vertices;
            var _loc_3:* = param1.vertices;
            if (_loc_2 != null)
            {
                _loc_4 = _loc_2;
                do
                {
                    
                    _loc_5 = _loc_4;
                    _loc_5.sort();
                    _loc_4 = _loc_4.next;
                }while (_loc_4 != _loc_3)
            }
            _loc_2 = param1.vertices;
            _loc_3 = param1.vertices;
            if (_loc_2 != null)
            {
                _loc_4 = _loc_2;
                do
                {
                    
                    _loc_5 = _loc_4;
                    _loc_6 = _loc_5.prev;
                    _loc_7 = null;
                    _loc_8 = _loc_5.diagonals.head;
                    while (_loc_8 != null)
                    {
                        
                        _loc_9 = _loc_8.elt;
                        if (_loc_8.next == null)
                        {
                            _loc_10 = _loc_5.next;
                        }
                        else
                        {
                            _loc_10 = _loc_8.next.elt;
                        }
                        if (!ZPP_Convex.isinner(_loc_10, _loc_5, _loc_6))
                        {
                            _loc_7 = _loc_8;
                            _loc_6 = _loc_9;
                            _loc_8 = _loc_8.next;
                            continue;
                        }
                        _loc_11 = true;
                        _loc_12 = _loc_9;
                        _loc_13 = _loc_12.prev;
                        _loc_14 = null;
                        _loc_15 = _loc_12.diagonals.head;
                        while (_loc_15 != null)
                        {
                            
                            _loc_16 = _loc_15.elt;
                            if (_loc_16 == _loc_5)
                            {
                                if (_loc_15.next == null)
                                {
                                    _loc_17 = _loc_12.next;
                                }
                                else
                                {
                                    _loc_17 = _loc_15.next.elt;
                                }
                                _loc_11 = ZPP_Convex.isinner(_loc_17, _loc_12, _loc_13);
                                break;
                            }
                            _loc_13 = _loc_16;
                            _loc_14 = _loc_15;
                            _loc_15 = _loc_15.next;
                        }
                        if (_loc_11)
                        {
                            _loc_8 = _loc_5.diagonals.erase(_loc_7);
                            _loc_12.diagonals.erase(_loc_14);
                            continue;
                        }
                        _loc_6 = _loc_9;
                        _loc_7 = _loc_8;
                        _loc_8 = _loc_8.next;
                    }
                    _loc_4 = _loc_4.next;
                }while (_loc_4 != _loc_3)
            }
            return;
        }// end function

    }
}
