package zpp_nape.geom
{
    import zpp_nape.util.*;

    public class ZPP_Simple extends Object
    {
        public static var sweep:ZPP_SimpleSweep;
        public static var inthash:FastHash2_Hashable2_Boolfalse;
        public static var vertices:ZPP_Set_ZPP_SimpleVert;
        public static var queue:ZPP_Set_ZPP_SimpleEvent;
        public static var ints:ZPP_Set_ZPP_SimpleEvent;
        public static var list_vertices:ZNPList_ZPP_SimpleVert;
        public static var list_queue:ZNPList_ZPP_SimpleEvent;

        public function ZPP_Simple() : void
        {
            return;
        }// end function

        public static function decompose(param1:ZPP_GeomVert, param2:ZNPList_ZPP_GeomVert = undefined) : ZNPList_ZPP_GeomVert
        {
            var _loc_7:* = null as ZPP_GeomVert;
            var _loc_8:* = null as ZPP_GeomVert;
            var _loc_9:* = null as ZPP_SimpleVert;
            var _loc_10:* = null as ZPP_SimpleVert;
            var _loc_11:* = null as ZPP_Set_ZPP_SimpleVert;
            var _loc_12:* = null as ZPP_Set_ZPP_SimpleVert;
            var _loc_13:* = null as ZPP_SimpleEvent;
            var _loc_14:* = null as ZPP_SimpleEvent;
            var _loc_15:* = null as ZPP_SimpleEvent;
            var _loc_16:* = null as ZPP_SimpleSeg;
            var _loc_17:* = null as ZPP_SimpleSeg;
            var _loc_18:* = null as ZPP_Set_ZPP_SimpleEvent;
            var _loc_19:* = null as ZPP_Set_ZPP_SimpleEvent;
            var _loc_20:* = null as ZPP_Set_ZPP_SimpleEvent;
            var _loc_21:* = null as Hashable2_Boolfalse;
            var _loc_22:* = null as Hashable2_Boolfalse;
            var _loc_23:* = null as ZPP_SimpleEvent;
            var _loc_24:* = null as ZPP_SimpleSeg;
            var _loc_25:* = null as ZPP_SimpleSeg;
            var _loc_26:* = false;
            var _loc_27:* = false;
            var _loc_28:* = false;
            var _loc_29:* = null as ZPP_SimpleVert;
            var _loc_30:* = null as ZPP_Set_ZPP_SimpleSeg;
            var _loc_31:* = null as ZPP_Set_ZPP_SimpleSeg;
            var _loc_34:* = 0;
            var _loc_35:* = null as Hashable2_Boolfalse;
            if (ZPP_Simple.sweep == null)
            {
                ZPP_Simple.sweep = new ZPP_SimpleSweep();
                ZPP_Simple.inthash = new FastHash2_Hashable2_Boolfalse();
            }
            if (ZPP_Simple.vertices == null)
            {
                if (ZPP_Set_ZPP_SimpleVert.zpp_pool == null)
                {
                    ZPP_Simple.vertices = new ZPP_Set_ZPP_SimpleVert();
                }
                else
                {
                    ZPP_Simple.vertices = ZPP_Set_ZPP_SimpleVert.zpp_pool;
                    ZPP_Set_ZPP_SimpleVert.zpp_pool = ZPP_Simple.vertices.next;
                    ZPP_Simple.vertices.next = null;
                }
                ZPP_Simple.vertices.lt = ZPP_SimpleVert.less_xy;
                ZPP_Simple.vertices.swapped = ZPP_SimpleVert.swap_nodes;
            }
            if (ZPP_Simple.queue == null)
            {
                if (ZPP_Set_ZPP_SimpleEvent.zpp_pool == null)
                {
                    ZPP_Simple.queue = new ZPP_Set_ZPP_SimpleEvent();
                }
                else
                {
                    ZPP_Simple.queue = ZPP_Set_ZPP_SimpleEvent.zpp_pool;
                    ZPP_Set_ZPP_SimpleEvent.zpp_pool = ZPP_Simple.queue.next;
                    ZPP_Simple.queue.next = null;
                }
                ZPP_Simple.queue.lt = ZPP_SimpleEvent.less_xy;
                ZPP_Simple.queue.swapped = ZPP_SimpleEvent.swap_nodes;
            }
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = param1;
            var _loc_6:* = param1;
            if (_loc_5 != null)
            {
                _loc_7 = _loc_5;
                do
                {
                    
                    _loc_8 = _loc_7;
                    if (ZPP_SimpleVert.zpp_pool == null)
                    {
                        _loc_10 = new ZPP_SimpleVert();
                    }
                    else
                    {
                        _loc_10 = ZPP_SimpleVert.zpp_pool;
                        ZPP_SimpleVert.zpp_pool = _loc_10.next;
                        _loc_10.next = null;
                    }
                    _loc_10.x = _loc_8.x;
                    _loc_10.y = _loc_8.y;
                    _loc_9 = _loc_10;
                    _loc_12 = ZPP_Simple.vertices.parent;
                    while (_loc_12 != null)
                    {
                        
                        if (ZPP_Simple.vertices.lt(_loc_9, _loc_12.data))
                        {
                            _loc_12 = _loc_12.prev;
                            continue;
                        }
                        if (ZPP_Simple.vertices.lt(_loc_12.data, _loc_9))
                        {
                            _loc_12 = _loc_12.next;
                            continue;
                        }
                        break;
                    }
                    _loc_11 = _loc_12;
                    if (_loc_11 != null)
                    {
                        _loc_10 = _loc_9;
                        _loc_10.links.clear();
                        _loc_10.node = null;
                        _loc_10.forced = false;
                        _loc_10.next = ZPP_SimpleVert.zpp_pool;
                        ZPP_SimpleVert.zpp_pool = _loc_10;
                        _loc_9 = _loc_11.data;
                    }
                    else
                    {
                        _loc_9.node = ZPP_Simple.vertices.insert(_loc_9);
                    }
                    if (_loc_4 != null)
                    {
                        if (ZPP_SimpleEvent.zpp_pool == null)
                        {
                            _loc_14 = new ZPP_SimpleEvent();
                        }
                        else
                        {
                            _loc_14 = ZPP_SimpleEvent.zpp_pool;
                            ZPP_SimpleEvent.zpp_pool = _loc_14.next;
                            _loc_14.next = null;
                        }
                        _loc_14.vertex = _loc_4;
                        _loc_13 = _loc_14;
                        if (ZPP_SimpleEvent.zpp_pool == null)
                        {
                            _loc_15 = new ZPP_SimpleEvent();
                        }
                        else
                        {
                            _loc_15 = ZPP_SimpleEvent.zpp_pool;
                            ZPP_SimpleEvent.zpp_pool = _loc_15.next;
                            _loc_15.next = null;
                        }
                        _loc_15.vertex = _loc_9;
                        _loc_14 = _loc_15;
                        if (ZPP_SimpleEvent.less_xy(_loc_13, _loc_14))
                        {
                            _loc_13.type = 1;
                            _loc_14.type = 2;
                            _loc_16 = ZPP_SimpleSeg.get(_loc_4, _loc_9);
                        }
                        else
                        {
                            _loc_13.type = 2;
                            _loc_14.type = 1;
                            _loc_16 = ZPP_SimpleSeg.get(_loc_9, _loc_4);
                        }
                        _loc_17 = _loc_16;
                        _loc_14.segment = _loc_17;
                        _loc_13.segment = _loc_17;
                        ZPP_Simple.queue.insert(_loc_13);
                        ZPP_Simple.queue.insert(_loc_14);
                        _loc_4.links.insert(_loc_9);
                        _loc_9.links.insert(_loc_4);
                    }
                    _loc_4 = _loc_9;
                    if (_loc_3 == null)
                    {
                        _loc_3 = _loc_9;
                    }
                    _loc_7 = _loc_7.next;
                }while (_loc_7 != _loc_6)
            }
            if (ZPP_SimpleEvent.zpp_pool == null)
            {
                _loc_14 = new ZPP_SimpleEvent();
            }
            else
            {
                _loc_14 = ZPP_SimpleEvent.zpp_pool;
                ZPP_SimpleEvent.zpp_pool = _loc_14.next;
                _loc_14.next = null;
            }
            _loc_14.vertex = _loc_4;
            _loc_13 = _loc_14;
            if (ZPP_SimpleEvent.zpp_pool == null)
            {
                _loc_15 = new ZPP_SimpleEvent();
            }
            else
            {
                _loc_15 = ZPP_SimpleEvent.zpp_pool;
                ZPP_SimpleEvent.zpp_pool = _loc_15.next;
                _loc_15.next = null;
            }
            _loc_15.vertex = _loc_3;
            _loc_14 = _loc_15;
            if (ZPP_SimpleEvent.less_xy(_loc_13, _loc_14))
            {
                _loc_13.type = 1;
                _loc_14.type = 2;
                _loc_16 = ZPP_SimpleSeg.get(_loc_4, _loc_3);
            }
            else
            {
                _loc_13.type = 2;
                _loc_14.type = 1;
                _loc_16 = ZPP_SimpleSeg.get(_loc_3, _loc_4);
            }
            _loc_17 = _loc_16;
            _loc_14.segment = _loc_17;
            _loc_13.segment = _loc_17;
            ZPP_Simple.queue.insert(_loc_13);
            ZPP_Simple.queue.insert(_loc_14);
            _loc_4.links.insert(_loc_3);
            _loc_3.links.insert(_loc_4);
            if (ZPP_Simple.ints == null)
            {
                if (ZPP_Set_ZPP_SimpleEvent.zpp_pool == null)
                {
                    ZPP_Simple.ints = new ZPP_Set_ZPP_SimpleEvent();
                }
                else
                {
                    ZPP_Simple.ints = ZPP_Set_ZPP_SimpleEvent.zpp_pool;
                    ZPP_Set_ZPP_SimpleEvent.zpp_pool = ZPP_Simple.ints.next;
                    ZPP_Simple.ints.next = null;
                }
                ZPP_Simple.ints.lt = ZPP_SimpleEvent.less_xy;
            }
            while (!ZPP_Simple.queue.empty())
            {
                
                _loc_13 = ZPP_Simple.queue.pop_front();
                ZPP_Simple.sweep.sweepx = _loc_13.vertex.x;
                if (_loc_13.type == 1)
                {
                    _loc_16 = _loc_13.segment;
                    ZPP_Simple.sweep.add(_loc_16);
                    if (_loc_16.next != null)
                    {
                    }
                    if (_loc_16 != null)
                    {
                    }
                    if (!(_loc_16.next.id < _loc_16.id ? (ZPP_Simple.inthash.has(_loc_16.next.id, _loc_16.id)) : (ZPP_Simple.inthash.has(_loc_16.id, _loc_16.next.id))))
                    {
                        _loc_14 = ZPP_Simple.sweep.intersection(_loc_16.next, _loc_16);
                        if (_loc_14 != null)
                        {
                            if (_loc_14.vertex.x >= ZPP_Simple.sweep.sweepx)
                            {
                                _loc_19 = ZPP_Simple.queue.parent;
                                while (_loc_19 != null)
                                {
                                    
                                    if (ZPP_Simple.queue.lt(_loc_14, _loc_19.data))
                                    {
                                        _loc_19 = _loc_19.prev;
                                        continue;
                                    }
                                    if (ZPP_Simple.queue.lt(_loc_19.data, _loc_14))
                                    {
                                        _loc_19 = _loc_19.next;
                                        continue;
                                    }
                                    break;
                                }
                                _loc_18 = _loc_19;
                                if (_loc_18 == null)
                                {
                                    _loc_20 = ZPP_Simple.ints.parent;
                                    while (_loc_20 != null)
                                    {
                                        
                                        if (ZPP_Simple.ints.lt(_loc_14, _loc_20.data))
                                        {
                                            _loc_20 = _loc_20.prev;
                                            continue;
                                        }
                                        if (ZPP_Simple.ints.lt(_loc_20.data, _loc_14))
                                        {
                                            _loc_20 = _loc_20.next;
                                            continue;
                                        }
                                        break;
                                    }
                                    _loc_19 = _loc_20;
                                    if (_loc_19 != null)
                                    {
                                        _loc_9 = _loc_14.vertex;
                                        _loc_9.links.clear();
                                        _loc_9.node = null;
                                        _loc_9.forced = false;
                                        _loc_9.next = ZPP_SimpleVert.zpp_pool;
                                        ZPP_SimpleVert.zpp_pool = _loc_9;
                                        _loc_14.vertex = _loc_19.data.vertex;
                                        _loc_19.data = _loc_14;
                                        ZPP_Simple.queue.insert(_loc_14);
                                    }
                                    else
                                    {
                                        ZPP_Simple.queue.insert(_loc_14);
                                        ZPP_Simple.ints.insert(_loc_14);
                                    }
                                    if (_loc_16.next.id < _loc_16.id)
                                    {
                                        if (Hashable2_Boolfalse.zpp_pool == null)
                                        {
                                            _loc_22 = new Hashable2_Boolfalse();
                                        }
                                        else
                                        {
                                            _loc_22 = Hashable2_Boolfalse.zpp_pool;
                                            Hashable2_Boolfalse.zpp_pool = _loc_22.next;
                                            _loc_22.next = null;
                                        }
                                        _loc_22.id = _loc_16.next.id;
                                        _loc_22.di = _loc_16.id;
                                        _loc_21 = _loc_22;
                                        _loc_21.value = true;
                                        ZPP_Simple.inthash.add(_loc_21);
                                    }
                                    else
                                    {
                                        if (Hashable2_Boolfalse.zpp_pool == null)
                                        {
                                            _loc_22 = new Hashable2_Boolfalse();
                                        }
                                        else
                                        {
                                            _loc_22 = Hashable2_Boolfalse.zpp_pool;
                                            Hashable2_Boolfalse.zpp_pool = _loc_22.next;
                                            _loc_22.next = null;
                                        }
                                        _loc_22.id = _loc_16.id;
                                        _loc_22.di = _loc_16.next.id;
                                        _loc_21 = _loc_22;
                                        _loc_21.value = true;
                                        ZPP_Simple.inthash.add(_loc_21);
                                    }
                                }
                                else
                                {
                                    _loc_15 = _loc_18.data;
                                    if (_loc_15.segment == _loc_14.segment)
                                    {
                                    }
                                    if (_loc_14.segment2 != _loc_15.segment2)
                                    {
                                        throw "corner case 2, shiiiit.";
                                    }
                                    _loc_9 = _loc_14.vertex;
                                    _loc_9.links.clear();
                                    _loc_9.node = null;
                                    _loc_9.forced = false;
                                    _loc_9.next = ZPP_SimpleVert.zpp_pool;
                                    ZPP_SimpleVert.zpp_pool = _loc_9;
                                    _loc_23 = _loc_14;
                                    _loc_23.vertex = null;
                                    _loc_17 = null;
                                    _loc_23.segment2 = _loc_17;
                                    _loc_23.segment = _loc_17;
                                    _loc_23.node = null;
                                    _loc_23.next = ZPP_SimpleEvent.zpp_pool;
                                    ZPP_SimpleEvent.zpp_pool = _loc_23;
                                }
                            }
                            else
                            {
                                _loc_9 = _loc_14.vertex;
                                _loc_9.links.clear();
                                _loc_9.node = null;
                                _loc_9.forced = false;
                                _loc_9.next = ZPP_SimpleVert.zpp_pool;
                                ZPP_SimpleVert.zpp_pool = _loc_9;
                                _loc_15 = _loc_14;
                                _loc_15.vertex = null;
                                _loc_17 = null;
                                _loc_15.segment2 = _loc_17;
                                _loc_15.segment = _loc_17;
                                _loc_15.node = null;
                                _loc_15.next = ZPP_SimpleEvent.zpp_pool;
                                ZPP_SimpleEvent.zpp_pool = _loc_15;
                            }
                        }
                    }
                    if (_loc_16 != null)
                    {
                    }
                    if (_loc_16.prev != null)
                    {
                    }
                    if (!(_loc_16.id < _loc_16.prev.id ? (ZPP_Simple.inthash.has(_loc_16.id, _loc_16.prev.id)) : (ZPP_Simple.inthash.has(_loc_16.prev.id, _loc_16.id))))
                    {
                        _loc_14 = ZPP_Simple.sweep.intersection(_loc_16, _loc_16.prev);
                        if (_loc_14 != null)
                        {
                            if (_loc_14.vertex.x >= ZPP_Simple.sweep.sweepx)
                            {
                                _loc_19 = ZPP_Simple.queue.parent;
                                while (_loc_19 != null)
                                {
                                    
                                    if (ZPP_Simple.queue.lt(_loc_14, _loc_19.data))
                                    {
                                        _loc_19 = _loc_19.prev;
                                        continue;
                                    }
                                    if (ZPP_Simple.queue.lt(_loc_19.data, _loc_14))
                                    {
                                        _loc_19 = _loc_19.next;
                                        continue;
                                    }
                                    break;
                                }
                                _loc_18 = _loc_19;
                                if (_loc_18 == null)
                                {
                                    _loc_20 = ZPP_Simple.ints.parent;
                                    while (_loc_20 != null)
                                    {
                                        
                                        if (ZPP_Simple.ints.lt(_loc_14, _loc_20.data))
                                        {
                                            _loc_20 = _loc_20.prev;
                                            continue;
                                        }
                                        if (ZPP_Simple.ints.lt(_loc_20.data, _loc_14))
                                        {
                                            _loc_20 = _loc_20.next;
                                            continue;
                                        }
                                        break;
                                    }
                                    _loc_19 = _loc_20;
                                    if (_loc_19 != null)
                                    {
                                        _loc_9 = _loc_14.vertex;
                                        _loc_9.links.clear();
                                        _loc_9.node = null;
                                        _loc_9.forced = false;
                                        _loc_9.next = ZPP_SimpleVert.zpp_pool;
                                        ZPP_SimpleVert.zpp_pool = _loc_9;
                                        _loc_14.vertex = _loc_19.data.vertex;
                                        _loc_19.data = _loc_14;
                                        ZPP_Simple.queue.insert(_loc_14);
                                    }
                                    else
                                    {
                                        ZPP_Simple.queue.insert(_loc_14);
                                        ZPP_Simple.ints.insert(_loc_14);
                                    }
                                    if (_loc_16.id < _loc_16.prev.id)
                                    {
                                        if (Hashable2_Boolfalse.zpp_pool == null)
                                        {
                                            _loc_22 = new Hashable2_Boolfalse();
                                        }
                                        else
                                        {
                                            _loc_22 = Hashable2_Boolfalse.zpp_pool;
                                            Hashable2_Boolfalse.zpp_pool = _loc_22.next;
                                            _loc_22.next = null;
                                        }
                                        _loc_22.id = _loc_16.id;
                                        _loc_22.di = _loc_16.prev.id;
                                        _loc_21 = _loc_22;
                                        _loc_21.value = true;
                                        ZPP_Simple.inthash.add(_loc_21);
                                    }
                                    else
                                    {
                                        if (Hashable2_Boolfalse.zpp_pool == null)
                                        {
                                            _loc_22 = new Hashable2_Boolfalse();
                                        }
                                        else
                                        {
                                            _loc_22 = Hashable2_Boolfalse.zpp_pool;
                                            Hashable2_Boolfalse.zpp_pool = _loc_22.next;
                                            _loc_22.next = null;
                                        }
                                        _loc_22.id = _loc_16.prev.id;
                                        _loc_22.di = _loc_16.id;
                                        _loc_21 = _loc_22;
                                        _loc_21.value = true;
                                        ZPP_Simple.inthash.add(_loc_21);
                                    }
                                }
                                else
                                {
                                    _loc_15 = _loc_18.data;
                                    if (_loc_15.segment == _loc_14.segment)
                                    {
                                    }
                                    if (_loc_14.segment2 != _loc_15.segment2)
                                    {
                                        throw "corner case 2, shiiiit.";
                                    }
                                    _loc_9 = _loc_14.vertex;
                                    _loc_9.links.clear();
                                    _loc_9.node = null;
                                    _loc_9.forced = false;
                                    _loc_9.next = ZPP_SimpleVert.zpp_pool;
                                    ZPP_SimpleVert.zpp_pool = _loc_9;
                                    _loc_23 = _loc_14;
                                    _loc_23.vertex = null;
                                    _loc_17 = null;
                                    _loc_23.segment2 = _loc_17;
                                    _loc_23.segment = _loc_17;
                                    _loc_23.node = null;
                                    _loc_23.next = ZPP_SimpleEvent.zpp_pool;
                                    ZPP_SimpleEvent.zpp_pool = _loc_23;
                                }
                            }
                            else
                            {
                                _loc_9 = _loc_14.vertex;
                                _loc_9.links.clear();
                                _loc_9.node = null;
                                _loc_9.forced = false;
                                _loc_9.next = ZPP_SimpleVert.zpp_pool;
                                ZPP_SimpleVert.zpp_pool = _loc_9;
                                _loc_15 = _loc_14;
                                _loc_15.vertex = null;
                                _loc_17 = null;
                                _loc_15.segment2 = _loc_17;
                                _loc_15.segment = _loc_17;
                                _loc_15.node = null;
                                _loc_15.next = ZPP_SimpleEvent.zpp_pool;
                                ZPP_SimpleEvent.zpp_pool = _loc_15;
                            }
                        }
                    }
                }
                else if (_loc_13.type == 2)
                {
                    _loc_16 = _loc_13.segment;
                    if (_loc_16.node != null)
                    {
                        _loc_17 = _loc_16.next;
                        _loc_24 = _loc_16.prev;
                        ZPP_Simple.sweep.remove(_loc_16);
                        _loc_25 = _loc_16;
                        _loc_9 = null;
                        _loc_25.right = _loc_9;
                        _loc_25.left = _loc_9;
                        _loc_25.prev = null;
                        _loc_25.node = null;
                        _loc_25.vertices.clear();
                        _loc_25.next = ZPP_SimpleSeg.zpp_pool;
                        ZPP_SimpleSeg.zpp_pool = _loc_25;
                        if (_loc_17 != null)
                        {
                        }
                        if (_loc_24 != null)
                        {
                        }
                        if (!(_loc_17.id < _loc_24.id ? (ZPP_Simple.inthash.has(_loc_17.id, _loc_24.id)) : (ZPP_Simple.inthash.has(_loc_24.id, _loc_17.id))))
                        {
                            _loc_14 = ZPP_Simple.sweep.intersection(_loc_17, _loc_24);
                            if (_loc_14 != null)
                            {
                                if (_loc_14.vertex.x >= ZPP_Simple.sweep.sweepx)
                                {
                                    _loc_19 = ZPP_Simple.queue.parent;
                                    while (_loc_19 != null)
                                    {
                                        
                                        if (ZPP_Simple.queue.lt(_loc_14, _loc_19.data))
                                        {
                                            _loc_19 = _loc_19.prev;
                                            continue;
                                        }
                                        if (ZPP_Simple.queue.lt(_loc_19.data, _loc_14))
                                        {
                                            _loc_19 = _loc_19.next;
                                            continue;
                                        }
                                        break;
                                    }
                                    _loc_18 = _loc_19;
                                    if (_loc_18 == null)
                                    {
                                        _loc_20 = ZPP_Simple.ints.parent;
                                        while (_loc_20 != null)
                                        {
                                            
                                            if (ZPP_Simple.ints.lt(_loc_14, _loc_20.data))
                                            {
                                                _loc_20 = _loc_20.prev;
                                                continue;
                                            }
                                            if (ZPP_Simple.ints.lt(_loc_20.data, _loc_14))
                                            {
                                                _loc_20 = _loc_20.next;
                                                continue;
                                            }
                                            break;
                                        }
                                        _loc_19 = _loc_20;
                                        if (_loc_19 != null)
                                        {
                                            _loc_9 = _loc_14.vertex;
                                            _loc_9.links.clear();
                                            _loc_9.node = null;
                                            _loc_9.forced = false;
                                            _loc_9.next = ZPP_SimpleVert.zpp_pool;
                                            ZPP_SimpleVert.zpp_pool = _loc_9;
                                            _loc_14.vertex = _loc_19.data.vertex;
                                            _loc_19.data = _loc_14;
                                            ZPP_Simple.queue.insert(_loc_14);
                                        }
                                        else
                                        {
                                            ZPP_Simple.queue.insert(_loc_14);
                                            ZPP_Simple.ints.insert(_loc_14);
                                        }
                                        if (_loc_17.id < _loc_24.id)
                                        {
                                            if (Hashable2_Boolfalse.zpp_pool == null)
                                            {
                                                _loc_22 = new Hashable2_Boolfalse();
                                            }
                                            else
                                            {
                                                _loc_22 = Hashable2_Boolfalse.zpp_pool;
                                                Hashable2_Boolfalse.zpp_pool = _loc_22.next;
                                                _loc_22.next = null;
                                            }
                                            _loc_22.id = _loc_17.id;
                                            _loc_22.di = _loc_24.id;
                                            _loc_21 = _loc_22;
                                            _loc_21.value = true;
                                            ZPP_Simple.inthash.add(_loc_21);
                                        }
                                        else
                                        {
                                            if (Hashable2_Boolfalse.zpp_pool == null)
                                            {
                                                _loc_22 = new Hashable2_Boolfalse();
                                            }
                                            else
                                            {
                                                _loc_22 = Hashable2_Boolfalse.zpp_pool;
                                                Hashable2_Boolfalse.zpp_pool = _loc_22.next;
                                                _loc_22.next = null;
                                            }
                                            _loc_22.id = _loc_24.id;
                                            _loc_22.di = _loc_17.id;
                                            _loc_21 = _loc_22;
                                            _loc_21.value = true;
                                            ZPP_Simple.inthash.add(_loc_21);
                                        }
                                    }
                                    else
                                    {
                                        _loc_15 = _loc_18.data;
                                        if (_loc_15.segment == _loc_14.segment)
                                        {
                                        }
                                        if (_loc_14.segment2 != _loc_15.segment2)
                                        {
                                            throw "corner case 2, shiiiit.";
                                        }
                                        _loc_9 = _loc_14.vertex;
                                        _loc_9.links.clear();
                                        _loc_9.node = null;
                                        _loc_9.forced = false;
                                        _loc_9.next = ZPP_SimpleVert.zpp_pool;
                                        ZPP_SimpleVert.zpp_pool = _loc_9;
                                        _loc_23 = _loc_14;
                                        _loc_23.vertex = null;
                                        _loc_25 = null;
                                        _loc_23.segment2 = _loc_25;
                                        _loc_23.segment = _loc_25;
                                        _loc_23.node = null;
                                        _loc_23.next = ZPP_SimpleEvent.zpp_pool;
                                        ZPP_SimpleEvent.zpp_pool = _loc_23;
                                    }
                                }
                                else
                                {
                                    _loc_9 = _loc_14.vertex;
                                    _loc_9.links.clear();
                                    _loc_9.node = null;
                                    _loc_9.forced = false;
                                    _loc_9.next = ZPP_SimpleVert.zpp_pool;
                                    ZPP_SimpleVert.zpp_pool = _loc_9;
                                    _loc_15 = _loc_14;
                                    _loc_15.vertex = null;
                                    _loc_25 = null;
                                    _loc_15.segment2 = _loc_25;
                                    _loc_15.segment = _loc_25;
                                    _loc_15.node = null;
                                    _loc_15.next = ZPP_SimpleEvent.zpp_pool;
                                    ZPP_SimpleEvent.zpp_pool = _loc_15;
                                }
                            }
                        }
                    }
                }
                else
                {
                    _loc_9 = _loc_13.vertex;
                    _loc_26 = _loc_9.node == null;
                    _loc_16 = _loc_13.segment;
                    _loc_17 = _loc_13.segment2;
                    if (_loc_17.next != _loc_16)
                    {
                        _loc_24 = _loc_16;
                        _loc_16 = _loc_17;
                        _loc_17 = _loc_24;
                    }
                    _loc_11 = _loc_16.vertices.parent;
                    while (_loc_11 != null)
                    {
                        
                        if (_loc_16.vertices.lt(_loc_9, _loc_11.data))
                        {
                            _loc_11 = _loc_11.prev;
                            continue;
                        }
                        if (_loc_16.vertices.lt(_loc_11.data, _loc_9))
                        {
                            _loc_11 = _loc_11.next;
                            continue;
                        }
                        break;
                    }
                    _loc_27 = _loc_11 == null;
                    _loc_11 = _loc_17.vertices.parent;
                    while (_loc_11 != null)
                    {
                        
                        if (_loc_17.vertices.lt(_loc_9, _loc_11.data))
                        {
                            _loc_11 = _loc_11.prev;
                            continue;
                        }
                        if (_loc_17.vertices.lt(_loc_11.data, _loc_9))
                        {
                            _loc_11 = _loc_11.next;
                            continue;
                        }
                        break;
                    }
                    _loc_28 = _loc_11 == null;
                    if (_loc_27)
                    {
                        _loc_11 = _loc_16.vertices.insert(_loc_9);
                        if (_loc_9 == _loc_16.left)
                        {
                            _loc_10 = _loc_9;
                        }
                        else
                        {
                            _loc_10 = _loc_16.vertices.predecessor_node(_loc_11).data;
                        }
                        if (_loc_9 == _loc_16.right)
                        {
                            _loc_29 = _loc_9;
                        }
                        else
                        {
                            _loc_29 = _loc_16.vertices.successor_node(_loc_11).data;
                        }
                        _loc_10.links.remove(_loc_29);
                        if (_loc_9 != _loc_10)
                        {
                            _loc_10.links.insert(_loc_9);
                        }
                        _loc_29.links.remove(_loc_10);
                        if (_loc_9 != _loc_29)
                        {
                            _loc_29.links.insert(_loc_9);
                        }
                        if (_loc_9 != _loc_10)
                        {
                            _loc_9.links.insert(_loc_10);
                        }
                        if (_loc_9 != _loc_29)
                        {
                            _loc_9.links.insert(_loc_29);
                        }
                    }
                    if (_loc_28)
                    {
                        _loc_11 = _loc_17.vertices.insert(_loc_9);
                        if (_loc_9 == _loc_17.left)
                        {
                            _loc_10 = _loc_9;
                        }
                        else
                        {
                            _loc_10 = _loc_17.vertices.predecessor_node(_loc_11).data;
                        }
                        if (_loc_9 == _loc_17.right)
                        {
                            _loc_29 = _loc_9;
                        }
                        else
                        {
                            _loc_29 = _loc_17.vertices.successor_node(_loc_11).data;
                        }
                        _loc_10.links.remove(_loc_29);
                        if (_loc_9 != _loc_10)
                        {
                            _loc_10.links.insert(_loc_9);
                        }
                        _loc_29.links.remove(_loc_10);
                        if (_loc_9 != _loc_29)
                        {
                            _loc_29.links.insert(_loc_9);
                        }
                        if (_loc_9 != _loc_10)
                        {
                            _loc_9.links.insert(_loc_10);
                        }
                        if (_loc_9 != _loc_29)
                        {
                            _loc_9.links.insert(_loc_29);
                        }
                    }
                    if (_loc_26)
                    {
                        _loc_9.node = ZPP_Simple.vertices.insert(_loc_9);
                    }
                    _loc_9.forced = true;
                    if (_loc_26)
                    {
                        _loc_30 = _loc_16.node;
                        _loc_31 = _loc_17.node;
                        _loc_30.data = _loc_17;
                        _loc_31.data = _loc_16;
                        _loc_16.node = _loc_31;
                        _loc_17.node = _loc_30;
                        _loc_17.next = _loc_16.next;
                        _loc_16.next = _loc_17;
                        _loc_16.prev = _loc_17.prev;
                        _loc_17.prev = _loc_16;
                        if (_loc_16.prev != null)
                        {
                            _loc_16.prev.next = _loc_16;
                        }
                        if (_loc_17.next != null)
                        {
                            _loc_17.next.prev = _loc_17;
                        }
                    }
                    if (_loc_17.next != null)
                    {
                    }
                    if (_loc_17 != null)
                    {
                    }
                    if (!(_loc_17.next.id < _loc_17.id ? (ZPP_Simple.inthash.has(_loc_17.next.id, _loc_17.id)) : (ZPP_Simple.inthash.has(_loc_17.id, _loc_17.next.id))))
                    {
                        _loc_14 = ZPP_Simple.sweep.intersection(_loc_17.next, _loc_17);
                        if (_loc_14 != null)
                        {
                            if (_loc_14.vertex.x >= ZPP_Simple.sweep.sweepx)
                            {
                                _loc_19 = ZPP_Simple.queue.parent;
                                while (_loc_19 != null)
                                {
                                    
                                    if (ZPP_Simple.queue.lt(_loc_14, _loc_19.data))
                                    {
                                        _loc_19 = _loc_19.prev;
                                        continue;
                                    }
                                    if (ZPP_Simple.queue.lt(_loc_19.data, _loc_14))
                                    {
                                        _loc_19 = _loc_19.next;
                                        continue;
                                    }
                                    break;
                                }
                                _loc_18 = _loc_19;
                                if (_loc_18 == null)
                                {
                                    _loc_20 = ZPP_Simple.ints.parent;
                                    while (_loc_20 != null)
                                    {
                                        
                                        if (ZPP_Simple.ints.lt(_loc_14, _loc_20.data))
                                        {
                                            _loc_20 = _loc_20.prev;
                                            continue;
                                        }
                                        if (ZPP_Simple.ints.lt(_loc_20.data, _loc_14))
                                        {
                                            _loc_20 = _loc_20.next;
                                            continue;
                                        }
                                        break;
                                    }
                                    _loc_19 = _loc_20;
                                    if (_loc_19 != null)
                                    {
                                        _loc_10 = _loc_14.vertex;
                                        _loc_10.links.clear();
                                        _loc_10.node = null;
                                        _loc_10.forced = false;
                                        _loc_10.next = ZPP_SimpleVert.zpp_pool;
                                        ZPP_SimpleVert.zpp_pool = _loc_10;
                                        _loc_14.vertex = _loc_19.data.vertex;
                                        _loc_19.data = _loc_14;
                                        ZPP_Simple.queue.insert(_loc_14);
                                    }
                                    else
                                    {
                                        ZPP_Simple.queue.insert(_loc_14);
                                        ZPP_Simple.ints.insert(_loc_14);
                                    }
                                    if (_loc_17.next.id < _loc_17.id)
                                    {
                                        if (Hashable2_Boolfalse.zpp_pool == null)
                                        {
                                            _loc_22 = new Hashable2_Boolfalse();
                                        }
                                        else
                                        {
                                            _loc_22 = Hashable2_Boolfalse.zpp_pool;
                                            Hashable2_Boolfalse.zpp_pool = _loc_22.next;
                                            _loc_22.next = null;
                                        }
                                        _loc_22.id = _loc_17.next.id;
                                        _loc_22.di = _loc_17.id;
                                        _loc_21 = _loc_22;
                                        _loc_21.value = true;
                                        ZPP_Simple.inthash.add(_loc_21);
                                    }
                                    else
                                    {
                                        if (Hashable2_Boolfalse.zpp_pool == null)
                                        {
                                            _loc_22 = new Hashable2_Boolfalse();
                                        }
                                        else
                                        {
                                            _loc_22 = Hashable2_Boolfalse.zpp_pool;
                                            Hashable2_Boolfalse.zpp_pool = _loc_22.next;
                                            _loc_22.next = null;
                                        }
                                        _loc_22.id = _loc_17.id;
                                        _loc_22.di = _loc_17.next.id;
                                        _loc_21 = _loc_22;
                                        _loc_21.value = true;
                                        ZPP_Simple.inthash.add(_loc_21);
                                    }
                                }
                                else
                                {
                                    _loc_15 = _loc_18.data;
                                    if (_loc_15.segment == _loc_14.segment)
                                    {
                                    }
                                    if (_loc_14.segment2 != _loc_15.segment2)
                                    {
                                        throw "corner case 2, shiiiit.";
                                    }
                                    _loc_10 = _loc_14.vertex;
                                    _loc_10.links.clear();
                                    _loc_10.node = null;
                                    _loc_10.forced = false;
                                    _loc_10.next = ZPP_SimpleVert.zpp_pool;
                                    ZPP_SimpleVert.zpp_pool = _loc_10;
                                    _loc_23 = _loc_14;
                                    _loc_23.vertex = null;
                                    _loc_24 = null;
                                    _loc_23.segment2 = _loc_24;
                                    _loc_23.segment = _loc_24;
                                    _loc_23.node = null;
                                    _loc_23.next = ZPP_SimpleEvent.zpp_pool;
                                    ZPP_SimpleEvent.zpp_pool = _loc_23;
                                }
                            }
                            else
                            {
                                _loc_10 = _loc_14.vertex;
                                _loc_10.links.clear();
                                _loc_10.node = null;
                                _loc_10.forced = false;
                                _loc_10.next = ZPP_SimpleVert.zpp_pool;
                                ZPP_SimpleVert.zpp_pool = _loc_10;
                                _loc_15 = _loc_14;
                                _loc_15.vertex = null;
                                _loc_24 = null;
                                _loc_15.segment2 = _loc_24;
                                _loc_15.segment = _loc_24;
                                _loc_15.node = null;
                                _loc_15.next = ZPP_SimpleEvent.zpp_pool;
                                ZPP_SimpleEvent.zpp_pool = _loc_15;
                            }
                        }
                    }
                    if (_loc_16 != null)
                    {
                    }
                    if (_loc_16.prev != null)
                    {
                    }
                    if (!(_loc_16.id < _loc_16.prev.id ? (ZPP_Simple.inthash.has(_loc_16.id, _loc_16.prev.id)) : (ZPP_Simple.inthash.has(_loc_16.prev.id, _loc_16.id))))
                    {
                        _loc_14 = ZPP_Simple.sweep.intersection(_loc_16, _loc_16.prev);
                        if (_loc_14 != null)
                        {
                            if (_loc_14.vertex.x >= ZPP_Simple.sweep.sweepx)
                            {
                                _loc_19 = ZPP_Simple.queue.parent;
                                while (_loc_19 != null)
                                {
                                    
                                    if (ZPP_Simple.queue.lt(_loc_14, _loc_19.data))
                                    {
                                        _loc_19 = _loc_19.prev;
                                        continue;
                                    }
                                    if (ZPP_Simple.queue.lt(_loc_19.data, _loc_14))
                                    {
                                        _loc_19 = _loc_19.next;
                                        continue;
                                    }
                                    break;
                                }
                                _loc_18 = _loc_19;
                                if (_loc_18 == null)
                                {
                                    _loc_20 = ZPP_Simple.ints.parent;
                                    while (_loc_20 != null)
                                    {
                                        
                                        if (ZPP_Simple.ints.lt(_loc_14, _loc_20.data))
                                        {
                                            _loc_20 = _loc_20.prev;
                                            continue;
                                        }
                                        if (ZPP_Simple.ints.lt(_loc_20.data, _loc_14))
                                        {
                                            _loc_20 = _loc_20.next;
                                            continue;
                                        }
                                        break;
                                    }
                                    _loc_19 = _loc_20;
                                    if (_loc_19 != null)
                                    {
                                        _loc_10 = _loc_14.vertex;
                                        _loc_10.links.clear();
                                        _loc_10.node = null;
                                        _loc_10.forced = false;
                                        _loc_10.next = ZPP_SimpleVert.zpp_pool;
                                        ZPP_SimpleVert.zpp_pool = _loc_10;
                                        _loc_14.vertex = _loc_19.data.vertex;
                                        _loc_19.data = _loc_14;
                                        ZPP_Simple.queue.insert(_loc_14);
                                    }
                                    else
                                    {
                                        ZPP_Simple.queue.insert(_loc_14);
                                        ZPP_Simple.ints.insert(_loc_14);
                                    }
                                    if (_loc_16.id < _loc_16.prev.id)
                                    {
                                        if (Hashable2_Boolfalse.zpp_pool == null)
                                        {
                                            _loc_22 = new Hashable2_Boolfalse();
                                        }
                                        else
                                        {
                                            _loc_22 = Hashable2_Boolfalse.zpp_pool;
                                            Hashable2_Boolfalse.zpp_pool = _loc_22.next;
                                            _loc_22.next = null;
                                        }
                                        _loc_22.id = _loc_16.id;
                                        _loc_22.di = _loc_16.prev.id;
                                        _loc_21 = _loc_22;
                                        _loc_21.value = true;
                                        ZPP_Simple.inthash.add(_loc_21);
                                    }
                                    else
                                    {
                                        if (Hashable2_Boolfalse.zpp_pool == null)
                                        {
                                            _loc_22 = new Hashable2_Boolfalse();
                                        }
                                        else
                                        {
                                            _loc_22 = Hashable2_Boolfalse.zpp_pool;
                                            Hashable2_Boolfalse.zpp_pool = _loc_22.next;
                                            _loc_22.next = null;
                                        }
                                        _loc_22.id = _loc_16.prev.id;
                                        _loc_22.di = _loc_16.id;
                                        _loc_21 = _loc_22;
                                        _loc_21.value = true;
                                        ZPP_Simple.inthash.add(_loc_21);
                                    }
                                }
                                else
                                {
                                    _loc_15 = _loc_18.data;
                                    if (_loc_15.segment == _loc_14.segment)
                                    {
                                    }
                                    if (_loc_14.segment2 != _loc_15.segment2)
                                    {
                                        throw "corner case 2, shiiiit.";
                                    }
                                    _loc_10 = _loc_14.vertex;
                                    _loc_10.links.clear();
                                    _loc_10.node = null;
                                    _loc_10.forced = false;
                                    _loc_10.next = ZPP_SimpleVert.zpp_pool;
                                    ZPP_SimpleVert.zpp_pool = _loc_10;
                                    _loc_23 = _loc_14;
                                    _loc_23.vertex = null;
                                    _loc_24 = null;
                                    _loc_23.segment2 = _loc_24;
                                    _loc_23.segment = _loc_24;
                                    _loc_23.node = null;
                                    _loc_23.next = ZPP_SimpleEvent.zpp_pool;
                                    ZPP_SimpleEvent.zpp_pool = _loc_23;
                                }
                            }
                            else
                            {
                                _loc_10 = _loc_14.vertex;
                                _loc_10.links.clear();
                                _loc_10.node = null;
                                _loc_10.forced = false;
                                _loc_10.next = ZPP_SimpleVert.zpp_pool;
                                ZPP_SimpleVert.zpp_pool = _loc_10;
                                _loc_15 = _loc_14;
                                _loc_15.vertex = null;
                                _loc_24 = null;
                                _loc_15.segment2 = _loc_24;
                                _loc_15.segment = _loc_24;
                                _loc_15.node = null;
                                _loc_15.next = ZPP_SimpleEvent.zpp_pool;
                                ZPP_SimpleEvent.zpp_pool = _loc_15;
                            }
                        }
                    }
                    ZPP_Simple.ints.remove(_loc_13);
                }
                _loc_14 = _loc_13;
                _loc_14.vertex = null;
                _loc_16 = null;
                _loc_14.segment2 = _loc_16;
                _loc_14.segment = _loc_16;
                _loc_14.node = null;
                _loc_14.next = ZPP_SimpleEvent.zpp_pool;
                ZPP_SimpleEvent.zpp_pool = _loc_14;
            }
            var _loc_32:* = 0;
            var _loc_33:* = ZPP_Simple.inthash.table.length;
            while (_loc_32 < _loc_33)
            {
                
                _loc_32++;
                _loc_34 = _loc_32;
                _loc_21 = ZPP_Simple.inthash.table[_loc_34];
                if (_loc_21 == null)
                {
                    continue;
                }
                while (_loc_21 != null)
                {
                    
                    _loc_22 = _loc_21.hnext;
                    _loc_21.hnext = null;
                    _loc_35 = _loc_21;
                    _loc_35.next = Hashable2_Boolfalse.zpp_pool;
                    Hashable2_Boolfalse.zpp_pool = _loc_35;
                    _loc_21 = _loc_22;
                }
                ZPP_Simple.inthash.table[_loc_34] = null;
            }
            if (param2 == null)
            {
                param2 = new ZNPList_ZPP_GeomVert();
            }
            while (!ZPP_Simple.vertices.empty())
            {
                
                ZPP_Simple.clip_polygon(ZPP_Simple.vertices, param2);
            }
            return param2;
        }// end function

        public static function clip_polygon(param1:ZPP_Set_ZPP_SimpleVert, param2:ZNPList_ZPP_GeomVert) : void
        {
            var _loc_7:* = null as ZPP_Set_ZPP_SimpleVert;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            var _loc_14:* = null as ZPP_GeomVert;
            var _loc_15:* = null as ZPP_GeomVert;
            var _loc_16:* = null as ZPP_SimpleVert;
            var _loc_17:* = null as ZPP_Set_ZPP_SimpleVert;
            var _loc_18:* = null as ZPP_SimpleVert;
            var _loc_19:* = NaN;
            var _loc_20:* = NaN;
            var _loc_21:* = NaN;
            var _loc_3:* = null;
            var _loc_4:* = param1.first();
            var _loc_5:* = _loc_4;
            var _loc_6:* = _loc_4.links.parent;
            if (_loc_6.prev == null)
            {
                _loc_7 = _loc_6.next;
            }
            else
            {
                _loc_7 = _loc_6.prev;
            }
            var _loc_8:* = _loc_6.data;
            var _loc_9:* = _loc_7.data;
            _loc_10 = 0;
            _loc_11 = 0;
            _loc_10 = _loc_4.x - _loc_8.x;
            _loc_11 = _loc_4.y - _loc_8.y;
            _loc_12 = 0;
            _loc_13 = 0;
            _loc_12 = _loc_9.x - _loc_4.x;
            _loc_13 = _loc_9.y - _loc_4.y;
            if (_loc_13 * _loc_10 - _loc_12 * _loc_11 < 0)
            {
                _loc_9 = _loc_8;
            }
            if (ZPP_GeomVert.zpp_pool == null)
            {
                _loc_15 = new ZPP_GeomVert();
            }
            else
            {
                _loc_15 = ZPP_GeomVert.zpp_pool;
                ZPP_GeomVert.zpp_pool = _loc_15.next;
                _loc_15.next = null;
            }
            _loc_15.forced = false;
            _loc_15.x = _loc_4.x;
            _loc_15.y = _loc_4.y;
            _loc_14 = _loc_15;
            if (_loc_3 == null)
            {
                _loc_15 = _loc_14;
                _loc_14.next = _loc_15;
                _loc_15 = _loc_15;
                _loc_14.prev = _loc_15;
                _loc_3 = _loc_15;
            }
            else
            {
                _loc_14.prev = _loc_3;
                _loc_14.next = _loc_3.next;
                _loc_3.next.prev = _loc_14;
                _loc_3.next = _loc_14;
            }
            _loc_3 = _loc_14;
            _loc_3.forced = _loc_4.forced;
            while (true)
            {
                
                _loc_4.links.remove(_loc_9);
                _loc_9.links.remove(_loc_4);
                if (_loc_9 == _loc_5)
                {
                    if (_loc_4.links.empty())
                    {
                        param1.remove(_loc_4);
                        _loc_16 = _loc_4;
                        _loc_16.links.clear();
                        _loc_16.node = null;
                        _loc_16.forced = false;
                        _loc_16.next = ZPP_SimpleVert.zpp_pool;
                        ZPP_SimpleVert.zpp_pool = _loc_16;
                    }
                    break;
                }
                if (ZPP_GeomVert.zpp_pool == null)
                {
                    _loc_15 = new ZPP_GeomVert();
                }
                else
                {
                    _loc_15 = ZPP_GeomVert.zpp_pool;
                    ZPP_GeomVert.zpp_pool = _loc_15.next;
                    _loc_15.next = null;
                }
                _loc_15.forced = false;
                _loc_15.x = _loc_9.x;
                _loc_15.y = _loc_9.y;
                _loc_14 = _loc_15;
                if (_loc_3 == null)
                {
                    _loc_15 = _loc_14;
                    _loc_14.next = _loc_15;
                    _loc_15 = _loc_15;
                    _loc_14.prev = _loc_15;
                    _loc_3 = _loc_15;
                }
                else
                {
                    _loc_14.prev = _loc_3;
                    _loc_14.next = _loc_3.next;
                    _loc_3.next.prev = _loc_14;
                    _loc_3.next = _loc_14;
                }
                _loc_3 = _loc_14;
                _loc_3.forced = _loc_9.forced;
                if (_loc_9.links.singular())
                {
                    if (_loc_4.links.empty())
                    {
                        param1.remove(_loc_4);
                        _loc_16 = _loc_4;
                        _loc_16.links.clear();
                        _loc_16.node = null;
                        _loc_16.forced = false;
                        _loc_16.next = ZPP_SimpleVert.zpp_pool;
                        ZPP_SimpleVert.zpp_pool = _loc_16;
                    }
                    _loc_4 = _loc_9;
                    _loc_9 = _loc_9.links.parent.data;
                    continue;
                }
                _loc_16 = null;
                _loc_10 = 0;
                if (!_loc_9.links.empty())
                {
                    _loc_17 = _loc_9.links.parent;
                    while (_loc_17.prev != null)
                    {
                        
                        _loc_17 = _loc_17.prev;
                    }
                    while (_loc_17 != null)
                    {
                        
                        _loc_18 = _loc_17.data;
                        if (_loc_16 == null)
                        {
                            _loc_16 = _loc_18;
                            _loc_11 = 0;
                            _loc_12 = 0;
                            _loc_11 = _loc_9.x - _loc_4.x;
                            _loc_12 = _loc_9.y - _loc_4.y;
                            _loc_13 = 0;
                            _loc_19 = 0;
                            _loc_13 = _loc_18.x - _loc_9.x;
                            _loc_19 = _loc_18.y - _loc_9.y;
                            _loc_10 = _loc_19 * _loc_11 - _loc_13 * _loc_12;
                        }
                        else
                        {
                            _loc_12 = 0;
                            _loc_13 = 0;
                            _loc_12 = _loc_9.x - _loc_4.x;
                            _loc_13 = _loc_9.y - _loc_4.y;
                            _loc_19 = 0;
                            _loc_20 = 0;
                            _loc_19 = _loc_18.x - _loc_9.x;
                            _loc_20 = _loc_18.y - _loc_9.y;
                            _loc_11 = _loc_20 * _loc_12 - _loc_19 * _loc_13;
                            if (_loc_11 > 0)
                            {
                            }
                            if (_loc_10 <= 0)
                            {
                                _loc_16 = _loc_18;
                                _loc_10 = _loc_11;
                            }
                            else if (_loc_10 * _loc_11 >= 0)
                            {
                                _loc_13 = 0;
                                _loc_19 = 0;
                                _loc_13 = _loc_9.x - _loc_18.x;
                                _loc_19 = _loc_9.y - _loc_18.y;
                                _loc_20 = 0;
                                _loc_21 = 0;
                                _loc_20 = _loc_16.x - _loc_9.x;
                                _loc_21 = _loc_16.y - _loc_9.y;
                                _loc_12 = _loc_21 * _loc_13 - _loc_20 * _loc_19;
                                if (_loc_12 > 0)
                                {
                                    _loc_16 = _loc_18;
                                    _loc_10 = _loc_11;
                                }
                            }
                        }
                        if (_loc_17.next != null)
                        {
                            _loc_17 = _loc_17.next;
                            while (_loc_17.prev != null)
                            {
                                
                                _loc_17 = _loc_17.prev;
                            }
                            continue;
                        }
                        do
                        {
                            
                            _loc_17 = _loc_17.parent;
                            if (_loc_17.parent != null)
                            {
                            }
                        }while (_loc_17 == _loc_17.parent.next)
                        _loc_17 = _loc_17.parent;
                    }
                }
                if (_loc_4.links.empty())
                {
                    param1.remove(_loc_4);
                    _loc_18 = _loc_4;
                    _loc_18.links.clear();
                    _loc_18.node = null;
                    _loc_18.forced = false;
                    _loc_18.next = ZPP_SimpleVert.zpp_pool;
                    ZPP_SimpleVert.zpp_pool = _loc_18;
                }
                _loc_4 = _loc_9;
                _loc_9 = _loc_16;
            }
            param1.remove(_loc_5);
            _loc_16 = _loc_5;
            _loc_16.links.clear();
            _loc_16.node = null;
            _loc_16.forced = false;
            _loc_16.next = ZPP_SimpleVert.zpp_pool;
            ZPP_SimpleVert.zpp_pool = _loc_16;
            param2.add(_loc_3);
            return;
        }// end function

        public static function isSimple(param1:ZPP_GeomVert) : Boolean
        {
            var _loc_3:* = null as ZNPList_ZPP_SimpleVert;
            var _loc_6:* = null as ZPP_GeomVert;
            var _loc_7:* = null as ZPP_GeomVert;
            var _loc_8:* = null as ZPP_SimpleVert;
            var _loc_10:* = null as ZNPList_ZPP_SimpleEvent;
            var _loc_12:* = null as ZPP_SimpleVert;
            var _loc_13:* = null as ZPP_SimpleEvent;
            var _loc_14:* = null as ZPP_SimpleEvent;
            var _loc_15:* = null as ZPP_SimpleEvent;
            var _loc_16:* = null as ZPP_SimpleSeg;
            var _loc_17:* = null as ZNPNode_ZPP_SimpleEvent;
            var _loc_18:* = null as ZNPNode_ZPP_SimpleEvent;
            var _loc_19:* = null as ZNPNode_ZPP_SimpleEvent;
            var _loc_20:* = null as ZNPNode_ZPP_SimpleEvent;
            var _loc_21:* = null as ZNPNode_ZPP_SimpleEvent;
            var _loc_22:* = 0;
            var _loc_23:* = 0;
            var _loc_24:* = 0;
            var _loc_25:* = 0;
            var _loc_27:* = null as ZPP_SimpleSeg;
            if (ZPP_Simple.sweep == null)
            {
                ZPP_Simple.sweep = new ZPP_SimpleSweep();
                ZPP_Simple.inthash = new FastHash2_Hashable2_Boolfalse();
            }
            var _loc_2:* = ZPP_Simple.list_vertices;
            if (_loc_2 == null)
            {
                _loc_3 = new ZNPList_ZPP_SimpleVert();
                ZPP_Simple.list_vertices = _loc_3;
                _loc_2 = _loc_3;
            }
            var _loc_4:* = param1;
            var _loc_5:* = param1;
            if (_loc_4 != null)
            {
                _loc_6 = _loc_4;
                do
                {
                    
                    _loc_7 = _loc_6;
                    if (ZPP_SimpleVert.zpp_pool == null)
                    {
                        _loc_8 = new ZPP_SimpleVert();
                    }
                    else
                    {
                        _loc_8 = ZPP_SimpleVert.zpp_pool;
                        ZPP_SimpleVert.zpp_pool = _loc_8.next;
                        _loc_8.next = null;
                    }
                    _loc_8.x = _loc_7.x;
                    _loc_8.y = _loc_7.y;
                    _loc_2.add(_loc_8);
                    _loc_6 = _loc_6.next;
                }while (_loc_6 != _loc_5)
            }
            var _loc_9:* = ZPP_Simple.list_queue;
            if (_loc_9 == null)
            {
                _loc_10 = new ZNPList_ZPP_SimpleEvent();
                ZPP_Simple.list_queue = _loc_10;
                _loc_9 = _loc_10;
            }
            var _loc_11:* = _loc_2.head;
            _loc_8 = _loc_11.elt;
            _loc_11 = _loc_11.next;
            while (_loc_11 != null)
            {
                
                _loc_12 = _loc_11.elt;
                if (ZPP_SimpleEvent.zpp_pool == null)
                {
                    _loc_14 = new ZPP_SimpleEvent();
                }
                else
                {
                    _loc_14 = ZPP_SimpleEvent.zpp_pool;
                    ZPP_SimpleEvent.zpp_pool = _loc_14.next;
                    _loc_14.next = null;
                }
                _loc_14.vertex = _loc_8;
                _loc_13 = _loc_9.add(_loc_14);
                if (ZPP_SimpleEvent.zpp_pool == null)
                {
                    _loc_15 = new ZPP_SimpleEvent();
                }
                else
                {
                    _loc_15 = ZPP_SimpleEvent.zpp_pool;
                    ZPP_SimpleEvent.zpp_pool = _loc_15.next;
                    _loc_15.next = null;
                }
                _loc_15.vertex = _loc_12;
                _loc_14 = _loc_9.add(_loc_15);
                _loc_13.segment = ZPP_SimpleEvent.less_xy(_loc_13, _loc_14) ? (_loc_13.type = 1, _loc_14.type = 2, _loc_16 = ZPP_SimpleSeg.get(_loc_8, _loc_12), _loc_14.segment = _loc_16, _loc_16) : (_loc_13.type = 2, _loc_14.type = 1, _loc_16 = ZPP_SimpleSeg.get(_loc_12, _loc_8), _loc_14.segment = _loc_16, _loc_16);
                _loc_8 = _loc_12;
                _loc_11 = _loc_11.next;
            }
            _loc_12 = _loc_2.head.elt;
            if (ZPP_SimpleEvent.zpp_pool == null)
            {
                _loc_14 = new ZPP_SimpleEvent();
            }
            else
            {
                _loc_14 = ZPP_SimpleEvent.zpp_pool;
                ZPP_SimpleEvent.zpp_pool = _loc_14.next;
                _loc_14.next = null;
            }
            _loc_14.vertex = _loc_8;
            _loc_13 = _loc_9.add(_loc_14);
            if (ZPP_SimpleEvent.zpp_pool == null)
            {
                _loc_15 = new ZPP_SimpleEvent();
            }
            else
            {
                _loc_15 = ZPP_SimpleEvent.zpp_pool;
                ZPP_SimpleEvent.zpp_pool = _loc_15.next;
                _loc_15.next = null;
            }
            _loc_15.vertex = _loc_12;
            _loc_14 = _loc_9.add(_loc_15);
            _loc_13.segment = ZPP_SimpleEvent.less_xy(_loc_13, _loc_14) ? (_loc_13.type = 1, _loc_14.type = 2, _loc_16 = ZPP_SimpleSeg.get(_loc_8, _loc_12), _loc_14.segment = _loc_16, _loc_16) : (_loc_13.type = 2, _loc_14.type = 1, _loc_16 = ZPP_SimpleSeg.get(_loc_12, _loc_8), _loc_14.segment = _loc_16, _loc_16);
            _loc_10 = _loc_9;
            if (_loc_10.head != null)
            {
            }
            if (_loc_10.head.next != null)
            {
                _loc_17 = _loc_10.head;
                _loc_18 = null;
                _loc_19 = null;
                _loc_20 = null;
                _loc_21 = null;
                _loc_22 = 1;
                do
                {
                    
                    _loc_23 = 0;
                    _loc_19 = _loc_17;
                    _loc_17 = null;
                    _loc_18 = _loc_17;
                    while (_loc_19 != null)
                    {
                        
                        _loc_23++;
                        _loc_20 = _loc_19;
                        _loc_24 = 0;
                        _loc_25 = _loc_22;
                        do
                        {
                            
                            _loc_24++;
                            _loc_20 = _loc_20.next;
                            if (_loc_20 != null)
                            {
                            }
                        }while (_loc_24 < _loc_22)
                        do
                        {
                            
                            if (_loc_24 == 0)
                            {
                                _loc_21 = _loc_20;
                                _loc_20 = _loc_20.next;
                                _loc_25--;
                            }
                            else
                            {
                                if (_loc_25 != 0)
                                {
                                }
                                if (_loc_20 == null)
                                {
                                    _loc_21 = _loc_19;
                                    _loc_19 = _loc_19.next;
                                    _loc_24--;
                                }
                                else if (ZPP_SimpleEvent.less_xy(_loc_19.elt, _loc_20.elt))
                                {
                                    _loc_21 = _loc_19;
                                    _loc_19 = _loc_19.next;
                                    _loc_24--;
                                }
                                else
                                {
                                    _loc_21 = _loc_20;
                                    _loc_20 = _loc_20.next;
                                    _loc_25--;
                                }
                            }
                            if (_loc_18 != null)
                            {
                                _loc_18.next = _loc_21;
                            }
                            else
                            {
                                _loc_17 = _loc_21;
                            }
                            _loc_18 = _loc_21;
                            if (_loc_24 <= 0)
                            {
                                if (_loc_25 > 0)
                                {
                                }
                            }
                        }while (_loc_20 != null)
                        _loc_19 = _loc_20;
                    }
                    _loc_18.next = null;
                    _loc_22 = _loc_22 << 1;
                }while (_loc_23 > 1)
                _loc_10.head = _loc_17;
                _loc_10.modified = true;
                _loc_10.pushmod = true;
            }
            var _loc_26:* = true;
            while (_loc_9.head != null)
            {
                
                _loc_13 = _loc_9.pop_unsafe();
                _loc_16 = _loc_13.segment;
                if (_loc_13.type == 1)
                {
                    ZPP_Simple.sweep.add(_loc_16);
                    if (!ZPP_Simple.sweep.intersect(_loc_16, _loc_16.next))
                    {
                    }
                    if (ZPP_Simple.sweep.intersect(_loc_16, _loc_16.prev))
                    {
                        _loc_26 = false;
                        break;
                    }
                }
                else if (_loc_13.type == 2)
                {
                    if (ZPP_Simple.sweep.intersect(_loc_16.prev, _loc_16.next))
                    {
                        _loc_26 = false;
                        break;
                    }
                    ZPP_Simple.sweep.remove(_loc_16);
                    _loc_27 = _loc_16;
                    _loc_8 = null;
                    _loc_27.right = _loc_8;
                    _loc_27.left = _loc_8;
                    _loc_27.prev = null;
                    _loc_27.node = null;
                    _loc_27.vertices.clear();
                    _loc_27.next = ZPP_SimpleSeg.zpp_pool;
                    ZPP_SimpleSeg.zpp_pool = _loc_27;
                }
                _loc_14 = _loc_13;
                _loc_14.vertex = null;
                _loc_27 = null;
                _loc_14.segment2 = _loc_27;
                _loc_14.segment = _loc_27;
                _loc_14.node = null;
                _loc_14.next = ZPP_SimpleEvent.zpp_pool;
                ZPP_SimpleEvent.zpp_pool = _loc_14;
            }
            while (_loc_9.head != null)
            {
                
                _loc_13 = _loc_9.pop_unsafe();
                if (_loc_13.type == 2)
                {
                    _loc_16 = _loc_13.segment;
                    _loc_8 = null;
                    _loc_16.right = _loc_8;
                    _loc_16.left = _loc_8;
                    _loc_16.prev = null;
                    _loc_16.node = null;
                    _loc_16.vertices.clear();
                    _loc_16.next = ZPP_SimpleSeg.zpp_pool;
                    ZPP_SimpleSeg.zpp_pool = _loc_16;
                }
                _loc_14 = _loc_13;
                _loc_14.vertex = null;
                _loc_16 = null;
                _loc_14.segment2 = _loc_16;
                _loc_14.segment = _loc_16;
                _loc_14.node = null;
                _loc_14.next = ZPP_SimpleEvent.zpp_pool;
                ZPP_SimpleEvent.zpp_pool = _loc_14;
            }
            ZPP_Simple.sweep.clear();
            while (_loc_2.head != null)
            {
                
                _loc_8 = _loc_2.pop_unsafe();
                _loc_8.links.clear();
                _loc_8.node = null;
                _loc_8.forced = false;
                _loc_8.next = ZPP_SimpleVert.zpp_pool;
                ZPP_SimpleVert.zpp_pool = _loc_8;
            }
            return _loc_26;
        }// end function

    }
}
