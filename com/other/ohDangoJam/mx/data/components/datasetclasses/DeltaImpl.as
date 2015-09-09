class mx.data.components.datasetclasses.DeltaImpl extends Object implements mx.data.components.datasetclasses.Delta
{
    var _deltaItems, _id, _source, _op, _message, _accessCl, _owner;
    function DeltaImpl(id, curSrc, op, msg, acl)
    {
        super();
        _deltaItems = new Array();
        _id = id;
        _source = curSrc;
        _op = op;
        _message = msg == undefined ? ("") : (msg);
        _accessCl = acl == undefined ? (false) : (acl);
    } // End of the function
    function addDeltaItem(item)
    {
        var _loc2 = this.getItemIndexByName(item.__get__name());
        if (_loc2 < 0 || item.__get__kind() == mx.data.components.datasetclasses.DeltaItem.Method)
        {
            _deltaItems.push(item);
        }
        else
        {
            _deltaItems.splice(_loc2, 1);
            _deltaItems.splice(_loc2, 0, item);
        } // end else if
    } // End of the function
    function getId()
    {
        return (_id);
    } // End of the function
    function getOperation()
    {
        return (_op);
    } // End of the function
    function getChangeList()
    {
        if (_op != mx.data.components.datasetclasses.DeltaPacketConsts.Added || _accessCl)
        {
            return (_deltaItems);
        }
        else
        {
            return (null);
        } // end else if
    } // End of the function
    function getItemByName(name)
    {
        var _loc2 = this.getItemIndexByName(name);
        if (_loc2 >= 0)
        {
            return (_deltaItems[_loc2]);
        }
        else
        {
            return (null);
        } // end else if
    } // End of the function
    function getSource()
    {
        var _loc4 = _source;
        if (_op == mx.data.components.datasetclasses.DeltaPacketConsts.Added && arguments.length > 0)
        {
            if (_source.clone == undefined)
            {
                _loc4 = new Object();
                var _loc3;
                for (var _loc5 in _source)
                {
                    _loc3 = _source[_loc5];
                    if (typeof(_loc3) != "function")
                    {
                        _loc4[_loc5] = _loc3;
                    } // end if
                } // end of for...in
            }
            else
            {
                _loc4 = _source.clone();
            } // end if
        } // end else if
        return (_loc4);
    } // End of the function
    function getMessage()
    {
        return (_message);
    } // End of the function
    function getDeltaPacket()
    {
        return (_owner);
    } // End of the function
    function getItemIndexByName(name)
    {
        var _loc3;
        if (_op == mx.data.components.datasetclasses.DeltaPacketConsts.Modified || _accessCl)
        {
            for (var _loc2 = 0; _loc2 < _deltaItems.length; ++_loc2)
            {
                _loc3 = _deltaItems[_loc2];
                if (_loc3.__get__name() == name)
                {
                    return (_loc2);
                } // end if
            } // end of for
        } // end if
        return (-1);
    } // End of the function
} // End of Class
