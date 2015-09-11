package zpp_nape.geom
{
    import flash.*;
    import nape.*;
    import zpp_nape.util.*;

    public class ZPP_PartitionedPoly extends Object
    {
        public var vertices:ZPP_PartitionVertex;
        public var next:ZPP_PartitionedPoly;
        public static var zpp_pool:ZPP_PartitionedPoly;
        public static var sharedPPList:ZNPList_ZPP_PartitionedPoly;
        public static var sharedGVList:ZNPList_ZPP_GeomVert;

        public function ZPP_PartitionedPoly(param1:ZPP_GeomVert = undefined) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            next = null;
            vertices = null;
            init(param1);
            return;
        }// end function

        public function remove_collinear_vertices() : Boolean
        {
            var _loc_3:* = null as ZPP_PartitionVertex;
            var _loc_4:* = null as ZPP_PartitionVertex;
            var _loc_5:* = false;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_11:* = null as ZPP_PartitionVertex;
            var _loc_1:* = vertices;
            var _loc_2:* = true;
            do
            {
                
                _loc_2 = false;
                if (eq(_loc_1, _loc_1.next))
                {
                    if (_loc_1 == vertices)
                    {
                        vertices = _loc_1.next;
                        _loc_2 = true;
                    }
                    if (_loc_1.forced)
                    {
                        _loc_1.next.forced = true;
                    }
                    if (_loc_1 != null)
                    {
                    }
                    if (_loc_1.prev == _loc_1)
                    {
                        _loc_3 = null;
                        _loc_1.prev = _loc_3;
                        _loc_1.next = _loc_3;
                        _loc_3 = _loc_1;
                        _loc_3.helper = null;
                        _loc_3.next = ZPP_PartitionVertex.zpp_pool;
                        ZPP_PartitionVertex.zpp_pool = _loc_3;
                        _loc_1 = null;
                        _loc_1 = _loc_1;
                    }
                    else
                    {
                        _loc_3 = _loc_1.next;
                        _loc_1.prev.next = _loc_1.next;
                        _loc_1.next.prev = _loc_1.prev;
                        _loc_4 = null;
                        _loc_1.prev = _loc_4;
                        _loc_1.next = _loc_4;
                        _loc_4 = _loc_1;
                        _loc_4.helper = null;
                        _loc_4.next = ZPP_PartitionVertex.zpp_pool;
                        ZPP_PartitionVertex.zpp_pool = _loc_4;
                        _loc_1 = null;
                        _loc_1 = _loc_3;
                    }
                    if (_loc_1 == null)
                    {
                        vertices = null;
                        break;
                    }
                }
                else
                {
                    _loc_1 = _loc_1.next;
                }
                if (!_loc_2)
                {
                }
            }while (_loc_1 != vertices)
            if (vertices == null)
            {
                return true;
            }
            do
            {
                
                _loc_5 = false;
                _loc_1 = vertices;
                _loc_2 = true;
                do
                {
                    
                    _loc_2 = false;
                    _loc_3 = _loc_1.prev;
                    _loc_6 = 0;
                    _loc_7 = 0;
                    _loc_6 = _loc_1.x - _loc_3.x;
                    _loc_7 = _loc_1.y - _loc_3.y;
                    _loc_8 = 0;
                    _loc_9 = 0;
                    _loc_8 = _loc_1.next.x - _loc_1.x;
                    _loc_9 = _loc_1.next.y - _loc_1.y;
                    _loc_10 = _loc_9 * _loc_6 - _loc_8 * _loc_7;
                    if (_loc_10 * _loc_10 >= Config.epsilon * Config.epsilon)
                    {
                        _loc_1 = _loc_1.next;
                    }
                    else
                    {
                        if (_loc_1 == vertices)
                        {
                            vertices = _loc_1.next;
                            _loc_2 = true;
                        }
                        if (_loc_1 != null)
                        {
                        }
                        if (_loc_1.prev == _loc_1)
                        {
                            _loc_4 = null;
                            _loc_1.prev = _loc_4;
                            _loc_1.next = _loc_4;
                            _loc_4 = _loc_1;
                            _loc_4.helper = null;
                            _loc_4.next = ZPP_PartitionVertex.zpp_pool;
                            ZPP_PartitionVertex.zpp_pool = _loc_4;
                            _loc_1 = null;
                            _loc_1 = _loc_1;
                        }
                        else
                        {
                            _loc_4 = _loc_1.next;
                            _loc_1.prev.next = _loc_1.next;
                            _loc_1.next.prev = _loc_1.prev;
                            _loc_11 = null;
                            _loc_1.prev = _loc_11;
                            _loc_1.next = _loc_11;
                            _loc_11 = _loc_1;
                            _loc_11.helper = null;
                            _loc_11.next = ZPP_PartitionVertex.zpp_pool;
                            ZPP_PartitionVertex.zpp_pool = _loc_11;
                            _loc_1 = null;
                            _loc_1 = _loc_4;
                        }
                        _loc_5 = true;
                        if (_loc_1 == null)
                        {
                            _loc_5 = false;
                            vertices = null;
                            break;
                        }
                    }
                    if (!_loc_2)
                    {
                    }
                }while (_loc_1 != vertices)
            }while (_loc_5)
            return vertices == null;
        }// end function

        public function pull_partitions(param1:ZPP_PartitionVertex, param2:ZNPList_ZPP_PartitionedPoly) : ZPP_PartitionVertex
        {
            var _loc_3:* = null as ZPP_PartitionedPoly;
            var _loc_5:* = null as ZPP_PartitionVertex;
            var _loc_6:* = null as ZPP_PartitionVertex;
            var _loc_7:* = null as ZNPList_ZPP_PartitionVertex;
            var _loc_9:* = null as ZPP_PartitionVertex;
            var _loc_10:* = null as ZPP_PartitionVertex;
            if (ZPP_PartitionedPoly.zpp_pool == null)
            {
                _loc_3 = new ZPP_PartitionedPoly();
            }
            else
            {
                _loc_3 = ZPP_PartitionedPoly.zpp_pool;
                ZPP_PartitionedPoly.zpp_pool = _loc_3.next;
                _loc_3.next = null;
            }
            var _loc_4:* = param1;
            do
            {
                
                if (ZPP_PartitionVertex.zpp_pool == null)
                {
                    _loc_6 = new ZPP_PartitionVertex();
                }
                else
                {
                    _loc_6 = ZPP_PartitionVertex.zpp_pool;
                    ZPP_PartitionVertex.zpp_pool = _loc_6.next;
                    _loc_6.next = null;
                }
                _loc_6.x = _loc_4.x;
                _loc_6.y = _loc_4.y;
                _loc_6.forced = _loc_4.forced;
                _loc_5 = _loc_6;
                if (_loc_3.vertices == null)
                {
                    _loc_6 = _loc_5;
                    _loc_5.next = _loc_6;
                    _loc_6 = _loc_6;
                    _loc_5.prev = _loc_6;
                    _loc_3.vertices = _loc_6;
                }
                else
                {
                    _loc_5.prev = _loc_3.vertices;
                    _loc_5.next = _loc_3.vertices.next;
                    _loc_3.vertices.next.prev = _loc_5;
                    _loc_3.vertices.next = _loc_5;
                }
                _loc_3.vertices = _loc_5;
                _loc_3.vertices.forced = _loc_4.forced;
                if (_loc_4.diagonals.head != null)
                {
                    _loc_7 = _loc_4.diagonals;
                    _loc_6 = _loc_7.head.elt;
                    _loc_7.pop();
                    _loc_5 = _loc_6;
                    if (_loc_5 == param1)
                    {
                        break;
                    }
                    else
                    {
                        _loc_4 = pull_partitions(_loc_4, param2);
                    }
                    continue;
                }
                _loc_4 = _loc_4.next;
            }while (_loc_4 != param1)
            var _loc_8:* = 0;
            _loc_5 = _loc_3.vertices;
            _loc_6 = _loc_3.vertices;
            if (_loc_5 != null)
            {
                _loc_9 = _loc_5;
                do
                {
                    
                    _loc_10 = _loc_9;
                    _loc_8 = _loc_8 + _loc_10.x * (_loc_10.next.y - _loc_10.prev.y);
                    _loc_9 = _loc_9.next;
                }while (_loc_9 != _loc_6)
            }
            if (_loc_8 * 0.5 != 0)
            {
                param2.add(_loc_3);
            }
            return _loc_4;
        }// end function

        public function pull(param1:ZPP_PartitionVertex, param2:ZNPList_ZPP_GeomVert) : ZPP_PartitionVertex
        {
            var _loc_5:* = null as ZPP_GeomVert;
            var _loc_6:* = null as ZPP_GeomVert;
            var _loc_7:* = null as ZPP_PartitionVertex;
            var _loc_8:* = null as ZNPList_ZPP_PartitionVertex;
            var _loc_9:* = null as ZPP_PartitionVertex;
            var _loc_11:* = NaN;
            var _loc_12:* = null as ZPP_GeomVert;
            var _loc_13:* = null as ZPP_GeomVert;
            var _loc_14:* = false;
            var _loc_15:* = NaN;
            var _loc_16:* = false;
            var _loc_17:* = NaN;
            var _loc_18:* = NaN;
            var _loc_19:* = NaN;
            var _loc_3:* = null;
            var _loc_4:* = param1;
            do
            {
                
                if (ZPP_GeomVert.zpp_pool == null)
                {
                    _loc_6 = new ZPP_GeomVert();
                }
                else
                {
                    _loc_6 = ZPP_GeomVert.zpp_pool;
                    ZPP_GeomVert.zpp_pool = _loc_6.next;
                    _loc_6.next = null;
                }
                _loc_6.forced = false;
                _loc_6.x = _loc_4.x;
                _loc_6.y = _loc_4.y;
                _loc_5 = _loc_6;
                if (_loc_3 == null)
                {
                    _loc_6 = _loc_5;
                    _loc_5.next = _loc_6;
                    _loc_6 = _loc_6;
                    _loc_5.prev = _loc_6;
                    _loc_3 = _loc_6;
                }
                else
                {
                    _loc_5.prev = _loc_3;
                    _loc_5.next = _loc_3.next;
                    _loc_3.next.prev = _loc_5;
                    _loc_3.next = _loc_5;
                }
                _loc_3 = _loc_5;
                _loc_3.forced = _loc_4.forced;
                if (_loc_4.diagonals.head != null)
                {
                    _loc_8 = _loc_4.diagonals;
                    _loc_9 = _loc_8.head.elt;
                    _loc_8.pop();
                    _loc_7 = _loc_9;
                    if (_loc_7 == param1)
                    {
                        break;
                    }
                    else
                    {
                        _loc_4 = pull(_loc_4, param2);
                    }
                    continue;
                }
                _loc_4 = _loc_4.next;
            }while (_loc_4 != param1)
            _loc_11 = 0;
            _loc_5 = _loc_3;
            _loc_6 = _loc_3;
            if (_loc_5 != null)
            {
                _loc_12 = _loc_5;
                do
                {
                    
                    _loc_13 = _loc_12;
                    _loc_11 = _loc_11 + _loc_13.x * (_loc_13.next.y - _loc_13.prev.y);
                    _loc_12 = _loc_12.next;
                }while (_loc_12 != _loc_6)
            }
            var _loc_10:* = _loc_11 * 0.5;
            if (_loc_10 * _loc_10 >= Config.epsilon * Config.epsilon)
            {
                _loc_5 = _loc_3;
                _loc_14 = true;
                do
                {
                    
                    _loc_14 = false;
                    _loc_11 = 0;
                    _loc_15 = 0;
                    _loc_11 = _loc_5.x - _loc_5.next.x;
                    _loc_15 = _loc_5.y - _loc_5.next.y;
                    if (_loc_11 * _loc_11 + _loc_15 * _loc_15 < Config.epsilon * Config.epsilon)
                    {
                        if (_loc_5 == _loc_3)
                        {
                            _loc_3 = _loc_5.next;
                            _loc_14 = true;
                        }
                        if (_loc_5.forced)
                        {
                            _loc_5.next.forced = true;
                        }
                        if (_loc_5 != null)
                        {
                        }
                        if (_loc_5.prev == _loc_5)
                        {
                            _loc_6 = null;
                            _loc_5.prev = _loc_6;
                            _loc_5.next = _loc_6;
                            _loc_5 = null;
                            _loc_5 = _loc_5;
                        }
                        else
                        {
                            _loc_6 = _loc_5.next;
                            _loc_5.prev.next = _loc_5.next;
                            _loc_5.next.prev = _loc_5.prev;
                            _loc_12 = null;
                            _loc_5.prev = _loc_12;
                            _loc_5.next = _loc_12;
                            _loc_5 = null;
                            _loc_5 = _loc_6;
                        }
                        if (_loc_5 == null)
                        {
                            _loc_3 = null;
                            break;
                        }
                    }
                    else
                    {
                        _loc_5 = _loc_5.next;
                    }
                    if (!_loc_14)
                    {
                    }
                }while (_loc_5 != _loc_3)
                if (_loc_3 != null)
                {
                    do
                    {
                        
                        _loc_16 = false;
                        _loc_5 = _loc_3;
                        _loc_14 = true;
                        do
                        {
                            
                            _loc_14 = false;
                            _loc_6 = _loc_5.prev;
                            _loc_11 = 0;
                            _loc_15 = 0;
                            _loc_11 = _loc_5.x - _loc_6.x;
                            _loc_15 = _loc_5.y - _loc_6.y;
                            _loc_17 = 0;
                            _loc_18 = 0;
                            _loc_17 = _loc_5.next.x - _loc_5.x;
                            _loc_18 = _loc_5.next.y - _loc_5.y;
                            _loc_19 = _loc_18 * _loc_11 - _loc_17 * _loc_15;
                            if (_loc_19 * _loc_19 >= Config.epsilon * Config.epsilon)
                            {
                                _loc_5 = _loc_5.next;
                            }
                            else
                            {
                                if (_loc_5 == _loc_3)
                                {
                                    _loc_3 = _loc_5.next;
                                    _loc_14 = true;
                                }
                                if (_loc_5 != null)
                                {
                                }
                                if (_loc_5.prev == _loc_5)
                                {
                                    _loc_12 = null;
                                    _loc_5.prev = _loc_12;
                                    _loc_5.next = _loc_12;
                                    _loc_5 = null;
                                    _loc_5 = _loc_5;
                                }
                                else
                                {
                                    _loc_12 = _loc_5.next;
                                    _loc_5.prev.next = _loc_5.next;
                                    _loc_5.next.prev = _loc_5.prev;
                                    _loc_13 = null;
                                    _loc_5.prev = _loc_13;
                                    _loc_5.next = _loc_13;
                                    _loc_5 = null;
                                    _loc_5 = _loc_12;
                                }
                                _loc_16 = true;
                                if (_loc_5 == null)
                                {
                                    _loc_16 = false;
                                    _loc_3 = null;
                                    break;
                                }
                            }
                            if (!_loc_14)
                            {
                            }
                        }while (_loc_5 != _loc_3)
                    }while (_loc_16)
                }
                if (_loc_3 != null)
                {
                    param2.add(_loc_3);
                }
            }
            return _loc_4;
        }// end function

        public function init(param1:ZPP_GeomVert = undefined) : void
        {
            var _loc_6:* = null as ZPP_GeomVert;
            var _loc_7:* = null as ZPP_GeomVert;
            var _loc_8:* = null as ZPP_PartitionVertex;
            var _loc_9:* = null as ZPP_PartitionVertex;
            if (param1 == null)
            {
                return;
            }
            var _loc_3:* = 0;
            var _loc_4:* = param1;
            var _loc_5:* = param1;
            if (_loc_4 != null)
            {
                _loc_6 = _loc_4;
                do
                {
                    
                    _loc_7 = _loc_6;
                    _loc_3 = _loc_3 + _loc_7.x * (_loc_7.next.y - _loc_7.prev.y);
                    _loc_6 = _loc_6.next;
                }while (_loc_6 != _loc_5)
            }
            var _loc_2:* = _loc_3 * 0.5 > 0;
            _loc_4 = param1;
            do
            {
                
                if (_loc_2)
                {
                    if (ZPP_PartitionVertex.zpp_pool == null)
                    {
                        _loc_9 = new ZPP_PartitionVertex();
                    }
                    else
                    {
                        _loc_9 = ZPP_PartitionVertex.zpp_pool;
                        ZPP_PartitionVertex.zpp_pool = _loc_9.next;
                        _loc_9.next = null;
                    }
                    _loc_9.x = _loc_4.x;
                    _loc_9.y = _loc_4.y;
                    _loc_8 = _loc_9;
                    if (vertices == null)
                    {
                        _loc_9 = _loc_8;
                        _loc_8.next = _loc_9;
                        _loc_9 = _loc_9;
                        _loc_8.prev = _loc_9;
                        vertices = _loc_9;
                    }
                    else
                    {
                        _loc_8.prev = vertices;
                        _loc_8.next = vertices.next;
                        vertices.next.prev = _loc_8;
                        vertices.next = _loc_8;
                    }
                    vertices = _loc_8;
                }
                else
                {
                    if (ZPP_PartitionVertex.zpp_pool == null)
                    {
                        _loc_9 = new ZPP_PartitionVertex();
                    }
                    else
                    {
                        _loc_9 = ZPP_PartitionVertex.zpp_pool;
                        ZPP_PartitionVertex.zpp_pool = _loc_9.next;
                        _loc_9.next = null;
                    }
                    _loc_9.x = _loc_4.x;
                    _loc_9.y = _loc_4.y;
                    _loc_8 = _loc_9;
                    if (vertices == null)
                    {
                        _loc_9 = _loc_8;
                        _loc_8.next = _loc_9;
                        _loc_9 = _loc_9;
                        _loc_8.prev = _loc_9;
                        vertices = _loc_9;
                    }
                    else
                    {
                        _loc_8.next = vertices;
                        _loc_8.prev = vertices.prev;
                        vertices.prev.next = _loc_8;
                        vertices.prev = _loc_8;
                    }
                    vertices = _loc_8;
                }
                vertices.forced = _loc_4.forced;
                _loc_4 = _loc_4.next;
            }while (_loc_4 != param1)
            remove_collinear_vertices();
            return;
        }// end function

        public function free() : void
        {
            return;
        }// end function

        public function extract_partitions(param1:ZNPList_ZPP_PartitionedPoly = undefined) : ZNPList_ZPP_PartitionedPoly
        {
            var _loc_2:* = null as ZPP_PartitionVertex;
            var _loc_3:* = null as ZPP_PartitionVertex;
            var _loc_4:* = null as ZPP_PartitionVertex;
            var _loc_5:* = null as ZPP_PartitionVertex;
            var _loc_6:* = null as ZNPNode_ZPP_PartitionedPoly;
            var _loc_7:* = null as ZNPNode_ZPP_PartitionedPoly;
            var _loc_8:* = null as ZPP_PartitionedPoly;
            if (param1 == null)
            {
                param1 = new ZNPList_ZPP_PartitionedPoly();
            }
            if (vertices != null)
            {
                _loc_2 = vertices;
                _loc_3 = vertices;
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
                pull_partitions(vertices, param1);
                while (vertices != null)
                {
                    
                    if (vertices != null)
                    {
                    }
                    if (vertices.prev == vertices)
                    {
                        _loc_2 = null;
                        vertices.prev = _loc_2;
                        vertices.next = _loc_2;
                        _loc_2 = vertices;
                        _loc_2.helper = null;
                        _loc_2.next = ZPP_PartitionVertex.zpp_pool;
                        ZPP_PartitionVertex.zpp_pool = _loc_2;
                        _loc_2 = null;
                        vertices = _loc_2;
                        vertices = _loc_2;
                        continue;
                    }
                    _loc_2 = vertices.next;
                    vertices.prev.next = vertices.next;
                    vertices.next.prev = vertices.prev;
                    _loc_3 = null;
                    vertices.prev = _loc_3;
                    vertices.next = _loc_3;
                    _loc_3 = vertices;
                    _loc_3.helper = null;
                    _loc_3.next = ZPP_PartitionVertex.zpp_pool;
                    ZPP_PartitionVertex.zpp_pool = _loc_3;
                    vertices = null;
                    vertices = _loc_2;
                }
                _loc_6 = null;
                _loc_7 = param1.head;
                while (_loc_7 != null)
                {
                    
                    _loc_8 = _loc_7.elt;
                    if (_loc_8.remove_collinear_vertices())
                    {
                        param1.erase(_loc_6);
                        continue;
                    }
                    _loc_6 = _loc_7;
                    _loc_7 = _loc_7.next;
                }
            }
            return param1;
        }// end function

        public function extract(param1:ZNPList_ZPP_GeomVert = undefined) : ZNPList_ZPP_GeomVert
        {
            var _loc_2:* = null as ZPP_PartitionVertex;
            var _loc_3:* = null as ZPP_PartitionVertex;
            var _loc_4:* = null as ZPP_PartitionVertex;
            var _loc_5:* = null as ZPP_PartitionVertex;
            if (param1 == null)
            {
                param1 = new ZNPList_ZPP_GeomVert();
            }
            if (vertices != null)
            {
                _loc_2 = vertices;
                _loc_3 = vertices;
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
                pull(vertices, param1);
                while (vertices != null)
                {
                    
                    if (vertices != null)
                    {
                    }
                    if (vertices.prev == vertices)
                    {
                        _loc_2 = null;
                        vertices.prev = _loc_2;
                        vertices.next = _loc_2;
                        _loc_2 = vertices;
                        _loc_2.helper = null;
                        _loc_2.next = ZPP_PartitionVertex.zpp_pool;
                        ZPP_PartitionVertex.zpp_pool = _loc_2;
                        _loc_2 = null;
                        vertices = _loc_2;
                        vertices = _loc_2;
                        continue;
                    }
                    _loc_2 = vertices.next;
                    vertices.prev.next = vertices.next;
                    vertices.next.prev = vertices.prev;
                    _loc_3 = null;
                    vertices.prev = _loc_3;
                    vertices.next = _loc_3;
                    _loc_3 = vertices;
                    _loc_3.helper = null;
                    _loc_3.next = ZPP_PartitionVertex.zpp_pool;
                    ZPP_PartitionVertex.zpp_pool = _loc_3;
                    vertices = null;
                    vertices = _loc_2;
                }
            }
            return param1;
        }// end function

        public function eq(param1:ZPP_PartitionVertex, param2:ZPP_PartitionVertex) : Boolean
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            _loc_3 = param1.x - param2.x;
            _loc_4 = param1.y - param2.y;
            return _loc_3 * _loc_3 + _loc_4 * _loc_4 < Config.epsilon * Config.epsilon;
        }// end function

        public function alloc() : void
        {
            return;
        }// end function

        public function add_diagonal(param1:ZPP_PartitionVertex, param2:ZPP_PartitionVertex) : void
        {
            param1.diagonals.add(param2);
            param2.diagonals.add(param1);
            var _loc_3:* = true;
            param2.forced = true;
            param1.forced = _loc_3;
            return;
        }// end function

        public static function getSharedPP() : ZNPList_ZPP_PartitionedPoly
        {
            if (ZPP_PartitionedPoly.sharedPPList == null)
            {
                ZPP_PartitionedPoly.sharedPPList = new ZNPList_ZPP_PartitionedPoly();
            }
            return ZPP_PartitionedPoly.sharedPPList;
        }// end function

        public static function getShared() : ZNPList_ZPP_GeomVert
        {
            if (ZPP_PartitionedPoly.sharedGVList == null)
            {
                ZPP_PartitionedPoly.sharedGVList = new ZNPList_ZPP_GeomVert();
            }
            return ZPP_PartitionedPoly.sharedGVList;
        }// end function

    }
}
